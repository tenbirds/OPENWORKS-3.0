/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
import zes.openworks.intra.bassDegreeManage.BassDegreeManageVO;
import zes.openworks.intra.dmandExaminDtls.DmandExaminRegistMngrVO;
import zes.openworks.web.login.UserLoginVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일               수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 16.     홍길동     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface RegisterService {

    /**
     * userGubun 설명
     *
     * @return
     */
    List<RegisterVO> userGubun(RegisterVO vo);

    /**
     * pUserForm 설명
     *
     * @param vo
     * @return
     */
    RegisterVO pUserForm(RegisterVO vo);

    /**
     * cUserForm 설명
     *
     * @param vo
     * @return
     */
    RegisterVO cUserForm(RegisterVO vo);

    /**
     * stUserForm 설명
     *
     * @param vo
     * @return
     */
    RegisterVO stUserForm(RegisterVO vo);

    /**
     * interestItemList 설명
     *
     * @param vo
     * @return
     */
    List<RegisterVO> interestItemList(RegisterVO vo);

    /**
     * checkDupleId 설명
     *
     * @param vo
     * @return
     */
    int checkDupleId(RegisterUserVO vo);

    /**
     * insertAction 설명
     *
     * @param vo
     * @return
     */
    int insertAction(RegisterUserVO vo);

    /**
     * insertOptionAction 설명
     *
     * @param vo
     */
    int insertOptionAction(RegisterUserVO vo);

    /**
     * cpUserInsertAction 설명
     *
     * @param vo
     * @return
     */
    int cpUserInsertAction(RegisterUserVO vo);

    /**
     * cpUserOptionInsertAction 설명
     *
     * @param vo
     */
    int cpUserOptionInsertAction(RegisterUserVO vo);

    /**
     * updateForm 설명
     *
     * @param vo
     * @return
     */
    RegisterUserVO updateForm(RegisterUserVO uservo);

    /**
     * updateAction 설명
     *
     * @param vo
     * @return
     */
    int updateAction(RegisterUserVO vo);

    /**
     * updateOptionAction 설명
     *
     * @param vo
     */
    int updateOptionAction(RegisterUserVO vo);

    /**
     * checkPassword 설명
     *
     * @param vo
     * @return
     */
    RegisterUserVO checkPassword(RegisterUserVO vo);

    /**
     * updateCompanyForm 설명
     *
     * @param uservo
     * @return
     */
    RegisterUserVO updateCompanyForm(RegisterUserVO uservo);

    /**
     * cpUserUpdateAction 설명
     *
     * @param vo
     * @return
     */
    int cpUserUpdateAction(RegisterUserVO vo);

    /**
     * cpUserOptionUpdateAction 설명
     *
     * @param vo
     */
    int cpUserOptionUpdateAction(RegisterUserVO vo);

    /**
     * userOutConfirm 설명
     *
     * @param vo
     * @return
     */
    Map<String, Integer> userOutConfirm(UserLoginVO vo);

    /**
     * userOutConfirm2 설명
     *
     * @param vo
     */
    int userOutConfirm2(RegisterUserVO vo);

    /**
     * userOutConfirm3 설명
     *
     * @param vo
     * @return
     */
    int userOutConfirm3(RegisterUserVO vo);

    /**
     * updateAction 설명
     *
     * @param vo
     * @return
     */
    int recovryDrmncyAction(RegisterUserVO vo);

    int deleteUserDrmncy(RegisterUserVO vo);

    List<Map<String, Object>> userNation(RegisterVO vo);

    int emailDupleCheck(RegisterUserVO vo);

    Map<String, Object> mailCrtfcInsert(RegisterUserVO vo);

    Map<String, Object> mailCrtfcCheck(String cryEnKey, Integer seq);

    Integer mailCrtftDelete(Integer seq);

    @SuppressWarnings("rawtypes")
    List prvCodeList(String langCode, int grpCd);

    Integer passwordUpdateAction(RegisterUserVO vo);

    Integer checkDupleStoreNm(RegisterUserVO vo);

    Integer checkDupleBizrno(RegisterUserVO vo);

    Integer dupleDplctSbscrbPrvnKey(String sbscrbTyCd);

    RegisterUserVO cetifybizNo(RegisterUserVO vo);

    Integer checkStoreSales(RegisterUserVO vo);

    List<Map<String, Object>> cmntyList(RegisterUserVO vo);


    /**
     * 기관유형리스트
     *
     * @param
     * @return List
     */
    List<PblinsttVO> pblinsttTypeList();
    /**
     * 상위기관리스트
     *
     * @param
     * @return List
     */
    List<PblinsttVO> upperPblinsttList(PblinsttVO vo);
    /**
     * 기관리스트
     *
     * @param
     * @return List
     */
    List<PblinsttVO> pblinsttList(PblinsttVO vo);

    /**
     * 사전설명회 카운트
     *
     * @param
     * @return DcPartcptReqstVO
     */
    DcPartcptReqstVO partcptCount();

    /**
     * 사전설명회 신청여부 체크
     *
     * @param
     * @return DcPartcptReqstVO
     */
    int reqstChk(DcPartcptReqstVO vo);

    /**
     * 사전설명회 신청
     *
     * @param vo
     * @return
     */
    int reqstInsertAction(DcPartcptReqstVO vo);

    /**
     * 사전설명회 신청결과
     *
     * @param vo
     * @return DcPartcptReqstVO
     */
    DcPartcptReqstVO dcPartcptAprslt(DcPartcptReqstVO vo);

    /**
     * 사전설명회 신청 취소
     *
     * @param vo
     * @return int
     */
    int aprsltCanclAction(DcPartcptReqstVO vo);

    /**
     * bassAgremInsertAction 설명
     * @param vo
     * @return
     */
    int bassAgremInsertAction(BassAgremVO vo);


    /**
     * bassAgremInsertNewAction 설명
     * @param vo
     * @return
     */
    int bassAgremInsertNewAction(BassAgremVO vo);
    
    /**
     * bassAgremInsertAction 설명
     * @param vo
     * @return
     */
    int bassAgremUpdateAction(BassAgremVO vo);
    
    
    /**
     * searchUserList 설명
     * @return
     */
    List<RegisterUserVO> searchUserList(RegisterUserVO vo);

    /**
     * updateMasterId 설명
     * @param vo
     * @return
     */
    int updateMasterId(RegisterUserVO vo);

    /**
     * subList 설명
     * @param vo
     * @return
     */
    Pager<RegisterUserVO> subList(RegisterUserVO vo);

    /**
     * deleteSubForm 설명
     * @param vo
     * @param request
     * @return
     */
    int deleteSubForm(RegisterUserVO vo, HttpServletRequest request);

    /**
     * bassAgremUpdateUserTyCd 설명
     * @param vo
     * @return
     */
    int updateUserTyCd(RegisterUserVO vo);

    /**
     * selectStoreCnt 설명
     * @param uvo
     * @return
     */
    int selectStoreCnt(RegisterUserVO uvo);

    /**
     * updateStoreData 설명
     * @param uvo
     */
    int updateStoreData(RegisterUserVO uvo);
    
    /**
     * insertStore 설명
     * @param uvo
     */
    int insertStoreData(RegisterUserVO uvo);

    /**
     * updateUserOpt 설명
     * @param vo
     */
    int updateUserOpt(RegisterUserVO vo);
    
    /**
     * searchOrganList 설명
     * @param paramMap
     * @return
     */
    List<OrganPagerVo> searchOrganList(OrganPagerVo vo);
    
    //{{ 공급자정보관리 
    BassAgremVO bassAgremView(BassAgremVO vo);
  
    RegisterUserVO svcStrorView(RegisterUserVO vo);    
    
    int bassAgremStatAction(BassAgremVO vo);    
    
    Pager<SupplierInfoVO> supplierInfoList(SupplierInfoVO vo);
    
    BassDegreeManageVO degreeInfo();
   
    int supplierInfoCnt (Map<String, Object> dataMap);
    
    int getBassAgremMaxSeq(Map<String, Object> dataMap) ;//최종차수 가져오기 
    //}}
    
    int saveUserEnterOpt(RegisterUserVO uvo);    
    
    
    /**
     * 수요조사 작성관리정보 조회
     *
     * @param 
     * @return DmandExaminRegistMngrVO
     */
    DmandExaminRegistMngrVO dmandExaminRegistMngrInfo();
    
    /**
     * 수요조사 담당자정보 체크(기관정보체크)
     *
     * @param String
     * @return RegisterUserVO
     */
    RegisterUserVO pblinsttNmChkAction(String userId);
    
    /**
     * 수요조사 담당자 기관정보 확인
     *
     * @param String
     * @return int
     */
    int pblinsttNmCnfirmAction(String userId);
    
    /**
     * 해당기관의 수요조사 담당자 카운트
     *
     * @param
     * @return RegisterUserVO
     */
    int dmandExaminChagerCnt(RegisterUserVO vo);

    /**
     * 등록기간 체크, 0 일때만 등록가능
     * 
     * @return
     */
    Object chkRegistTerm();
}