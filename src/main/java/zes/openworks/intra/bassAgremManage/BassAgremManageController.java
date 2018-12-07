package zes.openworks.intra.bassAgremManage;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

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
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.store.goods.GoodsManageService;


/**
 *
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  기본협약관리>기본협약관리
 *
 * 수정일          수정자    수정내용
 *--------------  --------  -------------------------------
 * 2016. 10. 26.   엔키      신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/bassAgremManage")
public class BassAgremManageController extends IntraController {

    @Autowired private BassAgremManageService service;
    @Autowired GoodsManageService goodsManageService;
    @Autowired CodeService codeService;
    /** 파일 저장 경로 */
    public static final String BASS_AGREM_FILE = "bassAgremFile" + File.separator;

    /**
     * bassAgremManageList (기본협약관리목록)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void bassAgremManageList(HttpServletRequest request, ModelMap model, BassAgremManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        
/*        vo.getDataMap().put("q_agremstat",request.getParameter("q_agremstat"));
        vo.getDataMap().put("q_searchStatVal",request.getParameter("q_searchStatVal"));*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2035);
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_stat", codeService.codeList(codeVO));
        model.addAttribute("q_agremstat",request.getParameter("q_agremstat"));
        model.addAttribute("q_searchStatVal",vo.getDataMap().put("q_searchStatVal",request.getParameter("q_searchStatVal")));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.bassAgremManageList(vo));
        
        model.addAttribute("summaryBassAgrem", service.summaryBassAgrem(vo));
    }

    /**
     * 기본협약관리목록 엑셀다운로드
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_indexExcel.do", method=RequestMethod.GET)
    public void wishListExcel(HttpServletRequest request, ModelMap model, BassAgremManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
        model.addAttribute("bassAgremManageListExcel", service.bassAgremManageListExcel(vo));
    }


    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "BD_insertForm.do", "BD_updateForm.do" }, method = RequestMethod.POST)
    public String bannerForm(HttpServletRequest request, ModelMap model, BassAgremManageVO vo) {
        
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2035);
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_stat", codeService.codeList(codeVO));
        
        if(Validate.isNotEmpty(vo.getBassAgremManageSeq())) {
            model.addAttribute(GlobalConfig.KEY_BASE_VO, service.bassAgremManageView(vo));
            return baseUrl + "/BD_updateForm";
        }
        return baseUrl + "/BD_insertForm";
    }


    /**
     * 기본협약등록
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do", method=RequestMethod.POST )
    public String insertAction(HttpServletRequest request, ModelMap model, BassAgremManageVO vo) {

        // 처리자 ID 가져오기
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());
        vo.setUpdtId(loginVo.getMngrId());

        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, BASS_AGREM_FILE);

        // 처리 파일 VO 선언
        List<FileVO> bassAgrmntFile         = new ArrayList<FileVO>();        // 제출 협약서
        List<FileVO> rgsbukTrnscrFile       = new ArrayList<FileVO>();        // 등기부등본
        List<FileVO> vnentrCrtfFile         = new ArrayList<FileVO>();        // 벤처기업증명서
        List<FileVO> directPrdctnCrtfFile   = new ArrayList<FileVO>();        // 직접생산증명서
        List<FileVO> cdltDocFile            = new ArrayList<FileVO>();        // 신용평가서
        List<FileVO> fnlttFile              = new ArrayList<FileVO>();        // 재무제표

        /************************************************/
        /** STEP1) File VO 바인딩 - 시작 ********************/
        /************************************************/
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();
            
            // 기본협약서
            if (inputNm.startsWith("bassAgrmntFile")) {
                bassAgrmntFile.add(uploadFile.get(i));
            }

            // 등기부등본
            if (inputNm.startsWith("rgsbukTrnscrFile")) {
                rgsbukTrnscrFile.add(uploadFile.get(i));
            }

            // 벤처기업증명서
            if (inputNm.startsWith("vnentrCrtfFile")) {
                vnentrCrtfFile.add(uploadFile.get(i));
            }

            // 직접생산증명서
            if (inputNm.startsWith("directPrdctnCrtfFile")) {
                directPrdctnCrtfFile.add(uploadFile.get(i));
            }

            // 신용평가서
            if (inputNm.startsWith("cdltDocFile")) {
                cdltDocFile.add(uploadFile.get(i));
            }

            // 재무제표
            if (inputNm.startsWith("fnlttFile")) {
                fnlttFile.add(uploadFile.get(i));
            }
        }

        // VO 에 바인딩
        vo.setBassAgrmntFile(bassAgrmntFile);             // 기본협약서
        vo.setRgsbukTrnscrFile(rgsbukTrnscrFile);         // 등기부등본
        vo.setVnentrCrtfFile(vnentrCrtfFile);             // 벤처기업증명서
        vo.setDirectPrdctnCrtfFile(directPrdctnCrtfFile); // 직접생산증명서
        vo.setCdltDocFile(cdltDocFile);                   // 신용평가서
        vo.setFnlttFile(fnlttFile);                       // 재무제표

        /************************************************/
        /** STEP1) File VO 바인딩 - 끝 ******************/
        /************************************************/

        /************************************************/
        /** STEP2) 등록 - 시작 **************************/
        /************************************************/
        Integer key = service.bassAgremManageInsertAction(vo);
        /************************************************/
        /** STEP2) 등록 - 끝 ****************************/
        /************************************************/
        if(key <= 0){
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, "BD_index.do");
    }

    /**
     * 기본협약수정
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_updateAction.do", method=RequestMethod.POST )
    public String UpdateAction(HttpServletRequest request, ModelMap model, BassAgremManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        
        if(vo.getAgremStat() == 1004){
            // 파일 저장경로
            List<FileVO> uploadFile = UploadHelper.upload(request, BASS_AGREM_FILE);

            // 처리 파일 VO 선언
            List<FileVO> lastAgrmntFile         = new ArrayList<FileVO>();        // 확정 협약서
            /************************************************/
            /** STEP1) File VO 바인딩 - 시작 ********************/
            /************************************************/
            for(int i = 0 ; i < uploadFile.size() ; i++) {
                String inputNm = uploadFile.get(i).getInputNm();

                // 확정 협약서
                if (inputNm.startsWith("lastAgrmntFile")) {
                    lastAgrmntFile.add(uploadFile.get(i));
                }
            }    
            vo.setLastAgrmntFile(lastAgrmntFile);              // 확정협약서 셋팅
            service.tumSvcStorIUpdateAction(vo);               // 스토아 활성화 
        }
        
        Integer key = service.bassAgremManageUpdateAction(vo);  // 확정협약서 파일 업데이트 
        Integer key2 = service.opUserUpdateAction(vo);          // 승인/반료 상태 변환 
        
        if(Validate.isEmpty(key) && Validate.isEmpty(key2)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }
        //여기에 넣을것
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, "BD_index.do");
    }

    /**
     * bassAgremManageDeleteAction (기본협약관리 삭제)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String bassAgremManageDeleteAction(ModelMap model, BassAgremManageVO vo) {

        int affected = service.bassAgremManageDeleteAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);

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
     * 담당자 목록(팝업)
     */
    @RequestMapping(value = "PD_sellerListPop.do")
    public void sellerListPop(ModelMap model, HttpServletRequest request, BassAgremManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.sellerListPop(vo));
    }

    /**
     * 담당자 정보변경
     */
    @RequestMapping(value = "ND_updateUser.do")
    public String updateUser(ModelMap model, HttpServletRequest request,BassAgremManageVO vo) {
        int affected = service.updateUser(vo);
        
        if  (affected < 1) 
        {
            return responseJson(model, StringUtil.ZERO);
        }

        return responseJson(model, affected);
    }

    
}