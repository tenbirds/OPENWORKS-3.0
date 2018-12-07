/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.code;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.core.utils.Converter;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 코드관리 DAO
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

@Repository
public class CodeDAO extends EgovAbstractMapper {

    @SuppressWarnings("unchecked")
    public List<CodeVO> codeList(CodeVO vo) {
        return list("_code.prvCodeList", vo);
    }
    @SuppressWarnings("unchecked")
    public List<CodeVO> codeList2(CodeVO vo) {
        return list("_code.prvCodeList2", vo);
    }

    @SuppressWarnings("unchecked")
    public List<CodeVO> grpList(CodeVO vo) {

        return list("_code.grpCodeList", vo);
    }

    @SuppressWarnings("unchecked")
    public List<CodeVO> codeList(String langCd, Integer grpCd) {

        CodeVO bean = new CodeVO();
        bean.setUseYn("Y");
        bean.setLangCode(langCd);
        bean.setGrpCd(grpCd);

        return list("_code.prvCodeList", bean);
    }

    /**
     * 코드 상세조회
     */
    @SuppressWarnings("unchecked")
    public CodeVO codeView(CodeVO vo) {

        if(vo.getPrvCd() == StringUtil.ZERO) {
            CodeVO dataVo = (CodeVO) selectByPk("_code.grpCodeView", vo);
            if(dataVo != null) {
                List<String> prvNmList = list("_code.prvNmList", vo);
                String[] prvNms =
                    prvNmList.toArray(new String[prvNmList.size()]);
                dataVo.setPrvNms(prvNms);

                CodeCtgVO CodeCtgVO2 = new CodeCtgVO();
                CodeCtgVO2.setLangCode(vo.getLangCode());
                CodeCtgVO2.setGrpCd(vo.getGrpCd());

                CodeCtgResultHandler handler = new CodeCtgResultHandler();

                getSqlSession().select("_code.ctgCdMap", CodeCtgVO2, handler);

                dataVo.setCtgList(handler.getList());
            }

            return dataVo;
        }
        else {
            return (CodeVO) selectByPk("_code.prvCodeView", vo);
        }
    }

    /**
     * 코드 등록 액션
     */
    public Integer insertAction(CodeVO vo) {

        Integer sKey = null;

        if(vo.getPrvCd() == StringUtil.ZERO) {
            sKey = insert("_code.grpCodeInsert", vo);
        } else {
            sKey = insert("_code.prvCodeInsert", vo);
            logging(vo.getLangCode(), vo.getGrpCd(), vo.getPrvCd(), "I", vo.getModId());
        }

        return sKey;
    }

    /**
     * 코드 수정 액션
     * 
     * @return
     */
    public int updateAction(CodeVO vo) {

        // 기본 정보 수정
        // if ( vo.getOrderNo() == StringUtil.ZERO ) {
        int affected = 0;
        if(vo.getPrvCd() == StringUtil.ZERO) {

            CodeCtgVO CodeCtgVO2 = new CodeCtgVO();
            CodeCtgVO2.setGrpCd(vo.getGrpCd());
            CodeCtgVO2.setOldGrpCd(vo.getOldGrpCd());

            affected = update("_code.prvForGrpCodeUpdate", vo);
            affected = update("_code.ctgForGrpCodeUpdate", vo);
            affected = update("_code.grpCodeUpdate", vo);

            logging(vo.getLangCode(), vo.getGrpCd(), null, "U", vo.getModId());
        }
        else {
            vo.setModiDt(DateFormatUtil.getTodayFull());
            affected = update("_code.ctgForPrvCodeUpdate", vo);
            affected = update("_code.prvCodeUpdate", vo);

            logging(vo.getLangCode(), vo.getGrpCd(), vo.getPrvCd(), "U", vo.getModId());
        }
        return affected;
        // }
        // 정렬 정보 수정 (개별 코드만 해당)
        // else {
        // List<CodeVO2> sameLevelList = list("_code.sameLevelList", vo);
        // int sameLevelLength = sameLevelList.size();
        //
        // int newOrderNo = vo.getOrderNo();
        //
        // if ( newOrderNo <= 0 )
        // newOrderNo = 1;
        // if ( newOrderNo > sameLevelLength )
        // newOrderNo = sameLevelLength + 1;
        //
        // sameLevelList.add(newOrderNo-1, vo);
        // sameLevelLength++;
        //
        // int affected = StringUtil.ZERO;
        //
        // for (int i=0 ; i < sameLevelLength ; i++) {
        // CodeVO2 sameLevelVo = (CodeVO2)sameLevelList.get(i);
        //
        // sameLevelVo.setOrderNo( i + 1 );
        // affected += update("_code.prvCodeOrderUpdate", sameLevelVo);
        // }
        //
        // if ( affected == sameLevelLength ) {
        // return StringUtil.ONE;
        // }
        // else {
        // return StringUtil.ZERO;
        // }
        // }
    }

