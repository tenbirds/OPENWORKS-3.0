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
import java.util.List;

import zes.base.vo.FileVO;
import zes.core.spi.compress.ZipCompress;
import zes.openworks.common.GlobalConfig;

/**
 * ZIP 압축 유틸을 웹 컨트롤러 차원에서 사용하기 편하도록 지원하는 Helper 클레스
 * <p />
 * 웹 컨트롤러에서는 <code>FileVO</code> 객체를 기본으로 사용하므로 이를 <code>File</code> 객체로 변환하여
 * 적용시키는 등의 역할을 담당한다.
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
 *  2012. 4. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ZipHelper {

    /** Was ROOT 경로 */
    public static final String WEBAPP_ROOT = GlobalConfig.WEBAPP_ROOT;
    /** 파일경로구분자 */
    static final String PATH_SEPARATOR = "/";

    /**
     * 파일 목록을 받아 압축파일을 생성한다.
     * 
     * @param fileVoList FileVO 객체의 파일 목록
     * @param zipPath 압축파일을 생성할 경로 위치.
     *        경로가 절대 경로값으로 넘어 오는 경우 기본저장경로를 사용하지 않고,
     *        지정된 경로에 생성한다.
     *        <p />
     *        단! 주의 사항은 해당 경로에 파일 읽기/쓰기 권한이 있어야 한다.
     * @param zipFileName 압축파일 명
     * @return
     * @throws IOException
     */
    public static File compressFile(List<FileVO> fileVoList, String zipPath, String zipFileName)
        throws IOException {

        String filePath;
        String fileUrl;

        List<File> fileList = new ArrayList<File>();
        for(FileVO fileVo : fileVoList) {

            fileUrl = fileVo.getFileUrl();
            filePath = fileUrl.substring(0, fileUrl.lastIndexOf("/") + 1);
            File file = new File(WEBAPP_ROOT + filePath + fileVo.getLocalNm());

            fileList.add(file);
        }

        return ZipCompress.compress(fileList, zipPath, zipFileName);
    }
}
