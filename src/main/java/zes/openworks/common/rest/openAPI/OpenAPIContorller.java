/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.openAPI;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import zes.base.spring.GeneralController;
import zes.core.lang.Validate;
import zes.openworks.common.rest.RestResultCode;
import zes.openworks.common.rest.RestServiceResult;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;


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
 * 2014. 12. 23.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/openapi")
public class OpenAPIContorller  extends GeneralController  {

    @Autowired OpenAPIService service;

    @Autowired CommonDutyService commonService;

    @RequestMapping(value = "/getTest", method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody @ResponseStatus(value = HttpStatus.OK)
    public RestServiceResult<Object> getTest(OpenAPIVO vo) throws Exception {

        if(Validate.isEmpty(vo.getId())){
            return new RestServiceResult<Object>(RestResultCode.CM_FAIL_REQUEST);
        }

        return new RestServiceResult<Object>(service.sampleList(vo));
    }

    public String Language(HttpServletRequest request) {
        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }

    @RequestMapping(value = "/getGoodsInfo", method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody @ResponseStatus(value = HttpStatus.OK)
    public RestServiceResult<Object> getGoodsInfo(OpenAPIVO vo, HttpServletRequest request) throws Exception {

        vo.setLangCode(Language(request));
        if(Validate.isEmpty(vo.getLangCode())) {
            vo.setLangCode("00");
        }

        //서비스구분
        if(Validate.isEmpty(vo.getGoodsTyCd())){
            return new RestServiceResult<Object>(RestResultCode.CM_REQUIRED,"code goodsTyCd[1001:표준프레임워크호환,1002:솔루션,1003:IT전문가서비스]");
        }
        //서비스명
        if(Validate.isNotEmpty(vo.getGoodsNm())){
            int GoodsNmMin = 2;
            if(vo.getGoodsNm().length() < GoodsNmMin){
                return new RestServiceResult<Object>(RestResultCode.CM_MIN,"code goodsNm["+ GoodsNmMin +"]");
            }
        }
        //시작일
        if(Validate.isEmpty(vo.getsDate())){
            return new RestServiceResult<Object>(RestResultCode.CM_REQUIRED,"code sDate[YYYY-MM-DD]");
        }
        //종료일
        if(Validate.isEmpty(vo.geteDate())){
            return new RestServiceResult<Object>(RestResultCode.CM_REQUIRED,"code eDate[YYYY-MM-DD]");
        }

        return new RestServiceResult<Object>(service.goodsInfoList(vo));
    }

/*    @RequestMapping(value = "/getTest1", method = RequestMethod.GET)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public RestServiceResult<Object> getTest1(OpenAPIVO Vo) throws Exception {

        logger.info("## getTest1");

        Map<String, String> map = new HashMap<String, String>();

        map.put("test1", Vo.getId());
        map.put("test2", Vo.getName());


        return new RestServiceResult<Object>(map);
    }

    @RequestMapping(value = "/getTest2/{testPage}", method = RequestMethod.GET)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public RestServiceResult<Object> getTest2(@PathVariable String testPage) throws Exception {
        return new RestServiceResult<Object>(testPage);
    }



    @RequestMapping(value = "/getTest3/{testPage}", method = RequestMethod.GET)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public RestServiceResult<Object> getTest3(OpenAPIVO Vo, @PathVariable String testPage) throws Exception {

        logger.info("## getTest1");

        Map<String, String> map = new HashMap<String, String>();

        map.put("test1", Vo.getId());
        map.put("test2", Vo.getName());
        map.put("testPage", testPage);

        return new RestServiceResult<Object>(map);
    }*/


}
