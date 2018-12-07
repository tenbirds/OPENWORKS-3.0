/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCertif;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class MyCertifDAO extends EgovAbstractMapper{

    /*@Resource
    private FileDAO fileDao;*/

    /**
     * certifRequList (이용실적증명서 발급 신청록록 조회)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCertifGoodsVO> certifRequList(Map parameterMap) {
        return list("_myCertif.certifRequList", parameterMap);
    }
    

    /**
     * certifRequListCount (이용실적증명서 발급 신청록록 갯수)
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int certifRequListCount(Map parameterMap) {
        return (Integer) selectByPk("_myCertif.certifRequListCount", parameterMap);
    }
    
    /**
     * certifRequList (이용실적증명서 발급 조회)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCertifApplyVO> certifApplyList(Map parameterMap) {
        return list("_myCertif.certifApplyList", parameterMap);
    }
    
    /**
     * certifRequListCount (이용실적증명서 발급 조회 갯수)
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int certifApplyListCount(Map parameterMap) {
        return (Integer) selectByPk("_myCertif.certifApplyListCount", parameterMap);
    }

    /**
     * cntrctManageInsertAction (계약관리 등록)
     * @param vo
     * @return
     */
    public int certifRequInsertAction(MyCertifApplyVO vo) {
        
        int result = insert("_myCertif.certifRequInsert", vo) ;
        if(result > 0)  result = insert("_myCertif.certifServiceInsert", vo) ;
        return result;
    }

    public MyCertifApplyVO certifApplyDetail(MyCertifApplyVO vo) {
        return (MyCertifApplyVO) selectByPk("_myCertif.certifApplyDetail", vo);
    }
    
    /**
     * certifRequList (이용실적증명서 발급 조회)
     * @param vo
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<MyCertifGoodsVO> certifApplyGoodsList(MyCertifGoodsVO vo) {
        return list("_myCertif.certifApplyGoodsList", vo);
    }
    
    
    @SuppressWarnings("rawtypes")
    public int  certifApplyGoodsListCount(MyCertifGoodsVO vo) { 
        return (Integer) selectByPk("_myCertif.certifApplyGoodsListCount", vo);
    }
    
}
