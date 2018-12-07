/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.util.random.RandomNumber;
import zes.openworks.component.file.FileDAO;
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
 *         </pre>
 * 
 * @see
 */
@SuppressWarnings("unchecked")
@Repository
public class RegisterDao extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * userGubun 설명
     *
     * @param vo
     * @return
     */
    public List<RegisterVO> userGubun(RegisterVO vo) {
        return list("_register.userGubun", vo);
    }

    /**
     * pUserForm 설명
     *
     * @param vo
     * @return
     */
    public RegisterVO pUserForm(RegisterVO vo) {
        return (RegisterVO) selectByPk("_register.pUserForm", vo);
    }

    /**
     * cUserForm 설명
     *
     * @param vo
     * @return
     */
    public RegisterVO cUserForm(RegisterVO vo) {
        return (RegisterVO) selectByPk("_register.cUserForm", vo);
    }

    /**
     * stUserForm 설명
     *
     * @param vo
     * @return
     */
    public RegisterVO stUserForm(RegisterVO vo) {
        return (RegisterVO) selectByPk("_register.stUserForm", vo);
    }

    /**
     * interestItemList 설명
     *
     * @param vo
     * @return
     */
    public List<RegisterVO> interestItemList(RegisterVO vo) {
        return list("_register.interestItemList", vo);
    }

    /**
     * checkDupleId 설명
     *
     * @param vo
     * @return
     */
    public int checkDupleId(RegisterUserVO vo) {
        return (Integer) selectByPk("_register.checkDupleId", vo);
    }

    /**
     * insertAction 설명
     *
     * @param vo
     * @return
     */
    public int insertAction(RegisterUserVO vo) {

        RegisterUserVO register = new RegisterUserVO();
        register.setEmail(vo.getEmail());
        register.setBizrno(vo.getBizrno());
        if((Integer) selectByPk("_register.emailDupleCheck", vo) > 0) {
            return 999; // 최종 사업자번호 중복확인
        }

        int num = insert("_register.insertAction", vo); // 회원 기본정보
        if(vo.getUserTyCd().toString().startsWith("10")) {
            insert("_register.insertOptionAction", vo); // 개인회원 추가정보
        } else if(vo.getUserTyCd().toString().startsWith("20")) {
            insert("_register.insertEntrprsAction", vo); // 기업회원 추가정보
        } else if(vo.getUserTyCd().toString().startsWith("30")) {
            insert("_register.insertPblinsttAction", vo); // 공공기관 추가정보
        } else {
            return 888; // 회원구분 오류
        }

        if(Validate.isNotEmpty(vo.getCtgryCodes())) {
            for(String ctgryCode : vo.getCtgryCodes()) {
                vo.setCtgryCode(ctgryCode);
                insert("_register.insertCategoryAction", vo); // 관심카테고리 추가
            }
        }

        if(vo.getUserTyCd().toString().endsWith("02")) {
            vo.setStoreImageFileSeq(fileDao.saveFile(vo.getFileList(), vo.getStoreImageFileSeq()));
            for(int i = 0 ; i < vo.getStoreLangCodes().length ; ++i) {
                vo.setStoreLangCode(vo.getStoreLangCodes()[i]);
                vo.setLangStoreNm(Validate.isNotEmpty(vo.getLangStoreNms()) ? vo.getLangStoreNms()[i] : "");
                vo.setLangStoreIntrcn(Validate.isNotEmpty(vo.getLangStoreIntrcns()) ? vo.getLangStoreIntrcns()[i] : "");
                vo.setStoreUrl(Validate.isNotEmpty(vo.getStoreUrls()) ? vo.getStoreUrls()[i] : "");
                vo.setReprsntTelno(Validate.isNotEmpty(vo.getReprsntTelnos()) ? vo.getReprsntTelnos()[i] : "");
                vo.setReprsntEmail(Validate.isNotEmpty(vo.getReprsntEmails()) ? vo.getReprsntEmails()[i] : "");
                vo.setStoreChargerNm(Validate.isNotEmpty(vo.getStoreChargerNms()) ? vo.getStoreChargerNms()[i] : "");
                insert("_register.mergeStoreAction", vo); // 구매판매회원 상점정보
            }
        }
        return num;
    }

    /**
     * insertOptionAction 설명
     *
     * @param vo
     * @return
     */
    public int insertOptionAction(RegisterUserVO vo) {
        return update("_register.insertOptionAction", vo);
    }

    /**
     * cpUserInsertAction 설명
     *
     * @param vo
     * @return
     */
    public int cpUserInsertAction(RegisterUserVO vo) {
        return update("_register.cpUserInsertAction", vo);
    }

    /**
     * cpUserOptionInsertAction 설명
     *
     * @param vo
     * @return
     */
    public int cpUserOptionInsertAction(RegisterUserVO vo) {
        return update("_register.cpUserOptionInsertAction", vo);
    }

    /**
     * updateForm 설명
     *
     * @param vo
     * @return
     */
    public RegisterUserVO updateForm(RegisterUserVO uservo) {

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("userId", uservo.getUserId());
        parameterMap.put("userTyCd", uservo.getUserTyCd());
        parameterMap.put("nationCode", uservo.getNationCode());
        parameterMap.put("langCode", uservo.getLangCode());
        if(uservo.getUserTyCd() == 1001) {// 개인 수요자/공급자
            /*
             * parameterMap.put("column",
             * "B.SMS_RECPTN_AGRE_CD AS smsRecptnAgreCd");
             */
            parameterMap.put("tableId", "OP_USER_OPTION");
        } else if(uservo.getUserTyCd() == 3001 || uservo.getUserTyCd() == 3002) {// 공공기관
                                                                                 // 수요자
            parameterMap.put("tableId", "OP_USER_PBLINSTT_OPTION");
        } else {// 기업 수요자/공급자
            /*
             * parameterMap.put("column",
             * "B.FAX_RECPTN_AGRE_CD AS faxRecptnAgreCd");
             */
            parameterMap.put("tableId", "OP_USER_ENTRPRS_OPTION");
        }
        RegisterUserVO vo = (RegisterUserVO) selectByPk("_register.updateForm", parameterMap);

        List<Map<String, String>> list = list("_register.userCategory", parameterMap);
        for(int i = 0 ; i < list.size() ; ++i) {
            int indexNum = list.get(i).get("CTGRYPATH").toString().lastIndexOf(">") + 1;
            list.get(i).put("CTGRYNM", list.get(i).get("CTGRYPATH").toString().substring(indexNum)); // 최하위의
                                                                                                     // 카테고리
            list.get(i).put("CTGRYPATH", list.get(i).get("CTGRYPATH").toString().substring(0, indexNum));
        }

        vo.setCtgryList(list);
        if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2002) {
            vo.setUserList(list("_register.updateStoreForm", uservo));
            for(int i = 0 ; i < vo.getUserList().size() ; ++i) {
                if(i == 0) {
                    RegisterUserVO store = vo.getUserList().get(i);
                    vo.setFileList(fileDao.getFiles(store.getStoreImageFileSeq()));
                }
            }
        }
        return vo;
    }

    /**
     * updateAction 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int updateAction(RegisterUserVO vo) {
        int num = 0;
        if(Validate.isEmpty(vo.getUserTyCd2())) {
            if(vo.getUserTyCd() == 3001 || vo.getUserTyCd() == 3002) {
                insert("_register.updatePblinsttAction", vo); // 공공기관회원 추가정보
            }
            /*
             * if(vo.getUserTyCd() == 1001) {
             * //insert("_register.updateOptionAction", vo); // 개인회원 추가정보
             * } else if(vo.getUserTyCd() == 3001) {
             * //insert("_register.updatePblinsttAction", vo); // 공공기관회원 추가정보
             * } else {
             * //insert("_register.updateEntrprsAction", vo); // 기업회원 추가정보
             * }
             */
            delete("_register.deleteCategory", vo);
            if(Validate.isNotEmpty(vo.getCtgryCodes())) {
                for(String ctgryCode : vo.getCtgryCodes()) {
                    vo.setCtgryCode(ctgryCode);
                    insert("_register.insertCategoryAction", vo);
                }
            }
            /*
             * if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2002) {
             * int fileSeq = (Integer)
             * selectByPk("_register.selectStoreImageFileSeq", vo.getUserId());
             * if(fileSeq != vo.getStoreImageFileSeq()) {
             * //기존 파일SEQ 비교후 삭제후 신규저장
             * fileDao.removeFile(fileSeq);
             * vo.setStoreImageFileSeq(fileDao.saveFile(vo.getFileList(),
             * vo.getStoreImageFileSeq()));
             * } else if(vo.getStoreImageFileSeq() == -1 &&
             * Validate.isNotEmpty(vo.getFileList())) {
             * vo.setStoreImageFileSeq(fileDao.saveFile(vo.getFileList(),
             * vo.getStoreImageFileSeq()));
             * }
             * }
             */
        } /*
           * else if(vo.getUserTyCd2() == 1002 || vo.getUserTyCd2() == 2002 ||
           * vo.getUserTyCd2() == 3002){
           * //판매전환시 신규 파일로
           * vo.setStoreImageFileSeq(fileDao.saveFile(vo.getFileList(),
           * vo.getStoreImageFileSeq()));
           * }
           */

        /*
         * if(Validate.isNotEmpty(vo.getStoreLangCodes())){
         * List reqLangCdList = new ArrayList(); //추가 및 수정 할 언어코드 리스트
         * for(int i = 0 ; i < vo.getStoreLangCodes().length ; ++i){
         * vo.setStoreLangCode(vo.getStoreLangCodes()[i]);
         * vo.setLangStoreNm(Validate.isNotEmpty(vo.getLangStoreNms()) ?
         * vo.getLangStoreNms()[i] : "");
         * vo.setLangStoreIntrcn(Validate.isNotEmpty(vo.getLangStoreIntrcns()) ?
         * vo.getLangStoreIntrcns()[i] : "");
         * vo.setStoreUrl(Validate.isNotEmpty(vo.getStoreUrls()) ?
         * vo.getStoreUrls()[i] : "");
         * vo.setReprsntTelno(Validate.isNotEmpty(vo.getReprsntTelnos()) ?
         * vo.getReprsntTelnos()[i] : "");
         * vo.setReprsntEmail(Validate.isNotEmpty(vo.getReprsntEmails()) ?
         * vo.getReprsntEmails()[i] : "");
         * vo.setStoreChargerNm(Validate.isNotEmpty(vo.getStoreChargerNms()) ?
         * vo.getStoreChargerNms()[i] : "");
         * insert("_register.mergeStoreAction", vo); // 구매판매회원 상점정보
         * reqLangCdList.add(vo.getStoreLangCodes()[i]);
         * }
         * List dbLangCdList = new ArrayList();
         * List delLangList = new ArrayList();
         * dbLangCdList = list("_register.getDbLangCd", vo); //DB상의 활성화된 언어코드
         * 리스트
         * if(dbLangCdList.size() > 0){
         * for(int d = 0; d < dbLangCdList.size(); d++){
         * boolean flag = false;
         * for(int c = 0 ; c < reqLangCdList.size() ; ++c) {
         * //체크해제된 언어는 비활성 처리
         * if(dbLangCdList.get(d).equals(reqLangCdList.get(c))){
         * flag = true;
         * reqLangCdList.remove(c);
         * break;
         * }
         * }
         * if(!flag){
         * delLangList.add(dbLangCdList.get(d));
         * }
         * }
         * if(delLangList.size() > 0){
         * for(int j = 0 ; j < delLangList.size(); j++) {
         * vo.setLangCode(delLangList.get(j).toString());
         * update("_register.updateStoreActvty", vo); //기존언어 수정
         * }
         * }
         * }
         * }
         */

        num = update("_register.updateAction", vo); // 회원 기본정보

        return num;
    }

    /**
     * updateOptionAction 설명
     *
     * @param vo
     * @return
     */
    public int updateOptionAction(RegisterUserVO vo) {
        return update("_register.updateOptionAction", vo);
    }

    /**
     * checkPassword 설명
     *
     * @param vo
     * @return
     */
    public RegisterUserVO checkPassword(RegisterUserVO vo) {
        return (RegisterUserVO) selectByPk("_register.checkPassword", vo);
    }

    /**
     * updateCompanyForm 설명
     *
     * @param uservo
     * @return
     */
    public RegisterUserVO updateCompanyForm(RegisterUserVO uservo) {
        return (RegisterUserVO) selectByPk("_register.updateCompanyForm", uservo);
    }

    /**
     * cpUserUpdateAction 설명
     *
     * @param vo
     * @return
     */
    public int cpUserUpdateAction(RegisterUserVO vo) {
        return update("_register.cpUserUpdateAction", vo);
    }

    /**
     * cpUserOptionUpdateAction 설명
     *
     * @param vo
     * @return
     */
    public int cpUserOptionUpdateAction(RegisterUserVO vo) {
        return update("_register.cpUserOptionUpdateAction", vo);
    }

    /**
     * userOutConfirm 설명
     *
     * @param vo
     * @return
     */
    public Map<String, Integer> userOutConfirm(UserLoginVO vo) {
        Map<String, Integer> cnt = (Map<String, Integer>) selectByPk("_register.deleteRequirement", vo);

        if(Validate.isEmpty(cnt.get("GOODSCNT")) && Validate.isEmpty(cnt.get("CMMNTYCNT")) && Validate.isEmpty(cnt.get("ORDRCNT"))) {
            if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2002 || vo.getUserTyCd() == 3002) {
                // 서브 회원일 경우 스토어 정보 업데이트 안함
                if(vo.getMasterId().equals(null) || vo.getMasterId().equals("")) {
                    // 판매회원 스토어 정보 업데이트 및 첨부파일 삭제
                    RegisterUserVO userVo = new RegisterUserVO();
                    userVo.setUserId(vo.getUserId());
                    userVo.setUserList(list("_register.updateStoreForm", userVo));
                    RegisterUserVO store = userVo.getUserList().get(0);
                    fileDao.removeFile(store.getStoreImageFileSeq());
                    update("_register.userOutConfirm1", vo);
                }
            }
            if(vo.getUserTyCd().toString().startsWith("10")) {
                // 개인 회원 삭제 (10)
                delete("_register.userOutConfirm2", vo);

                // 판매회원 일때 공급자 정보 테이블 삭제
                if(vo.getUserTyCd().toString().endsWith("02")) {
                    delete("_register.userOutConfirm3", vo);
                }
            } else if(vo.getUserTyCd().toString().startsWith("20")) {
                // 사업자 회원 삭제 (20)
                delete("_register.userOutConfirm3", vo);
            } else {
                // 공공 회원 삭제 (30)
                delete("_register.userOutConfirm4", vo);

                // 판매회원 일때 공급자 정보 테이블 삭제
                if(vo.getUserTyCd().toString().endsWith("02")) {
                    delete("_register.userOutConfirm3", vo);
                }
            }
            delete("_register.deleteCategory", vo); // 관심카테고리정보 삭제
            vo.setUserSttusCd(1002);// 회원 본인 탈퇴
            cnt.put("affected", update("_register.userOutConfirm", vo));
        } else {
            cnt.put("affected", 0);
        }
        return cnt;
    }

    /**
     * userOutConfirm2 설명
     *
     * @param vo
     * @return
     */
    public int userOutConfirm2(RegisterUserVO vo) {
        return delete("_register.userOutConfirm2", vo);
    }

    public int userOutConfirm3(RegisterUserVO vo) {
        return delete("_register.userOutConfirm3", vo);
    }

    public List<Map<String, Object>> userNation(RegisterVO vo) {
        return list("_register.userNation", vo);
    }

    public int emailDupleCheck(RegisterUserVO vo) {
        return (Integer) selectByPk("_register.emailDupleCheck", vo);
    }

    /**
     * 인증메일 정보 저장
     */
    public Map<String, Object> mailCrtfcInsert(RegisterUserVO vo) {
        Crypto cry = CryptoFactory.getInstance("SEED");

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("cyrEnKey", cry.encrypt(userTempKey(6, 4)));
        parameterMap.put("userNm", vo.getUserNm());
        parameterMap.put("userTyCd", vo.getUserTyCd());
        parameterMap.put("email", vo.getEmail());

        int dupEmail = (Integer) selectByPk("_register.emailDupleCheck2", parameterMap);
        if(dupEmail == StringUtil.ZERO) {
            parameterMap.put("affected", insert("_register.mailCrtfcInsert", parameterMap));
        } else {
            parameterMap.put("affected", 999);
        }

        return parameterMap;
    }

    /**
     * 인증메일 유효시간 체크
     */
    public Map<String, Object> mailCrtfcCheck(String cryEnKey, Integer seq) {

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("cryEnKey", cryEnKey);
        parameterMap.put("seq", seq);
        Map<String, Object> crtfcKeyValue = (Map<String, Object>) selectByPk("_register.mailCrtfcCheck", parameterMap);
        return crtfcKeyValue;
    }

    /**
     * 인증메일에서의 가입취소
     */
    public Integer mailCrtftDelete(Integer seq) {
        int affected = delete("_register.mailCrtftDelete", seq);
        return affected;
    }

    /**
     * 임시 비밀번호 생성
     * EX : AA1234567
     * 8자리로 구성하며 앞 두자리는 임의의 영문자 나머지는 숫자로 구성
     */
    private String userTempKey(int alplen, int numlen) {
        String alp = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String num = "0123456789";
        String newkey = "";
        int max = alplen + numlen;
        int n = 0;
        int a_len = alp.length();
        int n_len = num.length();

        for(int i = 0 ; i < max ; i++) {
            if(i < alplen) {
                n = RandomNumber.getInt(a_len);
                newkey = newkey + alp.charAt(n);
            } else {
                n = RandomNumber.getInt(n_len);
                newkey = newkey + num.charAt(n);
            }
        }
        return newkey;
    }

    /**
     * 공통코드 테이블 코드 목록 불러옴
     */
    @SuppressWarnings("rawtypes")
    public List prvCodeList(String langCode, int grpCd) {

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("langCode", langCode);
        parameterMap.put("grpCd", grpCd);

        return list("_register.prvCodeList", parameterMap);
    }

    /**
     * 사용자 비밀번호 변경 액션
     */
    public int passwordUpdateAction(RegisterUserVO vo) {
        RegisterUserVO user = (RegisterUserVO) selectByPk("_register.checkPassword", vo);
        if((Validate.isNotEmpty(user.getBeforePassword()) && user.getBeforePassword().equals(vo.getUserPassword2()))
            || user.getUserPassword().equals(vo.getUserPassword2())) {
            // 이전 비밀번호와 동일할 경우
            return 999;
        }
        int affected = update("_register.passwordUpdateAction", vo);

        return affected;
    }

    /**
     * 스토어명 중복 검사
     */
    public Integer checkDupleStoreNm(RegisterUserVO vo) {
        return (Integer) selectByPk("_register.checkDupleStoreNm", vo);
    }

    /**
     * 사업자번호 중복 검사
     */
    public Integer checkDupleBizrno(RegisterUserVO vo) {
        return (Integer) selectByPk("_register.checkDupleBizrno", vo);
    }

    /**
     * I-PIN & SMS 인증 중복방지키값 중복 검사
     */
    public Integer dupleDplctSbscrbPrvnKey(String sbscrbTyCd) {
        return (Integer) selectByPk("_register.dupleDplctSbscrbPrvnKey", sbscrbTyCd);
    }

    public RegisterUserVO cetifybizNo(RegisterUserVO vo) {
        return (RegisterUserVO) selectByPk("_register.cetifybizNo", vo);
    }

    public Integer checkStoreSales(RegisterUserVO vo) {
        return (Integer) selectByPk("_register.checkStoreSales", vo);
    }

    public List<Map<String, Object>> cmntyList(RegisterUserVO vo) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        list.add((Map<String, Object>) selectByPk("_register.cmntyList1", vo));
        list.addAll(list("_register.cmntyList2", vo));
        list.add((Map<String, Object>) selectByPk("_register.cmntyList3", vo));
        return list;
    }

    /**
     * recovryDrmncyAction 설명
     *
     * @param vo
     * @return
     */
    public int recovryDrmncyAction(RegisterUserVO vo) {
        return update("_register.recovryDrmncyAction", vo);
    }

    public int deleteUserDrmncy(RegisterUserVO vo) {
        return delete("_register.deleteUserDrmncy", vo);
    }

    /**
     * 기관유형
     *
     * @param
     * @return
     */
    public List<PblinsttVO> pblinsttTypeList() {
        return list("_register.pblinsttTypeList", "");
    }

    /**
     * 상위기관목록
     *
     * @param
     * @return
     */
    public List<PblinsttVO> upperPblinsttList(PblinsttVO vo) {
        return list("_register.upperPblinsttList", vo);
    }

    /**
     * 기관목록 조회
     *
     * @param vo
     * @return 기관목록
     */
    public List<PblinsttVO> pblinsttList(PblinsttVO vo) {
        return list("_register.pblinsttList", vo);
    }

    /**
     * 사전설명회 카운트
     *
     * @param
     * @return 사전설명회 카운트
     */
    public DcPartcptReqstVO partcptCount() {
        DcPartcptReqstVO vo = new DcPartcptReqstVO();
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("partcptSe", 1001);
        vo.setPartcptCnt1((Integer) selectByPk("_register.partcptCount", parameterMap));
        parameterMap.put("partcptSe", 1002);
        vo.setPartcptCnt2((Integer) selectByPk("_register.partcptCount", parameterMap));
        return vo;
    }

    /**
     * 사전설명회 신청 체크
     *
     * @param
     * @return 사전설명회 신청 체크
     */
    public int reqstChk(DcPartcptReqstVO vo) {
        return (Integer) selectByPk("_register.reqstChk", vo);
    }

    /**
     * 사전설명회 신청
     *
     * @param vo
     * @return
     */
    public int reqstInsertAction(DcPartcptReqstVO vo) {

        return insert("_register.reqstInsertAction", vo);
    }

    /**
     * 사전설명회 신청결과
     *
     * @param vo
     * @return DcPartcptReqstVO
     */
    public DcPartcptReqstVO dcPartcptAprslt(DcPartcptReqstVO vo) {
        return (DcPartcptReqstVO) selectByPk("_register.dcPartcptAprslt", vo);
    }

    /**
     * 사전설명회 신청 취소
     *
     * @param vo
     * @return int
     */
    public int aprsltCanclAction(DcPartcptReqstVO vo) {
        return delete("_register.aprsltCanclAction", vo);
    }

    /**
     * bassAgremInsertAction (기본협약관리 등록)
     * 
     * @param vo
     * @return
     */
    public int bassAgremInsertAction(BassAgremVO vo) {

        // 기업로그
        if(vo.getMultiFile().size() > 0) {
            vo.setMultiFileSeq(fileDao.saveFile(vo.getMultiFile(), vo.getMultiFileSeq()));
        }

        // 기본협약서파일
        if(vo.getBassAgrmntFile().size() > 0) {
            vo.setBassAgrmntFileSeq(fileDao.saveFile(vo.getBassAgrmntFile(), vo.getBassAgrmntFileSeq()));
        } else {
            vo.setBassAgrmntFileSeq(-1);
        }
        // 등기부등본파일
        if(vo.getRgsbukTrnscrFile().size() > 0) {
            vo.setRgsbukTrnscrFileSeq(fileDao.saveFile(vo.getRgsbukTrnscrFile(), vo.getRgsbukTrnscrFileSeq()));
        } else {

            String hdRgsbukTrnscrFileFileId = vo.getHdRgsbukTrnscrFile();

            if((hdRgsbukTrnscrFileFileId != null) && (!"".equals(hdRgsbukTrnscrFileFileId))) // 1차
                                                                                             // 파일이
                                                                                             // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdRgsbukTrnscrFileFileId); // 1차 파일
                vo.setRgsbukTrnscrFileSeq(fvo.getFileSeq());
                ;
            } else {
                vo.setRgsbukTrnscrFileSeq(-1);
            }
        }
        // 벤처기업증명서파일
        if(vo.getVnentrCrtfFile().size() > 0) {
            vo.setVnentrCrtfFileSeq(fileDao.saveFile(vo.getVnentrCrtfFile(), vo.getVnentrCrtfFileSeq()));
        } else {

            String hdVnentrCrtfFileId = vo.getHdVnentrCrtfFile();

            if((hdVnentrCrtfFileId != null) && (!"".equals(hdVnentrCrtfFileId))) // 1차
                                                                                 // 파일이
                                                                                 // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdVnentrCrtfFileId); // 1차 파일
                vo.setVnentrCrtfFileSeq(fvo.getFileSeq());
                ;
            } else {
                vo.setVnentrCrtfFileSeq(-1);
            }
        }
        // 직접생산증명서파일
        if(vo.getDirectPrdctnCrtfFile().size() > 0) {
            vo.setDirectPrdctnCrtfFileSeq(fileDao.saveFile(vo.getDirectPrdctnCrtfFile(), vo.getDirectPrdctnCrtfFileSeq()));
        } else {

            String hdDirectPrdctnCrtfFileId = vo.getHdDirectPrdctnCrtfFile();

            if((hdDirectPrdctnCrtfFileId != null) && (!"".equals(hdDirectPrdctnCrtfFileId))) // 1차
                                                                                             // 파일이
                                                                                             // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdDirectPrdctnCrtfFileId); // 1차 파일
                vo.setDirectPrdctnCrtfFileSeq(fvo.getFileSeq());
            } else {
                vo.setDirectPrdctnCrtfFileSeq(-1);
            }
        }
        // 신용평가서파일
        if(vo.getCdltDocFile().size() > 0) {
            vo.setCdltDocFileSeq(fileDao.saveFile(vo.getCdltDocFile(), vo.getCdltDocFileSeq()));
        } else {

            String hdCdltDocFileId = vo.getHdCdltDocFile();

            if((hdCdltDocFileId != null) && (!"".equals(hdCdltDocFileId))) // 1차
                                                                           // 파일이
                                                                           // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdCdltDocFileId); // 1차 파일
                vo.setCdltDocFileSeq(fvo.getFileSeq());
            } else {
                vo.setCdltDocFileSeq(-1);
            }

        }
        // 재무재표파일
        if(vo.getFnlttFile().size() > 0) {
            vo.setFnlttFileSeq(fileDao.saveFile(vo.getFnlttFile(), vo.getFnlttFileSeq()));
        } else {

            String hdFnlttFile = vo.getHdFnlttFile();

            if((hdFnlttFile != null) && (!"".equals(hdFnlttFile))) // 1차 파일이
                                                                   // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdFnlttFile); // 1차 파일
                vo.setFnlttFileSeq(fvo.getFileSeq());
            } else {
                vo.setFnlttFileSeq(-1);
            }

        }

        return insert("_register.bassAgremInsertAction", vo);
    }

    /**
     * bassAgremInsertNewAction (기본협약관리 등록)
     * 
     * @param vo
     * @return
     */
    public int bassAgremInsertNewAction(BassAgremVO vo) {

        // 기업로그
        if(vo.getMultiFile().size() > 0) {
            vo.setMultiFileSeq(fileDao.saveFile(vo.getMultiFile(), vo.getMultiFileSeq()));
        }

        // 기본협약서파일
        if(vo.getBassAgrmntFile().size() > 0) {
            vo.setBassAgrmntFileSeq(fileDao.saveFile(vo.getBassAgrmntFile(), vo.getBassAgrmntFileSeq()));
        } else {
            vo.setBassAgrmntFileSeq(-1);
        }
        // 등기부등본파일
        if(vo.getRgsbukTrnscrFile().size() > 0) {
            vo.setRgsbukTrnscrFileSeq(fileDao.saveFile(vo.getRgsbukTrnscrFile(), vo.getRgsbukTrnscrFileSeq()));
        } else {

            String hdRgsbukTrnscrFileFileId = vo.getHdRgsbukTrnscrFile();

            if((hdRgsbukTrnscrFileFileId != null) && (!"".equals(hdRgsbukTrnscrFileFileId))) // 1차
                                                                                             // 파일이
                                                                                             // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdRgsbukTrnscrFileFileId); // 1차 파일
                vo.setRgsbukTrnscrFileSeq(fvo.getFileSeq());
                ;
            } else {
                vo.setRgsbukTrnscrFileSeq(-1);
            }
        }
        // 벤처기업증명서파일
        if(vo.getVnentrCrtfFile().size() > 0) {
            vo.setVnentrCrtfFileSeq(fileDao.saveFile(vo.getVnentrCrtfFile(), vo.getVnentrCrtfFileSeq()));
        } else {

            String hdVnentrCrtfFileId = vo.getHdVnentrCrtfFile();

            if((hdVnentrCrtfFileId != null) && (!"".equals(hdVnentrCrtfFileId))) // 1차
                                                                                 // 파일이
                                                                                 // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdVnentrCrtfFileId); // 1차 파일
                vo.setVnentrCrtfFileSeq(fvo.getFileSeq());
                ;
            } else {
                vo.setVnentrCrtfFileSeq(-1);
            }
        }
        // 직접생산증명서파일
        if(vo.getDirectPrdctnCrtfFile().size() > 0) {
            vo.setDirectPrdctnCrtfFileSeq(fileDao.saveFile(vo.getDirectPrdctnCrtfFile(), vo.getDirectPrdctnCrtfFileSeq()));
        } else {

            String hdDirectPrdctnCrtfFileId = vo.getHdDirectPrdctnCrtfFile();

            if((hdDirectPrdctnCrtfFileId != null) && (!"".equals(hdDirectPrdctnCrtfFileId))) // 1차
                                                                                             // 파일이
                                                                                             // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdDirectPrdctnCrtfFileId); // 1차 파일
                vo.setDirectPrdctnCrtfFileSeq(fvo.getFileSeq());
            } else {
                vo.setDirectPrdctnCrtfFileSeq(-1);
            }
        }
        // 신용평가서파일
        if(vo.getCdltDocFile().size() > 0) {
            vo.setCdltDocFileSeq(fileDao.saveFile(vo.getCdltDocFile(), vo.getCdltDocFileSeq()));
        } else {

            String hdCdltDocFileId = vo.getHdCdltDocFile();

            if((hdCdltDocFileId != null) && (!"".equals(hdCdltDocFileId))) // 1차
                                                                           // 파일이
                                                                           // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdCdltDocFileId); // 1차 파일
                vo.setCdltDocFileSeq(fvo.getFileSeq());
            } else {
                vo.setCdltDocFileSeq(-1);
            }

        }
        // 재무재표파일
        if(vo.getFnlttFile().size() > 0) {
            vo.setFnlttFileSeq(fileDao.saveFile(vo.getFnlttFile(), vo.getFnlttFileSeq()));
        } else {

            String hdFnlttFile = vo.getHdFnlttFile();

            if((hdFnlttFile != null) && (!"".equals(hdFnlttFile))) // 1차 파일이
                                                                   // 존재하면..
            {
                FileVO fvo = fileDao.getFile(hdFnlttFile); // 1차 파일
                vo.setFnlttFileSeq(fvo.getFileSeq());
            } else {
                vo.setFnlttFileSeq(-1);
            }

        }

        return insert("_register.bassAgremInsertNewAction", vo);
    }

    /**
     * bassAgremInsertAction (기본협약관리 등록)
     * 
     * @param vo
     * @return
     */
    public int bassAgremUpdateAction(BassAgremVO vo) {

        // 기업로그
        if(vo.getMultiFile().size() > 0) {
            vo.setMultiFileSeq(fileDao.saveFile(vo.getMultiFile(), vo.getMultiFileSeq()));
        }

        // 기본협약서파일
        if(vo.getBassAgrmntFile().size() > 0) {
            vo.setBassAgrmntFileSeq(fileDao.saveFile(vo.getBassAgrmntFile(), vo.getBassAgrmntFileSeq()));
        }

        // 등기부등본파일
        if(vo.getRgsbukTrnscrFile().size() > 0) {
            vo.setRgsbukTrnscrFileSeq(fileDao.saveFile(vo.getRgsbukTrnscrFile(), vo.getRgsbukTrnscrFileSeq()));
        }

        // 벤처기업증명서파일
        if(vo.getVnentrCrtfFile().size() > 0) {
            vo.setVnentrCrtfFileSeq(fileDao.saveFile(vo.getVnentrCrtfFile(), vo.getVnentrCrtfFileSeq()));
        }

        // 직접생산증명서파일
        if(vo.getDirectPrdctnCrtfFile().size() > 0) {
            vo.setDirectPrdctnCrtfFileSeq(fileDao.saveFile(vo.getDirectPrdctnCrtfFile(), vo.getDirectPrdctnCrtfFileSeq()));
        }

        // 신용평가서파일
        if(vo.getCdltDocFile().size() > 0) {
            vo.setCdltDocFileSeq(fileDao.saveFile(vo.getCdltDocFile(), vo.getCdltDocFileSeq()));
        }

        // 재무재표파일
        if(vo.getFnlttFile().size() > 0) {
            vo.setFnlttFileSeq(fileDao.saveFile(vo.getFnlttFile(), vo.getFnlttFileSeq()));
        }

        return update("_register.bassAgremStatAction", vo);
    }

    /**
     * searchUserList 설명
     * 
     * @param vo
     * @return
     */
    public List<RegisterUserVO> searchUserList(RegisterUserVO vo) {
        return list("_register.searchUserList", vo);
    }

    /**
     * updateMasterId 설명
     * 
     * @param vo
     * @return
     */
    public int updateMasterId(RegisterUserVO vo) {
        int result = 0;
        update("_register.updateMasterId", vo);
        if(selectByPk("_register.entrprsSearchUser", vo).equals(StringUtil.ONE)) {
            update("_register.updateSubIntoEntrprs", vo);
        } else {
            insert("_register.insertSubIntoEntrprs", vo);
        }
        result = 1;
        return result;
    }

    /**
     * subList 설명
     * 
     * @param vo
     * @return
     */
    public Pager<RegisterUserVO> subList(RegisterUserVO vo) {
        List<RegisterUserVO> dataList = list("_register.subList", vo);
        vo.setTotalNum((Integer) selectByPk("_register.subListCount", vo));

        return new Pager<RegisterUserVO>(dataList, vo);
    }

    /**
     * deleteSubForm 설명
     * 
     * @param vo
     * @param request
     * @return
     */
    public int deleteSubForm(RegisterUserVO vo) {
        int result = 0;
        for(int i = 0 ; i < vo.getDeleleLists().length ; i++) {
            vo.setUserId(vo.getDeleleLists()[i]);
            selectByPk("_register.deleteSubList", vo);
            selectByPk("_register.updateSubList", vo);
            result = 1;
        }
        return result;
    }

    /**
     * updateUserTyCd 설명
     * 
     * @param vo
     * @return
     */
    public int updateUserTyCd(RegisterUserVO vo) {

        return update("_register.updateUserTyCd", vo);
    }

    /**
     * selectStoreCnt 설명
     * 
     * @param vo
     * @return
     */
    public int selectStoreCnt(RegisterUserVO vo) {
        return (Integer) selectByPk("_register.selectStoreCnt", vo);
    }

    /**
     * updateStoreData 설명
     * 
     * @param vo
     * @return
     */
    public int updateStoreData(RegisterUserVO vo) {
        return update("_register.updateStoreData", vo);
    }

    /**
     * insertStoreData 설명
     * 
     * @param vo
     * @return
     */
    public int insertStoreData(RegisterUserVO vo) {
        return insert("_register.insertStoreData", vo);
    }

    /**
     * updateUserOpt 설명
     * 
     * @param vo
     * @return
     */
    public int updateUserOpt(RegisterUserVO vo) {
        return update("_register.updateUserOpt", vo);
    }

    /**
     * searchOrganList 설명
     * 
     * @param paramMap
     * @return
     */
    public List<OrganPagerVo> searchOrganList(OrganPagerVo vo) {
        if ("A".equals(vo.getFlag())) {
            return list("_register.searchOrganListTrgetInst", vo);
        }else{
            return list("_register.searchOrganList", vo);    
        }
    }

    /**
     * checkPassword 설명
     *
     * @param vo
     * @return
     */
    public BassAgremVO bassAgremView(BassAgremVO vo) {

        BassAgremVO bvo = (BassAgremVO) selectByPk("_register.bassAgremView", vo);

        /* 확정협약서 */
        if(Validate.isNotEmpty(bvo.getLastAgrmntFileSeq())) {
            bvo.setLastAgrmntFile(fileDao.getFiles(bvo.getLastAgrmntFileSeq()));
        }

        /* 제출협약서 */
        if(Validate.isNotEmpty(bvo.getBassAgrmntFileSeq())) {
            bvo.setBassAgrmntFile(fileDao.getFiles(bvo.getBassAgrmntFileSeq()));
        }

        /* 등기부등본 */
        if(Validate.isNotEmpty(bvo.getRgsbukTrnscrFileSeq())) {
            bvo.setRgsbukTrnscrFile(fileDao.getFiles(bvo.getRgsbukTrnscrFileSeq()));
        }

        /* 신용평가서 */
        if(Validate.isNotEmpty(bvo.getCdltDocFileSeq())) {
            bvo.setCdltDocFile(fileDao.getFiles(bvo.getCdltDocFileSeq()));
        }

        /* 재무재표 */
        if(Validate.isNotEmpty(bvo.getFnlttFileSeq())) {
            bvo.setFnlttFile(fileDao.getFiles(bvo.getFnlttFileSeq()));
        }

        /* 벤처기업인증서 */
        if(Validate.isNotEmpty(bvo.getVnentrCrtfFileSeq())) {
            bvo.setVnentrCrtfFile(fileDao.getFiles(bvo.getVnentrCrtfFileSeq()));
        }

        /* 직접생산증명서 */
        if(Validate.isNotEmpty(bvo.getDirectPrdctnCrtfFileSeq())) {
            bvo.setDirectPrdctnCrtfFile(fileDao.getFiles(bvo.getDirectPrdctnCrtfFileSeq()));
        }

        return bvo;
    }

    /**
     * checkPassword 설명
     *
     * @param vo
     * @return
     */
    public RegisterUserVO svcStrorView(RegisterUserVO vo) {
        RegisterUserVO rvo = (RegisterUserVO) selectByPk("_register.svcStrorView", vo);
        /* 직접생산증명서 */
        if(Validate.isNotEmpty(rvo.getStoreImageFileSeq())) {
            rvo.setFileList(fileDao.getFiles(rvo.getStoreImageFileSeq()));
        }

        return rvo;
    }

    /**
     * bassAgremStatAction 설명
     * 
     * @param vo
     * @return
     */
    public int bassAgremStatAction(BassAgremVO vo) {
        update("_register.bassAgremStatAction", vo);
        return 1;
    }

    /**
     * bassAgremManageList (기본협약관리 목록)
     * 
     * @param vo
     * @return
     */
    public Pager<SupplierInfoVO> supplierInfoList(SupplierInfoVO vo) {
        vo.setTotalNum((Integer) selectByPk("_register.supplierInfoListCount", vo.getDataMap()));

        List<SupplierInfoVO> dataList = list("_register.supplierInfoList", vo.getDataMap());
        return new Pager<SupplierInfoVO>(dataList, vo);
    }

    public BassDegreeManageVO degreeInfo() {
        Map<String, String> vo = new HashMap<String, String>();
        return (BassDegreeManageVO) selectByPk("_register.degreeInfo", vo);
    }

    public int supplierInfoCnt(Map<String, Object> dataMap) {
        return (Integer) selectByPk("_register.supplierInfoListCount", dataMap);
    }

    public int getBassAgremMaxSeq(Map<String, Object> dataMap) {
        return (Integer) selectByPk("_register.getBassAgremMaxSeq", dataMap);
    }

    public int saveUserEnterOpt(RegisterUserVO uvo) {
        int result;
        if(selectByPk("_register.entrprsSearchUser", uvo).equals(StringUtil.ONE)) {
            result = update("_register.updateIntoEntrprs", uvo);
        } else {
            result = insert("_register.insertIntoEntrprs", uvo);
        }
        return result;
    }

    /**
     * 수요조사 작성관리정보 조회
     *
     * @param
     * @return DmandExaminRegistMngrVO
     */
    public DmandExaminRegistMngrVO dmandExaminRegistMngrInfo() {
        return (DmandExaminRegistMngrVO) selectByPk("_register.dmandExaminRegistMngrInfo", null);
    }

    /**
     * 수요조사 담당자정보 체크(기관정보체크)
     *
     * @param String
     * @return RegisterUserVO
     */
    public RegisterUserVO pblinsttNmChkAction(String userId) {
        return (RegisterUserVO) selectByPk("_register.pblinsttNmChkAction", userId);
    }

    /**
     * 수요조사 기관명확인 플래그 update
     *
     * @param String
     * @return int
     */
    public int pblinsttNmCnfirmAction(String userId) {
        return update("_register.pblinsttNmCnfirmAction", userId);
    }

    /**
     * 해당기관의 수요조사 담당자 카운트
     *
     * @param RegisterUserVO
     * @return int
     */
    public int dmandExaminChagerCnt(RegisterUserVO vo) {
        return (Integer) selectByPk("_register.dmandExaminChagerCnt", vo);
    }

    /**
     * 등록기간 체크, 0 일때만 등록가능
     * 
     * @return
     */
    public int chkRegistTerm() {
        return (Integer) selectByPk("_register.chkRegistTerm", null);
    }
}
