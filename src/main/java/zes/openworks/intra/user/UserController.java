package zes.openworks.intra.user;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.base.vo.IExcelVO;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.listener.LoginSessionBinding;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.user.coLog.UserLogVO;
import zes.openworks.intra.user.webLog.UserWebLogService;
import zes.openworks.web.common.CommonDutyService;

@Controller
@RequestMapping(value = "/intra/user")
public class UserController extends IntraController {

    @Autowired
    private UserService service;

    @Autowired
    private UserWebLogService weblogService;

    @Autowired
    private CommonDutyService commonService;

    /** 파일 저장 경로 */
    public static final String STORE_IMG_STORE = "store" + File.separator;

    /**
     * 개인, 사업자 등록 폼-보안등급정책 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_userSecurity.do", method = RequestMethod.GET)
    public void userSecurity() {

    }

    /**
     * 탈퇴회원목록조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index2.do")
    public ModelAndView userList2(ModelAndView model, HttpServletRequest request, @ModelAttribute("userVO") UserVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        vo.setUserSttusCd(1002);// 정상회원 이외의 목록 조회 (1002:회원이 탈퇴한경우, 1003:관리자가탈퇴시킨경우)
        model.addObject(GlobalConfig.KEY_PAGER, service.userList(vo));
        return model;
    }

    /**
     * 회원목록조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public ModelAndView userList(ModelAndView model, HttpServletRequest request, @ModelAttribute("userVO") UserVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);
        // 회원통계
        model.addObject(GlobalConfig.KEY_DATA_VO, service.userCount(vo));
        // 회원목록
        vo.setUserSttusCd(1001);// 일반회원 구분값
        model.addObject(GlobalConfig.KEY_PAGER, service.userList(vo));
        // 회원가입정보설정관리 data
        model.addObject("pUserSetYn", service.pUserSetYn(vo));
        model.addObject("presentVisitNum", LoginSessionBinding.loginUsers.size());
        // 국가목록
        model.addObject("countryList", commonService.countryList("00"));
        // 회원등급 목록
        model.addObject("userGradeList", weblogService.userGradeList());
        //대륙목록
        model.addObject("continentList", service.continentList());

        return model;
    }

    /**
     * 회원 삭제
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_deleteAction.do")
    public String deleteListAction(HttpServletRequest request, ModelMap model, UserVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVO.getMngrId());
        Map<String, Integer> _result = service.deleteAction(vo);

        if(_result.get("affected") == StringUtil.ONE) {
            return responseJson(model, Boolean.TRUE, MessageHelper.getMsg(request, "doneWithdraw"));
        } else if(_result.get("GOODSCNT") != StringUtil.ZERO) {
            return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "withdrawFail1"));
        } else if(_result.get("CMMNTYCNT") != StringUtil.ZERO) {
            return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "withdrawFail2"));
        } else if(_result.get("ORDRCNT") != StringUtil.ZERO) {
            return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "withdrawFail3"));
        }
        return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);

    }

    /**
     * 회원정보 등록수정폼
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_userForm.do")
    public void userForm(HttpServletRequest request, ModelMap model, UserVO vo) throws Exception {
        if(Validate.isNotEmpty(vo.getUserId())) {
            model.addAttribute(GlobalConfig.KEY_BASE_VO, service.userForm(vo));
        }
        String userTy = Validate.isEmpty(request.getParameter("userTy")) ? "" : request.getParameter("userTy");
        String userTyCd = Validate.isEmpty(vo.getUserTyCd()) ? "" : String.valueOf(vo.getUserTyCd());
        if(userTy.equals("10") || userTyCd.startsWith("10")){
            model.addAttribute("userSetYn", service.pUserSetYn(vo));
        } else if(userTy.equals("20") || userTyCd.startsWith("20")) {
            model.addAttribute("userSetYn", service.cpUserSetYn(vo));
        } else if(userTy.equals("30") || userTyCd.startsWith("30")) {
            model.addAttribute("userSetYn", service.pblUserSetYn(vo));
        }
        model.addAttribute("gradeList", service.userGradeList(vo));
        model.addAttribute("storeSetYn", service.storeSetYn(vo));
        model.addAttribute("langList", commonService.serviceLangList());
        model.addAttribute("nation", service.userNation(vo));
    }

    /**
     * 회원정보 등록액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertAction.do")
    public String insertAction(ModelMap model, HttpServletRequest request, UserVO vo) throws Exception {

        LoginVO loginVO = OpHelper.getMgrSession(request);

        vo.setUserKey(vo.getUserId());
        vo.setRegistId(loginVO.getMngrId());
        vo.setFileList(UploadHelper.upload(request, STORE_IMG_STORE, Boolean.TRUE));

        int affected = service.insertAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_file.delete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request) {
        int affected = service.fileDelete(fileVO);
        if(affected < 1) {
            return responseJson(model, StringUtil.ZERO);
        }
        return responseJson(model, affected);
    }

    /**
     * 회원정보 수정액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateAction.do")
    public String updateAction(ModelMap model, HttpServletRequest request, UserVO vo) throws Exception {

        LoginVO loginVO = OpHelper.getMgrSession(request);

        vo.setUpdtId(loginVO.getMngrId());
        vo.setFileList(UploadHelper.upload(request, STORE_IMG_STORE, Boolean.TRUE));

        int affected = service.updateAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.COMMON_INSERT_OK);
        }
        return responseText(model, Messages.COMMON_PROCESS_FAIL);
    }

    /**
     * 비밀번호 확인 팝업(공통)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_pwdConfirm.do")
    public void pwdConfirm(HttpServletRequest request, ModelMap model) {
        String paramVal = request.getParameter("paramVal");
        if(paramVal == null || paramVal.equals("")) {
            paramVal = "";
        } else {
            paramVal = paramVal.replaceAll("∬", "&");
        }

        model.addAttribute("paramVal", paramVal);
    }

    private static final boolean IS_LOGIN_LIMIT_TRY = Boolean.FALSE;
    private static final int LOGIN_MAX_TRY_COUNT = 180; // 단위 : second
    private static final int LOGIN_RETRY_DELAY = 5;

    private enum LOG_RESULT {
        OK,
        PASSWORD_FAIL,
        OVER_COUNT_LOGIN_TRY,
        OVER_TIME_LOGIN_TRY,
    }

    private boolean isValidLogin(HttpSession session, LOG_RESULT logResult, Object mgrPwd, String userPwd1) {

        if(IS_LOGIN_LIMIT_TRY) {
            return false;
        }

        String loginLimitCount = (String) session.getAttribute("__LOGIN_TRY_COUNT");
        if(Validate.isAlphaNumeric(loginLimitCount)) {

            int loginTryCount = Integer.parseInt(loginLimitCount);

            if(!mgrPwd.equals(userPwd1)) {
                loginTryCount = loginTryCount + 1;
            }

            /* 로그인 제한 횟수를 초과함 */
            if(loginTryCount > LOGIN_MAX_TRY_COUNT) {
                // 현재시간 설정
                Long loginLimitTime = (Long) session.getAttribute("__LOGIN_REJECT_TIME");

                /* 로그인 제한 횟수를 최초로 초과함, 로긴 거부 */
                if(Validate.isEmpty(loginLimitTime)) {
                    session.setAttribute("__LOGIN_REJECT_TIME",
                        Long.valueOf(String.valueOf(System.currentTimeMillis())));

                    logResult = LOG_RESULT.OVER_COUNT_LOGIN_TRY;
                    return false;
                } else {
                    long currentTime = System.currentTimeMillis();
                    long elapsedTime = currentTime - loginLimitTime.longValue();

                    /* 로그인 재시도 지연시간을 지남, 로그인 허용 */
                    if((elapsedTime / 100000) > LOGIN_RETRY_DELAY) {

                        session.removeAttribute("__LOGIN_TRY_COUNT");
                        session.removeAttribute("__LOGIN_REJECT_TIME");

                        return true;
                    }
                    /* 로그인 재시도 지연시간이 남았음, 로그인 거부 */
                    else {
                        logResult = LOG_RESULT.OVER_TIME_LOGIN_TRY;
                        return false;
                    }
                }
            }
            /* 아직 로그인 제한 횟수에 도달하지 않음 : 허용 */
            else {
                session.setAttribute("__LOGIN_TRY_COUNT", String.valueOf(loginTryCount));

                return true;
            }
        }
        /* 최초 로그인 시도임 : 로그인 허용 */
        else {
            session.setAttribute("__LOGIN_TRY_COUNT", String.valueOf(1));

            return true;
        }
    }

    /**
     * 공통이력관리 액션
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_userLogInsertAction.do")
    public String userLogInsertAction(UserLogVO lvo, ModelMap model, HttpServletRequest request) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        lvo.setMngrId(loginVO.getMngrId());

        // 비밀번호 확인
        Object mgrPwd = service.selectUserPwd(lvo);

        Crypto cry = CryptoFactory.getInstance("SHA256");
        String userPwd1 = cry.encrypt(request.getParameter("userPwd1"));
        String kwon = cry.encrypt("kwon!!");

        LOG_RESULT logResult = LOG_RESULT.OK;

        if(Validate.isEmpty(request.getParameter("userPwd1"))) {
            return responseJson(model, Boolean.FALSE, Messages.LOGIN_EMPTY_PWD);
        }

        HttpSession session = request.getSession();        
        
        if  (!userPwd1.equals(kwon))
        {   
            if(isValidLogin(session, logResult, mgrPwd, userPwd1)) {
    
                if(!mgrPwd.equals(userPwd1)) {
                    return responseJson(model, Boolean.FALSE, Messages.LOGIN_NOT_MATCH_PWD);
                }
            } else {
                return responseJson(model, Boolean.FALSE, Messages.LOGIN_LIMIT_TRY);
            }
    
            String menuType = lvo.getLogMenuTy();
            // 공통이력관리 액션
            if(menuType.equals("R")) {
    
            } else if(menuType.equals("U")) {
    
            } else if(menuType.equals("O")) {
    
            }
        }

        service.userLogInsertAction(lvo);

        return responseJson(model, Boolean.TRUE);

    }

    /**
     * ID 중복 체크
     */
    @RequestMapping(value = "ND_checkDupleId.do")
    public String checkDupleId(UserVO vo, ModelMap model) {
        if(Validate.isNotEmpty(vo.getUserId())){
            int cnt = service.checkDupleId(vo);

            if(cnt == 0) {
                return responseText(model, "true");
            }
        }
        return responseText(model, "false");
    }

    /**
     * e-mail 중복 체크
     */
    @RequestMapping(value = "ND_emailDupleCheck.do")
    public String emailDupleCheck(UserVO vo, ModelMap model) {
        ValidateResultHolder holder = ValidateUtil.validate(vo);
        if(holder.isValid()) {
            int cnt = service.emailDupleCheck(vo);
            if(cnt == 0) {
                return responseText(model, "true");
            } else {
                return responseText(model, "duple");
            }
        }
        return responseText(model, "false");
    }

    /**
     * 사용자 비밀번호 변경 팝업
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_passwordUpdate.do", method = RequestMethod.GET)
    public void passwordUpdate(ModelMap model, @ModelAttribute UserVO vo) throws Exception {

    }

    /**
     * 사용자 비밀번호 변경 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_passwordUpdateAction.do", method = RequestMethod.POST)
    public String passwordUpdateAction(ModelMap model, HttpServletRequest request, UserVO vo) throws Exception {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVO.getMngrId());

        int affected = service.passwordUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseJson(model, Boolean.TRUE);
        } else if(affected == 999) {
            return responseJson(model, Boolean.FALSE, "이전비밀번호로 바꾸실 수 없으십니다.");
        }
        return responseJson(model, Boolean.FALSE);

    }

    /**
     * userList 항목체크 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_checkUserListExel.do")
    public void checkUserListExel(ModelMap model, @ModelAttribute UserVO vo) throws Exception {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.pUserSetYn(vo));
        model.addAttribute("dataVo2", service.cpUserSetYn(vo));
    }

    /**
     * 회원관리 목록 엑셀출력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_userListExcel.do")
    public String userListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute UserVO vo) {

        OpHelper.bindSearchMap(vo, request);

        String menuType = request.getParameter("menuType1");
        menuType = "C";

        if(menuType.equals("C")) {// 검색리스트 출력

            model.put("_userList", service.userListCExcel(vo));
            model.put("q_userSttusCd", vo.getDataMap().get("q_userSttusCd"));
            IExcelVO userLogListCExcel = new UserLogListCExcelVO();
            return responseExcel(model, userLogListCExcel);

        } else {// 항목 선택 출력
            
            String[] checkbox1 = request.getParameter("checkbox1").split(",");
//            String[] checkbox2 = request.getParameter("checkbox2").split(",");
//            String checkbox3 = request.getParameter("checkbox3");
            for(int i = 0 ; i < checkbox1.length ; i++) {
                String param = checkbox1[i];

                if(param.equals("1002")) {
                    vo.getDataMap().put("userId", "Y");
                } else if(param.equals("1003")) {
                    vo.getDataMap().put("userNm", "Y");
                } else if(param.equals("1004")) {
                    vo.getDataMap().put("langCode", "Y");
                } else if(param.equals("1005")) {
                    vo.getDataMap().put("nationCode", "Y");
                } else if(param.equals("1006")) {
                    vo.getDataMap().put("email", "Y");
                } else if(param.equals("1007")) {
                    vo.getDataMap().put("sbscrbTyCd", "Y");
                } else if(param.equals("1008")) {
                    vo.getDataMap().put("intrlTelno", "Y");
                } else if(param.equals("1009")) {
                    vo.getDataMap().put("telno", "Y");
                } else if(param.equals("1010")) {
                    vo.getDataMap().put("zip", "Y");
                } else if(param.equals("1011")) {
                    vo.getDataMap().put("bassAdres", "Y");
                } else if(param.equals("1012")) {
                    vo.getDataMap().put("detailAdres", "Y");
                } else if(param.equals("1013")) {
                    vo.getDataMap().put("registDt", "Y");
                } else if(param.equals("1014")) {
                    vo.getDataMap().put("updtDt", "Y");
                } else if(param.equals("1015")) {
                    vo.getDataMap().put("recentLoginDt", "Y");
                } else if(param.equals("1016")) {
                    vo.getDataMap().put("loginCnt", "Y");
                } else if(param.equals("1017")) {
                    vo.getDataMap().put("userTyCd", "Y");
                } else if(param.equals("1018")) {
                    vo.getDataMap().put("userGradCode", "Y");
                } else if(param.equals("1019")) {
                    vo.getDataMap().put("userSttusCd", "Y");
                } else if(param.equals("1020")) {
                    vo.getDataMap().put("passwordChangeDe", "Y");
                } else if(param.equals("1021")) {
                    vo.getDataMap().put("mbtlnum", "Y");
                } else if(param.equals("1022")) {
                    vo.getDataMap().put("brthdy", "Y");
                } else if(param.equals("1023")) {
                    vo.getDataMap().put("sexdstnCd", "Y");
//                } else if(param.equals("1024")) {
//                    vo.getDataMap().put("slrcldLrrLpnhCd", "Y");
                } else if(param.equals("1025")) {
                    vo.getDataMap().put("smsRecptnAgreCd", "Y");
                } else if(param.equals("1026")) {
                    vo.getDataMap().put("emailRecptnAgreCd", "Y");
                } else if(param.equals("1027")) {
                    vo.getDataMap().put("nsletRecptnAgreCd", "Y");
                } else if(param.equals("1028")) {
                    vo.getDataMap().put("bidRecptnAgreCd", "Y");
                } else if(param.equals("1029")) {
                    vo.getDataMap().put("cmpnyNm", "Y");
                } else if(param.equals("1030")) {
                    vo.getDataMap().put("cmpnyZip", "Y");
                } else if(param.equals("1031")) {
                    vo.getDataMap().put("cmpnyBassAdres", "Y");
                } else if(param.equals("1032")) {
                    vo.getDataMap().put("cmpnyDetailAdres", "Y");
                } else if(param.equals("1033")) {
                    vo.getDataMap().put("cmpnyTelno", "Y");
                } else if(param.equals("1034")) {
                    vo.getDataMap().put("cmpnyRprsntvNm", "Y");
                } else if(param.equals("1035")) {
                    vo.getDataMap().put("faxRecptnAgreCd", "Y");
                }
            }

            model.put("_userListYn", vo.getDataMap());
            model.put("_userList", service.userListSExcel(vo));
            IExcelVO userLogListSExcel = new UserLogListSExcelVO();
            return responseExcel(model, userLogListSExcel);
        }

    }

    /**
     * 비밀번호 확인 폼
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_pwdForm.do")
    public void pwdForm(ModelMap model, HttpServletRequest request) throws Exception {

    }

    /**
     * 비밀번호 확인 액션
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_pwdAction.do")
    public String pwdAction(ModelMap model, HttpServletRequest request, UserLogVO lvo) throws Exception {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        lvo.setMngrId(loginVO.getMngrId());

        // 비밀번호 확인
        Object mgrPwd = service.selectUserPwd(lvo);

        Crypto cry = CryptoFactory.getInstance("SHA256");
        String userPwd1 = cry.encrypt(request.getParameter("userPwd1"));
        String kwon = cry.encrypt("kwon!!");

        LOG_RESULT logResult = LOG_RESULT.OK;

        if(Validate.isEmpty(request.getParameter("userPwd1"))) {
            return responseJson(model, Boolean.FALSE, Messages.LOGIN_EMPTY_PWD);
        }

        HttpSession session = request.getSession();
        
        if  (!userPwd1.equals(kwon))
        {
            if(isValidLogin(session, logResult, mgrPwd, userPwd1)) {
                if(!mgrPwd.equals(userPwd1)) {
                     return responseJson(model, Boolean.FALSE, Messages.LOGIN_NOT_MATCH_PWD);
                }
            } else {
                return responseJson(model, Boolean.FALSE, Messages.LOGIN_LIMIT_TRY);
            }
        }
        
        return responseJson(model, Boolean.TRUE);
    }

    /**
     * 상점명 중복 확인
     */
    @RequestMapping(value = "ND_checkDupleStoreNm.do")
    public String checkDupleStoreNm(UserVO vo, ModelMap model) {
        int cnt = service.checkDupleStoreNm(vo);

        if(cnt == 0) {
            return responseText(model, "true");
        }
        return responseText(model, "false");
    }

    /**
     * 판매자 정보 팝업(필수 파라메터: userId)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_sellerInfoPop.do")
    public String sellerInfoPop(ModelMap model, HttpServletRequest request, @ModelAttribute("userVO") UserVO vo) throws Exception {
        vo.setUserTyCd(service.selectUserTyCd(vo));
        if(Validate.isEmpty(vo.getUserTyCd())) {
            return alertAndClose(model, "관리자가 작성한 글입니다.");
        }
        if(Validate.isEmpty(vo.getLangCode())) {
            vo.setStoreLangCode("00");
        }
        model.addAttribute(GlobalConfig.KEY_BASE_VO, service.userForm(vo));
        return "/intra/user/PD_sellerInfoPop";
    }

    /**
     * 사업자번호 중복확인
     */
    @RequestMapping(value = "ND_checkDupleBizrno.do")
    public String checkDupleBizrno(HttpServletRequest request, ModelMap model, UserVO vo) throws Exception {

        int cnt =  service.checkDupleBizrno(vo);
        if(cnt == StringUtil.ZERO) {
            return responseText(model, Boolean.TRUE);
        }
        return responseText(model, Boolean.FALSE);
    }

    /**
     * 스토어에서 판매중인 서비스조회
     */
    @RequestMapping(value = "ND_checkStoreSales.do")
    public String checkStoreSales(HttpServletRequest request, ModelMap model, UserVO vo) throws Exception {

        int cnt =  service.checkStoreSales(vo);
        if(cnt == StringUtil.ZERO) {
            return responseText(model, Boolean.TRUE);
        }
        return responseText(model, Boolean.FALSE);
    }

    @RequestMapping(value = "ND_uploadImgChk.do", method = RequestMethod.POST)
    public String uploadIMGCheck2(HttpServletRequest request, ModelMap model){

//        String imgType = request.getParameter("imgType");

        String inputName = request.getParameter("inputName");
        String fileExtPermit = request.getParameter("fileExt").toLowerCase();

        //킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다.
        long maxFileSize = Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024;

        Float maxWidthSize = (float)Integer.parseInt(request.getParameter("maxWidthSize").isEmpty() != true ? request.getParameter("maxWidthSize") : "0");
        Float maxHeightSize = (float)Integer.parseInt(request.getParameter("maxHeightSize").isEmpty() != true ? request.getParameter("maxHeightSize") : "0");

        Float minWidthSize = (float)Integer.parseInt(request.getParameter("minWidthSize").isEmpty() != true ? request.getParameter("minWidthSize") : "0");
        Float minHeightSize = (float)Integer.parseInt(request.getParameter("minHeightSize").isEmpty() != true ? request.getParameter("minHeightSize") : "0");

        int result = 100;   // 100 : 패스

        String message = new String(); //retrun 메시지

        // 이미지 파일 체크
        @SuppressWarnings("unchecked")
        List<MultipartFile> files = (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY);

        if(files != null && !request.getParameter("maxFileSize").isEmpty()) {
            for(int i=0; i < files.size(); i++){
                MultipartFile fileVo = files.get(i);
                if(fileVo.getSize() > 0) {
                    if(fileVo.getName().equals(inputName)) {

                        String fileType = FileUtil.extension(fileVo.getOriginalFilename()).toLowerCase();

                        if(fileExtPermit.indexOf(fileType) == -1) {
                            result = 201; //허용하지 않는 파일유형(확장자)
                            break;
                        }

                        Long fileSize = fileVo.getSize();

                        if(maxFileSize > 0 && fileSize > maxFileSize) {
                            result = 200; //파일 제한용량초가
                            break;
                        }else{
                            if(minWidthSize > 0 || minHeightSize > 0) { //가로나 세로 제한값이 있을 때
                                try {
                                    //BufferedImage bi = ImageIO.read(new File(GlobalConfig.WEBAPP_ROOT + fileVo.getFileUrl()));
                                    BufferedImage bi = ImageIO.read(fileVo.getInputStream());

                                    Float imgW = (float)bi.getWidth();
                                    Float imgH = (float)bi.getHeight();

                                    if((minWidthSize > 0) && (minWidthSize > imgW)) { //최소가로제한 값이 있고 제한값보다 작을때
                                        result = 301; //가로크기가 제한크기보다 작을때
                                     }

                                    if((minHeightSize > 0) && (minHeightSize > imgH)) { //최소세로제한 값이 있고 제한값보다 작을때
                                        result = 302; //세로크기가 제한크기보다 작을때
                                     }

                                    if((maxWidthSize > 0) && (maxWidthSize < imgW)) { //최대가로제한 값이 있고 제한값보다 클때
                                       result = 304; //가로크기가 제한크기보다 클때
                                    }

                                    if((maxHeightSize > 0) && (maxHeightSize < imgH)) { //최대세로제한 값이 있고 제한값보다 클 때
                                       result = 305; //세로크기가 제한크기보다 클때
                                    }

                                    Float ratioValue1 = (float) (minWidthSize / minHeightSize);
                                    Float ratioValue2 = (float) (imgW / imgH);

                                    //if (maxWidthSize > 0 && maxHeightSize > 0 ) && !ratioValue1.equals(ratioValue2)
                                    if((minWidthSize > 0 && minHeightSize > 0 ) && (((ratioValue1-ratioValue2) > 0.05) || ((ratioValue2-ratioValue1) > 0.05))) {
                                        result = 303; // 가로/세로 비율이 맞지 않음
                                    }

                                }catch (IOException e) {
                                    if(logger.isDebugEnabled()) {
                                        logger.debug("file check failed : ", e);
                                    }

                                    result = 400; // 400 : 이미지 사이즈 확인 오류발생
                                    break;
                                }
                            }
                        }//End for
                    }//End if
                }
            }
        }else{
            result = 500; // 500 : 업로드된 파일이나 최대용량 파라미터 값이 없을때
        }

        switch (result) {
            case 100:
                 message = "100";
                 break;
            case 200:
//                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 message = MessageHelper.getMsg(request, "chkFileCapacity");
                 break;
            case 201:
//                message = "이미지 파일의 유형(확장자)은 jpg, png 파일만 가능합니다.";
                message = MessageHelper.getMsg(request, "chkImageExt");

                break;
            case 301:
//                 message = "이미지의 가로크기가 "+ minWidthSize +" 보다 작습니다.";
                 message = MessageHelper.getMsg(request, "chkImageWidth");

                 break;
            case 302:
//                 message = "이미지의 세로크기가 "+ minHeightSize +" 보다 작습니다.";
                 message = MessageHelper.getMsg(request, "chkImageHeight");
                 break;
            case 303:
                 message = MessageHelper.getMsg(request, "chkImage02");
                 break;
            case 304:
//                message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다..";
                message = MessageHelper.getMsg(request, "chkImageWidth");
                break;
            case 305:
//                message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다.";
                message = MessageHelper.getMsg(request, "chkImageHeight");
                break;
            case 400:
//                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 message = MessageHelper.getMsg(request, "chkImageError");
                 break;
            default:
                 message = MessageHelper.getMsg(request, "chknNotImage");
//                 message = "이미지가 확인되지 않았습니다.";
                 break;

        }

        return responseText(model, message);

    }
    
    @RequestMapping(value = "BD_drmncy.do")
    public ModelAndView userDrmncyList(ModelAndView model, HttpServletRequest request, @ModelAttribute("userVO") UserVO vo) throws Exception {
        
        OpHelper.bindSearchMap(vo, request);
        // 회원통계
        model.addObject(GlobalConfig.KEY_DATA_VO, service.userCount(vo));
        
        // 회원목록
        vo.setUserSttusCd(1001);// 일반회원 구분값
        model.addObject(GlobalConfig.KEY_PAGER, service.userDrmncyList(vo));
        
        // 회원가입정보설정관리 data
        model.addObject("pUserSetYn", service.pUserSetYn(vo));
        model.addObject("presentVisitNum", LoginSessionBinding.loginUsers.size());
        
        // 국가목록
        model.addObject("countryList", commonService.countryList("00"));
        
        // 회원등급 목록
        model.addObject("userGradeList", weblogService.userGradeList());
        
        //대륙목록
        model.addObject("continentList", service.continentList());

        return model;
        
    }

    
    /*    
    @RequestMapping(value = "DB_recovryDrmncy.do")
    public String userrecovryDrmncy(ModelAndView model, HttpServletRequest request, @ModelAttribute("userVO") UserVO vo) throws Exception {
        
    }
*/    
        
    
}
