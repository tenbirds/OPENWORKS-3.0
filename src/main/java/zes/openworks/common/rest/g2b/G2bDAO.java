/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b;

import org.springframework.stereotype.Repository;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.rest.g2b.vo.G2bResponseVO;
import zes.openworks.common.rest.g2b.vo.G2bVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 11.    이슬버미       신규
 *</pre>
 * @see
 */

@Repository
public class G2bDAO {

    private G2bServiceClient client = new G2bServiceClient();
    
    /**
     * getInsttAcctoBidPblancListServc (나라장터 기관별 입찰공고/재공고 용역 목록을 조회)
     * @param vo
     * @return
     * @throws Exception 
     */
    public G2bResponseVO getInsttAcctoBidPblancListServc(G2bVO vo) throws Exception {

        StringBuffer naraUrl = new StringBuffer();
        
        //주소
        naraUrl.append("http://openapi.g2b.go.kr/openapi/service/rest/BidPublicInfoService/getInsttAcctoBidPblancListServc");
        
        //ServiceKey
        naraUrl.append("?").append("ServiceKey=").append(GlobalConfig.NARA_SERVICE_KEY);
        
        //시작일
        if(Validate.isNotEmpty(vo.getsDate())){
            naraUrl.append("&").append("sDate=").append(vo.getsDate().replaceAll("-", ""));
        }
        
        //종료일
        if(Validate.isNotEmpty(vo.geteDate())){
            naraUrl.append("&").append("eDate=").append(vo.geteDate().replaceAll("-", ""));
        }        
        
        //발주기관
        if(Validate.isNotEmpty(vo.getOrderCode())){
            naraUrl.append("&").append("orderCode=").append(vo.getOrderCode());
        }
        
        //수요기관
        if(Validate.isNotEmpty(vo.getDemandCode())){
            naraUrl.append("&").append("demandCode=").append(vo.getDemandCode());
        }
        
        //공고/개찰일
        if(Validate.isNotEmpty(vo.getDateType())){
            naraUrl.append("&").append("dateType=").append(vo.getDateType());
        }        
        
        //한 페이지 결과 수
        if(Validate.isNotEmpty(vo.getDataMap().get("pagingStartNum"))){
            //naraUrl.append("&").append("numOfRows=").append(vo.getDataMap().get("q_rowPerPage"));
            naraUrl.append("&").append("numOfRows=").append("9999");
        }
        
        //페이지 번호
        if(Validate.isNotEmpty(vo.getDataMap().get("pagingEndNum"))){
            naraUrl.append("&").append("pageNo=").append(vo.getDataMap().get("q_currPage") );
        }
        
        return client.request(naraUrl.toString());
    }
    
    /**
     * getInsttCntrctInfoListServcCntrctSttus (나라장터 계약현황 기관별 용역 목록을 조회)
     * @param vo
     * @return
     * @throws Exception 
     */
    public G2bResponseVO getInsttCntrctInfoListServcCntrctSttus(G2bVO vo) throws Exception {
        StringBuffer naraUrl = new StringBuffer();
        
        //주소
        naraUrl.append("http://openapi.g2b.go.kr/openapi/service/rest/CntrctInfoService/getInsttCntrctInfoListServcCntrctSttus");
        
        //ServiceKey
        naraUrl.append("?").append("ServiceKey=").append(GlobalConfig.NARA_SERVICE_KEY);
        
        //시작일
        if(Validate.isNotEmpty(vo.getsDate())){
            naraUrl.append("&").append("sDate=").append(vo.getsDate().replaceAll("-", ""));
        }
        
        //종료일
        if(Validate.isNotEmpty(vo.geteDate())){
            naraUrl.append("&").append("eDate=").append(vo.geteDate().replaceAll("-", ""));
        }        
        
        //계약기관명
        if(Validate.isNotEmpty(vo.getContractNum())){
            naraUrl.append("&").append("contractNum=").append(vo.getContractNum());
        }
        
        //수요기관명
        if(Validate.isNotEmpty(vo.getDemandNum())){
            naraUrl.append("&").append("demandNum=").append(vo.getDemandNum());
        }
        
        //한 페이지 결과 수
        if(Validate.isNotEmpty(vo.getDataMap().get("pagingStartNum"))){
            //naraUrl.append("&").append("numOfRows=").append(vo.getDataMap().get("q_rowPerPage"));
            naraUrl.append("&").append("numOfRows=").append("9999");
        }
        
        //페이지 번호
        if(Validate.isNotEmpty(vo.getDataMap().get("pagingEndNum"))){
            naraUrl.append("&").append("pageNo=").append(vo.getDataMap().get("q_currPage") );
        }
        
        return client.request(naraUrl.toString());
    }

    
}
