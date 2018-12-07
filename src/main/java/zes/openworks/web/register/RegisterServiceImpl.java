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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import zes.base.pager.Pager;
import zes.base.vo.PaggingVO;
import zes.openworks.intra.bassDegreeManage.BassDegreeManageVO;
import zes.openworks.intra.dmandExaminDtls.DmandExaminRegistMngrVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.register.SupplierInfoVO;

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
@Service("registerService")
public class RegisterServiceImpl extends AbstractServiceImpl implements RegisterService {

    @Resource
    private RegisterDao dao;

    @Override
    public List<RegisterVO> userGubun(RegisterVO vo) {
        return dao.userGubun(vo);
    }

    @Override
    public RegisterVO pUserForm(RegisterVO vo) {
        return dao.pUserForm(vo);
    }

    @Override
    public RegisterVO cUserForm(RegisterVO vo) {
        return dao.cUserForm(vo);
    }

    @Override
    public RegisterVO stUserForm(RegisterVO vo) {
        return dao.stUserForm(vo);
    }

    @Override
    public List<RegisterVO> interestItemList(RegisterVO vo) {
        return dao.interestItemList(vo);
    }

    @Override
    public int checkDupleId(RegisterUserVO vo) {
        return dao.checkDupleId(vo);
    }

    @Override
    public int insertAction(RegisterUserVO vo) {
        return dao.insertAction(vo);
    }

    @Override
    public int insertOptionAction(RegisterUserVO vo) {
        return dao.insertOptionAction(vo);
    }

    @Override
    public int cpUserInsertAction(RegisterUserVO vo) {
        return dao.cpUserInsertAction(vo);
    }

    @Override
    public int cpUserOptionInsertAction(RegisterUserVO vo) {
        return dao.cpUserOptionInsertAction(vo);
    }

    @Override
    public RegisterUserVO updateForm(RegisterUserVO uservo) {
        return dao.updateForm(uservo);
    }

    @Override
    public int updateAction(RegisterUserVO vo) {
        return dao.updateAction(vo);
    }

    @Override
    public int updateOptionAction(RegisterUserVO vo) {
        return dao.updateOptionAction(vo);
    }

    @Override
    public RegisterUserVO checkPassword(RegisterUserVO vo) {
        return dao.checkPassword(vo);
    }

    @Override
    public RegisterUserVO updateCompanyForm(RegisterUserVO uservo) {
        return dao.updateCompanyForm(uservo);
    }

    @Override
    public int cpUserUpdateAction(RegisterUserVO vo) {
        return dao.cpUserUpdateAction(vo);
    }

    @Override
    public int cpUserOptionUpdateAction(RegisterUserVO vo) {
        return dao.cpUserOptionUpdateAction(vo);
    }

    @Override
    public Map<String, Integer> userOutConfirm(UserLoginVO vo) {
        return dao.userOutConfirm(vo);
    }

    @Override
    public int userOutConfirm2(RegisterUserVO vo) {
        return dao.userOutConfirm2(vo);
    }

    @Override
    public int userOutConfirm3(RegisterUserVO vo) {
        return dao.userOutConfirm3(vo);
    }

    @Override
    public List<Map<String, Object>> userNation(RegisterVO vo) {
        return dao.userNation(vo);
    }

    @Override
    public int emailDupleCheck(RegisterUserVO vo) {
        return dao.emailDupleCheck(vo);
    }

    @Override
    public Map<String, Object> mailCrtfcInsert(RegisterUserVO vo) {
        return dao.mailCrtfcInsert(vo);
    }

    @Override
    public Map<String, Object> mailCrtfcCheck(String cryEnKey, Integer seq) {
        return dao.mailCrtfcCheck(cryEnKey, seq);
    }

