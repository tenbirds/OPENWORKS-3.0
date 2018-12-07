/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.support;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.cms.CmsConstant;
import zes.openworks.intra.cms.CmsVO;

/**
 * Cms 관리 파일 업로드 유틸 클레스.
 * OP_FILE 테이블을 이용하지 않고 별도로 관리한다.
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
 *  2012. 5. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CmsUploadUtil {

    /** 서버 루트 경로 */
    public static final String WEBAPP_ROOT = GlobalConfig.WEBAPP_ROOT;
    /** Cms 관리 파일 업로드 루트 경로 */
    public static final String MENU_ROOT = CmsConstant.MENU_ROOT;
    /** 파일 구분자 */
    public static final String FILE_SEPA = GlobalConfig.FILE_SEPARATOR;

    /**
     * CMS 메뉴 관련 이미지 파일 업로드
     * 
     * @param files
     * @param cmsVo
     * @return
     */
    public static List<FileVO> upload(List<MultipartFile> files, CmsVO cmsVo) {

        if(Validate.isEmpty(files)) {
            return new ArrayList<FileVO>();
        }

        MultipartFile[] multiFiles = files.toArray(new MultipartFile[] {});
        String saveFolder = WEBAPP_ROOT + MENU_ROOT + "/" + cmsVo.getDomainCd() + "/" + cmsVo.getMenuCode();

        String concludeFolderPath = createFolderAsMenuCode(saveFolder);

        FileVO fileVo;
        List<FileVO> fileList = new ArrayList<FileVO>();

        try {
            for(MultipartFile multiFile : multiFiles) {

                if(multiFile.getSize() > 0) {

                    String uuid = UUID.randomUUID().toString();
                    String newFileName = renameTo(multiFile, cmsVo);
                    File newFileObject = new File(concludeFolderPath, newFileName);

                    String filePath = newFileObject.getAbsolutePath();
                    String fileType = multiFile.getContentType();

                    multiFile.transferTo(newFileObject);

                    fileVo = new FileVO();

                    fileVo.setFile(newFileObject);
                    fileVo.setFileUrl(FileUtil.getContextPath(WEBAPP_ROOT, filePath));
                    fileVo.setInputNm(multiFile.getName());
                    fileVo.setServerNm(newFileObject.getName());
                    fileVo.setLocalNm(multiFile.getOriginalFilename());
                    fileVo.setFileType(fileType);
                    fileVo.setFileSize(FileUtil.toDisplaySize(multiFile.getSize()));
                    fileVo.setFileByteSize(multiFile.getSize());
                    fileVo.setFileId(uuid);
                    fileVo.setFileExt(extension(fileVo.getLocalNm()));

                    fileList.add(fileVo);

                }
            }
        } catch (IOException e) {
            return new ArrayList<FileVO>();
        }

        return fileList;
    }

    /**
     * 저장 파일명. CMS는 메뉴 코드가 기본이므로 업로드되는 파일을 메뉴 코드명으로 설정하여 생성
     * 
     * @param multi
     * @param cmsVo
     * @return
     */
    private static String renameTo(MultipartFile multi, CmsVO cmsVo) {

        String fileName = multi.getOriginalFilename();
        String fileExtension = FileUtil.extension(fileName);
        String cmsFileName = "";
        String menuCode = cmsVo.getMenuCode();

        if("titleImgFile".equals(multi.getName())) {
            cmsFileName = "title_" + menuCode + "." + fileExtension;
        } else if("menuTitleImgFile".equals(multi.getName())) {
            cmsFileName = "menu_title_" + menuCode + "." + fileExtension;
        } else if("menuOnImgFile".equals(multi.getName())) {
            cmsFileName = "menu_on_" + menuCode + "." + fileExtension;
        } else if("menuOffImgFile".equals(multi.getName())) {
            cmsFileName = "menu_off_" + menuCode + "." + fileExtension;
        } else {
            cmsFileName = UUID.randomUUID() + "." + fileExtension;
        }

        return cmsFileName;
    }

    /**
     * 파일 확장자 반환
     * 
     * @param fileName
     * @return
     */
    private static String extension(String fileName) {
        return FileUtil.extension(fileName).toLowerCase();
    }

    /**
     * 폴더 생성
     * 
     * @param fullFolderPath
     * @return
     */
    private static String createFolderAsMenuCode(String fullFolderPath) {

        CmsUtil.mkdirs(fullFolderPath);

        return fullFolderPath;
    }
}
