package zes.openworks.intra.auth;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.base.vo.IExcelVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.dept.DeptService;
import zes.openworks.intra.dept.DeptVO;

@Controller
@RequestMapping(value = "/intra/authAssign")
public class AssignController extends IntraController {

    @Resource(name = "authService")
    private AuthService service;

    @Autowired
    private DeptService deptService;

    /**
     * 권한할당 관리 페이지
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {
    }

    /**
     * 권한그룹 목록
     */
    @RequestMapping(value = "ND_groupAuthList.do", method = RequestMethod.POST)
    public String authList(AuthVO vo, ModelMap model) {
        return responseJson(model, service.groupAuthList(vo));
    }

    /**
     * 부서목록 목록
     */
    @RequestMapping(value = "ND_deptList.do", method = RequestMethod.POST)
    public String deptList(DeptVO vo, ModelMap model) {
        return responseJson(model, deptService.deptList(vo));
    }

    /**
     * 부서별 담당자 목록
     */
    @RequestMapping(value = "ND_mgrList.do")
    public void mgrList(AuthMgrVO vo, HttpServletRequest request, ModelMap model) {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.mgrList(vo));
    }

    /**
     * 부서별 담당자 목록
     */
    @RequestMapping(value = "ND_mgrDeptAllList.do", method = RequestMethod.POST)
    public String mgrSearchedList(AuthMgrVO vo, HttpServletRequest request, ModelMap model) {
        OpHelper.bindSearchMap(vo, request);

        return responseJson(model, service.mgrDeptAllList(vo));
    }

    /**
     * 권한 메뉴 할당 정보 저장
     * 
     * @return
     */
    @RequestMapping(value = "ND_assignMgrSaveAction.do", method = RequestMethod.POST)
    public String assignMenuSaveAction(HttpServletRequest request, ModelMap model) {
        service.saveAssignMgr(request);
        return responseText(model, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 권한별 담당자 검색
     */
    @RequestMapping(value = "PD_searchAssignList.do")
    public void searchAssignList(AuthMgrVO vo, HttpServletRequest request, ModelMap model) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.assignMgrList(vo));
    }

    /**
     * mgrListByAuthExcel 권한별 담당자 목록 엑셀
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_mgrListByAuthExcel.do")
    public String mgrListByAuthExcel(AuthMgrVO vo, HttpServletRequest request, ModelMap model) {
        OpHelper.bindSearchMap(vo, request);
        model.put("_mgrListByAuth", service.assignMgrListExcel(vo));

        IExcelVO mgrListByAuthExcel = new MgrListByAuthExcelVO();

        return responseExcel(model, mgrListByAuthExcel);
    }

    /**
     * 권한그룹 목록
     */
    @RequestMapping(value = "ND_authList.do")
    public String authAllList(AuthVO vo, ModelMap model) {
        return responseJson(model, service.groupAuthList(vo));
    }

    /**
     * 담당자별 권한할당 관리
     */
    @RequestMapping(value = "PD_assignList.do")
    public void assignMgr(AuthVO vo, ModelMap model) {
        return;
    }
}
