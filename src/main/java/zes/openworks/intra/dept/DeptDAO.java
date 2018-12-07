/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dept;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
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
 *  2012. 5. 2.    유상원   부서 관리
 * </pre>
 * @see
 */
/**
 * 부서관리 DAO
 * 
 * @author zesinc
 */
@Repository
@SuppressWarnings("unchecked")
public class DeptDAO extends EgovAbstractMapper {

    private final String HIGH_DEPT_CD = String.valueOf(GlobalConfig.HIGH_DEPT_CD);

    /**
     * 부서정보 목록 조회 (계층별 Tree 조회)
     */
    public List<TreeVO> deptList(DeptVO vo) {

        if(Validate.isEmpty(vo.getUpperDeptCode())) {
            vo.setUpperDeptCode(HIGH_DEPT_CD);
        }

        return list("_deptn.treeList", vo);
    }

    /**
     * 부서정보 목록 조회 (전체 Tree 조회)
     */
    public List<TreeVO> deptListAll(DeptVO vo) {

        if(Validate.isEmpty(vo.getUpperDeptCode())) {
            vo.setUpperDeptCode(HIGH_DEPT_CD);
        }

        return list("_deptn.listAll", vo);
    }

    /**
     * 부서정보 목록 조회 (autocomplite 겸용)
     */
    public List<DeptVO> deptSearchList(DeptVO vo) {

        return list("_deptn.list", vo);
    }

    /**
     * 부서정보 폼
     */
    public DeptVO deptForm(DeptVO vo) {

        return (DeptVO) selectByPk("_deptn.deptkey", vo);
    }

    /**
     * 부서정보 상세 조회
     */
    public DeptVO deptView(DeptVO vo) {

        return (DeptVO) selectByPk("_deptn.view", vo);
    }

    /**
     * 부서정보 등록 액션
     */
    public Integer insertAction(DeptVO vo) {

        if(Validate.isEmpty(vo.getUpperDeptCode())) {
            vo.setUpperDeptCode(HIGH_DEPT_CD);
        }

        return insert("_deptn.insert", vo);
    }

    /**
     * 부서코드 중복확인
     */
    public int dupCheckDept(DeptVO vo) {
        return (Integer) selectByPk("_deptn.dupCheckDept", vo);
    }

    /**
     * 부서정보 수정 액션
     */
    public int updateAction(DeptVO vo) {

        if(Validate.isEmpty(vo.getUpperDeptCode())) {
            vo.setUpperDeptCode(HIGH_DEPT_CD);
        }

        // 기본 정보 수정
        if(Validate.isEmpty(vo.getDeptOrdrNo()) || vo.getDeptOrdrNo() == StringUtil.ZERO) {

            vo.setModiDt(DateFormatUtil.getTodayFull());           
            return update("_deptn.infoUpdate", vo);
        }

        // 정렬 정보 수정
        else {
            List<DeptVO> sameLevelList = list("_deptn.sameLevelList", vo);
            int sameLevelLength = sameLevelList.size();

            int newOrderNo = vo.getDeptOrdrNo();

            if(newOrderNo <= StringUtil.ZERO) {
                newOrderNo = 1;
            }

            if(newOrderNo > sameLevelLength) {
                newOrderNo = sameLevelLength + 1;
            }

            sameLevelList.add(newOrderNo - 1, vo);
            sameLevelLength++;

            int affected = StringUtil.ZERO;

            for(int i = 0 ; i < sameLevelLength ; i++) {
                DeptVO sameLevelVo = sameLevelList.get(i);

                sameLevelVo.setDeptOrdrNo(i + 1);
                affected += update("_deptn.orderUpdate", sameLevelVo);
            }

            if(affected == sameLevelLength) {
                return StringUtil.ONE;
            }
            else {
                return StringUtil.ZERO;
            }
        }
    }

    /**
     * 부서정보 삭제 액션
     */
    public int deleteAction(DeptVO vo) {

        return delete("_deptn.delete", vo);
    }

    public List<TreeVO> deptUserTreeList(DeptUserTreeVO dutVo) {

        if(Validate.isEmpty(dutVo.getUpperDeptCode())) {
            dutVo.setUpperDeptCode(HIGH_DEPT_CD);
        }

        return list("_deptn.deptUserTreeList", dutVo);
    }

    public DeptVO deptKey(DeptVO vo) {
        return (DeptVO) selectByPk("_deptn.deptKey", vo);
    }

    /**
     * deptListExcel 설명
     * 
     * @param vo
     * @return
     */
    public List<DeptVO> deptListExcel(DeptVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        List<DeptVO> dataList = list("_deptn.deptListExcel", parameterMap);
        return dataList;
    }
}
