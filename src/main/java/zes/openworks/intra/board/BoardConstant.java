/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;


/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 4. 17.    김영상       신규
 *</pre>
 * @see
 */
public class BoardConstant {
    
    /** 도메인과 도메인코드 매핑정보 */
    String domainCode[] = {"2","3","4"};
    String mgrName[] = {"eng","jpn","chn"};

    Map<String,String> domainMap = new HashMap<String,String>();

    public BoardConstant(){
        for(int i = 0 ; i < mgrName.length ; i ++){
            domainMap.put(domainCode[i], mgrName[i]);
        }
    }

    /**
     * 권한이름 구하기
     */
    public String getAuthName(String domainCd){
        return domainMap.get(domainCd);
    }
    
    /**
     * getDivName 설명
     * @param authMap
     * @return
     */
    @SuppressWarnings("rawtypes")
    public String getDivName(HashMap authMap) {
        
        String divName = "";
        Set s = authMap.keySet();
        Iterator it = s.iterator();
        
        while(it.hasNext()) {
            String str = it.next().toString();
            String value = authMap.get(str).toString();
            
            if(str.indexOf("_pt_") > -1) {
                if(value == "Y") {
                    divName = "pt";
                }
            } else if(str.indexOf("_mob_") > -1){
                if(value == "Y") {
                    divName = "mob";
                }
            }
        }

        return divName;
    }
    
    /**
     * 사이트구분코드 구하기
     */
    public String getSiteDivCd(String mgrNm, String divNm) {
        
        String siteDivCd = "";
        
        //영어
        if(!"".equals(mgrNm) && "eng".equals(mgrNm)){
            if(divNm.indexOf("mob") > -1) {  //모바일
                siteDivCd = "2001";
            } else if(divNm.indexOf("pt") > -1) {   //포털
                siteDivCd = "1001";
            }
        //일어
        } else if(!"".equals(mgrNm) && "jpn".equals(mgrNm)) {
            if(divNm.indexOf("mob") > -1) {  //모바일
                siteDivCd = "2002";
            } else if(divNm.indexOf("pt") > -1) {   //포털
                siteDivCd = "1002";
            }
        //중국어
        } else if(!"".equals(mgrNm) && "chn".equals(mgrNm)) {
            if(divNm.indexOf("mob") > -1) {  //모바일
                siteDivCd = "2003";
            } else if(divNm.indexOf("pt") > -1) {   //포털
                siteDivCd = "1003";
            }
        }
        
        return siteDivCd;
    }

}
