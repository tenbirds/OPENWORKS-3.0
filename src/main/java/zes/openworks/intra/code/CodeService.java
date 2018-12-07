/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.code;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import zes.base.pager.Pager;

/**
 * 코드관리 DAO interface
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
 *  2012. 4. 26.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

public interface CodeService {

    /**
     * 코드 목록
     */
    List<CodeVO> codeList(CodeVO vo);
    List<CodeVO> codeList2(CodeVO vo);    


    /**
     * 코드 목록
     */
    List<CodeVO> grpList(CodeVO vo);

    /**
     * 코드 상세조회
     */
    CodeVO codeView(CodeVO vo);

    /**
     * 코드 등록 액션
     */
    Integer insertAction(CodeVO vo);

    /**
     * 코드 수정 액션
     */
    int updateAction(CodeVO vo);

    /**
     * 코드 삭제 액션
     */
    int deleteAction(CodeVO vo);

    /**
     * 코드 카테고리 정보 페이지
     */
    List<String> ctgCdList(CodeCtgVO CodeCtgVO2);

    /**
     * 코드 카테고리 정보 조회
     */
    CodeCtgVO ctgView(CodeCtgVO CodeCtgVO2);

    /**
     * 코드 카테고리 정보 등록 액션
     */
    Object ctgInsertAction(CodeCtgVO CodeCtgVO2);

    /**
     * 코드 카테고리 정보 수정 액션
     */
    int ctgUpdateAction(CodeCtgVO CodeCtgVO2);

    /**
     * 코드 카테고리 정보 삭제 액션
     */
    int ctgDeleteAction(CodeCtgVO CodeCtgVO2);

    /**
     * 코드 조회
     */
    CodeVO codeSelect(CodeVO vo);

    /**
     * 코드 조회
     */
    CodeVO checkCode(CodeVO vo);

    /**
     * 전체코드 목록 조회
     */
    List<CodeVO> totalCodeList(CodeVO vo);

    List<CodeVO> ctgList(CodeCtgVO CodeCtgVO2);

    List<CodeVO> prvNmForCtgCd(CodeCtgVO CodeCtgVO2);

    List<CodeVO> prvNmUseYnList(CodeVO vo);
    
    List<CodeVO> getLangCodeList(CodeVO vo);

    /**
     * changeLogList 설명
     * 
     * @param vo
     * @return
     */
    Pager<LoggingCodeVO> changeLogList(CodeVO vo);

    /**
     * regExcelEnBloLoad 개별코드 일괄 등록 엑셀 로드
     * 
     * @param request
     * @return
     * @throws Exception
     */
    List<CodeVO> regExcelEnBloLoad(HttpServletRequest request) throws Exception;

    /**
     * insertPrvExcelEnBloc 개별코드 일괄 등록
     * 
     * @param vo
     */
    String[] insertPrvExcelEnBloc(CodeVO vo);

    /**
     * langList 설명
     * @param vo
     * @return
     */
    List<CodeVO>  langList(CodeVO vo);
    
    /** 20150901 소트 수정 추가 시작  */
    /**
     * 코드정렬순서 최대값 설명
     * @param vo
     * @return
     */
    int selectCodeSelectMaxOrder(CodeVO vo);
    
    /**
     * 코드정렬순서가 커졌을때 설명
     * @param vo
     * @return
     */
    int updateCodeUpdateOrderNoUp(CodeVO vo);
    
    /**
     * 코드정렬순서가 작아졌을때 설명
     * @param vo
     * @return
     */
    int updateCodeUpdateOrderNoDown(CodeVO vo);
    
    /**
     * 코드정렬순서 업데이트 설명
     * @param vo
     * @return
     */
    int updateCodeUpdateOrderNo(CodeVO vo);
    /** 20150901 소트 수정 추가 끝  */
}
