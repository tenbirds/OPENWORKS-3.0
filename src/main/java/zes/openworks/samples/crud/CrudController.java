/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.samples.crud;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 이것 저것 모은 셈플 패키지
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
 *  2012. 3. 23.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = { "/samples/crud" })
public class CrudController extends IntraController {

    @Autowired
    private CrudService crudService;

    /**
     * 상세
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_crud.view.do", method = RequestMethod.GET)
    public void crudView(HttpServletRequest request, ModelMap model, CrudVO crudVo,
        CrudReplyVO crudReplyVo) {

        // 원본글 상세
        OpHelper.bindSearchMap(crudVo, request);
        model.addAttribute(GlobalConfig.KEY_BASE_VO, crudService.crudView(crudVo));

        // 답글 목록
        crudReplyVo.setDataMap(crudVo.getDataMap());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, crudService.crudReplyList(crudReplyVo));
    }

    /**
     * 목록
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_crud.list.do", method = RequestMethod.GET)
    public void crudList(HttpServletRequest request, ModelMap model, CrudVO crudVo) {

        OpHelper.bindSearchMap(crudVo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, crudService.crudList(crudVo));
    }

    /**
     * 입력 폼
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "BD_crud.insert.form.do", "BD_crud.update.form.do" }, method = RequestMethod.GET)
    public String crudForm(HttpServletRequest request, ModelMap model, CrudVO crudVo) {

        OpHelper.bindSearchMap(crudVo, request);

        // 스크립트단에 동일한 validator를 설정할 수 있도록 한다.
        ValidateResultHolder holder = ValidateUtil.validate(crudVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        if(Validate.isNotEmpty(crudVo.getDataMap().get("q_seq"))) {
            model.addAttribute(GlobalConfig.KEY_DATA_VO, crudService.crudData(crudVo));
        }

        return baseUrl + "/BD_crud.form";
    }

    /**
     * 등록
     * 
     * @param request
     * @param model
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_crud.insert.do", method = RequestMethod.POST)
    public String crudInsert(HttpServletRequest request, ModelMap model, CrudVO crudVo)
        throws Exception {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(crudVo);
        if(holder.isValid()) {

            LoginVO loginVo = getLoginSession(request);
            crudVo.setRegId(loginVo.getMngrId());
            crudVo.setRegNm(loginVo.getMngrNm());
            crudVo.setIpAddr(request.getRemoteAddr());

            crudVo.setFileList(UploadHelper.upload(request, "crud"));
            // 등록 실행
            Object key = crudService.crudInsert(crudVo);
            if(Validate.isEmpty(key)) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_crud.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 수정
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_crud.update.do", method = RequestMethod.POST)
    public String crudUpdate(HttpServletRequest request, ModelMap model, CrudVO crudVo) {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(crudVo);
        if(holder.isValid()) {

            LoginVO loginVo = getLoginSession(request);
            crudVo.setModId(loginVo.getMngrId());
            crudVo.setModiNm(loginVo.getMngrNm());
            crudVo.setIpAddr(request.getRemoteAddr());

            crudVo.setFileList(UploadHelper.upload(request, "crud"));

            // 등록 실행
            Integer key = crudService.crudUpdate(crudVo);
            if(Validate.isEmpty(key)) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_crud.view.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_crud.delete.do", method = RequestMethod.POST)
    public String crudDelete(HttpServletRequest request, ModelMap model, CrudVO crudVo) {

        OpHelper.bindSearchMap(crudVo, request);

        Integer cnt = crudService.crudDelete(crudVo);
        if(cnt != 1) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_crud.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 목록 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_crud.list.delete.do", method = RequestMethod.POST)
    public String crudListDelete(HttpServletRequest request, ModelMap model, CrudVO crudVo) {

        OpHelper.bindSearchMap(crudVo, request);

        Integer cnt = crudService.crudListDelete(crudVo);
        if(cnt <= 0) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_crud.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 답변 폼
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "BD_crud.reply.insert.form.do", "BD_crud.reply.update.form.do" })
    public String crudReplyForm(HttpServletRequest request, ModelMap model, CrudVO crudVo,
        CrudReplyVO crudReplyVo) {

        OpHelper.bindSearchMap(crudVo, request);
        crudReplyVo.setDataMap(crudVo.getDataMap());

        ValidateResultHolder holder = ValidateUtil.validate(crudReplyVo);

        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);
        model.addAttribute(GlobalConfig.KEY_BASE_VO, crudService.crudView(crudVo));

        if(Validate.isNotEmpty(crudReplyVo.getDataMap().get("q_replySeq"))) {
            model.addAttribute(GlobalConfig.KEY_DATA_VO, crudService.crudReplyView(crudReplyVo));
        }

        return baseUrl + "/BD_crud.reply.form";
    }

    /**
     * 답변 등록
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_crud.reply.insert.do", method = RequestMethod.POST)
    public String crudReplyInsert(HttpServletRequest request, ModelMap model,
        CrudReplyVO crudReplyVo) {

        ValidateResultHolder holder = ValidateUtil.validate(crudReplyVo);
        if(holder.isValid()) {

            LoginVO loginVo = getLoginSession(request);
            crudReplyVo.setRegId(loginVo.getMngrId());
            crudReplyVo.setRegNm(loginVo.getMngrNm());
            crudReplyVo.setIpAddr(request.getRemoteAddr());

            crudReplyVo.setFileList(UploadHelper.upload(request, "crud"));
            // 등록 실행
            Object key = crudService.crudReplyInsert(crudReplyVo);
            if(Validate.isEmpty(key)) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }
        String url = "BD_crud.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 답변 수정
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_crud.reply.update.do", method = RequestMethod.POST)
    public String crudReplyUpdate(HttpServletRequest request, ModelMap model,
        CrudReplyVO crudReplyVo) {

        LoginVO loginVo = getLoginSession(request);
        crudReplyVo.setModId(loginVo.getMngrId());
        crudReplyVo.setModiNm(loginVo.getMngrNm());
        crudReplyVo.setIpAddr(request.getRemoteAddr());

        ValidateResultHolder holder = ValidateUtil.validate(crudReplyVo);
        if(holder.isValid()) {

            crudReplyVo.setFileList(UploadHelper.upload(request, "crud"));
            // 수정 실행
            Integer key = crudService.crudReplyUpdate(crudReplyVo);

            if(Validate.isEmpty(key)) {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }
        String url = "BD_crud.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 답변 삭제
     * 
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_crud.reply.delete.do", method = RequestMethod.POST)
    public String crudReplyDelete(HttpServletRequest request, ModelMap model,
        CrudReplyVO crudReplyVo) {

        OpHelper.bindSearchMap(crudReplyVo, request);

        Integer key = crudService.crudReplyDelete(crudReplyVo);
        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_crud.list.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

}
