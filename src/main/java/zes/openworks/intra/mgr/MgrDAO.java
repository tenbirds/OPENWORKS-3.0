package zes.openworks.intra.mgr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.intra.login.LoggingWebLoginVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 담당자 관리 DAO
 * 
 * @author zesinc
 */
@Repository
public class MgrDAO extends EgovAbstractMapper {

    /**
     * 담당자 목록 조회
     */
    @SuppressWarnings("unchecked")
    public Pager<MgrVO> mgrList(MgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("mngrId", vo.getMngrId());

        List<MgrVO> dataList = list("_mgr.list", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_mgr.listCount", parameterMap));

        return new Pager<MgrVO>(dataList, vo);
    }

    /**
     * 담당자 목록 조회(엑셀 다운로드)
     */
    @SuppressWarnings("unchecked")
    public List<MgrVO> mgrListExcel(MgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("deptCode", vo.getDeptCode());

        List<MgrVO> mgrList = (List<MgrVO>)list("_mgr.listExcel", parameterMap);
        for(MgrVO mgrvo : mgrList ){
            MgrAuthHandler handler = new MgrAuthHandler();
            getSqlSession().select("_mgr.selectAuthNmMap", mgrvo, handler);
            mgrvo.setAuthNm(handler.getResult());
        }

        return mgrList;
    }

    /**
     * 담당자 목록 조회(할당권한 포함)
     */
    @SuppressWarnings("unchecked")
    public Pager<MgrVO> mgrListWithPermission(MgrVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("deptCode", vo.getDeptCode());

        List<MgrVO> dataList = list("_mgr.view", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_mgr.listCount", parameterMap));

        return new Pager<MgrVO>(dataList, vo);
    }

    /**
     * 담당자 검색 목록 조회
     */
    @SuppressWarnings("unchecked")
    public List<MgrVO> mgrSearchList(MgrVO vo) {

        if("mngrId".equals(vo.getQ_searchKey())) {
            vo.setMngrId(vo.getQ_searchVal());
        } else if("mngrNm".equals(vo.getQ_searchKey())) {
            vo.setMngrNm(vo.getQ_searchVal());
        }

        return list("_mgr.searchList", vo);
    }

    /**
     * 담당자 정보 상세 조회(vo)
     */
    public int mgrView(MgrVO vo) {

        return (Integer) selectByPk("_mgr.checkDupleId", vo);
    }

    /**
     * 담당자 정보 상세 조회(mngrId)
     * public MgrVO mgrView(String mngrId) {
     * MgrVO vo = new MgrVO();
     * vo.setmngrId(mngrId);
     * return mgrView(vo);
     * }
     */

    /**
     * 담당자 정보 상세 조회 (할당권한 포함)
     */
    public MgrVO mgrViewWithPermission(MgrVO vo) {

        MgrVO dbVo = (MgrVO) selectByPk("_mgr.mgrUpdateValues", vo);
        //SHA256으로 바뀌므로 복호화기능 사용못함 2014.10.14
        if(dbVo != null && Validate.isNotEmpty(dbVo.getMngrPassword())) {
            //Crypto cry = CryptoFactory.getInstance();
            dbVo.setMngrPassword(dbVo.getMngrPassword());
        }
        
        return dbVo;
    }

    /**
     * 담당자 아이디로 권한코드,권한명,권한타입코드 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<MgrVO> currentlyList(MgrVO vo) {
        return list("_mgr.currentlyList", vo);
    }

    /**
     * 할당권한 수정시 권한 리스트 가져오기
     */
    @SuppressWarnings("unchecked")
    public List<MgrVO> authList(MgrVO vo) {
        return list("_mgr.authList", vo);
    }

    /**
     * 담당자 권한 정보 입력 액션
     */
    public Object assignInsertAction(MgrVO vo) {

        return insert("_mgr.mgrAssignInsert", vo);
    }

    /**
     * 담당자 권한 정보 삭제 액션
     */
    public int assignDeleteAction(MgrVO vo) {

        return delete("_mgr.mgrAssignDelete", vo);
    }

    @SuppressWarnings("unchecked")
    public List<MgrVO> grpAuthCdSelect(MgrVO vo) {

        return list("_mgr.grpAuthCdSelect", vo);
    }

    /**
     * 담당자 정보 등록 액션
     */
    public Object insertAction(MgrVO vo) {

        if(Validate.isNotEmpty(vo.getMngrPassword())) {
            Crypto cry = CryptoFactory.getInstance("SHA256");
            vo.setMngrPassword(cry.encrypt(vo.getMngrPassword()));
        }

        int affected = update("_mgr.insert", vo);
        logging(vo, "I");

        return affected == StringUtil.ONE ? vo.getMngrId() : null;
    }

    /**
     * 담당자 비밀번호 수정 액션
     */
    public int updatePwdAction(MgrVO vo) {

        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setMngrPassword(cry.encrypt(vo.getMngrPassword()));
        int _result = 0;
        //현재비밀번호나 이전비밀번호와 같은지 체크
        String currentPwd = (String)selectByPk("_mgr.currentPwd", vo);
        String beforePwd = (String)selectByPk("_mgr.beforePwd", vo);
        if(vo.getMngrPassword().equals(currentPwd) || vo.getMngrPassword().equals(beforePwd)){
            _result = -1;
        }else{
            vo.setModiDt(DateFormatUtil.getTodayFull());

            _result = update("_mgr.updatePwd", vo);
        }

        return _result;
    }

    /**
     * 담당자 정보 수정 액션
     */
    public int updateAction(MgrVO vo) {

        if(Validate.isNotEmpty(vo.getMngrPassword())) {
            Crypto cry = CryptoFactory.getInstance("SHA256");
            vo.setMngrPassword(cry.encrypt(vo.getMngrPassword()));
        }

        vo.setModiDt(DateFormatUtil.getTodayFull());

        int _result = update("_mgr.update", vo);
        logging(vo, "U");

        return _result;
    }

    /**
     * 담당자 권한 정보 수정 액션
     */
    public int assignUpdateAction(MgrVO vo) {

        String[] menuGrpCd = vo.getMenuGrpCd();

        delete("_mgr.menuAssignDelete", vo);

        if(Validate.isNotEmpty(menuGrpCd)) {
            Map<String, Object> parameterMap = new HashMap<String, Object>(2);
            parameterMap.put("mngrId", vo.getMngrId());

            for(String _menuGrpCd : menuGrpCd) {
                parameterMap.put("menuGrpCd", _menuGrpCd);
                update("_mgr.menuAssignInsert", parameterMap);
            }
        }

        return StringUtil.ONE;
    }

    /**
     * 담당자 부서 정보 수정 액션
     */
    public int deptUpdateAction(MgrVO vo) {

        vo.setModiDt(DateFormatUtil.getTodayFull());

        int _result = update("_mgr.deptUpdate", vo);
        logging(vo, "U");

        return _result;
    }

    /**
     * 담당자 사용여부 수정 액션
     */
    public int useYnUpdateAction(MgrVO vo) {
        vo.setModiDt(DateFormatUtil.getTodayFull());

        int _result = update("_mgr.useYnUpdate", vo);
        logging(vo, "U");

        return _result;
    }

    /**
     * 담당자 부서이동 수정 액션
     */
    public int deptTransferAction(MgrVO vo) {
        vo.setModiDt(DateFormatUtil.getTodayFull());

        int _result = update("_mgr.deptTransfer", vo);
        logging(vo, "U");

        return _result;
    }

    /**
     * 담당자 삭제 액션
     */
    public int deleteAction(MgrVO vo) {
        int _result = delete("_mgr.delete", vo);
        logging(vo, "D");
        return _result;
    }

    /**
     * 담당자 할당권한 코드 조회
     */
    @SuppressWarnings("unchecked")
    public List<MgrVO> menuAssignList(MgrVO vo) {

        return list("_mgr.menuAssignList", vo);
    }

    @SuppressWarnings("unchecked")
    public List<MgrVO> menuList(MgrVO vo) {

        return list("_mgr.menuList", vo);
    }

    public int currentlyListCount(MgrVO vo) {
        return (Integer) selectByPk("_mgr.currentlyListCount", vo);
    }

    public String mgrDeptNm(MgrVO vo) {
        return (String) selectByPk("_mgr.mgrDeptNm", vo);
    }

    /**
     * logging 설명
     * 
     * @param vo
     */
    private void logging(MgrVO vo, String logType) {
        LoggingMgrVO log = new LoggingMgrVO();
        log.setMngrId(vo.getMngrId());
        log.setLogTy(logType);
        log.setUpdtId(vo.getModiId());

        insert("_mgr.logging", log);
    }

    /**
     * webLogList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<LoggingWebLoginVO> webLogList(MgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("mngrId", vo.getMngrId());

        List<LoggingWebLoginVO> dataList = list("_mgr.webLogList", setDefaultParam(parameterMap));
        vo.setTotalNum((Integer) selectByPk("_mgr.webLogListCount", setDefaultParam(parameterMap)));

        return new Pager<LoggingWebLoginVO>(dataList, vo);
    }

    @SuppressWarnings("unchecked")
    public List<LoggingWebLoginVO> getIpState(MgrVO vo) {
        return list("_mgr.ipStat", vo);
    }

    public LoggingWebLoginVO getWebLogContents(MgrVO vo) {
        return (LoggingWebLoginVO) selectByPk("_mgr.webLogContents", vo);
    }

    @SuppressWarnings("unchecked")
    public Pager<LoggingMgrVO> changeLogList(MgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("mngrId", vo.getMngrId());

        List<LoggingMgrVO> dataList = list("_mgr.changeLogList", setDefaultParam(parameterMap));
        vo.setTotalNum((Integer) selectByPk("_mgr.changeLogListCount", setDefaultParam(parameterMap)));

        return new Pager<LoggingMgrVO>(dataList, vo);
    }

    @SuppressWarnings("unchecked")
    public MgrVO getDeptTransferInfo(Map<String, String[]> map) {
        List<MgrVO> dataList = (List<MgrVO>) list("_mgr.getDeptTransferInfo", map);
        StringBuffer strbf = new StringBuffer();
        // 담당장이름+직급 연결
        for(MgrVO dataVo : dataList){
            if(strbf.length() > 0) strbf.append(", ");
            strbf.append(dataVo.getMngrNm()+"("+dataVo.getGradeNm()+")");
        }
        MgrVO mgrVo = new MgrVO();
        mgrVo.setMngrNm(strbf.toString());
        return mgrVo;
    }

    /**
     * changeLogExcel 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<LoggingMgrVO> changeLogExcel(MgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("mngrId", vo.getMngrId());

        return list("_mgr.changeLogListExcel", setDefaultParam(parameterMap));
    }

    /**
     * webLogExcel 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<LoggingWebLoginVO> webLogExcel(MgrVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("mngrId", vo.getMngrId());

        return list("_mgr.webLogListExel", setDefaultParam(parameterMap));
    }

    private Map<String, Object> setDefaultParam(Map<String, Object> parameterMap) {
        /*
         * 주석처리:아무값도 없을때는 모두 나오게 by.SJ
         * if(!"ALL".equals(parameterMap.get("q_sType")) &&
         * Validate.isEmpty(parameterMap.get("q_stDate")) &&
         * Validate.isEmpty(parameterMap.get("q_enDate"))) {
         * parameterMap.put("q_stDate", DateFormatUtil.getTodayShortKr());
         * parameterMap.put("q_enDate", DateFormatUtil.getTodayShortKr());
         * }
         */
        return parameterMap;
    }

    /**
     * selectAuthNmByAuthCd 권한 정보 조회
     * 
     * @param vo
     * @return
     */
    public MgrVO selectAuthNmByAuthCd(MgrVO vo) {
        return (MgrVO) selectByPk("_mgr.selectAuthNmByAuthCd", vo);
    }

    /**
     * selectGradeNm 직급명
     * 
     * @param gradeCd
     * @return
     */
    public String selectGradeNm(MgrVO vo) {
        return (String) selectByPk("_mgr.selectGradeNm", vo);
    }

    /**
     * selectDeptNm 부서명
     * 
     * @param gradeCd
     * @return
     */
    public String selectDeptNm(String deptCd) {
        return (String) selectByPk("_mgr.selectDeptNm", deptCd);
    }
}