    @Override
    public Integer mailCrtftDelete(Integer seq) {
        return dao.mailCrtftDelete(seq);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List prvCodeList(String langCode, int grpCd) {
        return dao.prvCodeList(langCode, grpCd);
    }

    @Override
    public Integer passwordUpdateAction(RegisterUserVO vo) {
        return dao.passwordUpdateAction(vo);
    }

    @Override
    public Integer checkDupleStoreNm(RegisterUserVO vo) {
        return dao.checkDupleStoreNm(vo);
    }

    @Override
    public Integer checkDupleBizrno(RegisterUserVO vo) {
        return dao.checkDupleBizrno(vo);
    }

    @Override
    public Integer dupleDplctSbscrbPrvnKey(String sbscrbTyCd) {
        return dao.dupleDplctSbscrbPrvnKey(sbscrbTyCd);
    }

    @Override
    public RegisterUserVO cetifybizNo(RegisterUserVO vo) {
        return dao.cetifybizNo(vo);
    }

    @Override
    public Integer checkStoreSales(RegisterUserVO vo) {
        return dao.checkStoreSales(vo);
    }

    @Override
    public List<Map<String, Object>> cmntyList(RegisterUserVO vo) {
        return dao.cmntyList(vo);
    }

    @Override
    public int recovryDrmncyAction(RegisterUserVO vo) {
        return dao.recovryDrmncyAction(vo);
    }

    @Override
    public int deleteUserDrmncy(RegisterUserVO vo) {
        return dao.deleteUserDrmncy(vo);
    }


    @Override
    public List<PblinsttVO> pblinsttTypeList() {
        return dao.pblinsttTypeList();
    }
    @Override
    public List<PblinsttVO> upperPblinsttList(PblinsttVO vo) {
        return dao.upperPblinsttList(vo);
    }
    @Override
    public List<PblinsttVO> pblinsttList(PblinsttVO vo) {
        return dao.pblinsttList(vo);
    }

    @Override
    public DcPartcptReqstVO partcptCount() {
        return dao.partcptCount();
    }

    @Override
    public int reqstChk(DcPartcptReqstVO vo) {
        return dao.reqstChk(vo);
    }

    @Override
    public int reqstInsertAction(DcPartcptReqstVO vo) {
        return dao.reqstInsertAction(vo);
    }

    @Override
    public DcPartcptReqstVO dcPartcptAprslt(DcPartcptReqstVO vo) {
        return dao.dcPartcptAprslt(vo);
    }

    @Override
    public int aprsltCanclAction(DcPartcptReqstVO vo) {
        return dao.aprsltCanclAction(vo);
    }
    
    @Override
    public int bassAgremInsertAction(BassAgremVO vo) {
        return dao.bassAgremInsertAction(vo);
    }
    
    @Override
    public int bassAgremInsertNewAction(BassAgremVO vo) {
        return dao.bassAgremInsertNewAction(vo);
    }
    
    @Override
    public int bassAgremUpdateAction(BassAgremVO vo) {
        return dao.bassAgremUpdateAction(vo);
    }
    
    @Override
    public List<RegisterUserVO> searchUserList(RegisterUserVO vo) {
        return dao.searchUserList(vo);
    }

    @Override
    public int updateMasterId(RegisterUserVO vo) {
        return dao.updateMasterId(vo);
    }

    @Override
    public Pager<RegisterUserVO> subList(RegisterUserVO vo) {
        return dao.subList(vo);
    }

    @Override
    public int deleteSubForm(RegisterUserVO vo, HttpServletRequest request) {
        return dao.deleteSubForm(vo);
    }

    @Override
    public int updateUserTyCd(RegisterUserVO vo) {
        return dao.updateUserTyCd(vo);
    }

    @Override
    public int selectStoreCnt(RegisterUserVO vo) {
        return dao.selectStoreCnt(vo);
    }

    @Override
    public int updateStoreData(RegisterUserVO vo) {
        return dao.updateStoreData(vo);
    }

    @Override
    public int insertStoreData(RegisterUserVO vo) {
        return dao.insertStoreData(vo);
    }

    @Override
    public int updateUserOpt(RegisterUserVO vo) {
        return dao.updateUserOpt(vo);
    }

    @Override
    public List<OrganPagerVo> searchOrganList(OrganPagerVo vo) {
        return dao.searchOrganList(vo);
    }
 
    @Override
    public BassAgremVO bassAgremView(BassAgremVO vo) {
        return dao.bassAgremView(vo);
    }
 
    
    @Override
    public RegisterUserVO svcStrorView(RegisterUserVO vo) {
        return dao.svcStrorView(vo);
    }

    @Override
    public int bassAgremStatAction(BassAgremVO vo) {
        return dao.bassAgremStatAction(vo);
    }
    
    @Override
    public Pager<SupplierInfoVO> supplierInfoList(SupplierInfoVO vo) {
        
        return dao.supplierInfoList(vo);
    }

    @Override
    public BassDegreeManageVO degreeInfo() {
        return dao.degreeInfo();
    }

    @Override
    public int supplierInfoCnt(Map<String, Object> dataMap) {
         return dao.supplierInfoCnt(dataMap);
    }
    @Override
    public int getBassAgremMaxSeq(Map<String, Object> dataMap) {
         return dao.getBassAgremMaxSeq(dataMap);
    }
    
    public int saveUserEnterOpt(RegisterUserVO uvo){
        return dao.saveUserEnterOpt(uvo);
    }
    
    @Override
    public DmandExaminRegistMngrVO dmandExaminRegistMngrInfo() {
        return dao.dmandExaminRegistMngrInfo();
    }
    
    @Override
    public RegisterUserVO pblinsttNmChkAction(String userId) {
        return dao.pblinsttNmChkAction(userId);
    }
    
    @Override
    public int pblinsttNmCnfirmAction(String userId) {
        return dao.pblinsttNmCnfirmAction(userId);
    }
    
    @Override
    public int dmandExaminChagerCnt(RegisterUserVO vo) {
        return dao.dmandExaminChagerCnt(vo);
    }

    /**
     * 등록기간 체크, 0 일때만 등록가능
     * 
     * @see zes.openworks.web.register.RegisterService#chkRegistTerm()
     */
    @Override
    public Object chkRegistTerm() {       
        return dao.chkRegistTerm();
    }
}