    /**
     * 코드 삭제 액션
     */
    public int deleteAction(CodeVO vo) {

        if(vo.getPrvCd() == StringUtil.ZERO) {
            return delete("_code.grpCodeDelete", vo);
        }
        else {
            int delCnt = delete("_code.prvCodeDelete", vo);
            logging(vo.getLangCode(), vo.getGrpCd(), vo.getPrvCd(), "D", vo.getModId());

            return delCnt;
        }
    }

    /**
     * 코드 카테고리 정보 목록
     */
    @SuppressWarnings("unchecked")
    public List<String> ctgCdList(CodeCtgVO CodeCtgVO2) {

        return list("_code.ctgCdList", CodeCtgVO2);
    }

    /**
     * 코드 카테고리 정보 조회
     */
    @SuppressWarnings("unchecked")
    public CodeCtgVO ctgView(CodeCtgVO CodeCtgVO2) {

        CodeVO vo = new CodeVO();
        vo.setLangCode(CodeCtgVO2.getLangCode());
        vo.setGrpCd(CodeCtgVO2.getGrpCd());

        List<CodeVO> prvList = list("_code.prvCodeList", vo);
        CodeCtgVO2.setPrvList(prvList);

        if(Validate.isNotEmpty(CodeCtgVO2.getCtgCd())) {
            List<String> assignList = list("_code.ctgAssignList", CodeCtgVO2);
            String[] prvCds = assignList.toArray(new String[assignList.size()]);
            CodeCtgVO2.setPrvCds(prvCds);
        }

        return CodeCtgVO2;
    }

    /**
     * 코드 카테고리 정보 등록 액션
     */
    public Object ctgInsertAction(CodeCtgVO CodeCtgVO2) {
        String ctgCd = (String) selectByPk("_code.ctgCdView", CodeCtgVO2);

        if(Validate.isNotEmpty(ctgCd)) {
            return "DUPLE";
        }

        String[] prvCds = CodeCtgVO2.getPrvCds();
        if(Validate.isNotEmpty(prvCds)) {
            for(String prvCd : prvCds) {
                CodeCtgVO2.setPrvCd(Integer.parseInt(prvCd));
                update("_code.ctgInsert", CodeCtgVO2);
            }
        } else {
            update("_code.ctgInsert", CodeCtgVO2);
        }

        return CodeCtgVO2.getCtgCd();
    }

    /**
     * 코드 카테고리 정보 수정 액션
     */
    public int ctgUpdateAction(CodeCtgVO CodeCtgVO2) {

        delete("_code.ctgDelete", CodeCtgVO2);

        ctgInsertAction(CodeCtgVO2);

        return StringUtil.ONE;
    }

    /**
     * 코드 카테고리 정보 삭제 액션
     */
    public int ctgDeleteAction(CodeCtgVO CodeCtgVO2) {

        delete("_code.ctgDelete", CodeCtgVO2);

        return StringUtil.ONE;
    }

    /**
     * 코드조회
     */
    public CodeVO codeSelect(CodeVO vo) {

        if(vo.getGrpCd() == StringUtil.ZERO) {
            return (CodeVO) selectByPk("_code.grpCodeSelect", vo);
        }
        else {
            return (CodeVO) selectByPk("_code.prvCodeSelect", vo);
        }
    }

