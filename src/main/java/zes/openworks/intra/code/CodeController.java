/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.code;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 코드관리 Controller
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

@Controller
@RequestMapping(value = "/intra/code")
public class CodeController extends IntraController {

    @Autowired
    private CodeService service;

    /**
     * 코드정보 관리 페이지
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void index(CodeVO vo, ModelMap model) {
        model.addAttribute("langVo", service.langList(vo));
    }

    /**
     * 코드정보 목록 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_grList.do", method = RequestMethod.POST)
    public String grList(CodeVO vo, ModelMap model) {
        return responseJson(model, service.grpList(vo));
    }

    /**
     * 코드정보 목록 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_cdList.do")
    public String codeList(CodeCtgVO CodeCtgVO2, CodeVO vo, ModelMap model) {

        return responseJson(model, service.codeList(vo));
    }

    /**
     * 코드정보 상세 얻기
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_codeView.do")
    public void codeView(CodeVO vo, ModelMap model) {

        if(vo.getGrpCd() == StringUtil.ZERO) {
            model.addAttribute("code", service.codeSelect(vo).getGrpCd());
        } else {
            model.addAttribute("code", service.codeSelect(vo).getPrvCd());
        }
        model.addAttribute("langCodeList",service.getLangCodeList(vo));// 언어코드 가져오기 
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.prvNmUseYnList(vo)); // prvNm정보상세조회
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.codeView(vo)); // 코드정보상세조회
    }

    /**
     * 코드정보 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_insertAction.do")
    public String insertAction(CodeVO vo, ModelMap model, HttpServletRequest request) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModId(loginVO.getMngrId());

        int affected = service.insertAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * 코드정보 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_updateAction.do")
    public String updateAction(CodeVO vo, ModelMap model, HttpServletRequest request) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModId(loginVO.getMngrId());
        /** 20150901 소트 수정 추가 시작  */
        int ordNo = vo.getOrderNo();
        int ordNoBefore = vo.getOrderNoBefore();
        if(ordNo == ordNoBefore) {
            int affected = service.updateAction(vo);
    
            if(affected == StringUtil.ONE) {
                return responseText(model, Messages.TRUE);
            }
            return responseText(model, Messages.FALSE);
        }
        else {
            int max = service.selectCodeSelectMaxOrder(vo);
            
            if(vo.getOrderNo() > max || vo.getOrderNo() == 0) {
                return responseText(model, Messages.FALSE);
            }
            else {
                if(ordNo > ordNoBefore) {
                    int upRows = service.updateCodeUpdateOrderNoUp(vo);
                    
                    if(upRows == StringUtil.ZERO) {
                        return responseText(model, Messages.FALSE);
                    }
                }
                else if(ordNo < ordNoBefore) {
                    int downRows = service.updateCodeUpdateOrderNoDown(vo);
                    
                    if(downRows == StringUtil.ZERO) {
                        return responseText(model, Messages.FALSE);
                    }
                }
                else {
                    return responseText(model, Messages.FALSE);
                }
                
                int orderRow = service.updateCodeUpdateOrderNo(vo);
                int affected = service.updateAction(vo);
                
                if(orderRow > StringUtil.ZERO || affected > StringUtil.ZERO) {
                    return responseText(model, Messages.TRUE);
                }
                else {
                    return responseText(model, Messages.FALSE);
                }
            }
        }
        /** 20150901 소트 수정 추가 끝  */
    }

    /**
     * 코드정보 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_deleteAction.do")
    public String deleteAction(CodeVO vo, ModelMap model, HttpServletRequest request) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModId(loginVO.getMngrId());

        int affected = service.deleteAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 카테고리 코드 조회
     * 
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_ctgList.do")
    public String ctgList(CodeCtgVO CodeCtgVO2, CodeVO vo, ModelMap model) {
        
        return responseJson(model, service.ctgList(CodeCtgVO2));
    }

    /**
     * 코드 실렉터 정보
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_prvNmForCtgCd.do", method = RequestMethod.POST)
    public String prcNmForCtgCd(CodeCtgVO CodeCtgVO2, ModelMap model) {
        return responseJson(model, service.prvNmForCtgCd(CodeCtgVO2));
    }

    /**
     * 코드 카테고리 정보 페이지
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_ctgIndex.do")
    public void ctgIndex(CodeCtgVO CodeCtgVO2, CodeVO vo, ModelMap model) {
        model.addAttribute("langVo", service.langList(vo));
        model.addAttribute("langCode", vo.getLangCode());
        model.addAttribute("grpCd", vo.getGrpCd());
    }

    /**
     * 코드 카테고리 정보 등록 폼
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_ctgInsertForm.do", method = RequestMethod.POST)
    public void ctgInsertForm(CodeCtgVO CodeCtgVO2, ModelMap model) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.ctgView(CodeCtgVO2));
    }

    /**
     * 코드 카테고리 정보 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_ctgInsertAction.do", method = RequestMethod.POST)
    public String ctgInsertAction(CodeCtgVO CodeCtgVO2, ModelMap model) {
        Object primaryKey = service.ctgInsertAction(CodeCtgVO2);

        if(primaryKey != null) {
            if("DUPLE".equals(primaryKey.toString())) {
                return responseText(model, "DUPLE");
            } else {
                return responseText(model, Messages.TRUE);
            }
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * 코드 카테고리 정보 수정 폼
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_ctgUpdateForm.do")
    public void ctgUpdateForm(CodeCtgVO CodeCtgVO2, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.ctgView(CodeCtgVO2));
    }

    /**
     * 코드 카테고리 정보 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_ctgUpdateAction.do", method = RequestMethod.POST)
    public String ctgUpdateAction(CodeCtgVO CodeCtgVO2, ModelMap model) {
        int affected = service.ctgUpdateAction(CodeCtgVO2);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 코드 카테고리 정보 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_ctgDeleteAction.do", method = RequestMethod.POST)
    public String ctgDeleteAction(CodeCtgVO CodeCtgVO2, ModelMap model) {
        int affected = service.ctgDeleteAction(CodeCtgVO2);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 코드 체크
     * 
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_codeCheck.do")
    public String codeCheck(CodeVO vo, ModelMap model) {

        return responseText(model, service.checkCode(vo).getCodeCheckCount());
    }

    /**
     * 전체코드 목록 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_totalCodeList.do", method = RequestMethod.GET)
    public void totalCodeList(CodeVO vo, ModelMap model) {

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.totalCodeList(vo));
    }

    /**
     * 전체코드 목록 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_codeListExcel.do")
    public String excelCodeList(CodeVO vo, ModelMap model) {
        model.put("_codeList", service.totalCodeList(vo));

        return responseExcel(model, new CodeExcelVO());
    }

    /**
     * 변경 이력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_changeLog.do")
    public void changeLog(ModelMap model, HttpServletRequest request, @ModelAttribute CodeVO vo) {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.changeLogList(vo));
    }

    /**
     * registerExcelEnBlo 개별코드 일괄등록 폼 조회
     * 
     * @param model
     * @param request
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_regExcelEnBloc.do", method = RequestMethod.GET)
    public void regExcelEnBloForm(ModelMap model, HttpServletRequest request) throws Exception {

    }

    /**
     * registerExcelEnBloLoad 일괄 등록할 첨부엑셀내용 불러오기
     * 
     * @param model
     * @param request
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_regExcelEnBloc.do", method = RequestMethod.POST)
    public void regExcelEnBloLoad(ModelMap model, HttpServletRequest request) throws Exception {
        List<CodeVO> prvList = service.regExcelEnBloLoad(request);

        model.addAttribute("prvList", prvList);
    }

    /**
     * 개별코드 일괄등록 처리
     * 
     * @param model
     * @param request
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertPrvExcelEnBlocAction.do")
    public String insertPrvExcelEnBloc(ModelMap model, HttpServletRequest request, CodeVO vo) throws Exception {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModId(loginVO.getMngrId());
        String strVal = "";
        String strMsg = "";
        String[] affected = service.insertPrvExcelEnBloc(vo);
        if(affected.length == 1){
            strVal = affected[0];
            strMsg = "";
        }else{
            strVal = affected[0];
            strMsg = affected[1];
        }
        return responseJson(model, strVal, strMsg);
    }

}
