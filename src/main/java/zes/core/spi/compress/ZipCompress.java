/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.spi.compress;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import javax.activation.MimetypesFileTypeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.base.vo.FileVO;
import zes.core.utils.FileUtil;
import zes.core.utils.PathUtil;
import zes.openworks.common.GlobalConfig;

/**
 * ZIP 형식의 압축 파일을 관리한다.
 * <p />
 * zip 파일의 압축 해제 및 압축
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
 *  2012. 4. 6.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ZipCompress {

    /** 로깅 */
    private static Logger logger = LoggerFactory.getLogger(ZipCompress.class);

    /** 압축 레벨 */
    public static final int COMPRESSION_LEVEL = 8;
    /** 파일 스트림 버퍼 사이즈 */
    public static final int BUFFER_SIZE = 64 * 1024;
    /** 파일경로 구분자 */
    public static final String FILE_SEPARATOR = GlobalConfig.FILE_SEPARATOR;
    /** 첨부파일 루트 경로 */
    public static final String UPLOAD_ROOT = GlobalConfig.UPLOAD_ROOT;

    /**
     * 파일목록을 받아서 압축한다.
     * 
     * @param fileList 압축대상 파일목록
     * @param zipPath 압축파일 저장 경로
     * @param zipFileName 압축파일명
     * @return
     * @throws IOException
     */
    public static File compress(List<File> fileList, String zipPath, String zipFileName)
        throws IOException {

        File zipFile = new File(zipPath, zipFileName);
        File parentDir = zipFile.getParentFile();

        if(!parentDir.exists()) {
            parentDir.mkdirs();
        }

        String enrtyName;

        BufferedOutputStream bos = null;
        ZipOutputStream zos = null;

        try {

            byte[] buffer = new byte[BUFFER_SIZE];
            bos = new BufferedOutputStream(new FileOutputStream(zipFile));
            zos = new ZipOutputStream(bos);

            zos.setLevel(COMPRESSION_LEVEL);

            for(File file : fileList) {
                if(!file.exists() || !file.isFile()) {
                    continue;
                }

                enrtyName = file.getName();

                FileInputStream in = new FileInputStream(file);
                BufferedInputStream bis = new BufferedInputStream(in);

                zos.putNextEntry(new ZipEntry(enrtyName));
                int len;
                while((len = bis.read(buffer)) > 0) {
                    zos.write(buffer, 0, len);
                }
                zos.closeEntry();
                bis.close();
                in.close();
            }
            zos.close();
            bos.close();

        } catch (Exception e) {
            if(logger.isDebugEnabled()) {
                logger.debug("file compress failed", e);
            }
        } finally {
            if(zos != null) {
                zos.close();
            }
            if(bos != null) {
                bos.close();
            }
        }

        return zipFile;
    }

    /**
     * 웹 컨트롤러 기본 파일속성 객체인 FileVO 객체를 이용한 파일 압축
     * 
     * @param fileList 압축대상 파일목록
     * @param zipPath 압축파일 저장 경로
     * @param zipFileName 압축파일명
     * @return
     * @throws IOException
     */
    public static File compressVO(List<FileVO> fileList, String zipPath, String zipFileName)
        throws IOException {

        File zipFile = new File(zipPath, zipFileName);
        File parentDir = zipFile.getParentFile();

        if(!parentDir.exists()) {
            parentDir.mkdirs();
        }

        String enrtyName;
        String filePath;

        BufferedOutputStream bos = null;
        ZipOutputStream zos = null;
        try {

            byte[] buffer = new byte[BUFFER_SIZE];
            bos = new BufferedOutputStream(new FileOutputStream(zipFile));
            zos = new ZipOutputStream(bos);

            zos.setLevel(COMPRESSION_LEVEL);

            for(FileVO fileVo : fileList) {

                filePath = UPLOAD_ROOT + fileVo.getFileUrl();
                filePath = PathUtil.replacePath(filePath);

                enrtyName = fileVo.getLocalNm();

                FileInputStream in = new FileInputStream(filePath);
                BufferedInputStream bis = new BufferedInputStream(in);

                zos.putNextEntry(new ZipEntry(enrtyName));
                int len;
                while((len = bis.read(buffer)) > 0) {
                    zos.write(buffer, 0, len);
                }
                zos.closeEntry();
                bis.close();

            }
            zos.close();
            bos.close();

        } catch (Exception e) {
            if(logger.isDebugEnabled()) {
                logger.debug("File compress failed", e);
            }
        } finally {
            if(zos != null) {
                zos.close();
            }
            if(bos != null) {
                bos.close();
            }
        }

        return zipFile;
    }

    /**
     * 디렉토리 압축
     * 
     * @param sourcePath 압축 디렉토리
     * @param zipPath 압축파일 저장 경로
     * @param zipFileName 압축파일명
     * @return 압축결과파일
     * @throws Exception
     */
    public static File compressDir(String sourcePath, String zipPath, String zipFileName)
        throws Exception {

        int cnt = 0;
        byte[] buffer = new byte[BUFFER_SIZE];

        FileInputStream finput = null;
        FileOutputStream foutput = null;
        ZipOutputStream zoutput = null;
        ZipEntry zentry = null;

        File zipFile = new File(zipPath, zipFileName);
        File parentDir = zipFile.getParentFile();

        if(!parentDir.exists()) {
            parentDir.mkdirs();
        }

        File sourceDir = new File(sourcePath);

        try {
            foutput = new FileOutputStream(zipFile);
            zoutput = new ZipOutputStream(foutput);

            File[] files = sourceDir.listFiles();
            for(File file : files) {
                finput = new FileInputStream(file);
                zentry = new ZipEntry(file.getCanonicalPath());
                zoutput.putNextEntry(zentry);
                zoutput.setLevel(COMPRESSION_LEVEL);
                cnt = 0;

                while((cnt = finput.read(buffer)) != -1) {
                    zoutput.write(buffer, 0, cnt);
                }
                finput.close();
            }

            zoutput.closeEntry();
        } catch (Exception e) {
            try {
                zipFile.delete();
            } catch (Exception e1) {}
        } finally {
            if(finput != null) {
                finput.close();
            }
            if(zoutput != null) {
                zoutput.close();
            }
            if(foutput != null) {
                foutput.close();
            }
        }

        return zipFile;
    }

    /**
     * 압축해제
     * 
     * @param source zip 압축 파일명
     * @param zipPath 압축해제 폴더
     * @return 압축해제 목록
     * @throws IOException
     */
    public static List<File> unCompress(String source, String zipPath) throws IOException {

        FileInputStream fis = new FileInputStream(new File(source));

        return unCompress(fis, zipPath);
    }

    /**
     * 압축해제
     * 
     * @param source zip 압축 파일
     * @param zipPath 압축해제 폴더
     * @return 압축해제 목록
     * @throws IOException
     */
    public static List<File> unCompress(File source, String zipPath) throws IOException {

        FileInputStream fis = new FileInputStream(source);

        return unCompress(fis, zipPath);
    }

    /**
     * 압축해제
     * 
     * @param is 파일입력 스트림
     * @param zipPath 압축해제 폴더
     * @return 압축해제 목록
     * @throws IOException
     * @see {@link UUID}
     */
    public static List<File> unCompress(InputStream is, String zipPath)
        throws IOException {

        List<File> fileList = new ArrayList<File>();
        String basePath = zipPath + FILE_SEPARATOR;

        BufferedOutputStream bos = null;
        ZipInputStream zis = null;

        try {
            is = new BufferedInputStream(is);

            zis = new ZipInputStream(is);
            ZipEntry entry;
            File file;

            while((entry = zis.getNextEntry()) != null) {

                file = new File(basePath + entry.getName());

                if(entry.isDirectory()) {
                    if(!file.exists()) {
                        file.mkdirs();
                    }
                } else {

                    file = new File(basePath + entry.getName());

                    bos = new BufferedOutputStream(new FileOutputStream(file));
                    byte[] bytes = new byte[1024];

                    int c;
                    while((c = zis.read(bytes)) != -1) {
                        bos.write(bytes, 0, c);
                    }

                    zis.closeEntry();
                    bos.close();

                    fileList.add(file);
                }
            }
        } catch (IOException e) {
            if(logger.isDebugEnabled()) {
                logger.debug("File uncompress failed", e);
            }
        } finally {
            if(zis != null) {
                zis.close();
            }
            if(bos != null) {
                bos.close();
            }
            if(is != null) {
                is.close();
            }
        }

        return fileList;
    }

    /**
     * 압축해제(파일명 변경(UUID))
     * 
     * @param source zip 압축 파일명
     * @param zipPath 압축해제 폴더
     * @return 압축해제 목록
     * @throws IOException
     */
    public static List<FileVO> unCompressRename(File source, String zipPath)
        throws IOException {

        FileInputStream fis = new FileInputStream(source);

        return unCompressRename(fis, zipPath);
    }

    /**
     * 압축해제(파일명 변경(UUID))
     * 
     * @param source zip 압축 파일명
     * @param zipPath 압축해제 폴더
     * @return 압축해제 목록
     * @throws IOException
     * @see {@link UUID}
     */
    public static List<FileVO> unCompressRename(String source, String zipPath)
        throws IOException {

        FileInputStream fis = new FileInputStream(new File(source));

        return unCompressRename(fis, zipPath);
    }

    /**
     * 압축해제(파일명 변경(UUID))
     * 
     * @param is 파일입력 스트림
     * @param zipPath 압축해제 폴더
     * @param renameYn 파일명 변경 여부(UUID)
     * @return 압축해제 목록
     * @throws IOException
     * @see {@link UUID}
     */
    public static List<FileVO> unCompressRename(InputStream is, String zipPath)
        throws IOException {

        List<FileVO> fileList = new ArrayList<FileVO>();
        FileVO fileVo;

        String basePath;

        basePath = PathUtil.replacePath(zipPath);
        if(!basePath.endsWith(FILE_SEPARATOR)) {
            basePath = basePath + FILE_SEPARATOR;
        }

        BufferedOutputStream bos = null;
        ZipInputStream zis = null;

        try {
            is = new BufferedInputStream(is);

            zis = new ZipInputStream(is);
            ZipEntry entry;

            String newFileName;
            MimetypesFileTypeMap mimeTypeMap = new MimetypesFileTypeMap();

            while((entry = zis.getNextEntry()) != null) {

                File file = new File(basePath + entry.getName());

                if(entry.isDirectory()) {
                    if(!file.exists()) {
                        file.mkdirs();
                    }
                } else {

                    String uuid = UUID.randomUUID().toString();
                    String ext = getExtension(file.getName());

                    newFileName = renameTo(entry.getName(), uuid, ext);

                    file = new File(basePath, newFileName);

                    bos = new BufferedOutputStream(new FileOutputStream(file));
                    byte[] bytes = new byte[1024];

                    int c;
                    while((c = zis.read(bytes)) != -1) {
                        bos.write(bytes, 0, c);
                    }

                    zis.closeEntry();
                    bos.close();

                    fileVo = new FileVO();
                    fileVo.setFile(file);

                    fileVo.setFileId(uuid);
                    fileVo.setLocalNm(getFileName(entry.getName()));
                    fileVo.setServerNm(getFileName(newFileName));

                    fileVo.setFileExt(ext);
                    fileVo.setFileSize(FileUtil.toDisplaySize(file.length()));
                    fileVo.setFileByteSize(file.length());
                    fileVo.setFileType(mimeTypeMap.getContentType(file));
                    fileVo.setFileUrl(FileUtil.getContextPath(UPLOAD_ROOT, file.getAbsolutePath()));

                    fileList.add(fileVo);
                }
            }
        } catch (IOException e) {
            if(logger.isDebugEnabled()) {
                logger.debug("File uncompress failed", e);
            }
        } finally {
            if(zis != null) {
                zis.close();
            }
            if(bos != null) {
                bos.close();
            }
            if(is != null) {
                is.close();
            }
        }
        return fileList;
    }

    /**
     * ZIP 압축 파일 여부
     * 
     * @param contentType
     * @return
     */
    public static boolean isZipFile(String contentType) {

        return contentType.startsWith("application/zip")
            || contentType.startsWith("application/x-zip");
    }

    /**
     * 파일명 추출
     * 
     * @param fileName
     * @return
     */
    private static String getFileName(String fileName) {

        return FileUtil.filename(fileName);
    }

    /**
     * 파일 확장자 추출
     * 
     * @param fileName
     * @return
     */
    private static String getExtension(String fileName) {

        return FileUtil.extension(fileName).toLowerCase();
    }

    /**
     * 저장할 시스템 파일명 생성
     * 
     * @param pathName 저장 경로명
     * @param newName 시스템파일명
     * @param ext 확장자
     * @return 저장 파일명
     */
    private static String renameTo(String pathName, String newName, String ext) {

        String filePath = "";
        if(pathName.indexOf("/") > -1) {
            int idx = pathName.lastIndexOf("/");
            filePath = pathName.substring(0, idx + 1);
        }

        return filePath + newName + "." + ext;
    }

}
