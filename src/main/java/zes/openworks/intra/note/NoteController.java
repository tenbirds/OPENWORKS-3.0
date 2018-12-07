package zes.openworks.intra.note;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.mgr.MgrVO;

//@Controller
@RequestMapping(value = "/intra/note")
public class NoteController extends IntraController {

    @Autowired
    private NoteService service;

    /**
     * 쪽지함 목록 얻기
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public ModelAndView index(ModelAndView view, HttpServletRequest request, NoteVO noteVo) throws Exception {

        OpHelper.bindSearchMap(noteVo, request);

        LoginVO loginVo = OpHelper.getMgrSession(request);
        noteVo.setMngrId(loginVo.getMngrId());

        view.addObject(GlobalConfig.KEY_PAGER, service.list(noteVo));

        return view;
    }

    /**
     * 쪽지함 상세 얻기
     * 
     * @param model
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_noteView.do", method = RequestMethod.POST)
    public String noteView(ModelMap model, HttpServletRequest request, @ModelAttribute NoteVO noteVo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        noteVo.setMngrId(loginVo.getMngrId());

        return responseJson(model, service.noteView(noteVo));
    }

    /**
     * 쪽지함 등록 폼
     * 
     * @param view
     * @param request
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_insertForm.do", method = RequestMethod.GET)
    public ModelAndView insertForm(ModelAndView view, HttpServletRequest request, NoteVO noteVo) throws Exception {

        ValidateResultHolder holder = ValidateUtil.validate(noteVo);
        view.addObject(GlobalConfig.KEY_VALIDATE, holder);

        NoteVO dataVO = new NoteVO();

        // *** 등록폼 ***
        view.addObject("pageType", "INSERT");
        view.addObject(GlobalConfig.KEY_DATA_VO, dataVO);

        String mgrId = request.getParameter("mgrId");
        if(Validate.isNotEmpty(mgrId)) {
            MgrVO _mgrBean = service.mgrView(mgrId);

            view.addObject("txt", _mgrBean.getDeptNm() + "/" + _mgrBean.getMngrNm());
            view.addObject("val", _mgrBean.getMngrId());
        }
        return view;
    }

    /**
     * 쪽지 보내기
     * 
     * @param model
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_insertAction.do", method = RequestMethod.POST)
    public String insertAction(ModelMap model, HttpServletRequest request, NoteVO noteVo) throws Exception {

        // 실행코드
        LoginVO loginVo = OpHelper.getMgrSession(request);
        noteVo.setSenderId(loginVo.getMngrId());

        /* 쪽지 발송 시 파일업로드 추가 시작 2013.4 김영상 */
        List<FileVO> fileList = new ArrayList<FileVO>();
        fileList = UploadHelper.upload(request, "note");

        // 폼 업로드시 업로드 파일 용량을 체크한다.
        if(!checkUploadFileSize(fileList, noteVo)) {
            if(service.fileDelete(fileList)) {
                return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
            } else {
                return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
            }
        }
        noteVo.setFileList(fileList);

        int affected = service.insertAction(noteVo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 쪽지함 삭제
     * 
     * @param model
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_deleteAction.do", method = RequestMethod.POST)
    public String deleteAction(ModelMap model, HttpServletRequest request, NoteVO noteVo) throws Exception {

        if(request.getParameterValues("arraySeq[]") != null &&
            !"".equals(request.getParameterValues("arraySeq[]"))) {
            noteVo.setSeqs(request.getParameterValues("arraySeq[]"));
        }

        LoginVO loginVo = OpHelper.getMgrSession(request);
        noteVo.setMngrId(loginVo.getMngrId());
        int affected = service.deleteAction(noteVo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @RequestMapping(value = "INC_myNoteCount.do", method = RequestMethod.POST)
    public String myNoteCount(ModelMap model, HttpServletRequest request) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        Integer myNoteCount = service.myNoteCount(loginVo.getMngrId());

        return responseJson(model, myNoteCount);
    }

    @RequestMapping(value = "INC_deptUserTreeList.do", method = RequestMethod.POST)
    public String deptList(NoteVO vo, HttpServletRequest request, ModelMap model) {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVo.getMngrId());

        // List<JSONObject> deptList = service.deptUserTreeList(vo);

        List<TreeVO> deptList = service.deptUserTreeList(vo);
        return responseJson(model, deptList);
    }

    /**
     * 부서정보 상세 조회
     */
    @RequestMapping(value = "INC_deptView.do", method = RequestMethod.POST)
    public void deptView(NoteVO vo, ModelMap model) {

        model.addAttribute("deptKey", service.deptKey(vo).getDeptKey());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.deptView(vo));
    }

    /**
     * 폼 업로드시 업로드 파일 용량을 체크한다.
     */
    private boolean checkUploadFileSize(List<FileVO> fileList, NoteVO noteVO) {
        Long totalFileSize = 0L;
        boolean uploadYn = true;
        // 업로드 파일 사이즈 제한이 있는 경우(사이즈 0일 경우 무제한 용량)
        for(FileVO baseFileVO : fileList) {
            try {
                Long fileSize = baseFileVO.getFileByteSize();

                if(noteVO.getMaxFileSize() > 0) {
                    Long maxFileSize = Long.valueOf(((Integer) (noteVO.getMaxFileSize() * 1024 * 1024)).toString());
                    if(fileSize > maxFileSize) {
                        uploadYn = false;
                    }
                }
                totalFileSize += fileSize;
            } catch (Exception e) {
                uploadYn = false;
            }
        }
        // 업로드 총 파일 사이즈 제한이 있는 경우
        if(noteVO.getTotalFileSize() > 0) {
            Long totalMaxFileSize = Long.valueOf(((Integer) (noteVO.getTotalFileSize() * 1024 * 1024)).toString());
            if(totalFileSize > totalMaxFileSize) {
                return false;
            }
        }
        return uploadYn;
    }

}
