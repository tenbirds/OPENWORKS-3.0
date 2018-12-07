/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.base.support;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.spi.compress.ZipCompress;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;

/**
 * File upload 지원 클레스
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 25.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UploadHelper {

    /** 첨부 파일 저장 경로 */
    private static final String UPLOAD_FOLDER_PATH = GlobalConfig.UPLOAD_FOLDER_PATH;
    /** 컨텐츠 파일 저장 경로(웹서버에서 직접 접근) */
    private static final String RESOURCE_FOLDER_PATH = GlobalConfig.RESOURCE_FOLDER_PATH;
    /** 기능별 저장경로를 지정하지 않는 경우의 기본 폴더명 */
    private static final String DEFAULT_UPLOAD_FOLDER_NAME = GlobalConfig.DEFAULT_UPLOAD_FOLDER_NAME;
    /** File.separator */
    private static final String separator = File.separator;
    /** 첨부파일 ROOT 경로 */
    public static final String UPLOAD_ROOT = GlobalConfig.UPLOAD_ROOT;
    /** 정적컨텐츠파일 ROOT 경로 */
    public static final String RESOURCE_ROOT = GlobalConfig.RESOURCE_ROOT;

    /**
     * 기본 폴더명을 사용하여 파일 저장
     * 
     * @param request Http 요청 객체
     * @return 저장 파일 목록
     */
    public static List<FileVO> upload(HttpServletRequest request) {

        return upload(request, DEFAULT_UPLOAD_FOLDER_NAME);
    }

    /**
     * 폴더명을 지정하여 파일 저장
     * 
     * @param request
     * @param folderName 파일저장 폴더명
     * @return 저장 파일 목록
     */
    public static List<FileVO> upload(HttpServletRequest request, String folderName) {

        return upload(request, folderName, Boolean.FALSE);
    }

    /**
     * 폴더명을 지정하여 파일 저장
     * 
     * @param request Http 요청 객체
     * @param folderName 파일저장 폴더명
     * @param isResource 정적컨텐츠 여부(웹서버 직접 접근 여부)
     * @return 저장 파일 목록
     */
    public static List<FileVO> upload(HttpServletRequest request, String folderName, Boolean isResource) {

        return upload(request, folderName, isResource, Boolean.FALSE);
    }

    /**
     * upload 설명
     * 
     * @param request Http 요청 객체
     * @param folderName 파일저장 폴더명
     * @param isResource 정적컨텐츠 여부(웹서버 직접 접근 여부)
     * @param isExtractZip 압축해제 여부
     * @return 저장 파일 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static List<FileVO> upload(HttpServletRequest request, String folderName, Boolean isResource, Boolean isExtractZip) {
        
        List<MultipartFile> files = (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY);

        if(Validate.isEmpty(files)) {
            return new ArrayList<FileVO>();
        }

        MultipartFile[] multiFiles = files.toArray(new MultipartFile[] {});

        if(Validate.isEmpty(folderName)) {
            folderName = DEFAULT_UPLOAD_FOLDER_NAME;
        }

        String concludeFolderPath = createFolderAsDate(getUploadFolderPath(isResource) + folderName);

        FileVO fileVo;
        List<FileVO> fileList = new ArrayList<FileVO>();

        try {

            int fileCnt = multiFiles.length;
            String[] fileDescs = request.getParameterValues("fileDesc");

            for(int i = 0 ; i < fileCnt ; i++) {

                MultipartFile multiFile = multiFiles[i];
                String fileDesc = ((fileDescs == null || fileDescs[i] == null) ? "" : fileDescs[i]);

                if(multiFile.getSize() > 0) {

                    if(ZipCompress.isZipFile(multiFile.getContentType()) && isExtractZip) {
                        fileList = ZipCompress.unCompressRename(multiFile.getInputStream(), concludeFolderPath);
                    } else {
                        String contextPath;
                        if(Validate.isNotEmpty(isResource) && isResource) {
                            contextPath = RESOURCE_ROOT;
                        } else {
                            contextPath = UPLOAD_ROOT;
                        }
                        contextPath += contextPath.endsWith(separator) ? "" : separator;

                        String uuid = UUID.randomUUID().toString();
                        String newFileName = uuid + "." + extension(multiFile.getOriginalFilename());
                        File newFileObject = new File(concludeFolderPath, newFileName);
                        String filePath = newFileObject.getAbsolutePath();
                        String fileType = multiFile.getContentType();

                        multiFile.transferTo(newFileObject);

                        fileVo = new FileVO();

                        fileVo.setFile(newFileObject);
                        fileVo.setFileUrl(FileUtil.getContextPath(contextPath, filePath));
                        fileVo.setInputNm(multiFile.getName());
                        fileVo.setServerNm(newFileObject.getName());
                        fileVo.setLocalNm(multiFile.getOriginalFilename());
                        fileVo.setFileType(fileType);
                        fileVo.setFileSize(FileUtil.toDisplaySize(multiFile.getSize()));
                        fileVo.setFileByteSize(multiFile.getSize());
                        fileVo.setFileId(uuid);
                        fileVo.setFileExt(extension(fileVo.getLocalNm()));
                        fileVo.setFileDesc(fileDesc);

                        fileList.add(fileVo);
                    }
                }
            }
        } catch (IOException e) {
        } catch (Exception e) {
          //  e.printStackTrace();           
        }

        return fileList;
    }

    /**
     * 최상위 파일 저장 경로 반환
     * 
     * @return 최상위 저장경로
     */
    public static String getUploadFolderPath(Boolean isResource) {

        String uploadFolderPath;

        if(Validate.isNotEmpty(isResource) && isResource) {
            uploadFolderPath = RESOURCE_ROOT;
        } else {
            uploadFolderPath = UPLOAD_ROOT;
        }

        uploadFolderPath += uploadFolderPath.endsWith(separator) ? "" : separator;

        if(Validate.isNotEmpty(isResource) && isResource) {
            uploadFolderPath += RESOURCE_FOLDER_PATH;
        } else {
            uploadFolderPath += UPLOAD_FOLDER_PATH;
        }

        uploadFolderPath += separator;
        return uploadFolderPath;
    }

    /**
     * 파일 확장자 추출
     * 
     * @param fileName
     * @return
     */
    private static String extension(String fileName) {

        return FileUtil.extension(fileName).toLowerCase();
    }

    /**
     * 년월일 기반 저장 경로 생성
     * 
     * @param fullFolderPath
     * @return
     */
    public static String createFolderAsDate(String fullFolderPath) {

        Calendar cal = Calendar.getInstance();
        String yearFolderName = Integer.toString(cal.get(Calendar.YEAR));
        String monthFolderName = Integer.toString(cal.get(Calendar.MONTH) + 1);
        String dayFolderName = Integer.toString(cal.get(Calendar.DATE));

        String dateFolderName = separator + yearFolderName + separator + monthFolderName
            + separator + dayFolderName + separator;

        String returnFolderPath = fullFolderPath + dateFolderName;

        FileUtil.mkdirs(returnFolderPath);

        return returnFolderPath;
    }
}
