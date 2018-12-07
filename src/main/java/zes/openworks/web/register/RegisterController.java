/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import Kisinfo.Check.IPINClient;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.utils.Converter;
import zes.core.utils.FileUtil;
import zes.core.utils.MakeExcel;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.listener.LoginSessionBinding;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.bassDegreeManage.BassDegreeManageVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.dmandExaminDtls.DmandExaminRegistMngrVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.dmandExamin.DmandExaminService;
import zes.openworks.web.dmandExamin.DmandExaminVO;
import zes.openworks.web.login.UserLogVO;
import zes.openworks.web.login.UserLoginService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.main.MainConstant;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import zes.openworks.web.sale.goods.WebGoodsService;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *       <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일               수정자                       수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 13.     홍길동     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = { "/**/register" })
public class RegisterController extends WebController {

    @Autowired
    private RegisterService registerService;
    @Autowired
    private CommonDutyService commonService;
    @Autowired
    private AutoMailService amservice;
    @Autowired
    private SmsTransHistService smsService;
    @Autowired
    WebGoodsService goodsService;
    @Autowired
    private PopService popService;
    @Autowired
    private UserLoginService webLoginService;
    @Autowired
    private DmandExaminService dmandExaminService;
    
    /** 파일 저장 경로 */
    public static final String STORE_IMG_STORE = "store" + File.separator;
    public static final String DMANDEXAMIN_EXCEL = "dmandExamin" + File.separator;
    public static final String BASS_AGREM_FILE = "bassAgremFile" + File.separator;
    
    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }

    public String serverNm(HttpServletRequest request) {
      //{{ 2015.11.23, 도메인관리삭제로 인한 소스변경
      //변경소스
        String serverNm = "korean";
       return "/" + serverNm ;
      //}}
    }

    // 접속 사용자 도메인 값 불러와서 가져오기
    public String Language(HttpServletRequest request) {
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }
    
    /**
     * 회원가입 동의 약관
     * index 설명
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "BD_index.do")
    public String index(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String url = serverNm(request)+"/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_index.do";
        url += "&returnParam=userTyCd=&nationCode=" + vo.getNationCode(); // 판매권한 신청용 URL

        String paramUserTyCd = request.getParameter("userTyCd");
        
        System.out.println("paramUserTyCd: " + paramUserTyCd);
        int userTyCd2 = 0;
        if(Validate.isEmpty(paramUserTyCd) && userLoginVo.getUserTyCd() == 1001){
            userTyCd2 = 1002;
        } else if(Validate.isEmpty(paramUserTyCd) && userLoginVo.getUserTyCd() == 2001){
            userTyCd2 = 2002;
        } else if(Validate.isEmpty(paramUserTyCd) && userLoginVo.getUserTyCd() == 3001){
            userTyCd2 = 3002;
        }

        if(vo.getNationCode().equals("410")){
//          if("real".equals(GlobalConfig.SERVICE_MODE)){
                if(
                    "1002".equals(paramUserTyCd) || (Validate.isEmpty(paramUserTyCd) && userLoginVo.getUserTyCd() == 1001)
                    ||
                    "2002".equals(paramUserTyCd) || (Validate.isEmpty(paramUserTyCd) && userLoginVo.getUserTyCd() == 2001)
                    ||
                    "3002".equals(paramUserTyCd) || (Validate.isEmpty(paramUserTyCd) && userLoginVo.getUserTyCd() == 3001)
                ){
                    HttpSession session = request.getSession();
                    //dev 용 사업자 인증 중지
                    String strRetCd = /*request.getParameter("strRetCd") != null ? request.getParameter("strRetCd").toString() :*/ "1";       //사업자번호인증 결과 응답코드
                    String strRetDtlCd = /*request.getParameter("strRetDtlCd") != null ? request.getParameter("strRetDtlCd").toString() :*/ "A"; //사업자번호인증 결과 상세코드
                    String bizrno = session.getAttribute("bizNo") != null ? session.getAttribute("bizNo").toString() : "";                //인증된 사업자번호
                    String cmpnyNm = session.getAttribute("bizNm") != null ? session.getAttribute("bizNm").toString() : "";              //인증된 사업자명
                    
                    //인증 확인을 위해 인증정보 유무 판단
                    if("1".equals(strRetCd) && "A".equals(strRetDtlCd)){  //사업자번호와 회사명의 일치가 인증됨
                        model.addAttribute("notMatchBizno2", false);
                        if(Validate.isEmpty(request.getParameter("userTyCd"))
                            && (
                                userLoginVo.getUserTyCd() == 1001
                                || userLoginVo.getUserTyCd() == 2001
                                || userLoginVo.getUserTyCd() == 3001
                            )
                        ) {
                            //기존 기업 구매회원이 판매전환신청시 사업자 인증내용과 기존 회원정보내용 비교
                            bizrno = bizrno.substring(0, 3) + "-" + bizrno.substring(3, 5) + "-" + bizrno.substring(5);
                            vo.setBizrno(bizrno);
                            vo.setCmpnyNm(cmpnyNm);
                            vo.setUserId(userLoginVo.getUserId());
                            //인증데이터와 DB상의 정보 비교
                            RegisterUserVO bizVo = registerService.cetifybizNo(vo);  //가입자명가져오기
                                vo.setUserTyCd2(userTyCd2);
                                if(Validate.isEmpty(bizVo)) {
                                    //기존가입정보의 사업자정보와 다름 덮어씀 확인용
                                    model.addAttribute("notMatchBizno2", true);
                                }
                                model.addAttribute("userTyCd2", userTyCd2);
                                model.addAttribute("cmpnyNm", cmpnyNm);
                                model.addAttribute("bizrno", bizrno);
                                
                                return requestUrl(request) + "/BD_index";
                        } else {
                            //신규 기업 구매판매회원
                            return requestUrl(request) + "/BD_index";
                        }
                    }else if("2".equals(strRetCd)){
                        if("B".equals(strRetDtlCd)){ //인증시스템에서 인증실패
                            return alertAndBack(model, MessageHelper.getMsg(request, "bizNoFail"));
                        }else if("D".equals(strRetDtlCd)){   //사업자번호 체계가 틀림
                            //return alertAndBack(model, MessageHelper.getMsg(request, "bizNoIncorrect"));
                        }else if("E".equals(strRetDtlCd)){     //일시적인 통신장애
                            return alertAndBack(model, MessageHelper.getMsg(request, "certfyErrorBizNo"));
                        }else{
                            return alertAndBack(model, MessageHelper.getMsg(request, "bizNoFail"));
                        }
                    }else if("3".equals(strRetCd) && "G".equals(strRetDtlCd)){  //나이스에 등록되어있지 않은 사업자
                        return alertAndBack(model, MessageHelper.getMsg(request, "noRegBizNo"));
                    }else{
                        return alertAndBack(model, MessageHelper.getMsg(request, "bizNoFail"));
                    }
                }

                int dplctSbscrbPrvnKeyCnt = 0;
                if(vo.getSbscrbTyCd() == 1001) {
                    //SMS인증 후 중복검사
                    if(Validate.isNotEmpty(request.getParameter("encData"))) {
                        NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

                        String sResponseData = request.getParameter("encData");
                        String sSiteCode     = "G7358";
                        String sSitePw     = "UM0TNW4SRJ9S";
                        //SMS 복호화
                        int iReturn = niceCheck.fnDecode(sSiteCode, sSitePw, sResponseData);

                        if( iReturn == 0 ) {
                            String sPlainData = niceCheck.getPlainData();

                            // 데이타를 추출합니다.
                            @SuppressWarnings("rawtypes")
                            java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

                            dplctSbscrbPrvnKeyCnt = registerService.dupleDplctSbscrbPrvnKey((String)mapresult.get("DI"));
                        }
                    }
                } else if(vo.getSbscrbTyCd() == 1002) {
                    //I-PIN인증 후 중복검사
                    if(Validate.isNotEmpty(request.getParameter("enc_data"))) {
                        String sResponseData = request.getParameter("enc_data");
                        String sSiteCode     = "K517";
                        String sSitePw     = "57168249";
                        IPINClient pClient = new IPINClient();
                        pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
                        //아이핀 복호화
                        dplctSbscrbPrvnKeyCnt = registerService.dupleDplctSbscrbPrvnKey(pClient.getDupInfo());
                    }
                }
                if(dplctSbscrbPrvnKeyCnt != 0) {
                    //중복방지키값이 DB에 있음
                    return alertAndBack(model, MessageHelper.getMsg(request, "dupSbscrbTyCdCnt"));
                }

                if(Validate.isEmpty(vo.getUserTyCd())){
                    if(Validate.isEmpty(userLoginVo)){
                        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), url);
                    }
                }
