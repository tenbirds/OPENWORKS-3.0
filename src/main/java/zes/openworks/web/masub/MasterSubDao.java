/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.masub;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.util.random.RandomNumber;
import zes.openworks.component.file.FileDAO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.register.BassAgremVO;
import zes.openworks.web.register.DcPartcptReqstVO;
import zes.openworks.web.register.PblinsttVO;
import zes.openworks.web.register.RegisterUserVO;
import zes.openworks.web.register.RegisterVO;

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
@SuppressWarnings("unchecked")
@Repository
public class MasterSubDao extends EgovAbstractMapper {

    /**
     * subBoardList 설명
     * @param vo
     * @return
     */
    public Pager<MasterSubVO> subBoardList(MasterSubVO vo) {
        
        List<MasterSubVO> dataList = list("_masterSub.subBoardList", vo);
        vo.setTotalNum((Integer) selectByPk("_masterSub.subBoardListCount", vo));

        return new Pager<MasterSubVO>(dataList, vo);
    }

    /**
     * subBoardAction 설명
     * @param vo
     * @return 
     */
    public int subBoardAction(MasterSubVO vo) {
        int result = 0;
        if(vo.getStatus().equals("i")){
            result = update("_masterSub.subBoardInsert", vo);
        }else if(vo.getStatus().equals("u")){            
            result = update("_masterSub.subBoardInsert", vo);
        }else if(vo.getStatus().equals("d")){
            result = delete("_masterSub.subBoardDelete", vo);
        }else if(vo.getStatus().equals("r_i")){
            result = insert("_masterSub.replyBoardInsert", vo); 
        }else if(vo.getStatus().equals("r_u")){
            result = insert("_masterSub.replyBoardUpdate", vo); 
        }else if(vo.getStatus().equals("r_d")){
            result = insert("_masterSub.replyBoardDelete", vo); 
        }
        return result;
    }

    /**
     * subBoardDetail 설명
     * @param vo
     * @return
     */
    public MasterSubVO subBoardDetail(MasterSubVO vo) {
        update("_masterSub.masubSechCntUpdateAction", vo);  //카운트 업데이트
        return (MasterSubVO) selectByPk("_masterSub.subBoardDetail", vo);
    }

    /**
     * subBoardReplyDetail 설명
     * @param vo
     * @return
     */
    public List<MasterSubVO> subBoardReplyDetail(MasterSubVO vo) {
        return list("_masterSub.subBoardReplyDetail", vo);
    }
}
