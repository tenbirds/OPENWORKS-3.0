/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.interestlink;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.utils.DateFormatUtil;
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
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class InterestLinkDAO extends EgovAbstractMapper {

    /**
     * 관심목록 목록 조회(전체목록)
     */
    @SuppressWarnings("unchecked")
    public Pager<InterestLinkVO> interestLinkPager(InterestLinkVO interestLinkVo) {

        /*
         * Map<String, Object> parameterMap = interestLinkVo.getRequestMap();
         * System.err.println(parameterMap);
         */

        Map<String, Object> map = interestLinkVo.getDataMap();

        List<InterestLinkVO> list = list("_interestlink.interestLinkListAll", map);
        interestLinkVo.setTotalNum((Integer) selectByPk("_interestlink.interestLinkAllCount", map));
        /*
         * int listTotalCount = (Integer)
         * selectByPk("_interestlink.interestLinkAllCount",
         * interestLinkVo.getDataMap());
         */

        /* return OpHelper.getPager(parameterMap, list, listTotalCount); */
        return new Pager<InterestLinkVO>(list, interestLinkVo);
    }

    /**
     * 관심목록 리스트
     */
    @SuppressWarnings("unchecked")
    public List<InterestLinkVO> interestLinkList(InterestLinkVO interestLinkVo) {

        List<InterestLinkVO> list = list("_interestlink.interestLinkList", interestLinkVo);

        return ((list == null) ? new ArrayList<InterestLinkVO>() : list);
    }

    /**
     * 관심목록 카테고리 리스트
     */
    @SuppressWarnings("unchecked")
    public List<String> getCategoryList(InterestLinkVO interestLinkVo) {

        List<String> list = list("_interestlink.interestLinkCtgList", interestLinkVo);

        return ((list == null) ? new ArrayList<String>() : list);
    }

    /**
     * 관심목록 등록액션
     */
    public int insertInterestLink(InterestLinkVO interestLinkVo) {

        if((Integer) selectByPk("_interestlink.interestLinkCount", interestLinkVo) != 0) {
            return -1;
        }

        interestLinkVo.setRegDt(DateFormatUtil.getToday());
        Integer result = insert("_interestlink.interestLinkInsert", interestLinkVo);

        return ((result != null && result > 0) ? 1 : 0);
    }

    /**
     * 관심목록 삭제액션 - 하나씩
     */
    public int deleteInterestLink(InterestLinkVO interestLinkVo) {

        return ((Integer) delete("_interestlink.interestLinkDelete", interestLinkVo)).intValue();
    }

    /**
     * 관심목록 삭제 액션(목록 삭제)
     */
    public int delListInterestLink(InterestLinkVO interestLinkVo, String[] seqs) {
        int result = 0;
        for(String seq : seqs) {
            InterestLinkVO linkVo = new InterestLinkVO();
            linkVo.setSeq(Integer.valueOf(seq));
            result += deleteInterestLink(linkVo);
        }
        return result;
    }

    /**
     * 관심목록 업데이트
     */
    public int updateInterestLink(InterestLinkVO interestLinkVo) {

        return ((Integer) update("_interestlink.updateInterestLink", interestLinkVo)).intValue();
    }

}