//          }
        } else if(Validate.isEmpty(vo.getUserTyCd())) {
            if(Validate.isEmpty(userLoginVo)){
                return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), url);
            }
            if(userLoginVo.getUserTyCd().toString().endsWith("02")){
                return alertAndRedirect(model, MessageHelper.getMsg(request, "memberAlready"), serverNm(request)+ "/pt/index.do");
            }
        }
        if(Validate.isNotEmpty(userLoginVo) && Validate.isEmpty(vo.getUserTyCd())){
            model.addAttribute("userTyCd2", userTyCd2);
        }
        return requestUrl(request) + "/BD_index";
    }

    /**
     * 비밀번호 확인폼
     * password 설명
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "BD_password.do", method = RequestMethod.GET)
    public String password(HttpServletRequest request, ModelMap model) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            String url = serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_password.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), url);
        } else {
            return requestUrl(request) + "/BD_password";
        }
    }

    /**
     * 회원가입 개인회원 or 기업회원 선택
     * join 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "BD_join.do")
    public void join(HttpServletRequest request, ModelMap model, RegisterVO vo) {

    }

    /**
     * 회원가입 인증페이지
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "BD_userCrtfc.do")
    public String userCrtfc(HttpServletRequest request, ModelMap model, RegisterVO vo) throws UnsupportedEncodingException {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)) {
            if(Validate.isEmpty(vo.getUserTyCd())) {
                if(userLoginVo.getUserTyCd() == 1002 || userLoginVo.getUserTyCd() == 2002 || userLoginVo.getUserTyCd() == 3002) {
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "memberAlready"), serverNm(request)+ "/pt/index.do");
                }
                int userTyCd2 = 0;
                if(userLoginVo.getUserTyCd() == 1001){
                    userTyCd2 = 1002;
                } else if(userLoginVo.getUserTyCd() == 2001){
                    userTyCd2 = 2002;
                } else if(userLoginVo.getUserTyCd() == 3001){
                    userTyCd2 = 3002;
                }
                model.addAttribute("userTyCd2", userTyCd2);
                return requestUrl(request) + "/BD_userCrtfc";
            }
            return alertAndRedirect(model, MessageHelper.getMsg(request, "memberAlready"), serverNm(request)+ "/pt/index.do");
        } else {
            if(Validate.isEmpty(vo.getUserTyCd())) {
                return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request)+"/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_userCrtfc.do" + "&returnParam=userTyCd=&nationCode=" + vo.getNationCode());
            }
            return requestUrl(request) + "/BD_userCrtfc";
        }
    }

    /**
     * 회원 신규 가입폼
     */
    @RequestMapping(value = "BD_userForm.do", method = RequestMethod.POST)
    public String userForm(HttpServletRequest request, ModelMap model, RegisterVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "illegalRequest"), serverNm(request)+ "/pt/index.do");
        }
        model.addAttribute("nation", registerService.userNation(vo));// 등록되어있는 국가 정보
        model.addAttribute("emailList", registerService.prvCodeList(vo.getLangCode(), 80));// 공통코드의 이메일 목록

        RegisterVO registerVO = new RegisterVO();
        if(vo.getUserTyCd() == 1002 || vo.getUserTyCd() == 2002) {
            //판매 회원가입
            model.addAttribute("storeSetYn", registerService.stUserForm(registerVO));
            model.addAttribute("langList", commonService.serviceLangList());// 서비스되어지고 있는 언어 목록
        }
        if (vo.getUserTyCd() == 1001 || vo.getUserTyCd() == 1002) {
            //개인 가입시
            model.addAttribute("userSetYn", registerService.pUserForm(registerVO));
        } else if(vo.getUserTyCd() == 2001 || vo.getUserTyCd() == 2002){
            //기업 회원가입시
            model.addAttribute("userSetYn", registerService.cUserForm(registerVO));
        }
        return requestUrl(request) + "/BD_userForm";// 신규 회원가입시
    }

    /**
     * 판매권한 취득페이지
     */
    @RequestMapping(value = "BD_userChangeForm.do", method = RequestMethod.POST)
    public String userChangeForm(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        RegisterVO registerVO = new RegisterVO();
        registerVO.setLangCode(vo.getLangCode());
        if(Validate.isNotEmpty(userLoginVo) && userLoginVo.getUserTyCd().toString().endsWith("01")) {
            RegisterUserVO uservo = new RegisterUserVO();
            uservo.setUserTyCd(userLoginVo.getUserTyCd());
            uservo.setUserId(userLoginVo.getUserId());
            uservo.setLangCode(lagnCode(request));
            model.addAttribute("loginData", registerService.updateForm(uservo));
            model.addAttribute("nation", registerService.userNation(registerVO));// 등록되어있는 국가 정보
            model.addAttribute("emailList", registerService.prvCodeList(vo.getLangCode(), 80));// 공통코드의 이메일 목록
            model.addAttribute("cmpnyLocaList", registerService.prvCodeList(vo.getLangCode(), 2036)); // 공통코드의 소제지 목록
            model.addAttribute("langList", commonService.serviceLangList());// 서비스되어지고 있는 언어 목록
        } else if(Validate.isNotEmpty(userLoginVo) && userLoginVo.getUserTyCd().toString().endsWith("02")) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "memberAlready"), serverNm(request)+ "/pt/index.do");
        } else if(Validate.isEmpty(vo.getUserTyCd())) {
            // 로그인 없이 전환페이지 접급시
            return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_join.do");
        }

        model.addAttribute("storeSetYn", registerService.stUserForm(registerVO));
        return requestUrl(request) + "/BD_userChangeForm";// 공급자 전환 신청 페이지
    }
    
    /**
     * 기본협약등록
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_BassAgreminsertAction.do", method=RequestMethod.POST )
    public String BassAgreminsertAction(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVo.getUserId());
        uvo.setUserId(userLoginVo.getUserId());
        
        model.addAttribute("cmpnyLocaList", registerService.prvCodeList("00", 2036)); // 공통코드의 소제지 목록
        
        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, BASS_AGREM_FILE);
        
        // 처리 파일 VO 선언
        List<FileVO> multiFiles             = new ArrayList<FileVO>();        // 기업로그
        List<FileVO> bassAgrmntFile         = new ArrayList<FileVO>();        // 기본협약서
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

            // 기업로그
            if (inputNm.startsWith("multiFiles")) {
                multiFiles.add(uploadFile.get(i));
            }
            
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
        vo.setMultiFile(multiFiles);                      // 기업로그
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
        Integer key = registerService.bassAgremInsertAction(vo);

        // 회원유형변경( 일반 > 공급자 )
        if(userLoginVo.getUserTyCd().toString().startsWith("10")) {
            uvo.setUserTyCd(1002);
            uvo.setCmpnyTelno(vo.getTelno());
        }
        // 회원유형변경( 기업 > 공급자 )
        else if(userLoginVo.getUserTyCd().toString().startsWith("20")) {
            uvo.setUserTyCd(2002);
            uvo.setCmpnyTelno(vo.getTelno());
        }
        // 회원유형변경( 공공 > 공급자 )
        else if(userLoginVo.getUserTyCd().toString().startsWith("30")) {
            uvo.setUserTyCd(3002);
            uvo.setPblinsttNm(vo.getCmpnyNm());
            uvo.setBizrno(vo.getBizrno());
            uvo.setPblinsttTelno(vo.getTelno());
        }
        registerService.updateUserTyCd(uvo); /* 횐원정보변경 */
        registerService.updateUserOpt(uvo); /* 회원정보옵션수정 */

        // 스토어정보 등록
        uvo.setStoreImageFileSeq(vo.getMultiFileSeq());
        if(registerService.selectStoreCnt(uvo) > 0) {
            registerService.updateStoreData(uvo); /*스토어정보수정*/
        }
        else {
            registerService.insertStoreData(uvo); /*스토어정보등록*/
        }
        
        //op_user_entrprs_option
        registerService.saveUserEnterOpt(uvo);
        
        /************************************************/
        /** STEP2) 등록 - 끝 ****************************/
        /************************************************/
        
        if(key <= 0){
            return alertAndRedirect(model, MessageHelper.getMsg(request, "checksellerN"), requestUrl(request) + "/BD_index.do");
        }

        return alertAndRedirect(model, MessageHelper.getMsg(request, "checksellerY"), requestUrl(request) + "/BD_complete.do?userTyCd2="+ uvo.getUserTyCd());
    }
    
    /**
     * niceagree 설명
     * @param 공인인증서 페이지
     * @param request
     * @param model
     * @param vo
     * @return true
     */
    @RequestMapping(value="BD_NICEAgree.do", method= RequestMethod.GET)
    public void niceagree(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
    }
    
    /**
     * niceagreeAction 설명
     * @param 공인인증서 인증 액션 추가
     * @param request
     * @param model
     * @param vo
     * @return true
     */
    @RequestMapping(value="ND_niceAgreeAction.do", method= RequestMethod.POST)
    public String niceagreeAction(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        
        /*alertAndRedirect(model, MessageHelper.getMsg(request, "signgateCheckN"), requestUrl(request) + "/BD_NICEAgree.do");*/
        
        return alertAndRedirect(model, MessageHelper.getMsg(request, "signgateCheckY"), requestUrl(request) + "/BD_complete.do");
        
    }
    
    /**
     * 회원정보변경 페이지(실제페이지명:BD_userForm2.jsp)
     */
    @RequestMapping(value = "BD_userUpdateForm.do")
    public String userUpdateForm(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        String referer = Validate.isEmpty(request.getHeader("referer")) ? "" : request.getHeader("referer");
        if(referer.indexOf("ND_checkPassword.do") > -1 || referer.indexOf("BD_userUpdateForm.do") > -1 || referer.indexOf("BD_index.do") > -1){
            UserLoginVO userLoginVo = OpHelper.getUserSession(request);
            if(Validate.isNotEmpty(userLoginVo)) {
                model.addAttribute("langList", commonService.serviceLangList());// 서비스되어지고 있는 언어 목록

                RegisterVO registerVO = new RegisterVO();
                if(userLoginVo.getUserTyCd() == 1002 || userLoginVo.getUserTyCd() == 2002) {
                    //구매 + 판매 회원
                    model.addAttribute("storeSetYn", registerService.stUserForm(registerVO));
                }
                if(userLoginVo.getUserTyCd() == 1001 || userLoginVo.getUserTyCd() == 2001){
                    //개인 회원
                    model.addAttribute("userSetYn", registerService.pUserForm(registerVO));
                } else if(userLoginVo.getUserTyCd() == 2001 || userLoginVo.getUserTyCd() == 2002){
                    //기업 회원
                    model.addAttribute("userSetYn", registerService.cUserForm(registerVO));
                }

                model.addAttribute("emailList", registerService.prvCodeList(vo.getLangCode(), 80));// 공통코드의 이메일 목록

                vo.setUserTyCd(userLoginVo.getUserTyCd());
                vo.setUserId(userLoginVo.getUserId());
                vo.setLangCode(lagnCode(request));
                RegisterVO register = new RegisterVO();
                register.setLangCode(vo.getLangCode());
                model.addAttribute("nation", registerService.userNation(register));// 등록되어있는 국가 정보
                model.addAttribute("loginData", registerService.updateForm(vo));
                
                if(userLoginVo.getUserTyCd() == 3001 || userLoginVo.getUserTyCd() == 3002){
                    return requestUrl(request) + "/BD_userModify2";// 공공기업 회원정보 변경 페이지
                }else{
                    return requestUrl(request) + "/BD_userModify1";// 일반 + 기업회원정보변경 페이지
                }
            }
            // 로그인 없이 정보변경페이지 접급시
            return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_password.do");
        }
        return alertAndRedirect(model, MessageHelper.getMsg(request, "illegalRequest"), requestUrl(request) + "/BD_password.do");
    }
    
    /**
     * 완료 액션
     * BD_complete 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "BD_complete.do")
    public String complete(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        HttpSession session = request.getSession();

        if(Validate.isNotEmpty(userLoginVo)) {
            model.addAttribute("userId", userLoginVo.getUserId());
            model.addAttribute("userNm", userLoginVo.getUserNm());
            model.addAttribute("nationCode", userLoginVo.getNationCode());
            model.addAttribute("userTyCd", userLoginVo.getUserTyCd());
        }
        else if(Validate.isNotEmpty(session)) {
            model.addAttribute("userId", session.getAttribute("userId"));
            model.addAttribute("userNm", session.getAttribute("userNm"));
            model.addAttribute("nationCode", session.getAttribute("nationCode"));
            model.addAttribute("userTyCd", session.getAttribute("userTyCd"));
        }
        else {
            return alertAndBack(model, MessageHelper.getMsg(request, "validateFail"));
        }

        
        vo.setLangCode(lagnCode(request));
        model.addAttribute("userTyCd2", request.getParameter("userTyCd2"));
        model.addAttribute("cmntyList", registerService.cmntyList(vo));

        return requestUrl(request) + "/BD_complete";
    }
        
    @RequestMapping(value = "BD_updateComplete.do", method = RequestMethod.GET)
    public void updateComplete(HttpServletRequest request, ModelMap model, RegisterVO vo) {
    }

    @RequestMapping(value = "BD_outForm.do ", method = RequestMethod.GET)
    public void outForm(HttpServletRequest request, ModelMap model, RegisterVO vo) {
    }

    /**
     * 개인 회원 등록 액션
     * insertAction 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String insertAction(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        // 비밀번호 확인 {{
        if(Validate.isEmpty(vo.getUserPassword())) {
            String message = MessageHelper.getMsg(request, "emptyPwd");
            return responseText(model, message);
        }
        if(!vo.getUserPassword().equals(vo.getUserPassword2())) {
            String message = MessageHelper.getMsg(request, "notMatchPwd");
            return responseText(model, message);
        }
        if(!(vo.getUserPassword().length() >= 10 && vo.getUserPassword().length() <= 16) || !((Validate.isSpecial(vo.getUserPassword()) || Validate.isInNumber(vo.getUserPassword())) && !Validate.isInteger(vo.getUserPassword()))) {
            String message = MessageHelper.getMsg(request, "passwordCheck2");
            return responseText(model, message);
        }
        if(!Validate.validPwd(vo.getUserPassword(), vo.getUserId(), vo.getBrthdy(), vo.getEmail(), vo.getMbtlnum())) {
            String message = MessageHelper.getMsg(request, "passwordCheck1");
            return responseText(model, message);
        }
        // 이름확인
        if(Validate.isEmpty(vo.getUserNm())) {
            String message = MessageHelper.getMsg(request, "emptyUserNm");
            return responseText(model, message);
        }
        // 이메일 확인
        if(Validate.isEmpty(vo.getEmail())) {
            String message = MessageHelper.getMsg(request, "emptyEmail");
            return responseText(model, message);
        }
        // 이메일 형식 확인
        if(!Validate.isEmail(vo.getEmail())) {
            String message = MessageHelper.getMsg(request, "validEmail");
            return responseText(model, message);
        }
        
        //공공회원이면서 수요정보 조사자 체크 시
        if(vo.getUserTyCd().toString().startsWith("30") && ("Y").equals(vo.getDmandExaminChargerAt())) {
            if(registerService.dmandExaminChagerCnt(vo) > 0) {
                return responseText(model, "수요예보조사 담당자는 기관당 1명만 선택이 가능합니다.\r\n현재 회원님의 소속기관 수요예보조사 담당자가 이미 선택되어 있어 중복체크가 불가합니다.");
            }
        }

        // 등록자를 자기 자신으로
        vo.setRegistId(vo.getUserId());
        vo.setUserKey(vo.getUserId());
        vo.setFileList(UploadHelper.upload(request, STORE_IMG_STORE, Boolean.TRUE));
        // 비밀번호 암호화
        Crypto cry = CryptoFactory.getInstance("SHA256");
        vo.setUserPassword(cry.encrypt(vo.getUserPassword()));
        vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
        int affected = registerService.insertAction(vo);
        if(affected == StringUtil.ONE) {
            HttpSession session = request.getSession();
            session.setAttribute("userNm", vo.getUserNm());
            session.setAttribute("userId", vo.getUserId());
            session.setAttribute("userTyCd", vo.getUserTyCd());
            session.setAttribute("nationCode", vo.getNationCode());

            /** 매일발송 시작 **/
            Map<String, Object> autoMap = new HashMap<String, Object>();
            boolean result = false;
            /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
            if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002) { // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_MBER_SCRB);
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소

            String title1 = "일반";
            if(vo.getUserTyCd().toString().startsWith("20")) title1 = "일반 ";
            else if(vo.getUserTyCd().toString().startsWith("30")) title1 = "기업 ";
            String title2 = String.valueOf(vo.getUserTyCd()).endsWith("01") ? "구매 " : "공급자 권한 신청자 ";

            /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            String hostNm = CmsUtil.getHostName(request.getServerName());
            if("".equals(hostNm) || "www".equals(hostNm)) {
                hostNm = "korean";
            }

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("name", vo.getUserNm());
            oneToOneInfoMap.put("id", vo.getUserId());
            oneToOneInfoMap.put("userTyNm", title1 + title2);

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
                /*System.out.println("########################################################");
                System.out.println("####가입완료 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            } else {
                /*System.out.println("########################################################");
                System.out.println("####가입완료 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
            /** 매일발송 끝 **/
            /** SMS발송시작 **/
            if(vo.getMbtlnum() != null){
                Map<String, Object> smsMap = new HashMap<String, Object>();
                /*
                smsMap.put("rcvNo", "수신번호");
                smsMap.put("msg", "발신내용");    //메시지번호별 발송메시지 SmsTransHistConstant.java참고
                smsMap.put("dutyCd", "업무코드");   //RM,CM,UM,CO...
                */
                //SMS발송 및 전송이력쌓기
                SmsTransHistConstant shc = new SmsTransHistConstant();
                //수신번호-필수
                smsMap.put("rcvNo", vo.getMbtlnum());
                //발신내용-필수
                if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002){ //한국어사이트
                    smsMap.put("msg", shc.getSmsMsg("212"));
                }else if(vo.getSbscrbSiteSeCd() == 3001 || vo.getSbscrbSiteSeCd() == 3002){   //영어사이트
                    smsMap.put("msg", shc.getSmsMsg("312"));
                }else if(vo.getSbscrbSiteSeCd() == 4001 || vo.getSbscrbSiteSeCd() == 4002){   //스페인어사이트
                    smsMap.put("msg", shc.getSmsMsg("412"));
                }
                //업무코드
                smsMap.put("dutyCd", "UM");
                boolean smsRst = smsService.smsTransHist(smsMap);
                if(smsRst){
                    /*System.out.println("########################################################");
                    System.out.println("####가입완료 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 성공#########");
                    System.out.println("########################################################");*/
                }else{
                    /*System.out.println("########################################################");
                    System.out.println("####가입완료 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 실패#########");
                    System.out.println("########################################################");*/
                }
            }
            /** SMS발송끝 **/

            return responseText(model, "true");
        } else if(affected == 888) {
            return responseText(model, MessageHelper.getMsg(request, "validUserType")); // 코드오류
        } else if(affected == 999) {
            return responseText(model, MessageHelper.getMsg(request, "dupEmail")); // 등록된 이메일이 있어요
        }
        return responseText(model, "false");
    }

    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String updateAction(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)) {
            
            // 이메일 확인
            if(Validate.isEmpty(vo.getEmail())) {
                return responseText(model, MessageHelper.getMsg(request, "emptyEmail"));
            }
            // 이메일 형식 확인
            if(!Validate.isEmail(vo.getEmail())) {
                return responseText(model, MessageHelper.getMsg(request, "validEmail"));
            }
            
            vo.setUpdtId(userLoginVo.getUserNm());
            vo.setUserId(userLoginVo.getUserId());
            vo.setUserNm(userLoginVo.getUserNm());
            
            userLoginVo.setBuseoCode(vo.getBuseoCode());
            //공공회원이면서 수요정보 조사자 체크 시
            if(vo.getUserTyCd().toString().startsWith("30") && ("Y").equals(vo.getDmandExaminChargerAt())) {
                if(registerService.dmandExaminChagerCnt(vo) > 0) {
                    return responseText(model, "수요예보조사 담당자는 기관당 1명만 선택이 가능합니다.\r\n현재 회원님의 소속기관 수요예보조사 담당자가 이미 선택되어 있어 중복체크가 불가합니다.");
                }
            }
            
            //vo.setFileList(UploadHelper.upload(request, STORE_IMG_STORE, Boolean.TRUE));

            int affected = registerService.updateAction(vo);
            if(affected >= StringUtil.ONE) {
                HttpSession session = request.getSession(true);
                if(Validate.isEmpty(vo.getDmandExaminChargerAt())){
                    vo.setDmandExaminChargerAt("N");
                }
                session.setAttribute("MEM_CHARGER_AT", vo.getDmandExaminChargerAt());
                userLoginVo.setDmandExaminChargerAt(vo.getDmandExaminChargerAt());
                if(Validate.isNotEmpty(vo.getUserTyCd2())){

                    session.setAttribute("userNm", vo.getUserNm());
                    session.setAttribute("userId", vo.getUserId());
                    session.setAttribute("nationCode", vo.getNationCode());
                    session.setAttribute("userTyCd", vo.getUserTyCd());
                    session.setAttribute("userTyCd2", vo.getUserTyCd2());
                    session.removeAttribute("MEM_TYPE");
                    session.setAttribute("MEM_TYPE", vo.getUserTyCd2());
                    userLoginVo.setUserTyCd(vo.getUserTyCd2());
                    userLoginVo.setBuseoCode(vo.getBuseoCode());
                }
                return responseText(model, "true");
            }
        }
        return responseText(model, "false");
    }
    
    /**
     * 아이디 중복체크
     * checkDupleId 설명
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "ND_checkDupleId.do")
    public String checkDupleId(RegisterUserVO vo, ModelMap model) {
        if(vo.getUserId().indexOf("system") == -1 && vo.getUserId().indexOf("admin") == -1 && vo.getUserId().indexOf("test") == -1 && Validate.isNotEmpty(vo.getUserId())){
            int cnt = registerService.checkDupleId(vo);
            if(cnt == 0) {
                return responseText(model, "true");
            }
            return responseText(model, "false");
        }
        return responseText(model, "false");
    }

    /**
     * 비밀번호 체크
     * checkPassword 설명
     *
     * @param vo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "ND_checkPassword.do")
    public String checkPassword(RegisterUserVO vo, ModelMap model, HttpServletRequest request) {
        // 접속해 있는 사용자 아이디를 얻는다.
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVo.getUserId());
        // 사용자가 입력한 비밀번호 암호화
        String userPwd = request.getParameter("userPwd");
        String referer = Validate.isEmpty(request.getHeader("referer")) ? "" : request.getHeader("referer");
        if(userLoginVo.getUserPassword().equals(userPwd)) {
            if(referer.indexOf("BD_password.do") > -1) {
                return alertAndRedirect(model, MessageHelper.getMsg(request, "moveMemModifyPage"), requestUrl(request) + "/BD_userUpdateForm.do");
            } else if(referer.indexOf("BD_secession.do") > -1) {
                String url = requestUrl(request) + "/BD_outForm.do";
                return alertAndRedirect(model, MessageHelper.getMsg(request, "moveWithdrawPage"), url);
            }
        }

        return alertAndBack(model, MessageHelper.getMsg(request, "notMatchPwd"));
    }

    /**
     * 회원탈퇴 비밀번호 입력
     * secession 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "BD_secession.do", method = RequestMethod.GET)
    public String secession(HttpServletRequest request, ModelMap model, RegisterVO vo) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(userLoginVo == null) {
            String url = "/login/user/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noSession"), url);
        } else {
            return requestUrl(request) + "/BD_password";
        }
    }

    /**
     * 회원탈퇴 액션
     * userOutConfirm 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_userOutConfirm.do", method = RequestMethod.GET)
    public String userOutConfirm(HttpServletRequest request, ModelMap model) {
        UserLoginVO vo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(vo)){

            Map<String, Integer> _result = registerService.userOutConfirm(vo);

            if(_result.get("affected") == StringUtil.ONE) {
                /** 매일발송 시작 **/
                Map<String, Object> autoMap = new HashMap<String, Object>();
                boolean result = false;
                /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
                vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
                if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002) { // 한국어사이트
                    autoMap.put("automailId", AutoMailTemplate.KOR_MBER_SCSN);
                }

                // 전송할 메일 정보 입력
                autoMap.put("receiverName", vo.getUserNm()); // 수신자명
                autoMap.put("email", vo.getEmail()); // 수신이메일주소

                /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
                HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                String hostNm = CmsUtil.getHostName(request.getServerName());
                if("".equals(hostNm) || "www".equals(hostNm)) {
                    hostNm = "korean";
                }

                // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
                oneToOneInfoMap.put("name", vo.getUserNm());
                oneToOneInfoMap.put("id", vo.getUserId());

                // 치환정보 맵 입력
                autoMap.put("oneToOneInfo", oneToOneInfoMap);

                // 선택 입력 항목
                autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

                // EMAIL 발송
                result = amservice.sendAutoMail(autoMap);
                if(result) {
                    /*System.out.println("########################################################");
                    System.out.println("####탈퇴완료 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                    System.out.println("########################################################");*/
                } else {
                    /*System.out.println("########################################################");
                    System.out.println("####탈퇴완료 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                    System.out.println("########################################################");*/
                }
                /** 매일발송 끝 **/
                /** SMS발송시작 **/
                if(vo.getMbtlnum() != null){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    /*
                    smsMap.put("rcvNo", "수신번호");
                    smsMap.put("msg", "발신내용");    //메시지번호별 발송메시지 SmsTransHistConstant.java참고
                    smsMap.put("dutyCd", "업무코드");   //RM,CM,UM,CO...
                    */
                    //SMS발송 및 전송이력쌓기
                    SmsTransHistConstant shc = new SmsTransHistConstant();
                    //수신번호-필수
                    smsMap.put("rcvNo", vo.getMbtlnum());
                    //발신내용-필수
                    if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002){ //한국어사이트
                        smsMap.put("msg", shc.getSmsMsg("215"));
                    }else if(vo.getSbscrbSiteSeCd() == 3001 || vo.getSbscrbSiteSeCd() == 3002){   //영어사이트
                        smsMap.put("msg", shc.getSmsMsg("315"));
                    }else if(vo.getSbscrbSiteSeCd() == 4001 || vo.getSbscrbSiteSeCd() == 4002){   //스페인어사이트
                        smsMap.put("msg", shc.getSmsMsg("415"));
                    }
                    //업무코드
                    smsMap.put("dutyCd", "UM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                    if(smsRst){
                        /*System.out.println("########################################################");
                        System.out.println("####탈퇴완료 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 성공#########");
                        System.out.println("########################################################");*/
                    }else{
                        /*System.out.println("########################################################");
                        System.out.println("####탈퇴완료 SMS : "+vo.getMbtlnum()+","+vo.getUserNm()+"에게 발송 실패#########");
                        System.out.println("########################################################");*/
                    }
                }
                /** SMS발송끝 **/
                return alertAndRedirect(model, MessageHelper.getMsg(request, "doneWithdraw"), serverNm(request) + "/pt/login/user/ND_logoutAction.do"); //탈퇴
            } else if(_result.get("GOODSCNT") != StringUtil.ZERO) {
                return alertAndBack(model, MessageHelper.getMsg(request, "withdrawFail1")); // 판매중인 서비스가 있으므로 탈퇴불가
            } else if(_result.get("CMMNTYCNT") != StringUtil.ZERO) {
                return alertAndBack(model, MessageHelper.getMsg(request, "withdrawFail2")); // 운영중인 커뮤니티가 있으므로 탈퇴불가
            } else if(_result.get("ORDRCNT") != StringUtil.ZERO) {
                return alertAndBack(model, MessageHelper.getMsg(request, "withdrawFail3")); // 주문진행중인 서비스가 있으므로 탈퇴불가
            }
            return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
        }
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request)+"/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_outForm.do");
    }

    /**
     * 인증이메일 발송 액션
     * emailCrtfcAction 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "ND_emailCrtfcAction.do", method = RequestMethod.POST)
    public String emailCrtfcAction(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        Map<String, Object> emailCrtft = registerService.mailCrtfcInsert(vo);
        Integer affected = (Integer)emailCrtft.get("affected");
        String cyrEnKey = Converter.URLEncode((String) emailCrtft.get("cyrEnKey"));
        Integer seq = (Integer) emailCrtft.get("mailCrtfcSeq");
        String hostNm = ""; // 현재접속 서브도메인
        String rtnurl = ""; // 가입계속 시 들어오게 될 URL
        String cnlurl = ""; // 가입취소 시 돌아올 URL

        //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
        // 추가소스
        String DomainName = GlobalConfig.DOMAIN_SUBNM;
        //}}

        if(Validate.isNotEmpty(cyrEnKey) && Validate.isNotEmpty(affected)) {
            if(affected == 999){
                // 인증 유효시간 10분이내 같은 정보로 이메일 발송시도 체크
                return responseText(model, "999");
            }
            boolean result = false;
            Map<String, Object> autoMap = new HashMap<String, Object>();
            /*
             * 필수 입력 항목
             * ---------------------------------------------------------
             * 메일템플릿 번호
             * ---------------------------------------------------------
             * //AutoMailTemplate.java참고
             * ---------------------------------------------------------
             */
            vo.setSbscrbSiteSeCd(new Integer(new CommonDutyConstant().getJoinSiteDivCd(request)));
            if(vo.getSbscrbSiteSeCd() == 2001 || vo.getSbscrbSiteSeCd() == 2002) { // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_CTFC_EMAL);
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소

            /*
             * 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            hostNm = CmsUtil.getHostName(request.getServerName());
            if("".equals(hostNm) || "www".equals(hostNm)) {
                hostNm = "korean";
            }
            /* 이전소스
            rtnurl = "http://" + hostNm + ".ceart.kr/" + hostNm + "/pt/register/ND_emailCrtfcCheck.do?key=" + cyrEnKey + "&seq=" + seq + "&nation=" + vo.getNationCode();
            cnlurl = "http://" + hostNm + ".ceart.kr/" + hostNm + "/pt/register/ND_emailCrtfcCheck.do?seq=" + seq;*/

            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
            // 변경소스 http:// -> https://
            if  ("www.ceart.kr".equals(DomainName))
            {
                rtnurl = "https://" + DomainName  + "/" + hostNm + "/pt/register/ND_emailCrtfcCheck.do?key=" + cyrEnKey + "&seq=" + seq + "&nation=" + vo.getNationCode();
                cnlurl = "https://" + DomainName  + "/" + hostNm + "/pt/register/ND_emailCrtfcCheck.do?seq=" + seq;
            }
            else
            {
                rtnurl = "http://" + DomainName  + "/" + hostNm + "/pt/register/ND_emailCrtfcCheck.do?key=" + cyrEnKey + "&seq=" + seq + "&nation=" + vo.getNationCode();
                cnlurl = "http://" + DomainName  + "/" + hostNm + "/pt/register/ND_emailCrtfcCheck.do?seq=" + seq;

            }
            //}}

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("name", vo.getUserNm());
            oneToOneInfoMap.put("rtnurl", rtnurl);
            oneToOneInfoMap.put("cnlurl", cnlurl);

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓
            // autoMap.put("senderEmail", "발신자 이메일"); // 생략시 기본 설정값 적용 :
            // webmaster@ceart.kr
            // autoMap.put("mailTitle", "메일 제목"); // 생략시 기본 설정값 적용

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
                /*System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            } else {
                /*System.out.println("########################################################");
                System.out.println("####가입인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
            return responseText(model, "true");
        }
        return responseText(model, "false");
    }

    /**
     * 인증이메일에서 회원가입을 위해 통해 리턴
     * emailCrtfcCheck 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "ND_emailCrtfcCheck.do")
    public String emailCrtfcCheck(HttpServletRequest request, ModelMap model, @RequestParam(value = "key", required = false) String cryEnKey,
        @RequestParam(value = "seq", required = false) Integer seq, @RequestParam(value = "nation", required = false) Integer nation) {
        if(Validate.isNotEmpty(cryEnKey) && Validate.isNotEmpty(seq)) {
            Map<String, Object> user = registerService.mailCrtfcCheck(cryEnKey, seq);
            if(Validate.isNotEmpty(user)) {
                HttpSession session = request.getSession();
                session.setAttribute("userNm", user.get("USER_NM"));
                session.setAttribute("email", user.get("EMAIL"));
                model.addAttribute("userTyCd", user.get("USER_TY_CD"));
                model.addAttribute("nationCode", nation);
                model.addAttribute("sbscrbTyCd", 1003);
                return "redirect:" + requestUrl(request) + "/BD_index.do";
            }
        } else if(Validate.isNotEmpty(seq)) {
            registerService.mailCrtftDelete(seq);
            String script = "";
            script += "alert(\""+MessageHelper.getMsg(request, "emailCrtcDelete")+"\");";
            script += "window.close();";
            return sendScript(model, script);
        }
        return alertAndRedirect(model, MessageHelper.getMsg(request, "emailCrtfcAgain"), requestUrl(request) + "/BD_join.do");
    }

    /**
     * 이메일 중복 확인 액션
     * emailDupleCheck 설명
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_emailDupleCheck.do", method=RequestMethod.POST)
    public String emailDupleCheck(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        ValidateResultHolder holder = ValidateUtil.validate(vo);
        if(holder.isValid()) {
            int cnt = registerService.emailDupleCheck(vo);
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
    @RequestMapping(value = "PD_passwordUpdate.do", method = RequestMethod.GET)
    public void passwordUpdate(ModelMap model, HttpServletRequest request, @ModelAttribute RegisterUserVO vo) throws Exception {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, userLoginVo);
    }

    /**
     * 사용자 비밀번호 변경 액션
     */
    @RequestMapping(value = "ND_passwordUpdateAction.do", method = RequestMethod.POST)
    public String passwordUpdateAction(ModelMap model, HttpServletRequest request, RegisterUserVO vo ) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);        
        
        if(userLoginVo == null)
            return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "noSession"));
        
        vo.setUpdtId(userLoginVo.getUserId());
        vo.setUserId(userLoginVo.getUserId());
        // 비밀번호 확인 {{
        if(Validate.isEmpty(vo.getUserPassword2())) {
            return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "emptyPwd"));
        }
        if(!(vo.getUserPassword2().length() >= 10 && vo.getUserPassword2().length() <= 16) || !((Validate.isSpecial(vo.getUserPassword2()) || Validate.isInNumber(vo.getUserPassword2())) && !Validate.isInteger(vo.getUserPassword2()))) {
            return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "passwordCheck2"));
        }
        
       if(!Validate.validPwd(vo.getUserPassword2(), userLoginVo.getUserId(), userLoginVo.getBrthdy(),userLoginVo.getEmail(), userLoginVo.getMbtlnum())) {
            return responseJson(model, Boolean.FALSE,  MessageHelper.getMsg(request, "passwordCheck1"));
        }
        //}}
        
         if(userLoginVo.getUserPassword().equals(vo.getUserPassword())) {
            if(vo.getUserPassword().equals(request.getParameter("userPassword2"))){
                return responseJson(model, Messages.FALSE, MessageHelper.getMsg(request, "passwordSame"));
            }

            String strPwd2 = vo.getUserPassword2();
            Crypto cry = CryptoFactory.getInstance("SHA256");
            vo.setUserPassword2(cry.encrypt(vo.getUserPassword2()));
            vo.setBeforePassword(cry.encrypt(vo.getUserPassword()));
            int affected = registerService.passwordUpdateAction(vo);

            if(affected == StringUtil.ONE) {
            //   로그인시 userLoginVo에 암호화 되지 않은 문자 자체가 입력되어 있으므로, 비밀 번호 변경 시 암호화 되기 이전의 문자를 해당 Vo에 저장.
                userLoginVo.setUserPassword(strPwd2);
                return responseJson(model, Boolean.TRUE);
            } else if(affected == 999) {
                return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "passwordSame"));
            }
        }
        return responseJson(model, Messages.FALSE, MessageHelper.getMsg(request, "chkEventPassword"));
    }

    /**
     * 스토어명 중복 검사
     */
    @RequestMapping(value = "ND_checkDupleStoreNm.do")
    public String checkDupleStoreNm(ModelMap model, RegisterUserVO vo) {
         int cnt = registerService.checkDupleStoreNm(vo);
        if(cnt == 0) {
            return responseText(model, "true");
        }
        return responseText(model, "false");
    }

    /**
     * 사업자번호 중복확인
     */
    @RequestMapping(value = "ND_checkDupleBizrno.do")
    public String checkDupleBizrno(HttpServletRequest request, ModelMap model, RegisterUserVO vo) throws Exception {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)){
            vo.setUserId(userLoginVo.getUserId());
        }
        String bizNo = "";
        if(Validate.isNotEmpty(request.getParameter("bizNo"))){
            bizNo = request.getParameter("bizNo").substring(0, 3) + "-" + request.getParameter("bizNo").substring(3, 5) + "-" + request.getParameter("bizNo").substring(5);
        } else if(Validate.isNotEmpty(vo.getBizrno())){
            bizNo = vo.getBizrno();
        }

        // 사업자 번호 바인딩
        vo.setBizrno(bizNo);

        int cnt =  registerService.checkDupleBizrno(vo);
        if(cnt == StringUtil.ZERO || Validate.isEmpty(bizNo)) {
            return responseText(model, Boolean.TRUE); //중복된 사업자번호가 없음
        }
        return responseText(model, Boolean.FALSE); //중복된 사업자번호가 있음
    }

    @RequestMapping(value = "ND_ctgrySelect.do")
    public String ctgrySelect(WebGoodsManageVO vo, ModelMap model) {
        List<WebGoodsManageVO> list = new ArrayList<WebGoodsManageVO>();
        for(WebGoodsManageVO category : goodsService.ctgrySelect(vo)) {
            int indexNum = category.getCtgryPath().lastIndexOf(">") + 1;
            category.setCtgryNm(category.getCtgryPath().substring(indexNum)); // 최하위의 카테고리
            category.setCtgryPath(category.getCtgryPath().substring(0, indexNum));
            list.add(category);
        }
        return responseJson(model, list);
    }

    @RequestMapping(value = "PD_categoryPop.do")
    public void categoryPop() {

    }

    @RequestMapping(value = "PD_organSearchPop.do")
    public void organSearchPop(ModelMap model, OrganPagerVo vo) {
        vo.init();
        model.addAttribute("currPage", vo.getQ_currPage());
    }
    
    @RequestMapping(value = "PD_organSearchList.do")
    public String organSearchList(HttpServletRequest request, ModelMap model, OrganPagerVo vo) {
        vo.init(); // vo init
        vo.setLangCode(Language(request)); // lang code
        OpHelper.bindSearchMap(vo, request); // param to vo
        
        List<OrganPagerVo> organList = registerService.searchOrganList(vo);
        if(organList.size() <= 0 ) vo.setTotalNum(0);
        else vo.setTotalNum(organList.get(0).getTotalNum());

        Pager<OrganPagerVo> pager = new Pager<OrganPagerVo>(organList, vo);
        
        // response
        model.addAttribute("searchKey", vo.getQ_searchKey());
        model.addAttribute("searchVal", vo.getQ_searchVal());
        model.addAttribute(GlobalConfig.KEY_PAGER, pager);
        
        return requestUrl(request) + "/PD_organSearchPop";
    }
    
    @RequestMapping(value = "INC_categoryList.do")
    public String categoryList(CategoryVO vo, ModelMap model) {
        return responseJson(model, popService.categoryList(vo));
    }

    @RequestMapping(value = "PD_searchList.do")
    public void zipcodeList() throws Exception {

    }

    @RequestMapping(value = "AjaxRequestXML.do")
    public void AjaxRequestXML() throws Exception {

    }

    @RequestMapping(value = "PD_jusoSearch.do")
    public void jusoSearch() throws Exception {

    }

    @RequestMapping(value = "ND_uploadImgChk.do", method = RequestMethod.POST)
    public String uploadIMGCheck2(HttpServletRequest request, ModelMap model){

//      String imgType = request.getParameter("imgType");

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
//               message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 message = MessageHelper.getMsg(request, "chkFileCapacity");
                 break;
            case 201:
//              message = "이미지 파일의 유형(확장자)은 jpg, png 파일만 가능합니다.";
                message = MessageHelper.getMsg(request, "chkImageExt");

                break;
            case 301:
//               message = "이미지의 가로크기가 "+ minWidthSize +" 보다 작습니다.";
                 message = MessageHelper.getMsg(request, "chkImageWidth");

                 break;
            case 302:
//               message = "이미지의 세로크기가 "+ minHeightSize +" 보다 작습니다.";
                 message = MessageHelper.getMsg(request, "chkImageHeight");
                 break;
            case 303:
                 message = MessageHelper.getMsg(request, "chkImage02");
                 break;
            case 304:
//              message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다..";
                message = MessageHelper.getMsg(request, "chkImageWidth");
                break;
            case 305:
//              message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다.";
                message = MessageHelper.getMsg(request, "chkImageHeight");
                break;
            case 400:
//               message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 message = MessageHelper.getMsg(request, "chkImageError");
                 break;
            default:
                 message = MessageHelper.getMsg(request, "chknNotImage");
//               message = "이미지가 확인되지 않았습니다.";
                 break;

        }

        return responseText(model, message);

    }

    /**
     * 스토어에서 판매중인 서비스조회
     */
    @RequestMapping(value = "ND_checkStoreSales.do")
    public String checkStoreSales(HttpServletRequest request, ModelMap model, RegisterUserVO vo) throws Exception {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)){
            vo.setUserId(userLoginVo.getUserId());
            int cnt =  registerService.checkStoreSales(vo);
                if(cnt == StringUtil.ZERO) {
                    return responseText(model, Boolean.TRUE);
                }
                return responseText(model, Boolean.FALSE);
        }
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), "");
    }

    /**
     * 휴면 페이지
     */
    @RequestMapping(value = "BD_userDrmncyForm.do")
    public String userDrmncyForm(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        String referer = Validate.isEmpty(request.getHeader("referer")) ? "" : request.getHeader("referer");
        if(referer.indexOf("ND_checkPassword.do") > -1 || referer.indexOf("BD_userUpdateForm.do") > -1 || referer.indexOf("BD_index.do") > -1 || referer.indexOf("BD_newAgree.do") > -1){
            HttpSession session = request.getSession();

            if(session.getAttribute("userDrmncyId") != null) {
                return requestUrl(request) + "/BD_userDrmncyForm";// 회원정보변경 페이지
            }
            // 로그인 없이 접급시
            return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do");
        }
        return alertAndRedirect(model, MessageHelper.getMsg(request, "illegalRequest"), serverNm(request) + "/pt/login/user/BD_index.do");
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "ND_userRecovryDrmncyAction.do")
    public String recovryDrmncy(RegisterUserVO vo, ModelMap model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        if(session.getAttribute("userDrmncyId") != null) {
            vo.setUserId(session.getAttribute("userDrmncyId").toString());

            int rstUptc =  registerService.recovryDrmncyAction(vo);

            if(rstUptc == 0){
                
                Enumeration<String> enumer = session.getAttributeNames();
                while(enumer.hasMoreElements()) {
                    String key = enumer.nextElement();
                    session.removeAttribute(key);
                }

                session.invalidate();

                return alertAndRedirect(model, MessageHelper.getMsg(request, "recovryDrmncyFail"), serverNm(request) + "/pt/index.do");
            }else{
                int rstDelc =  registerService.deleteUserDrmncy(vo);

                if(rstDelc == 0){
                    
                    Enumeration<String> enumer = session.getAttributeNames();
                    while(enumer.hasMoreElements()) {
                        String key = enumer.nextElement();
                        session.removeAttribute(key);
                    }

                    session.invalidate();

                    return alertAndRedirect(model, MessageHelper.getMsg(request, "recovryDrmncyFail"), serverNm(request) + "/pt/index.do");
                }else{
                    //로그인 처리
                    UserLoginVO loginvo = new UserLoginVO();
                    UserLogVO logVo = new UserLogVO();

                    loginvo.setUserId(session.getAttribute("userDrmncyId").toString());
                    loginvo.setUserPassword(session.getAttribute("userDrmncyPw").toString());

                    UserLoginVO dataVo = webLoginService.loginAction(loginvo);

                    session.setAttribute(GlobalConfig.USER_SESSION_KEY, dataVo);

                    // 현재 접속자 구현을 위한 바인딩 리스너
                    session.setAttribute("__musk", new LoginSessionBinding());

                    session.setAttribute("MEM_ID", dataVo.getUserId());
                    session.setAttribute("MEM_KEY", dataVo.getUserKey());
                    session.setAttribute("MEM_NAME", dataVo.getUserNm());
                    session.setAttribute("MEM_TYPE", dataVo.getUserTyCd());

                    // 접속자 아이디set
                    logVo.setUserId(dataVo.getUserId());
                    // 금일 접속 확인
                    int loginYn = webLoginService.loginYn(logVo);
                    // 접속자 아이피 set
                    String ipAddr = request.getRemoteAddr();
                    logVo.setLoginIp(ipAddr);
                    logVo.setLoginResult(1);
                    // 접속이력을 남김
                    webLoginService.logAction(logVo);
                    webLoginService.userLog(logVo);
                    if(loginYn == StringUtil.ZERO) {
                        UserLogVO logVo2 = webLoginService.userInfo(logVo);
                        if(Validate.isNotEmpty(logVo2.getAge())) {
                            logVo.setAge(logVo2.getAge());
                        }
                        if(Validate.isNotEmpty(logVo2.getSex())) {
                            logVo.setSex(logVo2.getSex());
                        }
                        if(Validate.isNotEmpty(logVo2.getSbscrbTyCd())) {
                            logVo.setSbscrbTyCd(logVo2.getSbscrbTyCd());
                        }
                        int userAllCount = webLoginService.userAllCount(logVo);
                        logVo.setEntireUserCount(userAllCount);
                    }

                    return alertAndRedirect(model, MessageHelper.getMsg(request, "recovryDrmncySuccess"), serverNm(request) + "/pt/index.do");
                }
            }
        }else{
            // 로그인 없이 접속 시도시
            return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do");
        }
    }

    private String lagnCode(HttpServletRequest request) {
//      String site = new CommonDutyConstant().getJoinSiteDivCd(request);
//      String langCode = "00";
//      if(site.equals("2001") || site.equals("2002")) { // 한국어사이트
//          langCode = "00";
//      } else if(site.equals("3001") || site.equals("3002")) { // 영어사이트
//          langCode = "01";
//      } else if(site.equals("4001") || site.equals("4002")) { // 스페인어사이트
//          langCode = "06";
//      }
        //도메인별 도메인코드를 설정
        String hostNm = "";
        String domainCd = "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        if(!"".equals(hostNm)){
            domainCd = new MainConstant().getDomainCode(hostNm);
            if(domainCd == null){
                domainCd = "2";
            }
        } else {
            domainCd = "2"; //기본 한국어로 세팅
        }
        String langCd = commonService.getLangCd(Integer.parseInt(domainCd));
        return langCd;
    }


    /**
     * 수요조사기관검색
     */
    @RequestMapping(value = "PD_dmandExaminPblinstt.do", method = RequestMethod.GET)
    public String dmandExaminPblinstt(HttpServletRequest request, ModelMap model, PblinsttVO vo) {

        model.addAttribute("pblinsttTypeList", registerService.pblinsttTypeList());  // 기관유형리스트
        model.addAttribute("upperPblinsttList", registerService.upperPblinsttList(vo));   // 상위기관리스트

        model.addAttribute("pblinsttList", registerService.pblinsttList(vo));          // 기관리스트

        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
        return requestUrl(request) + "/PD_dmandExaminPblinstt";                      // 수요조사기관검색
    }


    /**
     * 수요조사 설명회 참가신청
     * @throws ParseException
     */
    @RequestMapping(value = "BD_dcPartcptReqst.do")
    public String dcPartcptReqst(HttpServletRequest request, ModelMap model, DcPartcptReqstVO vo) throws ParseException {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
    
        if(Validate.isNotEmpty(userLoginVo)) {
            if(userLoginVo.getUserTyCd() == 3001 && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                    Date startDate;  // 시작일자
                    Date endDate1;    // 종료일자(서울)
                    Date endDate2;    // 종료일자(대구
                    Date currentDate;   // 현재날짜 Date
                    String oTime = "";  // 현재날짜
                    SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                    Date currentTime = new Date();
                    oTime = mSimpleDateFormat.format ( currentTime ); //현재시간 (String)

                    startDate = mSimpleDateFormat.parse( "2016-10-04" );//2016-10-04
                    endDate1 = mSimpleDateFormat.parse( "2016-10-09" );//2016-10-09
                    endDate2 = mSimpleDateFormat.parse( "2016-10-10" );//2016-10-10
                    currentDate =  mSimpleDateFormat.parse( oTime );

                    int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                    int compareEnd1 = currentDate.compareTo( endDate1 ); // 날짜비교
                    int compareEnd2 = currentDate.compareTo( endDate2 ); // 날짜비교

                    if(compareStart >= 0 && compareEnd2 <= 0) {
                        vo = registerService.partcptCount();
                        if(compareEnd1 > 0) {
                            vo.setPartcptAt1("N");
                        } else {
                            if(vo.getPartcptCnt1() < 250) {
                                vo.setPartcptAt1("Y");
                            } else {
                                vo.setPartcptAt1("N");
                            }
                        }
                        if(vo.getPartcptCnt2() < 300) {
                            vo.setPartcptAt2("Y");
                        } else {
                            vo.setPartcptAt2("N");
                        }
                        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);

                        return requestUrl(request) + "/BD_dcPartcptReqst";// 수요조사 설명회 참가신청 페이지
                    }
                    // 신청기간이 아닌경우
                    return alertAndRedirect(model, "신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");

            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            //return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
            return confirmAndRedirect(model, "수요예보조사 담당자만 참여가능합니다. \n수요예보조사 담당자를 지정하시겠습니까?", serverNm(request) + "/pt/register/BD_password.do" );
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dcPartcptReqst.do");
    }

    @RequestMapping(value = "ND_dcPartcptReqstAction.do", method = RequestMethod.POST)
    public String dcPartcptReqstAction(HttpServletRequest request, ModelMap model, DcPartcptReqstVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)) {
            vo.setUserId(userLoginVo.getUserId());
            vo.setUserNm(userLoginVo.getUserNm());

            if(registerService.reqstChk(vo) > 0){
                return responseJson(model, Boolean.FALSE, "이미 신청 하셨습니다.\n신청결과 페이지를 확인하세요.");
            }

            DcPartcptReqstVO cntVo = new DcPartcptReqstVO();
            cntVo = registerService.partcptCount();
            // 저장전 카운트 다시 체크
            if(vo.getPartcptSe() == 1001) {
                if(cntVo.getPartcptCnt1() >= 250){
                    return responseJson(model, Boolean.FALSE, "클라우드 도입 사전평가 설명회의 \n신청이 마감되었습니다.");
                }
            }

            if(vo.getPartcptSe() == 1002) {
                if(cntVo.getPartcptCnt2() >= 300){
                    return responseJson(model, Boolean.FALSE, "클라우드 도입 사전평가 설명회의 \n신청이 마감되었습니다.");
                }
            }

            int affected = registerService.reqstInsertAction(vo);
            if(affected >= StringUtil.ONE) {
                return responseJson(model, Boolean.TRUE);
            } else {
                return responseJson(model, Boolean.FALSE, "신청에 실패했습니다.\n관리자에게 문의하세요.");
            }
        }
        return responseJson(model, Boolean.FALSE, "로그인정보가 없습니다. \n로그인 후 다시 시도하시기 바랍니다.");
    }

    /**
     * 수요조사 설명회 참가신청 결과
     * @throws ParseException
     */
    @RequestMapping(value = "BD_dcPartcptAprslt.do")
    public String dcPartcptAprslt(HttpServletRequest request, ModelMap model, DcPartcptReqstVO vo) throws ParseException {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)) {
            Date startDate;  // 시작일자
            Date currentDate;   // 현재날짜 Date
            String oTime = "";  // 현재날짜
            SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
            Date currentTime = new Date();
            oTime = mSimpleDateFormat.format ( currentTime ); //현재시간 (String)

            startDate = mSimpleDateFormat.parse( "2016-10-04" );//2016-10-04
            currentDate =  mSimpleDateFormat.parse( oTime );

            int compareStart = currentDate.compareTo( startDate ); // 날짜비교

            if(compareStart >= 0) {

                if(userLoginVo.getUserTyCd() == 3001 && userLoginVo.getDmandExaminChargerAt().equals("Y")) {
                    vo.setUserId(userLoginVo.getUserId());
                    vo.setUserNm(userLoginVo.getUserNm());

                    if(registerService.reqstChk(vo) > 0){

                        model.addAttribute(GlobalConfig.KEY_BASE_VO, registerService.dcPartcptAprslt(vo));

                        return requestUrl(request) + "/BD_dcPartcptAprslt";// 수요조사 설명회 참가신청 결과 페이지
                    }
                    return alertAndRedirect(model, "신청내역이 없습니다.", serverNm(request) + "/pt/index.do");
                }
                // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
                return alertAndRedirect(model, "수요예보조사 담당자만 볼 수 있습니다.", serverNm(request) + "/pt/index.do");
            }
            // 신청기간이 아닌경우
            return alertAndRedirect(model, "신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dcPartcptAprslt.do");
    }

    @RequestMapping(value = "ND_aprsltCanclAction.do", method = RequestMethod.POST)
    public String aprsltCanclAction(HttpServletRequest request, ModelMap model, DcPartcptReqstVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isNotEmpty(userLoginVo)) {
            vo.setUserId(userLoginVo.getUserId());
            vo.setUserNm(userLoginVo.getUserNm());

            if(registerService.reqstChk(vo) == 0){
                return responseJson(model, Boolean.FALSE, "신청 내역이 없습니다.");
            }

            int affected = registerService.aprsltCanclAction(vo);
            if(affected >= StringUtil.ONE) {
                return responseJson(model, Boolean.TRUE);
            } else {
                return responseJson(model, Boolean.FALSE, "신청취소에 실패했습니다.\n관리자에게 문의하세요.");
            }
        }
        return responseJson(model, Boolean.FALSE, "로그인정보가 없습니다. \n로그인 후 다시 시도하시기 바랍니다.");
    }

    /**
     * 수요예보조사 진입
     * @throws ParseException
     */
    @RequestMapping(value = "BD_dmandExamin.do")
    public String dmandExamin(HttpServletRequest request, ModelMap model, DmandExaminVO vo) throws ParseException {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        if(Validate.isNotEmpty(userLoginVo)) {

            vo.setUserId(userLoginVo.getUserId());
            vo.setBuseoCode(userLoginVo.getBuseoCode());
            
            if(!userLoginVo.getUserTyCd().toString().startsWith("30") ) {
                return alertAndRedirect(model, "\\r수요예보조사 대상기관이 아닙니다. \\n수요예보조사 대상 기관만 참여하실 수 있습니다.", serverNm(request) + "/pt/index.do");

            }else if(userLoginVo.getUserTyCd().toString().startsWith("30") && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                Date startDate;     // 시작일자
                Date endDate;       // 종료일자(서울)
                Date currentDate;   // 현재날짜 Date
                String oTime = "";  // 현재날짜
                SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                Date currentTime = new Date();
                oTime = mSimpleDateFormat.format ( currentTime );   //현재시간 (String)
                currentDate =  mSimpleDateFormat.parse( oTime );    //현재일자
                DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
                
                startDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistBeginDate());  //시작일자
                endDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistEndDate());      //종료일자
                
                int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                int compareEnd = currentDate.compareTo( endDate ); // 날짜비교

                if(compareStart >= 0 && compareEnd <= 0) {  //수요조사 날짜에 해당 할 경우
                    vo.setDmandExaminOprtnYear(dmandExaminRegistMngrVO.getDmandExaminOprtnYear());
                    int targetInstChkCnt = dmandExaminService.selectTargetInstChkCnt(vo);

                    int targetSubmitChkCnt = dmandExaminService.selectTargetSubmitChkCnt(vo);
                    
                    model.addAttribute("targetSubmitChkCnt", targetSubmitChkCnt);

                    //BD_dmandExamin.do
                    if(targetInstChkCnt > 0) {
                        /*1기관 1담당자 체크 카운트*/
                        int userTargetCnt = dmandExaminService.selectUserTargetCnt(vo);
                        if(userTargetCnt > 0){
                            return alertAndRedirect(model, "\\r이미 다른 담당자가 등록중이거나 제출한 기관입니다.\\r\\n해당 담당자만 열람 또는 제출할 수 있습니다.", serverNm(request) + "/pt/index.do");
                        }
                        return requestUrl(request) + "/BD_dmandExamin";// 수요예보조사
                    }
                    // 조사 대상 기관이 아닌경우
                    String message = "\\r기관정보가 정확하지 않습니다.\\r\\n회원정보에서 정확한 기관코드를 저장하여 주십시오.\\n(예: '한국정보화진흥원 재무팀' 은 '한국정보화진흥원' 으로 저장)\\r\\n기관코드를 변경하여도 이 안내창이 나오면 1522-0089로 문의하여 주시기 바랍니다. \\r\\n기관 코드를 변경하시 겠습니까?";
                    return confirmAndRedirect(model, message, serverNm(request) + "/pt/register/BD_password.do");
//                    return alertAndRedirect(model, "기관정보가 정확하지 않습니다.\\r\\n회원정보에서 정확한 기관코드를 저장하여 주십시오.\\n(예: '한국정보화진흥원 재무팀' 은 '한국정보화진흥원' 으로 저장)\\r\\n기관코드를 변경하여도 이 안내창이 나오면 1522-0089로 문의하여 주시기 바랍니다.", serverNm(request) + "/pt/index.do");
                }
                // 조사기간이 아닌경우
                return alertAndRedirect(model, "\\r수요예보조사 기간이 아닙니다.", serverNm(request) + "/pt/index.do");
            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            //return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
                        
//            return confirmAndRedirect(model, "\\r수요예보조사 담당자만 참여가능합니다. \\n수요예보조사 담당자를 지정하시겠습니까?", serverNm(request) + "/pt/register/BD_password.do");
            return confirmAndRedirect(model, "\\r클라우드컴퓨팅 수요예보조사 기간입니다. \\n수요예보조사 시 기관정보 업데이트를위해 회원정보수정이 필요합니다.\\n회원정보로 이동하시겠습니까?", serverNm(request) + "/pt/register/BD_password.do");            
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do");
    }
    
    
    /**
     * 수요조사 참여 클릭 시 체크(기관정보)
     */
    @RequestMapping(value = "ND_dmandExaminChkAction.do")
    public String dmandExaminChkAction(ModelMap model, HttpServletRequest request) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isNotEmpty(userLoginVO)) {
                    
            RegisterUserVO registerUserVO = registerService.pblinsttNmChkAction(userLoginVO.getUserId());
    
            /*if(기관명부정확여부 != 'Y')*/
            if(registerUserVO.getPblinsttUpdtAt().equals("Y")) {
                return responseText(model, "1002"); //회원정보수정요청팝업(jsonCode:1002)
            } 
            
            /*if (기관명확인여부 == 'N'){*/
            if(registerUserVO.getPblinsttNmCnfirmAt().equals("N")) {
                return responseText(model, "1003"); //회원정보수정요청팝업(jsonCode:1002)
            }
            
            return responseText(model, "1001");     //수요예보조사팝업(jsonCode:1001)
        }
        return responseText(model, "9999");
    }
    
    /**
     * 수요예보조사회원 소속기관 정보 확인
     * @throws ParseException
     */
    @RequestMapping(value = "PD_pstinstInfoCnfirm.do")
    public String pstinstInfoCnfirm(HttpServletRequest request, ModelMap model, RegisterUserVO vo) throws ParseException {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isNotEmpty(userLoginVO)) {
            vo.setUserTyCd(userLoginVO.getUserTyCd());
            vo.setUserId(userLoginVO.getUserId());
            vo.setLangCode(lagnCode(request));
            RegisterVO register = new RegisterVO();
            register.setLangCode(vo.getLangCode());
            model.addAttribute("loginData", registerService.updateForm(vo));
            
            return requestUrl(request) + "/PD_pstinstInfoCnfirm";// 수요예보조사 팝업
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do","top");
    }
    
    /**
     * 수요조사 참여 클릭 시 체크(기관정보)
     */
    @RequestMapping(value = "ND_pblinsttNmCnfirmAction.do")
    public String pblinsttNmCnfirmAction(ModelMap model, HttpServletRequest request) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if (Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=/korean/pt/register/BD_dmandExamin.do";
            return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"),"/korean/pt/login/user/BD_index.do" + returnUrl, "top");

        }
        
        int result = registerService.pblinsttNmCnfirmAction(userLoginVO.getUserId());
        
        return responseText(model, result);
    }
    
    /**
     * 수요예보조사회원 정보수정요청
     * @throws ParseException
     */
    @RequestMapping(value = "PD_infoUpdtRequst.do")
    public String infoUpdtRequst(HttpServletRequest request, ModelMap model, DmandExaminVO vo) throws ParseException {
        
        return requestUrl(request) + "/PD_infoUpdtRequst";// 수요예보조사 팝업
    }

    /**
     * 수요예보조사 상세목록
     * @throws ParseException
     */
    @RequestMapping(value = "BD_searchDmandExaminDetailList.do")
    public String searchDmandExaminDetailList(HttpServletRequest request, ModelMap model, DmandExaminVO vo) throws ParseException {

        List<DmandExaminVO> selectList = dmandExaminService.dmandExaminDetailList(vo.getUserId());

        model.addAttribute("selectList", selectList);

        return requestUrl(request) + "/BD_dmandExaminDetailList";// 수요예보조사

    }

    /**
     * 수요예보조사 참여 팝업
     * @throws ParseException
     */
    @RequestMapping(value = "PD_searchDmandExaminGridPop.do")
    public String PD_searchDmandExaminGridPop(HttpServletRequest request, ModelMap model, @ModelAttribute("vo")  DmandExaminVO  vo) throws ParseException {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        //로그인 체크
        if (Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/register/BD_dmandExamin.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
			vo.setBuseoCode(userLoginVO.getBuseoCode());
        }
       
        DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
        vo.setDmandExaminOprtnYear(dmandExaminRegistMngrVO.getDmandExaminOprtnYear());
        
        /*13번 항목을 보여줄지 말지 여부*/
        String dmandSurveyVldtySecretAtGubun = dmandExaminService.selectDmandSurveyVldtySecretAtGubun(vo);
        model.addAttribute("statsTyCode", dmandSurveyVldtySecretAtGubun);
        
        
        /*1기관 1담당자 체크 카운트*/
        int userTargetCnt = dmandExaminService.selectUserTargetCnt(vo);
        if(userTargetCnt > 0){
            return alertAndRedirectTarget(model, "\n해당 기관은 이미 등록되었습니다.", serverNm(request) + "/pt/register/BD_dmandExamin.do", "top");
        }
        /*수요조사 대상 기관여부 카운트*/
        int targetInstChkCnt = dmandExaminService.selectTargetInstChkCnt(vo);
       
        //기관코드 체크
        if(targetInstChkCnt > 0) {
        
            //info 조회
            int cnt = dmandExaminService.selectDmandExaminInfoCnt(vo);
            if(cnt < 1){    // 수요조사실시 이력이 없는 경우
                
                /*수요조사실시 정보 없을 경우 Info 테이블에 저장*/
                dmandExaminService.insertDmandExaminInfo(vo);
                
                // EA 데이터 조회
                List<DmandExaminVO> eaList = dmandExaminService.selectDmandExaminEAList(vo.getUserId()); 
                
                // 조회된 EA리스트를 op_dmand_examin_detail_2018로 INSERT
                if(eaList.size()>0){
                    for(int i = 0 ; i < eaList.size() ; i++) {
                        vo.setDmandSurveyNo(i+1);
                        vo.setDmandSurveyHighorgname(eaList.get(i).getDmandSurveyHighorgname());    //상위기관명
                        vo.setDmandSurveyOrgname(eaList.get(i).getDmandSurveyOrgname());            //기관명
                        vo.setDmandSurveySysname(eaList.get(i).getDmandSurveySysname());            //시스템명         
                        vo.setDmandSurveySysobj(eaList.get(i).getDmandSurveySysobj());              //시스템목적 
                        vo.setDmandSurveyManager(eaList.get(i).getDmandSurveyManager());            //담당자  
                        vo.setDmandSurveyBuildy(eaList.get(i).getDmandSurveyBuildy());              //구축년도
                        vo.setDmandSurveyUpy(eaList.get(i).getDmandSurveyUpy());                    //최근업그레이드년도
                        vo.setDmandSurveyBuildcost(eaList.get(i).getDmandSurveyBuildcost());        //구축비
                        vo.setDmandSurveyMaint(eaList.get(i).getDmandSurveyMaint());                //당해년도 유지보수비
                        vo.setDmandSurveyExpenses(eaList.get(i).getDmandSurveyExpenses());          //당해년도 운영비
                        //vo.setDmandSurveyDivision("기존");                                           //시스템구분
                        vo.setDmandSurveyDivision(eaList.get(i).getDmandSurveyDivision());          //시스템구분
                        vo.setDmandSurveyMail(eaList.get(i).getDmandSurveyMail());                  //EA 담당자 메일
                        vo.setDmandSurveyPhone(eaList.get(i).getDmandSurveyPhone());                  //EA 담당자 연락처

                        dmandExaminService.insertIntoDmandExaminDetail(vo);
                    }
                }
            } else if(cnt >= 1){ //수요조사실시 이력이 있는 경우                                                                           
                /*****************************          I N F O         *************************************
                 **  임시저장한 이력이 없을때는 기관변경이 가능하고                         **
                 **  변경된 기관의 EA데이터를 재조회하여 Detail테이블에 넣기 위한 루트  **
                 *****************************************************************************************/
                int tmprCnt = dmandExaminService.selectTmprChk(vo);                                         // 1. 수요조사표를 저장한 이력이 있는 지 체크
                if(tmprCnt < 1){                                                                                                  // 2. 저장한 이력이 없으면  
                    dmandExaminService.deleteDmandExaminDetail(vo.getUserId());                        // 3. 기존에 디테일 테이블에 있는 데이터 삭제 후 EA데이터 재조회후 insert
                   
                    // EA 데이터 조회
                    List<DmandExaminVO> eaList = dmandExaminService.selectDmandExaminEAList(vo.getUserId()); 
                    
                    // 조회된 EA리스트를 op_dmand_examin_detail_2018로 INSERT
                    if(eaList.size()>0){
                        for(int i = 0 ; i < eaList.size() ; i++) {
                            vo.setDmandSurveyNo(i+1);
                            vo.setDmandSurveyHighorgname(eaList.get(i).getDmandSurveyHighorgname());    //상위기관명
                            vo.setDmandSurveyOrgname(eaList.get(i).getDmandSurveyOrgname());            //기관명
                            vo.setDmandSurveySysname(eaList.get(i).getDmandSurveySysname());            //시스템명         
                            vo.setDmandSurveySysobj(eaList.get(i).getDmandSurveySysobj());              //시스템목적 
                            vo.setDmandSurveyManager(eaList.get(i).getDmandSurveyManager());            //담당자  
                            vo.setDmandSurveyBuildy(eaList.get(i).getDmandSurveyBuildy());              //구축년도
                            vo.setDmandSurveyUpy(eaList.get(i).getDmandSurveyUpy());                    //최근업그레이드년도
                            vo.setDmandSurveyBuildcost(eaList.get(i).getDmandSurveyBuildcost());        //구축비
                            vo.setDmandSurveyMaint(eaList.get(i).getDmandSurveyMaint());                //당해년도 유지보수비
                            vo.setDmandSurveyExpenses(eaList.get(i).getDmandSurveyExpenses());          //당해년도 운영비
                            //vo.setDmandSurveyDivision("기존");                                         //시스템구분
                            vo.setDmandSurveyDivision(eaList.get(i).getDmandSurveyDivision());          //시스템구분
                            vo.setDmandSurveyMail(eaList.get(i).getDmandSurveyMail());                  //EA 담당자 메일
                            vo.setDmandSurveyPhone(eaList.get(i).getDmandSurveyPhone());                //EA 담당자 연락처
                            dmandExaminService.insertIntoDmandExaminDetail(vo);
                        }
                    }
                }
            }
            
            DmandExaminVO user = dmandExaminService.selectDmandExaminUserInfo(vo.getUserId());
            model.addAttribute("userInfo", user);
            
            return requestUrl(request) + "/PD_searchDmandExaminGridPop";// 수요예보조사 팝업(aui팝업 - imsi)
        
        } else {
            return alertAndRedirectTarget(model, "\\n기관정보가 정확하지 않습니다.\\n회원정보에서 정확한 기관코드를 저장하여 주십시오.\\n(예: '한국정보화진흥원 재무팀' 은 '한국정보화진흥원' 으로 저장)\\n기관코드를 변경하여도 이 안내창이 나오면 1522-0089로 문의하여 주시기 바랍니다.", serverNm(request) + "/pt/index.do", "top");
        }
    }
    
    /**
     * 그리드 값 가져오기 (\n치환 등...)
     * @throws ParseException
     */
    @RequestMapping(value = "getDmandExaminGridData.do")
    public String getDmandExaminGridData(HttpServletRequest request, ModelMap model, DmandExaminVO vo) throws ParseException {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        //로그인 체크
        if (Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/register/BD_dmandExamin.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
			vo.setBuseoCode(userLoginVO.getBuseoCode());
        }
        
        // 디테일 정보를 조회해서 그리드 리스트로 가져오기
        List<DmandExaminVO> detailList = dmandExaminService.selectDmandExaminDetail(vo.getUserId());
        
        Gson gson = new Gson();
        String jsonData = gson.toJson(detailList);
        
        return responseJson(model, jsonData); // json 특수문자 처리를 위한 responseJosn 처리
    }
    
    /**
     * 수요예보조사 조사표 다운로드 팝업 - 공공기관일경우
     * @throws ParseException
     */
    @RequestMapping(value = "PD_searchDmandExaminSurveyPop.do")
    public String searchDmandExaminSurveyPop(HttpServletRequest request, ModelMap model, DmandExaminVO  vo) throws ParseException {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isNotEmpty(userLoginVO)) {
            
            vo.setUserId(userLoginVO.getUserId());
            vo.setDmandExaminOprtnYear("2017");
            vo.setStatsTyCode("1001");
            
            model.addAttribute(GlobalConfig.KEY_DATA_VO, dmandExaminService.dmandExaminView(vo));

            int hiddenYnCnt = dmandExaminService.selectHiddenStateNm(vo);            
            String hiddenYn = "";
            if(hiddenYnCnt > 0) {
                hiddenYn = "Y";
            } else {
                hiddenYn = "N";
            }
            
            model.addAttribute("hiddenYn", hiddenYn);
            
            return requestUrl(request) + "/PD_searchDmandExaminSurveyPop";// 수요예보조사 팝업
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do", "top");
        
    }
    /**
     * 수요예보조사 조사표 다운로드 팝업 - 공공기관이 아닌 경우
     * @throws ParseException
     */
    @RequestMapping(value = "PD_searchDmandExaminSurveyPop2.do")
    public String searchDmandExaminSurveyPop2(HttpServletRequest request, ModelMap model, DmandExaminVO  vo) throws ParseException {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isNotEmpty(userLoginVO)) {
            
            vo.setUserId(userLoginVO.getUserId());
            vo.setDmandExaminOprtnYear("2017");
            vo.setStatsTyCode("1002");
            
            model.addAttribute(GlobalConfig.KEY_DATA_VO, dmandExaminService.dmandExaminView(vo));

            int hiddenYnCnt = dmandExaminService.selectHiddenStateNm(vo);            
            String hiddenYn = "";
            if(hiddenYnCnt > 0) {
                hiddenYn = "Y";
            } else {
                hiddenYn = "N";
            }
            
            model.addAttribute("hiddenYn", hiddenYn);
            
            return requestUrl(request) + "/PD_searchDmandExaminSurveyPop2";// 수요예보조사 팝업
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do", "top");
        
    }
    
    
    /**
     * 그리드 값 임시저장하기(수정중)
     * @throws ParseException
     */
    @RequestMapping(value = "setDmandExaminGridData.do")
    @ResponseBody
    public String setDmandExaminGridData(HttpServletRequest request, ModelMap model, DmandExaminVO vo, @RequestBody List<Map<String, Object>> dataList) throws ParseException {
      
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
      //로그인 회원 체크
        if(Validate.isNotEmpty(userLoginVo)) {

            vo.setUserId(userLoginVo.getUserId());

            if(userLoginVo.getUserTyCd().toString().startsWith("30") && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                Date startDate;     // 시작일자
                Date endDate;       // 종료일자(서울)
                Date currentDate;   // 현재날짜 Date
                String oTime = "";  // 현재날짜
                String lDapCodeNm = "";  //유저ID에 따른 기관명 select
                SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                Date currentTime = new Date();
                oTime = mSimpleDateFormat.format ( currentTime );   //현재시간 (String)
                currentDate =  mSimpleDateFormat.parse( oTime );    //현재일자
                DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
                
                startDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistBeginDate());  //시작일자
                endDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistEndDate());      //종료일자
                
                int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                int compareEnd = currentDate.compareTo( endDate ); // 날짜비교

                if(compareStart >= 0 && compareEnd <= 0) {
                    
                    int cnt = 0;
                    
                    /*그리드에서 가져온 리스트 사이즈가 존재하면*/
                    if(dataList.size() > 0){
                        /*기존 데이터 삭제*/
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        
                        DmandExaminVO dataVO = new DmandExaminVO();
                        dataVO.setUserId(vo.getUserId());
                        for(Map<String, Object> map : dataList) {
//                         // table의 not null 체크
//                            if(exceptionNullValue(map, "dmandSurveySysname") == null 
//                                || exceptionNullValue(map, "dmandSurveySysname") == "") {
//                                continue;
//                            }

                            /*DmandExaminVO dataVO = new DmandExaminVO();*/
                            dataVO.setDmandSurveyNo(++cnt);                                                                         //①순번
                            dataVO.setDmandSurveyOrgname(exceptionNullValue(map, "dmandSurveyOrgname"));                            //②기관명                       
                            dataVO.setDmandSurveySysname(exceptionNullValue(map, "dmandSurveySysname"));                            //③시스템명                     
                            dataVO.setDmandSurveySysobj(exceptionNullValue(map, "dmandSurveySysobj"));                              //④시스템목적                   
                            dataVO.setDmandSurveyDivision(exceptionNullValue(map, "dmandSurveyDivision"));                          //⑤시스템구분                       
                            dataVO.setDmandSurveyManager(exceptionNullValue(map, "dmandSurveyManager"));                            //⑥담당자                       
                            dataVO.setDmandSurveyMail(exceptionNullValue(map, "dmandSurveyMail"));                                  //⑦이메일                       
                            dataVO.setDmandSurveyPhone(exceptionNullValue(map, "dmandSurveyPhone"));                                //⑧유선번호                     
                            dataVO.setDmandSurveyBuildy(exceptionNullValue(map, "dmandSurveyBuildy"));                              //⑨구축년도                     
                            dataVO.setDmandSurveyUpy(exceptionNullValue(map, "dmandSurveyUpy"));                                    //⑩최근 업그레이드년도          
                            dataVO.setDmandSurveyClouduse(exceptionNullValue(map, "dmandSurveyClouduse"));                          //⑪현 클라우드 이용여부         
                            dataVO.setDmandSurveySeparation(exceptionNullValue(map, "dmandSurveySeparation"));                      //⑪-1)클라우드구분              
                            dataVO.setDmandSurveyCnvrsPlan(exceptionNullValue(map, "dmandSurveyCnvrsPlan"));                        //⑫클라우드전환또는 도입예정    
                            dataVO.setDmandSurveyPlanCloudSeparation(exceptionNullValue(map, "dmandSurveyPlanCloudSeparation"));    //⑫-1) 클라우드 도입 예정시 클라
                            dataVO.setDmandSurveyPlanServSeparation(exceptionNullValue(map, "dmandSurveyPlanServSeparation"));      //⑫-1) 클라우드 도입 예정시 서비
                            dataVO.setDmandSurveyBudget(exceptionNullValue(map, "dmandSurveyBudget"));                              //⑫-2)클라우드 예산             
                            dataVO.setDmandSurveyVldtySecretAt(exceptionNullValue(map, "dmandSurveyVldtySecretAt"));                //⑬2020년이후 국가정보자원관리원                            
                            
//                            dataVO.setDmandSurveyHighorgname(exceptionNullValue(map, "dmandSurveyHighorgname"));/*상위기관명*/
//                            dataVO.setDmandSurveyOrgname(exceptionNullValue(map, "dmandSurveyOrgname"));/*기관명*/
//                            dataVO.setDmandSurveySysname(exceptionNullValue(map, "dmandSurveySysname"));/*시스템명*/
//                            dataVO.setDmandSurveySysobj(exceptionNullValue(map, "dmandSurveySysobj"));/*시스템목적*/
//                            dataVO.setDmandSurveyDivision(exceptionNullValue(map, "dmandSurveyDivision"));/*시스템구분*/
//                            dataVO.setDmandSurveyManager(exceptionNullValue(map, "dmandSurveyManager"));/*담당자*/
//                            dataVO.setDmandSurveyMail(exceptionNullValue(map, "dmandSurveyMail"));/*이메일*/
//                            dataVO.setDmandSurveyPhone(exceptionNullValue(map, "dmandSurveyPhone"));/*연락처*/
//                            dataVO.setDmandSurveyBuildy(exceptionNullValue(map, "dmandSurveyBuildy"));/*구축년도*/
//                            dataVO.setDmandSurveyUpy(exceptionNullValue(map, "dmandSurveyUpy"));/*최근업그레이드년도*/
//                            dataVO.setDmandSurveyBuildcost(exceptionNullValue(map, "dmandSurveyBuildcost"));/*구축비*/
//                            dataVO.setDmandSurveyMaint(exceptionNullValue(map, "dmandSurveyMaint"));/*당해년도유지보수비*/
//                            dataVO.setDmandSurveyExpenses(exceptionNullValue(map, "dmandSurveyExpenses"));/*당해년도운영비*/
//                            dataVO.setDmandSurveyClouduse(exceptionNullValue(map, "dmandSurveyClouduse"));/*클라우드 기이용여부*/
//                            dataVO.setDmandSurveySeparation(exceptionNullValue(map, "dmandSurveySeparation"));/*클라우드구분*/
//                            dataVO.setDmandSurveyIntroy(exceptionNullValue(map, "dmandSurveyIntroy"));/*클라우드 도입년도*/
//                            dataVO.setDmandSurveyCnvrsPlan(exceptionNullValue(map, "dmandSurveyCnvrsPlan"));/*클라우드 전환 또는 도입예정*/
//                            dataVO.setDmandSurveyPlanCloudSeparation(exceptionNullValue(map, "dmandSurveyPlanCloudSeparation"));/*(도입예정시) 클라우드 구분*/
//                            dataVO.setDmandSurveyPlanServSeparation(exceptionNullValue(map, "dmandSurveyPlanServSeparation"));/*(도입예정시) 서비스 구분*/
//                            dataVO.setDmandSurveyBudget(exceptionNullValue(map, "dmandSurveyBudget"));/*클라우드 예산*/
//                            dataVO.setDmandSurveyVldtySecretAt(exceptionNullValue(map, "dmandSurveyVldtySecretAt"));/*(도입타당성) 비밀여부*/
//                            dataVO.setDmandSurveyVldtyFirstecon(exceptionNullValue(map, "dmandSurveyVldtyFirstecon"));/*(도입타당성) 경제성*/
//                            dataVO.setDmandSurveyOpinion(exceptionNullValue(map, "dmandSurveyOpinion"));/*클라우드 도입 만족도*/
                           
                            lDapCodeNm = dmandExaminService.selectLDapCodeNm(vo);
                            
                            dataVO.setDmandSurveyOrgname(lDapCodeNm);
                            
                            /*그리드 데이터 저장*/
                            dmandExaminService.insertGridDmandExaminDetail(dataVO);
                        }
                        /*유저 인포 업데이트 임시저장 시간*/
                        dmandExaminService.updateDmandExaminUserInfo(dataVO.getUserId());
                    } else {
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        dmandExaminService.updateDmandExaminUserInfo(vo.getUserId());
                    }
                    
                    return "true";
                }
                // 신청기간이 아닌경우
                return alertAndRedirect(model, "신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");
            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            return confirmAndRedirect(model, "\n수요예보조사 담당자만 참여가능합니다. \n수요예보조사 담당자를 지정하시겠습니까?", serverNm(request) + "/pt/register/BD_password.do" );
			//return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do");
    }
    
    
    @RequestMapping(value = "setDmandExaminGridData1.do")
    @ResponseBody
    public String setDmandExaminGridData1(HttpServletRequest request, ModelMap model, DmandExaminVO vo, @RequestBody List<Map<String, Object>> dataList) throws ParseException {
      
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
      //로그인 회원 체크
        if(Validate.isNotEmpty(userLoginVo)) {

            vo.setUserId(userLoginVo.getUserId());

            if(userLoginVo.getUserTyCd().toString().startsWith("30") && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                Date startDate;     // 시작일자
                Date endDate;       // 종료일자(서울)
                Date currentDate;   // 현재날짜 Date
                String oTime = "";  // 현재날짜
                String lDapCodeNm = "";  //유저ID에 따른 기관명 select
                SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                Date currentTime = new Date();
                oTime = mSimpleDateFormat.format ( currentTime );   //현재시간 (String)
                currentDate =  mSimpleDateFormat.parse( oTime );    //현재일자
                DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
                
                startDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistBeginDate());  //시작일자
                endDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistEndDate());      //종료일자
                
                int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                int compareEnd = currentDate.compareTo( endDate ); // 날짜비교

                if(compareStart >= 0 && compareEnd <= 0) {
                    
                    int cnt = 0;
                    
                    /*그리드에서 가져온 리스트 사이즈가 존재하면*/
                    if(dataList.size() > 0){
                        /*기존 데이터 삭제*/
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        
                        DmandExaminVO dataVO = new DmandExaminVO();
                        dataVO.setUserId(vo.getUserId());
                        for(Map<String, Object> map : dataList) {
//                         // table의 not null 체크
//                            if(exceptionNullValue(map, "dmandSurveySysname") == null 
//                                || exceptionNullValue(map, "dmandSurveySysname") == "") {
//                                continue;
//                            }

                            /*DmandExaminVO dataVO = new DmandExaminVO();*/
                            dataVO.setDmandSurveyNo(++cnt);                                                                         //①순번
                            dataVO.setDmandSurveyOrgname(exceptionNullValue(map, "dmandSurveyOrgname"));                            //②기관명                       
                            dataVO.setDmandSurveySysname(exceptionNullValue(map, "dmandSurveySysname"));                            //③시스템명                     
                            dataVO.setDmandSurveySysobj(exceptionNullValue(map, "dmandSurveySysobj"));                              //④시스템목적                   
                            dataVO.setDmandSurveyDivision(exceptionNullValue(map, "dmandSurveyDivision"));                          //⑤시스템구분                       
                            dataVO.setDmandSurveyManager(exceptionNullValue(map, "dmandSurveyManager"));                            //⑥담당자                       
                            dataVO.setDmandSurveyMail(exceptionNullValue(map, "dmandSurveyMail"));                                  //⑦이메일                       
                            dataVO.setDmandSurveyPhone(exceptionNullValue(map, "dmandSurveyPhone"));                                //⑧유선번호                     
                            dataVO.setDmandSurveyBuildy(exceptionNullValue(map, "dmandSurveyBuildy"));                              //⑨구축년도                     
                            dataVO.setDmandSurveyUpy(exceptionNullValue(map, "dmandSurveyUpy"));                                    //⑩최근 업그레이드년도          
                            dataVO.setDmandSurveyClouduse(exceptionNullValue(map, "dmandSurveyClouduse"));                          //⑪현 클라우드 이용여부         
                            dataVO.setDmandSurveySeparation(exceptionNullValue(map, "dmandSurveySeparation"));                      //⑪-1)클라우드구분              
                            dataVO.setDmandSurveyCnvrsPlan(exceptionNullValue(map, "dmandSurveyCnvrsPlan"));                        //⑫클라우드전환또는 도입예정    
                            dataVO.setDmandSurveyPlanCloudSeparation(exceptionNullValue(map, "dmandSurveyPlanCloudSeparation"));    //⑫-1) 클라우드 도입 예정시 클라
                            dataVO.setDmandSurveyPlanServSeparation(exceptionNullValue(map, "dmandSurveyPlanServSeparation"));      //⑫-1) 클라우드 도입 예정시 서비
                            dataVO.setDmandSurveyBudget(exceptionNullValue(map, "dmandSurveyBudget"));                              //⑫-2)클라우드 예산             
                           
                            
//                            dataVO.setDmandSurveyHighorgname(exceptionNullValue(map, "dmandSurveyHighorgname"));/*상위기관명*/
//                            dataVO.setDmandSurveyOrgname(exceptionNullValue(map, "dmandSurveyOrgname"));/*기관명*/
//                            dataVO.setDmandSurveySysname(exceptionNullValue(map, "dmandSurveySysname"));/*시스템명*/
//                            dataVO.setDmandSurveySysobj(exceptionNullValue(map, "dmandSurveySysobj"));/*시스템목적*/
//                            dataVO.setDmandSurveyDivision(exceptionNullValue(map, "dmandSurveyDivision"));/*시스템구분*/
//                            dataVO.setDmandSurveyManager(exceptionNullValue(map, "dmandSurveyManager"));/*담당자*/
//                            dataVO.setDmandSurveyMail(exceptionNullValue(map, "dmandSurveyMail"));/*이메일*/
//                            dataVO.setDmandSurveyPhone(exceptionNullValue(map, "dmandSurveyPhone"));/*연락처*/
//                            dataVO.setDmandSurveyBuildy(exceptionNullValue(map, "dmandSurveyBuildy"));/*구축년도*/
//                            dataVO.setDmandSurveyUpy(exceptionNullValue(map, "dmandSurveyUpy"));/*최근업그레이드년도*/
//                            dataVO.setDmandSurveyBuildcost(exceptionNullValue(map, "dmandSurveyBuildcost"));/*구축비*/
//                            dataVO.setDmandSurveyMaint(exceptionNullValue(map, "dmandSurveyMaint"));/*당해년도유지보수비*/
//                            dataVO.setDmandSurveyExpenses(exceptionNullValue(map, "dmandSurveyExpenses"));/*당해년도운영비*/
//                            dataVO.setDmandSurveyClouduse(exceptionNullValue(map, "dmandSurveyClouduse"));/*클라우드 기이용여부*/
//                            dataVO.setDmandSurveySeparation(exceptionNullValue(map, "dmandSurveySeparation"));/*클라우드구분*/
//                            dataVO.setDmandSurveyIntroy(exceptionNullValue(map, "dmandSurveyIntroy"));/*클라우드 도입년도*/
//                            dataVO.setDmandSurveyCnvrsPlan(exceptionNullValue(map, "dmandSurveyCnvrsPlan"));/*클라우드 전환 또는 도입예정*/
//                            dataVO.setDmandSurveyPlanCloudSeparation(exceptionNullValue(map, "dmandSurveyPlanCloudSeparation"));/*(도입예정시) 클라우드 구분*/
//                            dataVO.setDmandSurveyPlanServSeparation(exceptionNullValue(map, "dmandSurveyPlanServSeparation"));/*(도입예정시) 서비스 구분*/
//                            dataVO.setDmandSurveyBudget(exceptionNullValue(map, "dmandSurveyBudget"));/*클라우드 예산*/
//                            dataVO.setDmandSurveyVldtySecretAt(exceptionNullValue(map, "dmandSurveyVldtySecretAt"));/*(도입타당성) 비밀여부*/
//                            dataVO.setDmandSurveyVldtyFirstecon(exceptionNullValue(map, "dmandSurveyVldtyFirstecon"));/*(도입타당성) 경제성*/
//                            dataVO.setDmandSurveyOpinion(exceptionNullValue(map, "dmandSurveyOpinion"));/*클라우드 도입 만족도*/
                           
                            lDapCodeNm = dmandExaminService.selectLDapCodeNm(vo);
                            
                            dataVO.setDmandSurveyOrgname(lDapCodeNm);
                            
                            /*그리드 데이터 저장*/
                            dmandExaminService.insertGridDmandExaminDetail(dataVO);
                        }
                        /*유저 인포 업데이트 임시저장 시간*/
                        dmandExaminService.updateDmandExaminUserInfo(dataVO.getUserId());
                    } else {
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        dmandExaminService.updateDmandExaminUserInfo(vo.getUserId());
                    }
                    
                    return "true";
                }
                // 신청기간이 아닌경우
                return alertAndRedirect(model, "신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");
            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do");
    }
    
    
    /*제출하기*/
    @RequestMapping(value = "submitInfo.do")
    @ResponseBody
    public String submitInfo(HttpServletRequest request, ModelMap model, DmandExaminVO vo, @RequestBody List<Map<String, Object>> dataList) throws Exception{
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String lDapCodeNm = "";
        
        if(Validate.isNotEmpty(userLoginVo)) {

            vo.setUserId(userLoginVo.getUserId());

            if(userLoginVo.getUserTyCd().toString().startsWith("30") && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                Date startDate;     // 시작일자
                Date endDate;       // 종료일자(서울)
                Date currentDate;   // 현재날짜 Date
                String oTime = "";  // 현재날짜
                SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                Date currentTime = new Date();
                oTime = mSimpleDateFormat.format ( currentTime );   //현재시간 (String)
                currentDate =  mSimpleDateFormat.parse( oTime );    //현재일자
                DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
                
                startDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistBeginDate());  //시작일자
                endDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistEndDate());      //종료일자
                
                int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                int compareEnd = currentDate.compareTo( endDate ); // 날짜비교

                if(compareStart >= 0 && compareEnd <= 0) {
                   
                    int cnt = 0;
                    
                    /*그리드에서 가져온 리스트 사이즈가 존재하면*/
                    if(dataList.size() > 0){
                        /*기존 데이터 삭제*/
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        
                        DmandExaminVO dataVO = new DmandExaminVO();
                        dataVO.setUserId(vo.getUserId());
                        
                        for(Map<String, Object> map : dataList) {
//                         // table의 not null 체크
//                            if(exceptionNullValue(map, "dmandSurveySysname") == null 
//                                || exceptionNullValue(map, "dmandSurveySysname") == "") {
//                                continue;
//                            }

                            dataVO.setDmandSurveyNo(++cnt);                                                                         //①순번
                            dataVO.setDmandSurveyOrgname(exceptionNullValue(map, "dmandSurveyOrgname"));                            //②기관명                       
                            dataVO.setDmandSurveySysname(exceptionNullValue(map, "dmandSurveySysname"));                            //③시스템명                     
                            dataVO.setDmandSurveySysobj(exceptionNullValue(map, "dmandSurveySysobj"));                              //④시스템목적                   
                            dataVO.setDmandSurveyDivision(exceptionNullValue(map, "dmandSurveyDivision"));                          //⑤시스템구분                       
                            dataVO.setDmandSurveyManager(exceptionNullValue(map, "dmandSurveyManager"));                            //⑥담당자                       
                            dataVO.setDmandSurveyMail(exceptionNullValue(map, "dmandSurveyMail"));                                  //⑦이메일                       
                            dataVO.setDmandSurveyPhone(exceptionNullValue(map, "dmandSurveyPhone"));                                //⑧유선번호                     
                            dataVO.setDmandSurveyBuildy(exceptionNullValue(map, "dmandSurveyBuildy"));                              //⑨구축년도                     
                            dataVO.setDmandSurveyUpy(exceptionNullValue(map, "dmandSurveyUpy"));                                    //⑩최근 업그레이드년도          
                            dataVO.setDmandSurveyClouduse(exceptionNullValue(map, "dmandSurveyClouduse"));                          //⑪현 클라우드 이용여부         
                            dataVO.setDmandSurveySeparation(exceptionNullValue(map, "dmandSurveySeparation"));                      //⑪-1)클라우드구분              
                            dataVO.setDmandSurveyCnvrsPlan(exceptionNullValue(map, "dmandSurveyCnvrsPlan"));                        //⑫클라우드전환또는 도입예정    
                            dataVO.setDmandSurveyPlanCloudSeparation(exceptionNullValue(map, "dmandSurveyPlanCloudSeparation"));    //⑫-1) 클라우드 도입 예정시 클라
                            dataVO.setDmandSurveyPlanServSeparation(exceptionNullValue(map, "dmandSurveyPlanServSeparation"));      //⑫-1) 클라우드 도입 예정시 서비
                            dataVO.setDmandSurveyBudget(exceptionNullValue(map, "dmandSurveyBudget"));                              //⑫-2)클라우드 예산             
                            dataVO.setDmandSurveyVldtySecretAt(exceptionNullValue(map, "dmandSurveyVldtySecretAt"));                //⑬2020년이후 국가정보자원관리원                            

                            
                            
//                            dataVO.setDmandSurveyHighorgname(exceptionNullValue(map, "dmandSurveyHighorgname"));/*상위기관명*/
//                            dataVO.setDmandSurveyOrgname(exceptionNullValue(map, "dmandSurveyOrgname"));/*기관명*/
//                            dataVO.setDmandSurveySysname(exceptionNullValue(map, "dmandSurveySysname"));/*시스템명*/
//                            dataVO.setDmandSurveySysobj(exceptionNullValue(map, "dmandSurveySysobj"));/*시스템목적*/
//                            dataVO.setDmandSurveyDivision(exceptionNullValue(map, "dmandSurveyDivision"));/*시스템구분*/
//                            dataVO.setDmandSurveyManager(exceptionNullValue(map, "dmandSurveyManager"));/*담당자*/
//                            dataVO.setDmandSurveyMail(exceptionNullValue(map, "dmandSurveyMail"));/*이메일*/
//                            dataVO.setDmandSurveyPhone(exceptionNullValue(map, "dmandSurveyPhone"));/*연락처*/
//                            dataVO.setDmandSurveyBuildy(exceptionNullValue(map, "dmandSurveyBuildy"));/*구축년도*/
//                            dataVO.setDmandSurveyUpy(exceptionNullValue(map, "dmandSurveyUpy"));/*최근업그레이드년도*/
//                            dataVO.setDmandSurveyBuildcost(exceptionNullValue(map, "dmandSurveyBuildcost"));/*구축비*/
//                            dataVO.setDmandSurveyMaint(exceptionNullValue(map, "dmandSurveyMaint"));/*당해년도유지보수비*/
//                            dataVO.setDmandSurveyExpenses(exceptionNullValue(map, "dmandSurveyExpenses"));/*당해년도운영비*/
//                            dataVO.setDmandSurveyClouduse(exceptionNullValue(map, "dmandSurveyClouduse"));/*클라우드 기이용여부*/
//                            dataVO.setDmandSurveySeparation(exceptionNullValue(map, "dmandSurveySeparation"));/*클라우드구분*/
//                            dataVO.setDmandSurveyIntroy(exceptionNullValue(map, "dmandSurveyIntroy"));/*클라우드 도입년도*/
//                            dataVO.setDmandSurveyCnvrsPlan(exceptionNullValue(map, "dmandSurveyCnvrsPlan"));/*클라우드 전환 또는 도입예정*/
//                            dataVO.setDmandSurveyPlanCloudSeparation(exceptionNullValue(map, "dmandSurveyPlanCloudSeparation"));/*(도입예정시) 클라우드 구분*/
//                            dataVO.setDmandSurveyPlanServSeparation(exceptionNullValue(map, "dmandSurveyPlanServSeparation"));/*(도입예정시) 서비스 구분*/
//                            dataVO.setDmandSurveyBudget(exceptionNullValue(map, "dmandSurveyBudget"));/*클라우드 예산*/
//                            dataVO.setDmandSurveyVldtySecretAt(exceptionNullValue(map, "dmandSurveyVldtySecretAt"));/*(도입타당성) 비밀여부*/
//                            dataVO.setDmandSurveyVldtyFirstecon(exceptionNullValue(map, "dmandSurveyVldtyFirstecon"));/*(도입타당성) 경제성*/
//                            dataVO.setDmandSurveyOpinion(exceptionNullValue(map, "dmandSurveyOpinion"));/*클라우드 도입 만족도*/
                           
                            lDapCodeNm = dmandExaminService.selectLDapCodeNm(vo);
                            
                            dataVO.setDmandSurveyOrgname(lDapCodeNm);

                            
                            /*그리드 데이터 저장*/
                            dmandExaminService.insertGridDmandExaminDetail(dataVO);
                        }
                        /*유저 인포 업데이트 임시저장시간, 제출 시간*/
                        dmandExaminService.updateDmandExaminUserInfoSubmit(vo.getUserId());
                    }   else {
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        /*유저 인포 업데이트 임시저장시간, 제출 시간*/
                        dmandExaminService.updateDmandExaminUserInfoSubmit(vo.getUserId());
                    }
                    return "true";
                }
                // 신청기간이 아닌경우
                return alertAndRedirect(model, "\n신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");
            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            //return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
			return confirmAndRedirect(model, "\n수요예보조사 담당자만 참여가능합니다. \n수요예보조사 담당자를 지정하시겠습니까?", serverNm(request) + "/pt/register/BD_password.do" );
        }
     // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do");
    }
    /*제출하기*/
    @RequestMapping(value = "submitInfo1.do")
    @ResponseBody
    public String submitInfo1(HttpServletRequest request, ModelMap model, DmandExaminVO vo, @RequestBody List<Map<String, Object>> dataList) throws Exception{
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String lDapCodeNm = "";
        
        if(Validate.isNotEmpty(userLoginVo)) {

            vo.setUserId(userLoginVo.getUserId());

            if(userLoginVo.getUserTyCd().toString().startsWith("30") && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                Date startDate;     // 시작일자
                Date endDate;       // 종료일자(서울)
                Date currentDate;   // 현재날짜 Date
                String oTime = "";  // 현재날짜
                SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                Date currentTime = new Date();
                oTime = mSimpleDateFormat.format ( currentTime );   //현재시간 (String)
                currentDate =  mSimpleDateFormat.parse( oTime );    //현재일자
                DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
                
                startDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistBeginDate());  //시작일자
                endDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistEndDate());      //종료일자
                
                int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                int compareEnd = currentDate.compareTo( endDate ); // 날짜비교

                if(compareStart >= 0 && compareEnd <= 0) {
                   
                    int cnt = 0;
                    
                    /*그리드에서 가져온 리스트 사이즈가 존재하면*/
                    if(dataList.size() > 0){
                        /*기존 데이터 삭제*/
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        
                        DmandExaminVO dataVO = new DmandExaminVO();
                        dataVO.setUserId(vo.getUserId());
                        
                        for(Map<String, Object> map : dataList) {
//                         // table의 not null 체크
//                            if(exceptionNullValue(map, "dmandSurveySysname") == null 
//                                || exceptionNullValue(map, "dmandSurveySysname") == "") {
//                                continue;
//                            }

                            dataVO.setDmandSurveyNo(++cnt);                                                                         //①순번
                            dataVO.setDmandSurveyOrgname(exceptionNullValue(map, "dmandSurveyOrgname"));                            //②기관명                       
                            dataVO.setDmandSurveySysname(exceptionNullValue(map, "dmandSurveySysname"));                            //③시스템명                     
                            dataVO.setDmandSurveySysobj(exceptionNullValue(map, "dmandSurveySysobj"));                              //④시스템목적                   
                            dataVO.setDmandSurveyDivision(exceptionNullValue(map, "dmandSurveyDivision"));                          //⑤시스템구분                       
                            dataVO.setDmandSurveyManager(exceptionNullValue(map, "dmandSurveyManager"));                            //⑥담당자                       
                            dataVO.setDmandSurveyMail(exceptionNullValue(map, "dmandSurveyMail"));                                  //⑦이메일                       
                            dataVO.setDmandSurveyPhone(exceptionNullValue(map, "dmandSurveyPhone"));                                //⑧유선번호                     
                            dataVO.setDmandSurveyBuildy(exceptionNullValue(map, "dmandSurveyBuildy"));                              //⑨구축년도                     
                            dataVO.setDmandSurveyUpy(exceptionNullValue(map, "dmandSurveyUpy"));                                    //⑩최근 업그레이드년도          
                            dataVO.setDmandSurveyClouduse(exceptionNullValue(map, "dmandSurveyClouduse"));                          //⑪현 클라우드 이용여부         
                            dataVO.setDmandSurveySeparation(exceptionNullValue(map, "dmandSurveySeparation"));                      //⑪-1)클라우드구분              
                            dataVO.setDmandSurveyCnvrsPlan(exceptionNullValue(map, "dmandSurveyCnvrsPlan"));                        //⑫클라우드전환또는 도입예정    
                            dataVO.setDmandSurveyPlanCloudSeparation(exceptionNullValue(map, "dmandSurveyPlanCloudSeparation"));    //⑫-1) 클라우드 도입 예정시 클라
                            dataVO.setDmandSurveyPlanServSeparation(exceptionNullValue(map, "dmandSurveyPlanServSeparation"));      //⑫-1) 클라우드 도입 예정시 서비
                            dataVO.setDmandSurveyBudget(exceptionNullValue(map, "dmandSurveyBudget"));                              //⑫-2)클라우드 예산             

                           
                            lDapCodeNm = dmandExaminService.selectLDapCodeNm(vo);
                            
                            dataVO.setDmandSurveyOrgname(lDapCodeNm);

                            
                            /*그리드 데이터 저장*/
                            dmandExaminService.insertGridDmandExaminDetail(dataVO);
                        }
                        /*유저 인포 업데이트 임시저장시간, 제출 시간*/
                        dmandExaminService.updateDmandExaminUserInfoSubmit(vo.getUserId());
                    }   else {
                        dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                        /*유저 인포 업데이트 임시저장시간, 제출 시간*/
                        dmandExaminService.updateDmandExaminUserInfoSubmit(vo.getUserId());
                    }
                    return "true";
                }
                // 신청기간이 아닌경우
                return alertAndRedirect(model, "\n신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");
            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            //return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
			return confirmAndRedirect(model, "\n수요예보조사 담당자만 참여가능합니다. \n수요예보조사 담당자를 지정하시겠습니까?", serverNm(request) + "/pt/register/BD_password.do" );
        }
     // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do");
    }
    
    /*toString null 예외 처리*/
    public String exceptionNullValue(Map<String, Object> map, String strColumn) {
        String strValue = "";
        if(map.get(strColumn) == null){
            return strValue;
        } else {
            return map.get(strColumn).toString();
        }
    }
    
    /**
     * 2019년도 수요예보조사 조사표 다운로드
     * @throws ParseException
     */
    @RequestMapping(value = "ND_dmandExaminDownloadAction.do")
    public String dmandExaminDownloadAction(HttpServletRequest request, HttpServletResponse response, ModelMap model, DmandExaminVO  vo) throws Exception  {
        /*관리자 페이지 제출목록 조사표 다운로드와 같이 사용*/
        
        /*유저페이지 UseId 저장*/
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        /*관리자페이지 UserId 저장*/
        String intraUserId = request.getParameter("userId");
        if(Validate.isNotEmpty(userLoginVo) || Validate.isNotEmpty(intraUserId)) {
            if(intraUserId != null){
                vo.setUserId(intraUserId);
            }else{
                vo.setUserId(userLoginVo.getUserId());
            }
            
           List<DmandExaminVO> detailList = dmandExaminService.selectDmandExaminDetail(vo.getUserId());
            Map<String , Object> beans = new HashMap<String , Object>();
            beans.put("list" , detailList);
            
            MakeExcel me = new MakeExcel();
            me.download(request, response, beans, "2019년수요예보조사표", "dmandExamin_sample2.xlsx");
            return null;
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do", "top");
    }
    /**
     * 전년도 수요예보조사 조사표 다운로드
     * @throws ParseException
     */
    @RequestMapping(value = "ND_dmandExaminDownloadAction1.do")
    public String ND_dmandExaminDownloadAction1(HttpServletRequest request, HttpServletResponse response, ModelMap model, DmandExaminVO  vo) throws Exception  {
        /*관리자 페이지 제출목록 조사표 다운로드와 같이 사용*/
        
        /*유저페이지 UseId 저장*/
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        /*관리자페이지 UserId 저장*/
        String intraUserId = request.getParameter("userId");
        if(Validate.isNotEmpty(userLoginVo) || Validate.isNotEmpty(intraUserId)) {
            if(intraUserId != null){
                vo.setUserId(intraUserId);
            }else{
                vo.setUserId(userLoginVo.getUserId());
            }

           List<DmandExaminVO> detailList = dmandExaminService.selectDmandExaminDetail1(vo.getUserId());
            Map<String , Object> beans = new HashMap<String , Object>();
            beans.put("list" , detailList);
            
            MakeExcel me = new MakeExcel();
            me.download(request, response, beans, "2018년수요예보조사표", "dmandExamin_sample2.xlsx");
            return null;
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do", "top");
    }
    /**
     * 2019년도 수요예보조사 조사표 다운로드
     * @throws ParseException
     */
    @RequestMapping(value = "ND_dmandExaminDownloadAction2.do")
    public String dmandExaminDownloadAction2(HttpServletRequest request, HttpServletResponse response, ModelMap model, DmandExaminVO  vo) throws Exception  {
        /*관리자 페이지 제출목록 조사표 다운로드와 같이 사용*/
        
        /*유저페이지 UseId 저장*/
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        /*관리자페이지 UserId 저장*/
        String intraUserId = request.getParameter("userId");
        if(Validate.isNotEmpty(userLoginVo) || Validate.isNotEmpty(intraUserId)) {
            if(intraUserId != null){
                vo.setUserId(intraUserId);
            }else{
                vo.setUserId(userLoginVo.getUserId());
            }
            
           List<DmandExaminVO> detailList = dmandExaminService.selectDmandExaminDetail2(vo.getUserId());
            Map<String , Object> beans = new HashMap<String , Object>();
            beans.put("list" , detailList);
            
            MakeExcel me = new MakeExcel();
            me.download(request, response, beans, "2019년수요예보조사표", "dmandExamin_sample3.xlsx");
            return null;
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do", "top");
    }
    /**
     * 전년도 수요예보조사 조사표 다운로드
     * @throws ParseException
     */
    @RequestMapping(value = "ND_dmandExaminDownloadAction3.do")
    public String ND_dmandExaminDownloadAction3(HttpServletRequest request, HttpServletResponse response, ModelMap model, DmandExaminVO  vo) throws Exception  {
        /*관리자 페이지 제출목록 조사표 다운로드와 같이 사용*/
        
        /*유저페이지 UseId 저장*/
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        /*관리자페이지 UserId 저장*/
        String intraUserId = request.getParameter("userId");
        if(Validate.isNotEmpty(userLoginVo) || Validate.isNotEmpty(intraUserId)) {
            if(intraUserId != null){
                vo.setUserId(intraUserId);
            }else{
                vo.setUserId(userLoginVo.getUserId());
            }

           List<DmandExaminVO> detailList = dmandExaminService.selectDmandExaminDetail3(vo.getUserId());
            Map<String , Object> beans = new HashMap<String , Object>();
            beans.put("list" , detailList);
            
            MakeExcel me = new MakeExcel();
            me.download(request, response, beans, "2018년수요예보조사표", "dmandExamin_sample3.xlsx");
            return null;
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirectTarget(model, MessageHelper.getMsg(request, "noSession"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do", "top");
    }
    
    
    
    /**
     * 수요조사저장
     * @param request
     * @param model
     */
    @RequestMapping(value = "BD_dmandExaminSaveAction.do", method = RequestMethod.POST)
    public String dmandExaminSaveAction(HttpServletRequest request, ModelMap model, DmandExaminVO vo)  throws ParseException{
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //로그인 회원 체크
        String lDapCodeNm = "";
        
        if(Validate.isNotEmpty(userLoginVo)) {

            vo.setUserId(userLoginVo.getUserId());

            if(userLoginVo.getUserTyCd().toString().startsWith("30") && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                Date startDate;     // 시작일자
                Date endDate;       // 종료일자(서울)
                Date currentDate;   // 현재날짜 Date
                String oTime = "";  // 현재날짜
                SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                Date currentTime = new Date();
                oTime = mSimpleDateFormat.format ( currentTime );   //현재시간 (String)
                currentDate =  mSimpleDateFormat.parse( oTime );    //현재일자
                DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
                
                startDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistBeginDate());  //시작일자
                endDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistEndDate());      //종료일자
                
                int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                int compareEnd = currentDate.compareTo( endDate ); // 날짜비교

                if(compareStart >= 0 && compareEnd <= 0) {
                    List<FileVO> uploadFile = UploadHelper.upload(request, DMANDEXAMIN_EXCEL);
                    List<FileVO> dmandExaminFile = new ArrayList<FileVO>();
                    for(int i = 0 ; i < uploadFile.size() ; i++) {

                        String inputNm = uploadFile.get(i).getInputNm();

                        if(inputNm.startsWith("dmandExaminFile")) {

                            dmandExaminFile.add(uploadFile.get(i));

                            File excelFile = uploadFile.get(i).getFile();

                            DmandExaminVO dmandExaminVO;

                            XSSFRow row;
                            XSSFCell cell;

                            try {
                                FileInputStream inputStream = new FileInputStream(excelFile);
                                XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
                                //sheet수 취득
                                int sheetCn = workbook.getNumberOfSheets();
                            
                                for (int cn = 0; cn < sheetCn; cn++){
                                    if (cn < 1) {
                            
                                        //0번째 sheet 정보 취득
                                        XSSFSheet sheet = workbook.getSheetAt(cn);

                                        //취득된 sheet에서 rows수 취득
                                        int rows = sheet.getPhysicalNumberOfRows();
                                        //취득된 row에서 취득대상 cell수 취득
                                        int cells = sheet.getRow(cn).getPhysicalNumberOfCells();// + 39; //
                                        
                                        //총셀이 17개가 맞는 수요정보조사표를 적용했을때
                                        if(cells==17){
                                            /*Excel정보를 등록하기 전 등록되어 있었던 디테일 정보 삭제*/
                                            dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                                            
                                            for (int r = 3; r < rows; r++) {
                                                dmandExaminVO = new DmandExaminVO();
                                                row = sheet.getRow(r); // row 가져오기

                                                if (row != null) {

                                                    for (int c = 0; c < cells; c++) {

                                                        cell = row.getCell(c);  // cell가져오기

                                                        if (cell != null) {

                                                            String cellVal = excelDataExport(workbook, cell);


                                                            if (c == 0) {   dmandExaminVO.setDmandSurveyNo(r-2);    }
                                                            else if (c == 1) {  dmandExaminVO.setDmandSurveyOrgname(cellVal);   }   
                                                            else if (c == 2) {  dmandExaminVO.setDmandSurveySysname(cellVal);   }
                                                            else if (c == 3) {  dmandExaminVO.setDmandSurveySysobj(cellVal);    }
                                                            else if (c == 4) {  dmandExaminVO.setDmandSurveyDivision(cellVal);  }
                                                            else if (c == 5) {  dmandExaminVO.setDmandSurveyManager(cellVal);   }
                                                            else if (c == 6) {  dmandExaminVO.setDmandSurveyMail(cellVal);  }
                                                            else if (c == 7) {  dmandExaminVO.setDmandSurveyPhone(cellVal); }
                                                            else if (c == 8) {  dmandExaminVO.setDmandSurveyBuildy(cellVal); }   
                                                            else if (c == 9) {  dmandExaminVO.setDmandSurveyUpy(cellVal);   }
                                                            else if (c == 10) {  dmandExaminVO.setDmandSurveyClouduse(cellVal);  }  
                                                            else if (c == 11) {  dmandExaminVO.setDmandSurveySeparation(cellVal);    }
                                                            else if (c == 12) {  dmandExaminVO.setDmandSurveyCnvrsPlan(cellVal); }
                                                            else if (c == 13) {  dmandExaminVO.setDmandSurveyPlanCloudSeparation(cellVal);   }   
                                                            else if (c == 14) {  dmandExaminVO.setDmandSurveyPlanServSeparation(cellVal);    }
                                                            else if (c == 15) {  dmandExaminVO.setDmandSurveyBudget(cellVal);    }
                                                            else if (c == 16) {  dmandExaminVO.setDmandSurveyVldtySecretAt(cellVal); }
                                                   
                                                        } else {
//                                                            System.out.print("[null]\t");
                                                        }
                                                    } // for(c) 문
//                                                    System.out.print("\n");
                                                }// 컬럼 중 어느 한가지라도 null이 아니면 저장하는 메소드

                                                
                                                if (Validate.isNotEmpty(dmandExaminVO.getDmandSurveySysname().trim())  || Validate.isNotEmpty(dmandExaminVO.getDmandSurveySysobj().trim())||
                                                    Validate.isNotEmpty(dmandExaminVO.getDmandSurveyDivision().trim()) || Validate.isNotEmpty(dmandExaminVO.getDmandSurveyClouduse().trim())||
                                                    Validate.isNotEmpty(dmandExaminVO.getDmandSurveyCnvrsPlan().trim())|| Validate.isNotEmpty(dmandExaminVO.getDmandSurveyVldtySecretAt().trim())) 
                                                {
                                                        dmandExaminVO.setUserId(vo.getUserId());
                                                        /*그리드 데이터 저장*/
                                                        
                                                        lDapCodeNm = dmandExaminService.selectLDapCodeNm(dmandExaminVO);
                                                        
                                                        //dmandExaminVO.setPblinsttNm(lDapCodeNm);
                                                        
                                                        dmandExaminVO.setDmandSurveyOrgname(lDapCodeNm);
                                                        
                                                        dmandExaminService.insertGridDmandExaminDetail(dmandExaminVO);
                                                }
                                            } // for(r) 문 END
                                            /*유저 인포 업데이트 임시저장 시간*/
                                            dmandExaminService.updateDmandExaminUserInfo(vo.getUserId());
                                        } else {
                                            return alertAndRedirect(model, MessageHelper.getMsg(request, "wrongFile"), "PD_searchDmandExaminGridPop.do");
                                        }
                                    }
                                }
                                
                            } catch (Exception e) {
                                return alertAndRedirect(model, MessageHelper.getMsg(request, "wrongFile"), "PD_searchDmandExaminGridPop.do");
//                                e.printStackTrace();
                            }
                        }
                    }

                    vo.setDmandExaminFile(dmandExaminFile);

                    Integer key = dmandExaminService.dmandExaminSaveAction(vo, 0);

                    if (Validate.isEmpty(key)) {

                        return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
                    } else {
//                        return alertAndRedirect(model, MessageHelper.getMsg(request, "saveOk"), "BD_dmandExamin.do");
//                        return alertAndRedirect(model, MessageHelper.getMsg(request, "saveOk"), "PD_searchDmandExaminGridPop.do");
                        return "redirect:"+requestUrl(request)+"/PD_searchDmandExaminGridPop.do";
                    }
                }
                // 신청기간이 아닌경우
                return alertAndRedirect(model, "신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");
            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            //return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
			return confirmAndRedirect(model, "\n수요예보조사 담당자만 참여가능합니다. \n수요예보조사 담당자를 지정하시겠습니까?", serverNm(request) + "/pt/register/BD_password.do" );
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do");
    }
    
    /**
     * 1001 공공기관이 아닌경우 16개 셀
     * dmandExaminSaveAction1 설명
     * @param request
     * @param model
     * @param vo
     * @return
     * @throws ParseException
     */
    @RequestMapping(value = "BD_dmandExaminSaveAction1.do", method = RequestMethod.POST)
    public String dmandExaminSaveAction1(HttpServletRequest request, ModelMap model, DmandExaminVO vo)  throws ParseException{
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //로그인 회원 체크
        String lDapCodeNm = "";
        
        if(Validate.isNotEmpty(userLoginVo)) {

            vo.setUserId(userLoginVo.getUserId());

            if(userLoginVo.getUserTyCd().toString().startsWith("30") && userLoginVo.getDmandExaminChargerAt().equals("Y")) {

                Date startDate;     // 시작일자
                Date endDate;       // 종료일자(서울)
                Date currentDate;   // 현재날짜 Date
                String oTime = "";  // 현재날짜
                SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
                Date currentTime = new Date();
                oTime = mSimpleDateFormat.format ( currentTime );   //현재시간 (String)
                currentDate =  mSimpleDateFormat.parse( oTime );    //현재일자
                DmandExaminRegistMngrVO dmandExaminRegistMngrVO = registerService.dmandExaminRegistMngrInfo();
                
                startDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistBeginDate());  //시작일자
                endDate = mSimpleDateFormat.parse(dmandExaminRegistMngrVO.getRegistEndDate());      //종료일자
                
                int compareStart = currentDate.compareTo( startDate ); // 날짜비교
                int compareEnd = currentDate.compareTo( endDate ); // 날짜비교

                if(compareStart >= 0 && compareEnd <= 0) {
                    List<FileVO> uploadFile = UploadHelper.upload(request, DMANDEXAMIN_EXCEL);
                    List<FileVO> dmandExaminFile = new ArrayList<FileVO>();
                    for(int i = 0 ; i < uploadFile.size() ; i++) {

                        String inputNm = uploadFile.get(i).getInputNm();

                        if(inputNm.startsWith("dmandExaminFile")) {

                            dmandExaminFile.add(uploadFile.get(i));

                            File excelFile = uploadFile.get(i).getFile();

                            DmandExaminVO dmandExaminVO;

                            XSSFRow row;
                            XSSFCell cell;

                            try {
                                FileInputStream inputStream = new FileInputStream(excelFile);
                                XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
                                //sheet수 취득
                                int sheetCn = workbook.getNumberOfSheets();
                            
                                for (int cn = 0; cn < sheetCn; cn++){
                                    if (cn < 1) {
                            
                                        //0번째 sheet 정보 취득
                                        XSSFSheet sheet = workbook.getSheetAt(cn);

                                        //취득된 sheet에서 rows수 취득
                                        int rows = sheet.getPhysicalNumberOfRows();
                                        //취득된 row에서 취득대상 cell수 취득
                                        int cells = sheet.getRow(cn).getPhysicalNumberOfCells();// + 39; //
                                        if(cells==16){
                                            /*Excel정보를 등록하기 전 등록되어 있었던 디테일 정보 삭제*/
                                            dmandExaminService.deleteDmandExaminDetail(vo.getUserId());
                                            
                                            for (int r = 3; r < rows; r++) {
                                                dmandExaminVO = new DmandExaminVO();
                                                row = sheet.getRow(r); // row 가져오기

                                                if (row != null) {

                                                    for (int c = 0; c < cells; c++) {

                                                        cell = row.getCell(c);  // cell가져오기

                                                        if (cell != null) {

                                                            String cellVal = excelDataExport(workbook, cell);

                                                                if (c == 0) {   dmandExaminVO.setDmandSurveyNo(r-2);    }
                                                                else if (c == 1) {  dmandExaminVO.setDmandSurveyOrgname(cellVal);   }   
                                                                else if (c == 2) {  dmandExaminVO.setDmandSurveySysname(cellVal);   }
                                                                else if (c == 3) {  dmandExaminVO.setDmandSurveySysobj(cellVal);    }
                                                                else if (c == 4) {  dmandExaminVO.setDmandSurveyDivision(cellVal);  }
                                                                else if (c == 5) {  dmandExaminVO.setDmandSurveyManager(cellVal);   }
                                                                else if (c == 6) {  dmandExaminVO.setDmandSurveyMail(cellVal);  }
                                                                else if (c == 7) {  dmandExaminVO.setDmandSurveyPhone(cellVal); }
                                                                else if (c == 8) {  dmandExaminVO.setDmandSurveyBuildy(cellVal); }   
                                                                else if (c == 9) {  dmandExaminVO.setDmandSurveyUpy(cellVal);   }
                                                                else if (c == 10) {  dmandExaminVO.setDmandSurveyClouduse(cellVal);  }  
                                                                else if (c == 11) {  dmandExaminVO.setDmandSurveySeparation(cellVal);    }
                                                                else if (c == 12) {  dmandExaminVO.setDmandSurveyCnvrsPlan(cellVal); }
                                                                else if (c == 13) {  dmandExaminVO.setDmandSurveyPlanCloudSeparation(cellVal);   }   
                                                                else if (c == 14) {  dmandExaminVO.setDmandSurveyPlanServSeparation(cellVal);    }
                                                                else if (c == 15) {  dmandExaminVO.setDmandSurveyBudget(cellVal);    }
                                               
                                                        } else {
//                                                            System.out.print("[null]\t");
                                                        }
                                                    } // for(c) 문
//                                                    System.out.print("\n");
                                                }// 컬럼 중 어느 한가지라도 null이 아니면 저장하는 메소드

                                                
                                                if (Validate.isNotEmpty(dmandExaminVO.getDmandSurveySysname().trim())  || Validate.isNotEmpty(dmandExaminVO.getDmandSurveySysobj().trim())||
                                                    Validate.isNotEmpty(dmandExaminVO.getDmandSurveyDivision().trim()) || Validate.isNotEmpty(dmandExaminVO.getDmandSurveyClouduse().trim())||
                                                    Validate.isNotEmpty(dmandExaminVO.getDmandSurveyCnvrsPlan().trim()) ) 
                                                {
                                                        dmandExaminVO.setUserId(vo.getUserId());
                                                        /*그리드 데이터 저장*/
                                                        
                                                        lDapCodeNm = dmandExaminService.selectLDapCodeNm(dmandExaminVO);
                                                        
                                                        //dmandExaminVO.setPblinsttNm(lDapCodeNm);
                                                        
                                                        dmandExaminVO.setDmandSurveyOrgname(lDapCodeNm);
                                                        
                                                        dmandExaminService.insertGridDmandExaminDetail(dmandExaminVO);
                                                }
                                            } // for(r) 문 END
                                            /*유저 인포 업데이트 임시저장 시간*/
                                            dmandExaminService.updateDmandExaminUserInfo(vo.getUserId());
                                        } else {
                                            return alertAndRedirect(model, MessageHelper.getMsg(request, "wrongFile"), "PD_searchDmandExaminGridPop.do");
                                        }
                                    }
                                }
                                
                            } catch (Exception e) {
                                return alertAndRedirect(model, MessageHelper.getMsg(request, "wrongFile"), "PD_searchDmandExaminGridPop.do");
//                                e.printStackTrace();
                            }
                        }
                    }

                    vo.setDmandExaminFile(dmandExaminFile);

                    Integer key = dmandExaminService.dmandExaminSaveAction(vo, 0);

                    if (Validate.isEmpty(key)) {

                        return alertAndBack(model, MessageHelper.getMsg(request, "processFail"));
                    } else {
//                        return alertAndRedirect(model, MessageHelper.getMsg(request, "saveOk"), "BD_dmandExamin.do");
//                        return alertAndRedirect(model, MessageHelper.getMsg(request, "saveOk"), "PD_searchDmandExaminGridPop.do");
                        return "redirect:"+requestUrl(request)+"/PD_searchDmandExaminGridPop.do";
                    }
                }
                // 신청기간이 아닌경우
                return alertAndRedirect(model, "신청기간이 아닙니다.", serverNm(request) + "/pt/index.do");
            }
            // 기관회원 중 수요조사 담당자가 아닌사람이 페이지 접근시
            return alertAndRedirect(model, "수요예보조사 담당자만 참여가능합니다.", serverNm(request) + "/pt/index.do");
        }
        // 로그인 없이 정보변경페이지 접급시
        return alertAndRedirect(model, MessageHelper.getMsg(request, "requiredLogin"), serverNm(request) + "/pt/login/user/BD_index.do?returnUrl=" + requestUrl(request) + "/BD_dmandExamin.do");
    }

    /**
     * 엑셀 데이터 저장
     * @param file
     * @param userId
     */
//    private void readExclAndDataSave(File file, String userId) {
//
//        DmandExaminVO dmandExaminVO;
//
//        XSSFRow row;
//        XSSFCell cell;
//
//        try {
//            FileInputStream inputStream = new FileInputStream(file);
//            XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
//            //sheet수 취득
//            int sheetCn = workbook.getNumberOfSheets();
//        
//            for (int cn = 0; cn < sheetCn; cn++){
//                if (cn < 1) {
//        
//                    //0번째 sheet 정보 취득
//                    XSSFSheet sheet = workbook.getSheetAt(cn);
//
//                    //취득된 sheet에서 rows수 취득
//                    int rows = sheet.getPhysicalNumberOfRows();
//                    //취득된 row에서 취득대상 cell수 취득
//                    int cells = sheet.getRow(cn).getPhysicalNumberOfCells();// + 39; //
//                    
//                    /*Excel정보를 등록하기 전 등록되어 있었던 디테일 정보 삭제*/
//                    dmandExaminService.deleteDmandExaminDetail(userId);
//                    
//                    for (int r = 3; r < rows; r++) {
//                        dmandExaminVO = new DmandExaminVO();
//                        row = sheet.getRow(r); // row 가져오기
//
//                        if (row != null) {
//
//                            for (int c = 0; c < cells; c++) {
//
//                                cell = row.getCell(c);  // cell가져오기
//
//                                if (cell != null) {
//
//                                    String cellVal = excelDataExport(workbook, cell);
//
//                                    if (c == 0) {   dmandExaminVO.setDmandSurveyNo(r-2); }/*순번*/
//                                    else if (c == 1) {  dmandExaminVO.setDmandSurveyHighorgname(cellVal); }/*상위기관명*/
//                                    else if (c == 2) {  dmandExaminVO.setDmandSurveyOrgname(cellVal); }/*기관명*/
//                                    else if (c == 3) {  dmandExaminVO.setDmandSurveySysname(cellVal); }/*시스템명*/
//                                    else if (c == 4) {  dmandExaminVO.setDmandSurveySysobj(cellVal); }/*시스템목적*/
//                                    else if (c == 5) {  dmandExaminVO.setDmandSurveyDivision(cellVal); }/*시스템구분*/
//                                    else if (c == 6) {  dmandExaminVO.setDmandSurveyManager(cellVal); }/*담당자*/
//                                    else if (c == 7) {  dmandExaminVO.setDmandSurveyMail(cellVal); }/*이메일*/
//                                    else if (c == 8) {  dmandExaminVO.setDmandSurveyPhone(cellVal); }/*연락처*/
//                                    else if (c == 9) {  dmandExaminVO.setDmandSurveyBuildy(cellVal); }/*구축년도*/
//                                    else if (c == 10) { dmandExaminVO.setDmandSurveyUpy(cellVal); }/*최근업그레이드년도*/
//                                    else if (c == 11) { dmandExaminVO.setDmandSurveyBuildcost(cellVal); }/*구축비*/
//                                    else if (c == 12) { dmandExaminVO.setDmandSurveyMaint(cellVal); }/*당해년도유지보수비*/
//                                    else if (c == 13) { dmandExaminVO.setDmandSurveyExpenses(cellVal); }/*당해년도운영비*/
//                                    else if (c == 14) { dmandExaminVO.setDmandSurveyClouduse(cellVal); }/*클라우드 기이용여부*/
//                                    else if (c == 15) { dmandExaminVO.setDmandSurveySeparation(cellVal); }/*클라우드구분*/
//                                    else if (c == 16) { dmandExaminVO.setDmandSurveyIntroy(cellVal); }/*클라우드 도입년도*/
//                                    else if (c == 17) {  dmandExaminVO.setDmandSurveyCnvrsPlan(cellVal); }/*클라우드 전환 또는 도입예정*/
//                                    else if (c == 18) {  dmandExaminVO.setDmandSurveyPlanCloudSeparation(cellVal); }/*(도입예정시) 클라우드 구분*/
//                                    else if (c == 19) {  dmandExaminVO.setDmandSurveyPlanServSeparation(cellVal); }/*(도입예정시) 서비스 구분*/
//                                    else if (c == 20) {  dmandExaminVO.setDmandSurveyBudget(cellVal); }/*클라우드 예산*/
//                                    else if (c == 21) {  dmandExaminVO.setDmandSurveyVldtySecretAt(cellVal); }/*(도입타당성) 비밀여부*/
//                                    else if (c == 22) {  dmandExaminVO.setDmandSurveyVldtyFirstecon(cellVal); }/*(도입타당성) 경제성*/
//                                    else if (c == 23) {  dmandExaminVO.setDmandSurveyOpinion(cellVal); }/*클라우드 도입 만족도*/
//                                } else {
//                                    System.out.print("[null]\t");
//                                }
//                            } // for(c) 문
//                            System.out.print("\n");
//                        }
//                        if (Validate.isNotEmpty(dmandExaminVO.getDmandSurveySysname().trim())) {
//                            dmandExaminVO.setUserId(userId);
//                            /*그리드 데이터 저장*/
//                            dmandExaminService.insertGridDmandExaminDetail(dmandExaminVO);
//                        }
//                    } // for(r) 문 END
//                    /*유저 인포 업데이트 임시저장 시간*/
//                    dmandExaminService.updateDmandExaminUserInfo(userId);
//                }
//            }
//            
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    private String excelDataExport(XSSFWorkbook workbook, XSSFCell cell) {

        FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator(); // 수식 계산 시 필요

        DecimalFormat df = new DecimalFormat();

        String value = null;
        switch (cell.getCellType()) {
            case XSSFCell.CELL_TYPE_FORMULA:
//              value = cell.getCellFormula();
//              break;
                if(!(cell.toString().equalsIgnoreCase("")) ){
                    if(evaluator.evaluateFormulaCell(cell)==XSSFCell.CELL_TYPE_NUMERIC){
                        double fddata = cell.getNumericCellValue();
                        //value = "" + df.format(fddata);
                        value = df.format(fddata);
                    }else if(evaluator.evaluateFormulaCell(cell)==XSSFCell.CELL_TYPE_STRING){
                        //value = "" + cell.getStringCellValue();
                        value = cell.getStringCellValue();
                    }else if(evaluator.evaluateFormulaCell(cell)==XSSFCell.CELL_TYPE_BOOLEAN){
                        boolean fbdata = cell.getBooleanCellValue();
                        //value = "" + String.valueOf(fbdata);
                        value = String.valueOf(fbdata);
                    }
                    return value;
                    //break;
                }
            case XSSFCell.CELL_TYPE_NUMERIC:
//              value = "" + cell.getNumericCellValue();
//              break;
                //if(DateUtil.isCellDateFormatted(cell)) {
                    //value = "" + cell.getDateCellValue().toString();
                //    value = cell.getDateCellValue().toString();
                //} else {
                    //value = "" + Integer.toString((int)cell.getNumericCellValue());
                    value = Integer.toString((int)cell.getNumericCellValue());
                //}
                return value;
                //break;

            case XSSFCell.CELL_TYPE_STRING:
                //value = "" + cell.getStringCellValue();
                value = cell.getStringCellValue();
                return value;
                //break;
            case XSSFCell.CELL_TYPE_BLANK:
                //value = "[null 아닌 공백]";
                //value = " ";
                value = " ";
                return value;
                //break;
            case XSSFCell.CELL_TYPE_ERROR:
                //value = "" + cell.getErrorCellValue();
                value = String.valueOf(cell.getErrorCellValue());
                return value;
                //break;
            default:
        }
//        System.out.print(value + "\t");

        return value;
    }

    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "BD_fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        DmandExaminVO dmandExaminVO = new DmandExaminVO();

        if (Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=/korean/pt/register/BD_dmandExamin.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);

        } else {

            dmandExaminVO.setUserId(userLoginVO.getUserId());

        }

        int affected = dmandExaminService.fileDelete(fileVO);

        if(affected > 0) {

            Integer key1 = dmandExaminService.deleteDmandExaminDetail(userLoginVO.getUserId());

            if (key1 >= 0) {
                Integer key2 = dmandExaminService.dmandExaminSaveAction(dmandExaminVO, -1);
                if (Validate.isNotEmpty(key2)) {
                    //정상삭제 완료
                    return responseJson(model, affected);
                }
            }

        }
        //삭제 실패
        return responseJson(model, StringUtil.ZERO);
    }
    
    /**
     * 마스터/서브관리 리스트
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "BD_subList.do")
    public String subList(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        
        //변경소스
        String hostNm = "korean";
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_subList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
            vo.setUserId(userLoginVO.getUserId());
        }
        
        if(!userLoginVO.getMasterId().equals(userLoginVO.getUserId())){
            return alertAndBack(model, MessageHelper.getMsg(request, "noCeartAuth2"));
        }
 
        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return confirmAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/korean/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=410");          
        }  
        
        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        model.addAttribute(GlobalConfig.KEY_PAGER, registerService.subList(vo));
        return requestUrl(request) + "/BD_subList";

    }
    
    /**
     * 마스터/서브관리 등록폼
     */
    @RequestMapping(value = "BD_subForm.do")
    public String subFrom(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        String hostNm = "korean";
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
     // 로그인 회원 체크
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_subList.do"; 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
            vo.setUserId(userLoginVO.getUserId());
        }
        
        if(!userLoginVO.getMasterId().equals(userLoginVO.getUserId())){
            return alertAndBack(model, MessageHelper.getMsg(request, "noCeartAuth2"));
        }
        return requestUrl(request) + "/BD_subForm";
    }
   
    /**
     * 마스터/서브관리 사용자검색 팝업
     */
    @RequestMapping(value = "PD_searchUser.do")
    public void searchUser(ModelMap model, HttpServletRequest request, @ModelAttribute RegisterUserVO vo) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, userLoginVo);
    }
    
    /**
     * 마스터/서브관리 사용자검색 팝업 - 조회
     */
    @RequestMapping(value = "PD_searchUserList.do")
    public String searchUserList(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String hostNm = "korean";
        String baseURL = getBaseUrl(model,hostNm) ;
        if(Validate.isEmpty(userLoginVo)) {
            String returnUrl = "?returnUrl=" + baseURL + "/BD_subForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }
        
        vo.setMasterId(userLoginVo.getUserId());
        model.addAttribute("userList", registerService.searchUserList(vo));
        return requestUrl(request) + "/PD_searchUser"; 
    }
    
    /**
     * 마스터/서브관리 서브등록
     */
    @RequestMapping(value = "BD_updateSubForm.do")
    public String updateSubFormAction(ModelMap model, HttpServletRequest request, RegisterUserVO vo ){
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setMasterId(userLoginVo.getUserId());
        vo.setUserTyCd(userLoginVo.getUserTyCd());
        
        int result = registerService.updateMasterId(vo);
        if(result >= StringUtil.ONE){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
    }
    
    /**
     * 마스터/서브관리 서브삭제
     */
    @RequestMapping(value = "BD_deleteSubForm.do")
    public String deleteSubForm(ModelMap model, HttpServletRequest request, RegisterUserVO vo ){
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setMasterId(userLoginVo.getUserId());

        int result = registerService.deleteSubForm(vo, request);
        if(result >= StringUtil.ONE){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
    }
    
    /* 공급자 씨앗 공급자 정보관리 리스트 출력*/
    @RequestMapping(value = "BD_suppliIndex.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String supplierInfo(HttpServletRequest request, ModelMap model, SupplierInfoVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
    
        //로그인 체크 
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl="+ requestUrl(request) +"/BD_suppliIndex.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }
       
        /* 판매권한 체크 20170111 */
       /* if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return confirmAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/korean/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=410");    
        }*/
        
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) { //판매자회원이 아닌경우
            Map<String, Object> map = new HashMap<String, Object>(); 
            map.put("Q_USERID", userLoginVO.getUserId());               //등록 id        
            int maxSeq = registerService.getBassAgremMaxSeq(map);
        
            if(maxSeq > 1){
                BassAgremVO vvo = new BassAgremVO();
                vvo.setBassAgremManageSeq(maxSeq);
                vvo.setUserId(userLoginVO.getUserId());
                vvo=  registerService.bassAgremView(vvo); 
                if (vvo.getAgremStatCd() != 1004 && vvo.getAgremStatCd() != 1005 )
                    return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
            }else {
                return confirmAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/korean/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=410");
            }
        }
        
        /* 마스터권한자 체크*/
        if(!userLoginVO.getMasterId().equals(userLoginVO.getUserId())){
            return alertAndBack(model, MessageHelper.getMsg(request, "noCeartAuth2"));
        }
        
        OpHelper.bindSearchMap(vo, request);
        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        model.addAttribute(GlobalConfig.KEY_PAGER, registerService.supplierInfoList(vo));
        
        model.addAttribute("chkRegistTerm", registerService.chkRegistTerm()); // 등록기간 체크, 0 일때만 등록가능
        
        return requestUrl(request) +"/BD_suppliIndex";
    }        

    
    /* 마이 씨앗 협약체결정보 관리 리스트 출력*/
    @RequestMapping(value = "BD_agreementIndex.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String agreementInfo(HttpServletRequest request, ModelMap model, SupplierInfoVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
    
        //로그인 체크 
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl="+ requestUrl(request) +"/BD_agreementInfo.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }
       
        
        OpHelper.bindSearchMap(vo, request);
        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        model.addAttribute(GlobalConfig.KEY_PAGER, registerService.supplierInfoList(vo));
        return requestUrl(request) +"/BD_agreementIndex";
    }        

    
    
    @RequestMapping(value ="BD_suppliModify.do", method=RequestMethod.POST )
    public String suppliModify(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        //로그인 회원 체크
        if(Validate.isEmpty(userLoginVO)) {
          String returnUrl = "?returnUrl=" + requestUrl(request) + "/"; 
          return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        if(vo.getBassAgremManageSeq() < 1) 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "isNotValidLink"),"/");
        
        vo.setUserId(userLoginVO.getUserId());
        uvo.setUserId(userLoginVO.getUserId());
        model.addAttribute("cmpnyLocaList", registerService.prvCodeList("00", 2036)); // 공통코드의 소제지 목록
        
        BassAgremVO bvo = new BassAgremVO();
        bvo=  registerService.bassAgremView(vo);        
        
        if(bvo == null) 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "isNotValidLink"),"/");
        
        String page ="";
        if (bvo.getAgremStatCd() == 1004 || bvo.getAgremStatCd() == 1005 )
            page="/BD_suppliViewCheck";
        else 
            page="/BD_suppliView";
        
        model.addAttribute("screenType", "myPage"); // 공통코드의 소제지 목록
        model.addAttribute("bassAgrem", bvo);
        model.addAttribute("svcStror", registerService.svcStrorView(uvo));
        return requestUrl(request) + page;
    }
    /**
     * 공급자정보관리 등록폼
     */
    @RequestMapping(value ="BD_suppliView.do", method=RequestMethod.POST )
    public String suppliView(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
      
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        //로그인 회원 체크
        if(Validate.isEmpty(userLoginVO)) {
          String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_suppliIndex.do"; 
          return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        if(vo.getBassAgremManageSeq() < 1) 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "isNotValidLink"),"/");
        
        vo.setUserId(userLoginVO.getUserId());
        uvo.setUserId(userLoginVO.getUserId());
        model.addAttribute("cmpnyLocaList", registerService.prvCodeList("00", 2036)); // 공통코드의 소제지 목록
        
        BassAgremVO bvo = new BassAgremVO();
        bvo=  registerService.bassAgremView(vo);        
        
        if(bvo == null) 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "isNotValidLink"),"/");
        
        String page ="";
        if (bvo.getAgremStatCd() == 1004 || bvo.getAgremStatCd() == 1005 )
            page="/BD_suppliViewCheck";
        else 
            page="/BD_suppliView";
        
        model.addAttribute("screenType", "forSale"); // 공통코드의 소제지 목록
        model.addAttribute("bassAgrem", bvo);
        model.addAttribute("svcStror", registerService.svcStrorView(uvo));
        return requestUrl(request) + page;
    }
    
    @RequestMapping(value = "BD_supplinewForm.do", method=RequestMethod.POST )
    public String BD_supplinewForm(HttpServletRequest request, ModelMap model, RegisterUserVO uvo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        //로그인 회원 체크
        if(Validate.isEmpty(userLoginVO)) {
          String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_suppliIndex.do"; 
          return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        /* 마스터권한자 체크*/
        if(!userLoginVO.getMasterId().equals(userLoginVO.getUserId())){
            return alertAndBack(model, MessageHelper.getMsg(request, "noCeartAuth2"));
        }
        
        BassDegreeManageVO mvo  =  registerService.degreeInfo();
        
        if (mvo == null )
            return alertAndRedirect(model, "연장(재)신청기간이 아닙니다. 관리자에게 문의하시기 바랍니다.","/korean/pt/register/BD_suppliIndex.do" );
                
        Map<String, Object> map = new HashMap<String, Object>(); 
         map.put("Q_DEGREE", Integer.toString(mvo.getBassDegree())); //차수
         map.put("Q_USERID", userLoginVO.getUserId());               //등록 id
        if (registerService.supplierInfoCnt(map) > 0)                //등록신청확인
            return alertAndRedirect(model, mvo.getBassDegree()+"차  연장(재)신청을 하셨습니다.","/korean/pt/register/BD_suppliIndex.do" );
        
        model.addAttribute("degreeInfo", mvo);  //차수정보         
        model.addAttribute("cmpnyLocaList", registerService.prvCodeList("00", 2036)); // 공통코드의 소제지 목록
        uvo.setUserId(userLoginVO.getUserId());
        model.addAttribute("svcStror", registerService.svcStrorView(uvo));
        return requestUrl(request) + "/BD_supplinewForm";
    } 
    

    @RequestMapping(value = "BD_suppliForm.do", method=RequestMethod.POST )
    public String BD_suppliForm(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        //로그인 회원 체크
        if(Validate.isEmpty(userLoginVO)) {
          String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_suppliIndex.do"; 
          return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        /* 마스터권한자 체크*/
        if(!userLoginVO.getMasterId().equals(userLoginVO.getUserId())){
            return alertAndBack(model, MessageHelper.getMsg(request, "noCeartAuth2"));
        }
        
        BassDegreeManageVO mvo  =  registerService.degreeInfo();
        
        if (mvo == null )
            return alertAndRedirect(model, "연장(재)신청기간이 아닙니다. 관리자에게 문의하시기 바랍니다.","/korean/pt/register/BD_suppliIndex.do" );
                
        Map<String, Object> map = new HashMap<String, Object>(); 
         map.put("Q_DEGREE", Integer.toString(mvo.getBassDegree())); //차수
         map.put("Q_USERID", userLoginVO.getUserId());               //등록 id
        if (registerService.supplierInfoCnt(map) > 0)                //등록신청확인
            return alertAndRedirect(model, mvo.getBassDegree()+"차  연장(재)신청을 하셨습니다.","/korean/pt/register/BD_suppliIndex.do" );
        
        model.addAttribute("degreeInfo", mvo);  //차수정보         
        model.addAttribute("cmpnyLocaList", registerService.prvCodeList("00", 2036)); // 공통코드의 소제지 목록
        uvo.setUserId(userLoginVO.getUserId());
        model.addAttribute("svcStror", registerService.svcStrorView(uvo));
        //model.addAttribute("agoBassAgrem", registerService.agoBassAgremView(vo)); // 기존차수의 구비서류정보만 받아온다.
        
        vo.setUserId(userLoginVO.getUserId());
        BassAgremVO vvo = registerService.bassAgremView(vo);
        model.addAttribute("bassAgremView",vvo ); // 기존차수의 구비서류정보만 받아온다. 
        
        return requestUrl(request) + "/BD_suppliForm";
    } 
   
    
    @RequestMapping(value = "BD_suppliUpdateAction.do", method=RequestMethod.POST )
    public String SuppliUpdateAction(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //로그인 회원 체크
        if(Validate.isEmpty(userLoginVo)) {
          String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_suppliIndex.do"; 
          return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        }
       
        vo.setUserId(userLoginVo.getUserId());
        uvo.setUserId(userLoginVo.getUserId());
        
        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, BASS_AGREM_FILE);
        
        // 처리 파일 VO 선언
        List<FileVO> multiFiles             = new ArrayList<FileVO>();        // 기업로그
        List<FileVO> bassAgrmntFile         = new ArrayList<FileVO>();        // 기본협약서
        List<FileVO> rgsbukTrnscrFile       = new ArrayList<FileVO>();        // 등기부등본
        List<FileVO> vnentrCrtfFile         = new ArrayList<FileVO>();        // 벤처기업증명서
        List<FileVO> directPrdctnCrtfFile   = new ArrayList<FileVO>();        // 직접생산증명서
        List<FileVO> cdltDocFile            = new ArrayList<FileVO>();        // 신용평가서
        List<FileVO> fnlttFile              = new ArrayList<FileVO>();        // 재무제표
        
        /** STEP1) File VO 바인딩 - 시작 ********************/
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();
            if (inputNm.startsWith("multiFiles")) multiFiles.add(uploadFile.get(i)); // 기업로그
            if (inputNm.startsWith("bassAgrmntFile")) bassAgrmntFile.add(uploadFile.get(i)); // 기본협약서
            if (inputNm.startsWith("rgsbukTrnscrFile")) rgsbukTrnscrFile.add(uploadFile.get(i)); // 등기부등본
            if (inputNm.startsWith("vnentrCrtfFile")) vnentrCrtfFile.add(uploadFile.get(i)); // 벤처기업증명서
            if (inputNm.startsWith("directPrdctnCrtfFile")) directPrdctnCrtfFile.add(uploadFile.get(i));  // 직접생산증명서
            if (inputNm.startsWith("cdltDocFile")) cdltDocFile.add(uploadFile.get(i)); // 신용평가서
            if (inputNm.startsWith("fnlttFile")) fnlttFile.add(uploadFile.get(i)); // 재무제표            
        }

        // VO 에 바인딩
        vo.setMultiFile(multiFiles);                        // 기업로그
        vo.setBassAgrmntFile(bassAgrmntFile);               // 기본협약서
        vo.setRgsbukTrnscrFile(rgsbukTrnscrFile);           // 등기부등본
        vo.setVnentrCrtfFile(vnentrCrtfFile);               // 벤처기업증명서
        vo.setDirectPrdctnCrtfFile(directPrdctnCrtfFile);   // 직접생산증명서
        vo.setCdltDocFile(cdltDocFile);                     // 신용평가서
        vo.setFnlttFile(fnlttFile);                         // 재무제표
        
        vo.setTelno(vo.getTelno());                         // 대표전화        
        vo.setAgremStatCd(vo.getAgremStatCd());             // 소재지      
        vo.setAgremStat(vo.getAgremStat());                 // 공급자 신청 상태
        
        int key = registerService.bassAgremUpdateAction(vo);
        
        /*
        registerService.updateUserTyCd(uvo);  횐원정보변경 */
        
        uvo.setUserTyCd(2002);
        uvo.setCmpnyTelno(vo.getTelno());
        registerService.updateUserOpt(uvo); // 회원정보옵션수정 
        
        // 스토어정보 등록
        uvo.setStoreImageFileSeq(vo.getMultiFileSeq());
        if(registerService.selectStoreCnt(uvo) > 0) {
            registerService.updateStoreData(uvo); //스토어정보수정
        }
        else {
            registerService.insertStoreData(uvo); //스토어정보등록
        }
        
        if(key <= 0){
            return alertAndRedirect(model, "보완 신청하는데 실패했습니다. 관리자에게 문의하시기 바랍니다.", requestUrl(request) + "/BD_suppliIndex.do");
        }

        if(vo.getScreenType().equals("myPage"))
            return alertAndRedirect(model, "보완 신청이 완료되었습니다.", requestUrl(request) + "/BD_agreementIndex.do");
        else
            return alertAndRedirect(model, "보완 신청이 완료되었습니다.", requestUrl(request) + "/BD_suppliIndex.do");
    }
    
    @RequestMapping(value = "BD_suppliInsertAction.do", method=RequestMethod.POST )
    public String SuppliInsertAction(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //로그인 회원 체크
        if(Validate.isEmpty(userLoginVo)) {
          String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_suppliIndex.do"; 
          return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        /* 마스터권한자 체크*/
        if(!userLoginVo.getMasterId().equals(userLoginVo.getUserId())){
            return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
        }
        
        vo.setUserId(userLoginVo.getUserId());
        uvo.setUserId(userLoginVo.getUserId());
        
        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, BASS_AGREM_FILE);
        
        // 처리 파일 VO 선언
        List<FileVO> multiFiles             = new ArrayList<FileVO>();        // 기업로그
        List<FileVO> bassAgrmntFile         = new ArrayList<FileVO>();        // 기본협약서
        List<FileVO> rgsbukTrnscrFile       = new ArrayList<FileVO>();        // 등기부등본
        List<FileVO> vnentrCrtfFile         = new ArrayList<FileVO>();        // 벤처기업증명서
        List<FileVO> directPrdctnCrtfFile   = new ArrayList<FileVO>();        // 직접생산증명서
        List<FileVO> cdltDocFile            = new ArrayList<FileVO>();        // 신용평가서
        List<FileVO> fnlttFile              = new ArrayList<FileVO>();        // 재무제표

        /** STEP1) File VO 바인딩 - 시작 ********************/
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if (inputNm.startsWith("multiFiles")) multiFiles.add(uploadFile.get(i)); // 기업로그
            if (inputNm.startsWith("bassAgrmntFile")) bassAgrmntFile.add(uploadFile.get(i)); // 기본협약서
            if (inputNm.startsWith("rgsbukTrnscrFile")) rgsbukTrnscrFile.add(uploadFile.get(i)); // 등기부등본
            if (inputNm.startsWith("vnentrCrtfFile")) vnentrCrtfFile.add(uploadFile.get(i)); // 벤처기업증명서
            if (inputNm.startsWith("directPrdctnCrtfFile")) directPrdctnCrtfFile.add(uploadFile.get(i));  // 직접생산증명서
            if (inputNm.startsWith("cdltDocFile")) cdltDocFile.add(uploadFile.get(i)); // 신용평가서
            if (inputNm.startsWith("fnlttFile")) fnlttFile.add(uploadFile.get(i)); // 재무제표          
        }

        // VO 에 바인딩
        vo.setMultiFile(multiFiles);                      // 기업로그
        vo.setBassAgrmntFile(bassAgrmntFile);             // 기본협약서
        vo.setRgsbukTrnscrFile(rgsbukTrnscrFile);         // 등기부등본
        vo.setVnentrCrtfFile(vnentrCrtfFile);             // 벤처기업증명서
        vo.setDirectPrdctnCrtfFile(directPrdctnCrtfFile); // 직접생산증명서
        vo.setCdltDocFile(cdltDocFile);                   // 신용평가서
        vo.setFnlttFile(fnlttFile);                       // 재무제표

        /** STEP2) 등록 - 시작 **************************/
        //협약서 저장  
        
        if (vo.getAgremStatCd() != 1001)
            return alertAndRedirect(model, MessageHelper.getMsg(request, "isNotValidLink"),"/");
        
        vo.setRegistId(userLoginVo.getUserId());        
        Integer key = registerService.bassAgremInsertAction(vo);

        uvo.setUserTyCd(2002);
        uvo.setCmpnyTelno(vo.getTelno());
        registerService.updateUserOpt(uvo); /* 회원정보옵션수정 */
        
        // 스토어정보 등록
         uvo.setStoreImageFileSeq(vo.getMultiFileSeq());
        if(registerService.selectStoreCnt(uvo) > 0) {
            registerService.updateStoreData(uvo); /*스토어정보수정*/
        }
        else {
            registerService.insertStoreData(uvo); /*스토어정보등록*/
        }
        
        /** STEP2) 등록 - 끝 ****************************/
        if(key <= 0){
            return alertAndRedirect(model, "신청하는데 실패했습니다. 관리자에게 문의하시기 바랍니다.", requestUrl(request)+ "/BD_suppliIndex.do");
        }

        return alertAndRedirect(model, "신청이 완료되었습니다.", requestUrl(request) + "/BD_suppliIndex.do");
    }
    
    @RequestMapping(value = "BD_suppliInsertNewAction.do", method=RequestMethod.POST )
    public String SuppliInsertNewAction(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //로그인 회원 체크
        if(Validate.isEmpty(userLoginVo)) {
          String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_suppliIndex.do"; 
          return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/korean/pt/login/user/BD_index.do" + returnUrl);
        }
        
        /* 마스터권한자 체크*/
        if(!userLoginVo.getMasterId().equals(userLoginVo.getUserId())){
            return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
        }
        
        vo.setUserId(userLoginVo.getUserId());
        uvo.setUserId(userLoginVo.getUserId());
        
        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, BASS_AGREM_FILE);
        
        // 처리 파일 VO 선언
        List<FileVO> multiFiles             = new ArrayList<FileVO>();        // 기업로그
        List<FileVO> bassAgrmntFile         = new ArrayList<FileVO>();        // 기본협약서
        List<FileVO> rgsbukTrnscrFile       = new ArrayList<FileVO>();        // 등기부등본
        List<FileVO> vnentrCrtfFile         = new ArrayList<FileVO>();        // 벤처기업증명서
        List<FileVO> directPrdctnCrtfFile   = new ArrayList<FileVO>();        // 직접생산증명서
        List<FileVO> cdltDocFile            = new ArrayList<FileVO>();        // 신용평가서
        List<FileVO> fnlttFile              = new ArrayList<FileVO>();        // 재무제표

        /** STEP1) File VO 바인딩 - 시작 ********************/
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if (inputNm.startsWith("multiFiles")) multiFiles.add(uploadFile.get(i)); // 기업로그
            if (inputNm.startsWith("bassAgrmntFile")) bassAgrmntFile.add(uploadFile.get(i)); // 기본협약서
            if (inputNm.startsWith("rgsbukTrnscrFile")) rgsbukTrnscrFile.add(uploadFile.get(i)); // 등기부등본
            if (inputNm.startsWith("vnentrCrtfFile")) vnentrCrtfFile.add(uploadFile.get(i)); // 벤처기업증명서
            if (inputNm.startsWith("directPrdctnCrtfFile")) directPrdctnCrtfFile.add(uploadFile.get(i));  // 직접생산증명서
            if (inputNm.startsWith("cdltDocFile")) cdltDocFile.add(uploadFile.get(i)); // 신용평가서
            if (inputNm.startsWith("fnlttFile")) fnlttFile.add(uploadFile.get(i)); // 재무제표          
        }

        // VO 에 바인딩
        vo.setMultiFile(multiFiles);                      // 기업로그
        vo.setBassAgrmntFile(bassAgrmntFile);             // 기본협약서
        vo.setRgsbukTrnscrFile(rgsbukTrnscrFile);         // 등기부등본
        vo.setVnentrCrtfFile(vnentrCrtfFile);             // 벤처기업증명서
        vo.setDirectPrdctnCrtfFile(directPrdctnCrtfFile); // 직접생산증명서
        vo.setCdltDocFile(cdltDocFile);                   // 신용평가서
        vo.setFnlttFile(fnlttFile);                       // 재무제표

        /** STEP2) 등록 - 시작 **************************/
        //협약서 저장  
        
        if (vo.getAgremStatCd() != 1001)
            return alertAndRedirect(model, MessageHelper.getMsg(request, "isNotValidLink"),"/");
        
        vo.setRegistId(userLoginVo.getUserId());        
        Integer key = registerService.bassAgremInsertNewAction(vo);

        uvo.setUserTyCd(2002);
        uvo.setCmpnyTelno(vo.getTelno());
        registerService.updateUserOpt(uvo); /* 회원정보옵션수정 */
        
        // 스토어정보 등록
         uvo.setStoreImageFileSeq(vo.getMultiFileSeq());
        if(registerService.selectStoreCnt(uvo) > 0) {
            registerService.updateStoreData(uvo); /*스토어정보수정*/
        }
        else {
            registerService.insertStoreData(uvo); /*스토어정보등록*/
        }
        
        /** STEP2) 등록 - 끝 ****************************/
        if(key <= 0){
            return alertAndRedirect(model, "신청하는데 실패했습니다. 관리자에게 문의하시기 바랍니다.", requestUrl(request)+ "/BD_suppliIndex.do");
        }

        return alertAndRedirect(model, "신청이 완료되었습니다.", requestUrl(request) + "/BD_suppliIndex.do");
    }
    
    
    /**
     * 공급자정보관리 보완신청 
     *
     * @param request
     * @param model
     */
    @RequestMapping(value = "ND_BassAgremUpdateAction.do", method=RequestMethod.POST )
    public String agremStatAction(HttpServletRequest request, ModelMap model, BassAgremVO vo, RegisterUserVO uvo) {
        
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVo.getUserId());
        uvo.setUserId(userLoginVo.getUserId());
        
        model.addAttribute("cmpnyLocaList", registerService.prvCodeList("00", 2036)); // 공통코드의 소제지 목록
        
        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, BASS_AGREM_FILE);
        
        // 처리 파일 VO 선언
        List<FileVO> multiFiles             = new ArrayList<FileVO>();        // 기업로그
        List<FileVO> bassAgrmntFile         = new ArrayList<FileVO>();        // 기본협약서
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

            // 기업로그
            if (inputNm.startsWith("multiFiles")) {
                multiFiles.add(uploadFile.get(i));
            }
            
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
        vo.setMultiFile(multiFiles);                        // 기업로그
        vo.setBassAgrmntFile(bassAgrmntFile);               // 기본협약서
        vo.setRgsbukTrnscrFile(rgsbukTrnscrFile);           // 등기부등본
        vo.setVnentrCrtfFile(vnentrCrtfFile);               // 벤처기업증명서
        vo.setDirectPrdctnCrtfFile(directPrdctnCrtfFile);   // 직접생산증명서
        vo.setCdltDocFile(cdltDocFile);                     // 신용평가서
        vo.setFnlttFile(fnlttFile);                         // 재무제표
        
        vo.setTelno(vo.getTelno());                         // 대표전화        
        vo.setAgremStatCd(vo.getAgremStatCd());             // 소재지      
        vo.setBassAgremManageSeq(vo.getBassAgremManageSeq());  // 기본협약관리순번        
        vo.setAgremStat(vo.getAgremStat());                 // 공급자 신청 상태
        
        //Integer key = registerService.bassAgremStatAction(vo);
        int key = registerService.bassAgremStatAction(vo);
        
        
        // 회원유형변경( 일반 > 공급자 )
        if(userLoginVo.getUserTyCd().toString().startsWith("10")) {
            uvo.setUserTyCd(1002);
            uvo.setCmpnyTelno(vo.getTelno());
        }
        // 회원유형변경( 기업 > 공급자 )
        else if(userLoginVo.getUserTyCd().toString().startsWith("20")) {
            uvo.setUserTyCd(2002);
            uvo.setCmpnyTelno(vo.getTelno());
        }
        // 회원유형변경( 공공 > 공급자 )
        else if(userLoginVo.getUserTyCd().toString().startsWith("30")) {
            uvo.setUserTyCd(3002);
            uvo.setPblinsttNm(vo.getCmpnyNm());
            uvo.setBizrno(vo.getBizrno());
            uvo.setPblinsttTelno(vo.getTelno());
        }
        registerService.updateUserTyCd(uvo); /* 횐원정보변경 */
        registerService.updateUserOpt(uvo); /* 회원정보옵션수정 */

        // 스토어정보 등록
        uvo.setStoreImageFileSeq(vo.getMultiFileSeq());
        if(registerService.selectStoreCnt(uvo) > 0) {
            registerService.updateStoreData(uvo); /*스토어정보수정*/
        }
        else {
            registerService.insertStoreData(uvo); /*스토어정보등록*/
        }
        
        /************************************************/
        /** STEP2) 등록 - 끝 ****************************/
        /************************************************/
        
        if(key <= 0){
            return alertAndRedirect(model, MessageHelper.getMsg(request, "checksellerN"), requestUrl(request) + "/BD_index.do");
        }

        return alertAndRedirect(model, MessageHelper.getMsg(request, "checksellerY"), requestUrl(request) + "/BD_complete.do?userTyCd2="+ uvo.getUserTyCd());
        //return alertAndRedirect(model, MessageHelper.getMsg(request, "uploadFileY"), requestUrl(request) + "/BD_NICEAgree.do");
    }


    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_useYnUpdateState.do", method = RequestMethod.POST)
    public String useYnUpdateState(ModelMap model, FileVO fileVO, HttpServletRequest request, WebGoodsManageVO goodsVo) {
        // setBoardService(request); // 게시판 유형 서비스 설정
        int affected = 0;
//        int markingInfoDeleteCount = service.deleteTstGoodMarkIInt(goodsVo, request);
        
//        int affected = service.fileDelete(fileVO);

//        if(affected < 1) {
//            return responseJson(model, StringUtil.ZERO);
//        }

        return responseJson(model, affected);
    }    

    
}