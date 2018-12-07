/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.user.coLog.UserLogVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

/**
 * 회원 관리 DAO
 */

@Repository
@SuppressWarnings("unchecked")
public class UserDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * 회원정보 등록액션
     * 
     * @param vo
     * @return
     */
    public int insertAction(UserVO vo) {

        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setUserPassword(cry.encrypt(vo.getUserPassword()));

        int num = insert("_user.insertAction", vo); // 회원 기본정보
        if(vo.getUserTyCd() == 1001 || vo.getUserTyCd() == 1002) {
            insert("_user.insertOptionAction", vo); // 개인회원 추가정보
        } else if(vo.getUserTyCd() == 2001 || vo.getUserTyCd() == 2002) {
            insert("_user.insertEntrprsAction", vo); // 기업회원 추가정보
        } else {
            insert("_user.insertPblinsttAction", vo); // 공공기업 추가정보
        }
        if(Validate.isNotEmpty(vo.getCtgryCodes())){
            for(String ctgryCode : vo.getCtgryCodes()){
                vo.setCtgryCode(ctgryCode);
                insert("_user.insertCategoryAction", vo); // 관심카테고리 추가
            }
        }
        if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2002) {
            vo.setStoreImageFileSeq(fileDao.saveFile(vo.getFileList(), vo.getStoreImageFileSeq()));
            for(int i = 0 ; i < vo.getStoreLangCodes().length ; ++i) {
                vo.setStoreLangCode(vo.getStoreLangCodes()[i]);
                vo.setLangStoreNm(Validate.isNotEmpty(vo.getLangStoreNms()) ? vo.getLangStoreNms()[i] : "");
                vo.setLangStoreIntrcn(Validate.isNotEmpty(vo.getLangStoreIntrcns()) ? vo.getLangStoreIntrcns()[i] : "");
                vo.setStoreUrl(Validate.isNotEmpty(vo.getStoreUrls()) ? vo.getStoreUrls()[i] : "");
                vo.setReprsntTelno(Validate.isNotEmpty(vo.getReprsntTelnos()) ? vo.getReprsntTelnos()[i] : "");
                vo.setReprsntEmail(Validate.isNotEmpty(vo.getReprsntEmails()) ? vo.getReprsntEmails()[i] : "");
                vo.setStoreChargerNm(Validate.isNotEmpty(vo.getStoreChargerNms()) ? vo.getStoreChargerNms()[i] : "");
                insert("_user.mergeStoreAction", vo); // 구매판매회원 상점정보
            }
        }

        return num;
    }

    /**
     * 회원정보 수정액션
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int updateAction(UserVO vo) {

        int num = insert("_user.updateAction", vo); // 회원 기본정보
        if(vo.getUserTyCd() == 1001) {
            insert("_user.updateOptionAction", vo); // 개인회원 추가정보
        }  else if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2001 || vo.getUserTyCd() == 2002 || vo.getUserTyCd() == 3002) {
            insert("_user.updateEntrprsAction", vo); // 기업회원 추가정보
        } else {
            insert("_user.updatePblinsttAction", vo); // 공공기업 추가정보
        }
        if(Validate.isNotEmpty(vo.getCtgryCodes())){
            delete("_user.deleteCategory", vo);
            for(String ctgryCode : vo.getCtgryCodes()){
                vo.setCtgryCode(ctgryCode);
                insert("_user.insertCategoryAction", vo);
            }
        }
        if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2002 || vo.getUserTyCd() == 3002) {
            if(Validate.isNotEmpty((Integer) selectByPk("_user.selectStoreImageFileSeq", vo.getUserId()))){
                int fileSeq = (Integer) selectByPk("_user.selectStoreImageFileSeq", vo.getUserId());
                if(fileSeq != vo.getStoreImageFileSeq()) {
                    fileDao.removeFile(fileSeq);
                    vo.setStoreImageFileSeq(fileDao.saveFile(vo.getFileList(), vo.getStoreImageFileSeq()));
                }
            } else {
                vo.setStoreImageFileSeq(fileDao.saveFile(vo.getFileList(), vo.getStoreImageFileSeq()));
            }
            
            if(Validate.isNotEmpty(vo.getStoreLangCodes())){
                List reqLangCdList = new ArrayList();   //추가 및 수정 할 언어코드 리스트
                for(int i = 0 ; i < vo.getStoreLangCodes().length ; ++i) {
                    vo.setStoreLangCode(vo.getStoreLangCodes()[i]);
                    vo.setLangStoreNm(Validate.isNotEmpty(vo.getLangStoreNms()) ? vo.getLangStoreNms()[i] : "");
                    vo.setLangStoreIntrcn(Validate.isNotEmpty(vo.getLangStoreIntrcns()) ? vo.getLangStoreIntrcns()[i] : "");
                    vo.setStoreUrl(Validate.isNotEmpty(vo.getStoreUrls()) ? vo.getStoreUrls()[i] : "");
                    vo.setReprsntTelno(Validate.isNotEmpty(vo.getReprsntTelnos()) ? vo.getReprsntTelnos()[i] : "");
                    vo.setReprsntEmail(Validate.isNotEmpty(vo.getReprsntEmails()) ? vo.getReprsntEmails()[i] : "");
                    vo.setStoreChargerNm(Validate.isNotEmpty(vo.getStoreChargerNms()) ? vo.getStoreChargerNms()[i] : "");
                    insert("_user.mergeStoreAction", vo); // 구매판매회원 상점정보
                    reqLangCdList.add(vo.getStoreLangCodes()[i]);
                }

                List dbLangCdList = new ArrayList();
                List delLangList = new ArrayList();
                dbLangCdList = list("_user.getDbLangCd", vo);    //DB상의 활성화된 언어코드 리스트
                if(dbLangCdList.size() > 0){
                    for(int d = 0; d < dbLangCdList.size(); d++){
                        boolean flag = false;
                        for(int c = 0 ; c < reqLangCdList.size() ; ++c) {
                            //체크해제된 언어는 비활성 처리
                            if(dbLangCdList.get(d).equals(reqLangCdList.get(c))){  
                                flag = true;
                                reqLangCdList.remove(c);
                                break;
                            }
                        }
                        if(!flag){
                            delLangList.add(dbLangCdList.get(d));
                        }
                    }

                    if(delLangList.size() > 0){
                        for(int j = 0 ; j < delLangList.size(); j++) {
                            vo.setLangCode(delLangList.get(j).toString());
                            update("_user.updateStoreActvty", vo);  //기존언어 수정
                        }
                    }
                }
            }
        }

        return num;
    }

    /**
     * 회원(개인 + 기업) 상세보기
     * 
     * @param vo
     * @return
     */
    public UserVO userForm(UserVO vo) {

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("userId", vo.getUserId());
        parameterMap.put("userTyCd", vo.getUserTyCd());
        if(vo.getUserTyCd() == 1001) {
            parameterMap.put("column", "B.SMS_RECPTN_AGRE_CD AS smsRecptnAgreCd");
            parameterMap.put("tableId", "OP_USER_OPTION");
        } else if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2001 || vo.getUserTyCd() == 2002 || vo.getUserTyCd() == 3002) {
            parameterMap.put("column", "B.FAX_RECPTN_AGRE_CD AS faxRecptnAgreCd");
            parameterMap.put("tableId", "OP_USER_ENTRPRS_OPTION");
        } else {
            parameterMap.put("column", "B.PBLINSTT_CD AS pblinsttCd");
            parameterMap.put("tableId", "OP_USER_PBLINSTT_OPTION");
        }
        UserVO userVO = (UserVO) selectByPk("_user.updateForm", parameterMap);
        userVO.setCtgryList(list("_user.userCategory", parameterMap));
        if(userVO.getUserTyCd() == 1002 || userVO.getUserTyCd() == 2002 || userVO.getUserTyCd() == 3002) {
            userVO.setUserList(list("_user.updateStoreForm", vo));
            for(int i = 0 ; i < userVO.getUserList().size() ; ++i) {
                if(i == 0) {
                    UserVO store = userVO.getUserList().get(i);
                    userVO.setFileList(fileDao.getFiles(store.getStoreImageFileSeq()));
                }
            }
        }
        return userVO;
    }

    /**
     * 개인회원 상세보기
     * 
     * @param vo
     * @return
     */
    public UserVO pUpdateForm(UserVO vo) {

        return (UserVO) selectByPk("_user.pUpdateForm", vo);
    }

    /**
     * 사용자 ID 체크(vo)
     * 
     * @param vo
     * @return
     */
    public int checkDupleId(UserVO vo) {

        return (Integer) selectByPk("_user.checkDupleId", vo);
    }

    /**
     * userList 설명
     * 
     * @param vo
     * @return
     */
    public Pager<UserVO> userList(UserVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();

        Object searchKey0 = parameterMap.get("q_searchKey0");
        if(Validate.isNotEmpty(searchKey0)) {
            String[] searchKeys = searchKey0.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey0", searchKeys);
        }

        Object searchKey2 = parameterMap.get("q_searchKey2");
        if(Validate.isNotEmpty(searchKey2)) {
            String[] searchKeys = searchKey2.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey2", searchKeys);
        }

        vo.getDataMap().put("q_userSttusCd", vo.getUserSttusCd());

        List<UserVO> dataList = list("_user.userList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_user.userListCount", parameterMap));

        // 원시값 다시 밀어넣기
         vo.getDataMap().put("q_searchKey0", searchKey0);
         vo.getDataMap().put("q_searchKey2", searchKey2);
        return new Pager<UserVO>(dataList, vo);
    }

    /**
     * 회원 삭제 액션
     */
    public Map<String, Integer> deleteAction(UserVO vo) {
        
        Map<String, Integer> cnt =  (Map<String, Integer>) selectByPk("_user.deleteRequirement", vo);
        
        if(Validate.isEmpty(cnt.get("GOODSCNT")) && Validate.isEmpty(cnt.get("CMMNTYCNT")) && Validate.isEmpty(cnt.get("ORDRCNT"))) {
            if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2002 || vo.getUserTyCd() == 3002) {
                // 판매회원 스토어 정보 업데이트 및 첨부파일 삭제
                vo.setUserList(list("_user.updateStoreForm", vo));
                UserVO store = vo.getUserList().get(0);
                fileDao.removeFile(store.getStoreImageFileSeq());
                update("_user.delete3", vo);
            }
            if(vo.getUserTyCd() == 1001) {
                // 개인 회원 삭제
                delete("_user.delete1", vo);
            } else if(vo.getUserTyCd() == 2001) {
                // 사업자 회원 삭제
                delete("_user.delete2", vo);
            } else {
             // 공공기업 회원 삭제
                delete("_user.delete4", vo);
            }
            delete("_user.deleteCategory", vo); // 관심카테고리정보 삭제
            vo.setUserSttusCd(1003);//관리자가 삭제한 경우
            cnt.put("affected", update("_user.delete", vo));
        } else {
            cnt.put("affected", 0);
        }
        return cnt;
    }

    /**
     * 개인회원정보 수정액션
     * 
     * @param vo
     * @return
     */
    public int pUpdateAction(UserVO vo) {

        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setUserPassword(cry.encrypt(vo.getUserPassword()));
        // 개인사용자기본정보 수정1 (table :OP_USER)
        int affected = update("_user.pUpdateAction1", vo);
        // 개인사용자기본정보 수정2 (table :OP_USER_OPTION)
        update("_user.pUpdateAction2", vo);

        return affected;
    }

    /**
     * 개인회원 추가정보 상세보기
     * 
     * @param vo
     * @return
     */
    public UserVO pOptionUpdateForm(UserVO vo) {

        return (UserVO) selectByPk("_user.pOptionUpdateForm", vo);
    }

    /**
     * 개인회원 추가정보 수정액션
     * 
     * @param vo
     * @return
     */
    public int pOptionUpdateAction(UserVO vo) {
        // 개인사용자기본정보 수정1(table : OP_USER)
        int affected = update("_user.pOptionUpdateAction1", vo);
        // 개인사용자기본정보 수정2 (table :OP_USER_OPTION)
        update("_user.pOptionUpdateAction2", vo);

        return affected;
    }

    /**
     * 개인회원 마일리지 정보 등록액션
     * 
     * @param vo
     * @return
     */
    public int pUserMileageAction(UserVO vo) {

        // 개인사용자기본정보 수정1(table :OP_USER)
        int num = update("_user.pUserMileageInsertAction", vo);

        return num;
    }

    /**
     * ID로 비밀번호 가져오기
     * 
     * @param vo
     * @return
     */
    public Object selectUserPwd(UserLogVO lvo) {

        return selectByPk("_user.selectMgrPwd", lvo);
    }

    /**
     * ID로 비밀번호 가져오기
     * 
     * @param vo
     * @return
     */
    public int passwordUpdateAction(UserVO vo) {
        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setNewPassword(cry.encrypt(vo.getNewPassword()));

        vo.setUserPassword((String) selectByPk("_user.userPassword", vo));
        if(vo.getUserPassword().equals(vo.getNewPassword())) {
            // 이전 비밀번호와 동일할 경우
            return 999;
        }
        
        return update("_user.passwordUpdateAction", vo);
    }

    /**
     * 공통이력관리 액션
     * 
     * @param vo
     * @return
     */
    public Object userLogInsertAction(UserLogVO vo) {

        return insert("_user.userLogInsertAction", vo);
    }

    /**
     * userListCExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserVO> userListCExcel(UserVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        
        //회원구분
        Object searchKey0 = parameterMap.get("q_searchKey0");
        if(Validate.isNotEmpty(searchKey0)) {
            String[] searchKeys = searchKey0.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey0", searchKeys);
        }
        //회원등급
        Object searchKey2 = parameterMap.get("q_searchKey2");
        if(Validate.isNotEmpty(searchKey2)) {
            String[] searchKeys = searchKey2.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey2", searchKeys);
        }
        
        List<UserVO> dataList = list("_user.userListCExcel", parameterMap);

        return dataList;
    }

    /**
     * userListSExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<UserVO> userListSExcel(UserVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        
        //회원구분
        Object searchKey0 = parameterMap.get("q_searchKey0");
        if(Validate.isNotEmpty(searchKey0)) {
            String[] searchKeys = searchKey0.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey0", searchKeys);
        }
        //회원등급
        Object searchKey2 = parameterMap.get("q_searchKey2");
        if(Validate.isNotEmpty(searchKey2)) {
            String[] searchKeys = searchKey2.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey2", searchKeys);
        }
//
//        parameterMap.put("userId", vo.getUserId());
//        parameterMap.put("userNm", vo.getUserNm());
//        parameterMap.put("email", vo.getEmail());
//        parameterMap.put("userGradeNm", vo.getUserGradCode());
//        parameterMap.put("sexNm", vo.getSexdstnCd());
//        parameterMap.put("telNum", vo.getTelno());
//        parameterMap.put("mobile", vo.getMbtlnum());
//        parameterMap.put("baseAddr", vo.getBassAdres());
//        parameterMap.put("birthday", vo.getBrthdy());
//        parameterMap.put("wpBaseAddr", vo.getBassAdres());
//        parameterMap.put("wpNm", vo.getCmpnyNm());
//        parameterMap.put("gradeNm", vo.getUserGradCode());
//        parameterMap.put("wpTelNum", vo.getCmpnyTelno());
//        parameterMap.put("totalAmount", vo.getTotalNum());

        List<UserVO> dataList = list("_user.userListSExcel", parameterMap);

        return dataList;
    }

    /**
     * UserCount 설명
     * 
     * @param vo
     * @return
     */
    public Object userCount(UserVO vo) {

        return selectByPk("_user.userCount", vo);
    }

    /**
     * userSetYn 설명
     * 
     * @param vo
     * @return
     */
    public Object pUserSetYn(UserVO vo) {

        return selectByPk("_user.pUserSetYn", vo);
    }

    /**
     * cpUserSetYn 설명
     * 
     * @param vo
     * @return
     */
    public Object cpUserSetYn(UserVO vo) {

        return selectByPk("_user.cpUserSetYn", vo);
    }
    
    /**
     * pblUserSetYn 설명
     * 
     * @param vo
     * @return
     */
    public Object pblUserSetYn(UserVO vo) {

        return selectByPk("_user.pblUserSetYn", vo);
    }
    
    /**
     * storeSetYn 설명
     * 
     * @param vo
     * @return
     */
    public Object storeSetYn(UserVO vo) {

        return selectByPk("_user.storeSetYn", vo);
    }

    /**
     * userGradeList 설명
     * 
     * @param vo
     * @return
     */
    public List<UserVO> userGradeList(UserVO vo) {

        return list("_user.userGradeList", vo);
    }

    public Integer checkDupleStoreNm(UserVO vo) {
        return (Integer) selectByPk("_user.checkDupleStoreNm", vo);
    }

    public Integer selectUserTyCd(UserVO vo) {
        return (Integer) selectByPk("_user.selectUserTyCd", vo);
    }

    public int emailDupleCheck(UserVO vo) {
        return (Integer) selectByPk("_user.emailDupleCheck", vo);
    }

    public List<Map<String, Object>> userNation(UserVO vo) {
        return (List<Map<String, Object>>) list("_user.userNation", vo);
    }

    public Integer checkDupleBizrno(UserVO vo) {
        return (Integer)selectByPk("_user.checkDupleBizrno", vo);
    }

    public List<Map<String, Object>> continentList() {
        return (List<Map<String, Object>>) list("_user.continentList", null);
    }

    public Integer checkStoreSales(UserVO vo) {
        return (Integer) selectByPk("_user.checkStoreSales", vo);
    }

    public Integer updateGoodsActvtyCd(UserVO vo) {
        return update("_user.updateGoodsActvtyCd", vo);
    }

    /**
     * userDrmncyList 휴면계정 정보 목록
     * @param vo
     * @return
     */
    public Pager<UserVO> userDrmncyList(UserVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();

        Object searchKey0 = parameterMap.get("q_searchKey0");
        if(Validate.isNotEmpty(searchKey0)) {
            String[] searchKeys = searchKey0.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey0", searchKeys);
        }

        Object searchKey2 = parameterMap.get("q_searchKey2");
        if(Validate.isNotEmpty(searchKey2)) {
            String[] searchKeys = searchKey2.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            parameterMap.put("q_searchKey2", searchKeys);
        }

        vo.getDataMap().put("q_userSttusCd", vo.getUserSttusCd());

        List<UserVO> dataList = list("_user.userDrmncyList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_user.userListCount", parameterMap));

        // 원시값 다시 밀어넣기
         vo.getDataMap().put("q_searchKey0", searchKey0);
         vo.getDataMap().put("q_searchKey2", searchKey2);
        return new Pager<UserVO>(dataList, vo);
    }
    
    
}