    public CodeVO checkCode(CodeVO vo) {

        if(vo.getPrvCd() == StringUtil.ZERO) {
            return (CodeVO) selectByPk("_code.checkGrpCode", vo);
        }
        else {
            return (CodeVO) selectByPk("_code.checkPrvCode", vo);
        }
    }

    @SuppressWarnings("unchecked")
    public List<CodeVO> totalCodeList(CodeVO vo) {

        return list("_code.grpTotalCodeList", vo);
    }

    @SuppressWarnings("unchecked")
    public List<CodeVO> ctgList(CodeCtgVO CodeCtgVO2) {
        return list("_code.ctgList", CodeCtgVO2);
    }

    @SuppressWarnings("unchecked")
    public List<CodeVO> prvNmForCtgCd(CodeCtgVO CodeCtgVO2) {

        return list("_code.prvNmForCtgCd", CodeCtgVO2);
    }

    @SuppressWarnings("unchecked")
    public List<CodeVO> prvNmUseYnList(CodeVO vo) {

        return list("_code.prvNmUseYnList", vo);
    }

    /**
     * logging 설명
     * 
     * @param vo
     */
    private void logging(String langCode, Integer grpCd, Integer prvCd, String logType, String modId) {
        LoggingCodeVO log = new LoggingCodeVO();
        log.setLangCode(langCode);
        log.setGrpCd(grpCd);
        log.setPrvCd(prvCd);
        log.setLogType(logType);
        log.setModId(modId);
        insert("_code.logging", log);
    }

    /**
     * changeLogList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<LoggingCodeVO> changeLogList(CodeVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("langCode", vo.getLangCode());
        parameterMap.put("grpCd", vo.getGrpCd());

        List<LoggingCodeVO> dataList = list("_code.changeLogList", parameterMap);
        int totalNum = ((Integer) selectByPk("_code.changeLogListCount", parameterMap)).intValue();

        return new Pager<LoggingCodeVO>(dataList, totalNum, Converter.getInt(parameterMap.get("q_currPage")), Converter.getInt(parameterMap.get("q_rowPerPage")));
    }

    /**
     * extChkGrpAction 설명
     * 
     * @param iGrpCd
     * @return
     */
    public int extChkGrpAction(HashMap<String, Object> vMap) {
        int result = 0;
        result = ((Integer) selectByPk("_code.extChkGrp", vMap)).intValue();

        return result;
    }

    /**
     * dupChkPrvAction 설명
     * 
     * @param vMap
     * @return
     */
    public int dupChkPrvAction(HashMap<String, Object> vMap) {
        int result = 0;
        result = ((Integer) selectByPk("_code.dupChkPrv", vMap)).intValue();

        return result;
    }
    
    @SuppressWarnings("unchecked")
    public List<CodeVO> getLangCodeList(CodeVO vo) {
        return list("_code.getLangCodeList", vo);
    }
    
    @SuppressWarnings("unchecked")
    public List<CodeVO> langList(CodeVO vo) {
        return list("_code.langList", vo);
    }

    /**
     * extChkLangAction 설명
     * @param string
     * @return
     */
    public int extChkLangAction(String langCd) {
        int result = 0;
        result = ((Integer) selectByPk("_code.extChkLang", langCd)).intValue();

        return result;
    }
    
    /** 20150901 소트 수정 추가 시작  */
    /**
     * 코드 정렬순서 최대값
     */
    public Integer selectCodeSelectMaxOrder(CodeVO vo) {
        return (Integer) selectByPk("_code.prvCodeSelectMaxOrder", vo);
    }
    
    /**
     * 코드 정렬순서 올라갔을때
     */
    public int updateCodeUpdateOrderNoUp(CodeVO vo) {
        return update("_code.prvCodeUpdateOrderNoUp", vo);
    }
    
    /**
     * 코드 정렬순서 내려갔을때
     */
    public int updateCodeUpdateOrderNoDown(CodeVO vo) {
        return update("_code.prvCodeUpdateOrderNoDown", vo);
    }
    
    /**
     * 코드 정렬순서 수정
     */
    public int updateCodeUpdateOrderNo(CodeVO vo) {
        return update("_code.prvCodeUpdateOrderNo", vo);
    }
    /** 20150901 소트 수정 추가 끝  */
}
