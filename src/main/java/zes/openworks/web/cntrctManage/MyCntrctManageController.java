package zes.openworks.web.cntrctManage;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.orderManage.cntrctManage.CntrctManageService;
import zes.openworks.intra.orderManage.cntrctManage.CntrctManageVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.webevent.WebEventMessages;
/**
 *
 * @Class Name : WikiController
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 * @Description : 씨앗마켓 위키 공통 Controller
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일                 수정자                수정내용
 *--------------    ----------    -------------------------------
 * 2016. 01. 04.    (주)엔키소프트      신규
 * @see
 */


@Controller
@RequestMapping(value = "/**/cntrctManage")
public class MyCntrctManageController extends GeneralController {

    @Autowired
    CntrctManageService service;

    /** 파일 저장 경로 */
    public static final String CNTRCT_IMG = "cntrct" + File.separator;

    @RequestMapping(value = "/BD_myCntrctIndex.do",  method = RequestMethod.GET)
    public String BD_myCntrctIndex(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/cntrctManage/BD_myCntrctIndex.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }


        OpHelper.bindSearchMap(vo, request);

        vo.getDataMap().put("userId", vo.getUserId());

        model.addAttribute(GlobalConfig.KEY_PAGER,service.cntrctManageList(vo));
        return "/korean/pt/cntrctManage/BD_myCntrctIndex";
    }

    /**
     * 계약서 등록폼
     */
    @RequestMapping(value = "BD_myCntrctForm.do")
    public String BD_myCntrctForm(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/cntrctManage/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        return "/korean/pt/cntrctManage/BD_myCntrctForm";
    }

    /**
     * 계약서 등록
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_myCntrctInsertAction.do", method = RequestMethod.POST)
    public String myCntrctInsertAction(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {


        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);

        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=/korean/pt/cntrctManage/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);

        }else{
            vo.setUserId(userLoginVO.getUserId());
        }

        List<FileVO> uploadFile = UploadHelper.upload(request, CNTRCT_IMG);
        List<FileVO> ctrtcFile= new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("ctrtcFile")) {
                ctrtcFile.add(uploadFile.get(i));
            }
        }

        vo.setCtrtcFile(ctrtcFile);
        vo.setCntrctBeginDe(vo.getCntrctBeginDe().replace("-", ""));
        vo.setCntrctEndDe(vo.getCntrctEndDe().replace("-", ""));

        Integer key = service.cntrctManageInsertAction(vo);

        if(Validate.isEmpty(key)) {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }else{

        }

        return alertAndRedirect(model, MessageHelper.getMsg(request, "insertOk"), "BD_myCntrctIndex.do");
    }

    /**
     * 계약서 수정 폼
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "BD_myCntrctView.do",  method = RequestMethod.GET)
    public String BD_myCntrctView(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/cntrctManage/BD_myCntrctView.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO,service.cntrctManageView(vo));
        return "/korean/pt/cntrctManage/BD_myCntrctView";
    }

    /**
     * 계약서 수정
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_myCntrctUpdateAction.do", method = RequestMethod.POST)
    public String myCntrctUpdateAction(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {


        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);

        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=/korean/pt/cntrctManage/BD_myCntrctIndex.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);

        }else{
            vo.setUserId(userLoginVO.getUserId());
        }

        List<FileVO> uploadFile = UploadHelper.upload(request, CNTRCT_IMG);
        List<FileVO> ctrtcFile= new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("ctrtcFile")) {
                ctrtcFile.add(uploadFile.get(i));
            }
        }

        vo.setCtrtcFile(ctrtcFile);
        vo.setCntrctBeginDe(vo.getCntrctBeginDe().replace("-", ""));
        vo.setCntrctEndDe(vo.getCntrctEndDe().replace("-", ""));

        Integer key = service.cntrctManageUpdateAction(vo);

        if(Validate.isEmpty(key)) {
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }else{

        }

        return alertAndRedirect(model, MessageHelper.getMsg(request, "updateOk"), "BD_myCntrctIndex.do?q_currPage=" + vo.getQ_currPage() + "&q_searchKey=" + vo.getQ_searchKey() + "&q_searchVal=" + vo.getQ_searchVal());
    }

    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request) {

        int affected = service.fileDelete(fileVO);

        if(affected < 1) {
            return responseJson(model, StringUtil.ZERO);
        }

        return responseJson(model, affected);
    }

    /**
     * 계약서 삭제(삭제 플래그 처리)
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_myCntrctDeleteAction.do", method = RequestMethod.POST)
    public String myCntrctDeleteAction(HttpServletRequest request, ModelMap model, CntrctManageVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/cntrctManage/BD_myCntrctIndex.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        OpHelper.bindSearchMap(vo, request);

        int deleteCnt = service.cntrctManageDeleteAction(vo);

        if(deleteCnt > 0) {
            return  responseJson(model, new WebEventMessages(WebEventMessages.SUCCESS,MessageHelper.getMsg(request, "deleteOk")));
        }
        return responseText(model, Messages.FALSE);
    }
}
