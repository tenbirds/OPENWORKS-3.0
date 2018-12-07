/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dept;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.vo.TreeVO;

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
 *  2012. 4. 30.    유상원   부서 관리
 * </pre>
 * @see
 */
public interface DeptService {

    /**
     * 부서정보 목록 조회 (계층별 Tree 조회)
     */
    List<TreeVO> deptList(DeptVO vo);

    /**
     * 부서정보 목록 조회 (전체 Tree 조회)
     */
    List<TreeVO> deptListAll(DeptVO vo);

    /**
     * 부서정보 목록 조회 (autocomplite 겸용)
     */
    List<DeptVO> deptSearchList(DeptVO vo);

    /**
     * 부서정보 상세 조회
     */
    DeptVO deptView(DeptVO vo);

    /**
     * 부서 등록 액션
     */
    Integer insertAction(DeptVO vo);

    /**
     * 부서코드중복확인
     */
    int dupCheckDept(DeptVO vo);

    /**
     * 부서 수정 액션
     */
    int updateAction(DeptVO vo);

    /**
     * 부서 삭제 액션
     */
    int deleteAction(DeptVO vo);

    List<TreeVO> deptUserTreeList(DeptUserTreeVO dutVo);

    DeptVO deptKey(DeptVO vo);

    /**
     * deptListExcel 설명
     */
    public List<DeptVO> deptListExcel(DeptVO vo);

    /**
     * registerExcelEnBloLoad 일괄 등록할 첨부한 엑셀내용 불러오기
     * 
     * @param request
     * @return
     * @throws Exception
     */
    List<DeptVO> registerExcelEnBloLoad(HttpServletRequest request) throws Exception;

    /**
     * insertDeptExcelEnBloc 부서 일괄등록 처리
     * 
     * @param vo
     * @return
     */
    int insertDeptExcelEnBloc(DeptVO vo);
}
