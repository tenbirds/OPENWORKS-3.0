/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc.
 */
package zes.openworks.web.communication.community;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
//import java.util.HashMap;
import java.util.List;
//import java.util.Map;


import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

//import zes.base.auth.AuthType;
//import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
//import zes.core.spi.commons.configuration.Config;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.loginCheck.LoginCheckReturn;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;


/**
 *
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 11. 11.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "**/pt/communication/community")
public class CmTotalMainController extends WebController {

	@Autowired
	CmTotalMainService cmTotalMainService;

	@Autowired
	CmManageService cmManageService;

	@Autowired
	CodeService codeService;

	@Autowired
	CommonDutyService commonDutyService;

	@Autowired
	SmsTransHistService smsService;
	@Autowired
	AutoMailService amservice;
	/**
	 * 커뮤니케이션 커뮤니티 전체 목록
	 */
	@RequestMapping(value = {"BD_index.do","BD_index1001.do","BD_index1002.do","BD_index1003.do","BD_index1004.do","BD_index1005.do","BD_index1006.do","BD_index1007.do","BD_index1008.do","BD_index1009.do","BD_index1010.do","BD_index1011.do","BD_index1012.do"})
	public String  cmTotalIndex (HttpServletRequest request, ModelMap model, CmManageVO vo){

		OpHelper.bindSearchMap(vo, request);

		String StrCmmntyCtgryCd =   request.getParameter("cmmntyCtgryCd") != null ? request.getParameter("cmmntyCtgryCd") : "0";
		String hostNm = CmsUtil.getHostName(request.getServerName());
		String StrCmmntyCtgryCd2 ="";
		String retrunUrl ="";
		//retrunUrl =  hostNm+ "/pt/communication/community/BD_index";
		
		/*{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 */
		retrunUrl =  "korean/pt/communication/community/BD_index"; 
		//}}
		
		// 도메인코드
		String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
		vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
		if(Integer.parseInt(StrCmmntyCtgryCd) != 0){
			StrCmmntyCtgryCd2 = StrCmmntyCtgryCd;
		}
		vo.setCmmntyCtgryCd(Integer.parseInt(StrCmmntyCtgryCd));
		vo.setCmmntySttusCd(1002); //1001 신청 1002 승인 1003 거절  1004 폐쇄 1005 폐쇄중
		//cvo.setLangCode("");
		//model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기
		model.addAttribute("cmmntyCtgryCd", StrCmmntyCtgryCd2);
		model.addAttribute(GlobalConfig.KEY_PAGER, cmTotalMainService.cmTotalMainList(vo));
		return retrunUrl;
	}

	/**
	 * 커뮤니케이션 커뮤니티 등록 폼
	 */
	@RequestMapping(value = "BD_cmOpenForm.do")
	public void cmOpenInsertForm(HttpServletRequest request, ModelMap model, CmManageVO vo, CmManageBoardVO cmbvo, CodeVO cvo){

		OpHelper.bindSearchMap(vo, request);
		OpHelper.bindSearchMap(cmbvo, request);

		UserLoginVO userLoginVo = OpHelper.getUserSession(request);

		String hostNm = CmsUtil.getHostName(request.getServerName());


		// 도메인코드
		String domainCode = new CommonDutyConstant().getDomainCode(hostNm);

		vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
		

		vo.setCmmntySttusCd(1002); //1001 신청 1002 승인 1003 거절  1004 폐쇄 1005 폐쇄중

		model.addAttribute("userId",userLoginVo.getUserId());//
//        model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기
		model.addAttribute("langCode",vo.getLangCode());
		model.addAttribute(GlobalConfig.KEY_PAGER, cmTotalMainService.cmTotalMainList(vo));
	}

	/**
	 *  커뮤니티 개설신청
	 *
	 */
	@RequestMapping(value = "INC_openCmUserInsert.do")
	public String openCmManageUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

		String StrResult1 = "";

		UserLoginVO userLoginVo = OpHelper.getUserSession(request);

		// 이전소스
		//String hostNm = CmsUtil.getHostName(request.getServerName());
		

		//{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경 
		//변경소스
		String hostNm = "korean";
		//}}
		
//        String rtnurl = ""; //

		// 도메인코드
		String domainCode = new CommonDutyConstant().getDomainCode(hostNm);

		vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
		
		/* 2016.05.26 BH.YANG 커뮤니티 개설 신청 시 서브URL주소 삽입 방법 변경*/
		String strCmmntySubUrl = GlobalConfig.DOMAIN_SUBNM + "/community/";
		/* }} */
		String strCmmntyUrl = vo.getCmmntyUrl();
		
		vo.setCmmntyId(strCmmntyUrl); // 중복체크와 맞물리는 증상이 있는 관계로 다시 설정
		vo.setCmmntyUrl(strCmmntySubUrl + strCmmntyUrl);
		vo.setUserId(userLoginVo.getUserId());
	   // vo.setMngrClsAt("N");
		vo.setEstblReqstId(userLoginVo.getUserId());
		vo.setLogoTitleNo(1);
		StrResult1 = cmTotalMainService.openCmUserInsert(request, vo); // 개설 신청 승인
		

		if("Y".equals(StrResult1)){
			/** 매일발송 시작 **/
			Map<String, Object> autoMap = new HashMap<String, Object>();
			boolean result = false;
			/* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
			int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
			if(intJoinSiteDivCd == 2001 || intJoinSiteDivCd == 2002) { // 한국어사이트
				autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_ESTB);
			}
			List<CmManageVO> cmMngrInfoSelet = cmManageService.cmMngrInfoSelet(vo);
			if(cmMngrInfoSelet != null){
				for(int i=0; i<cmMngrInfoSelet.size(); i++){
					CmManageVO cvoList = cmMngrInfoSelet.get(i);

					// 전송할 메일 정보 입력
					autoMap.put("receiverName", cvoList.getMngrNm()); // 수신자명
					autoMap.put("email", cvoList.getMngrEmail()); // 수신이메일주소

					/* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
					HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
					if("".equals(hostNm) || "www".equals(hostNm)) {
						hostNm = "korean";
					}
					//rtnurl = "http://" + hostNm + "ceart.kr/" + hostNm + "/cm/user/cmUserMain/BD_index.do?" + vo.getCmmntyId();
					// 치환내용 입력(메일 종류에 따라 선택적으로 입력)
					oneToOneInfoMap.put("rtnurl", vo.getCmmntyUrl());
					oneToOneInfoMap.put("name", userLoginVo.getUserNm());
					oneToOneInfoMap.put("phone", userLoginVo.getMbtlnum());
					oneToOneInfoMap.put("cmUrl", vo.getCmmntyUrl());
					oneToOneInfoMap.put("cmName", vo.getCmmntyNm());
					oneToOneInfoMap.put("cmCategory", vo.getCmmntyCtgryNm());
					oneToOneInfoMap.put("cmContents", vo.getCmmntyDc());
					oneToOneInfoMap.put("cmRequestReason", vo.getEstblReqstResn());

					// 치환정보 맵 입력
					autoMap.put("oneToOneInfo", oneToOneInfoMap);

					// 선택 입력 항목
					autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

					// EMAIL 발송
					result = amservice.sendAutoMail(autoMap);
					if(result) {
						/*System.out.println("########################################################");
						System.out.println("####커뮤니티개설 신청 E-MAIL : " + cvoList.getEmail() + "," + cvoList.getMngrNm() + "에게 발송 성공#########");
						System.out.println("########################################################");*/
					} else {
						/*System.out.println("########################################################");
						System.out.println("####커뮤니티개설 신청 E-MAIL : " + cvoList.getEmail() + "," + cvoList.getMngrNm() + "에게 발송 실패#########");
						System.out.println("########################################################");*/
					}
				}
			}
			/** 매일발송 끝 **/
			
			/** SMS발송시작 **/
			if(userLoginVo.getMbtlnum() != null){
				Map<String, Object> smsMap = new HashMap<String, Object>();

				//SMS발송 및 전송이력쌓기
				SmsTransHistConstant shc = new SmsTransHistConstant();
				//수신번호-필수
				smsMap.put("rcvNo", userLoginVo.getMbtlnum());
				//발신내용-필수
				if(intJoinSiteDivCd == 2001 || intJoinSiteDivCd == 2002) { // 한국어사이트
					smsMap.put("msg", shc.getSmsMsg("261"));
				} else if(intJoinSiteDivCd == 3001 || intJoinSiteDivCd == 3002) { // 영어사이트
					smsMap.put("msg", shc.getSmsMsg("361"));
				} else if(intJoinSiteDivCd == 4001 || intJoinSiteDivCd == 4002) { // 스페인어사이트
					smsMap.put("msg", shc.getSmsMsg("461"));
				}

				//업무코드
				smsMap.put("dutyCd", "CM");
				boolean smsRst = smsService.smsTransHist(smsMap);
				if(smsRst){
					/*System.out.println("########################################################");
					System.out.println("####커뮤니티개설 신청 SMS : "+userLoginVo.getMbtlnum()+","+userLoginVo.getUserNm()+"에게 발송 성공#########");
					System.out.println("########################################################");*/
				}else{
					/*System.out.println("########################################################");
					System.out.println("####커뮤니티개설 신청 SMS : "+userLoginVo.getMbtlnum()+","+userLoginVo.getUserNm()+"에게 발송 실패#########");
					System.out.println("########################################################");*/
				}
			}
			/** SMS발송끝 **/
			return responseText(model, Messages.TRUE );
		}else{
			return responseText(model,Messages.FALSE );
		}

	}

	/**
	 *  커뮤니티 이름 URL 중복 체크
	 *
	 */
	@RequestMapping(value = "INC_cmNmUrlCheck.do" )
	public String getOpenCmManageCheck(HttpServletRequest request, CmManageVO vo, ModelMap model){

		return responseText(model, cmManageService.getOpenCmManageCheck(vo));
	}


	/**
	 * 로그인 체크
	 */
	@RequestMapping(value = "ND_loginCheckURL.do")
	public String goLoginUrl(HttpServletRequest request, ModelMap model){

		//String hostNm = CmsUtil.getHostName(request.getServerName());

		String returnUri = request.getParameter("nowURL") != null ? request.getParameter("nowURL") : "";
		String StrCmmntyCtgryCd =   request.getParameter("cmmntyCtgryCd") != null ? request.getParameter("cmmntyCtgryCd") : "";
		String returnParam = "" ;
		String returnUrl = returnUri.replaceAll("/WEB-INF/pages/","");
		returnUrl = returnUrl.replaceAll(".jsp",".do");
		/** 로그인 리다이렉트 체크 부분 **/
		LoginCheckReturn loginchk = new LoginCheckReturn();
		//String rtnUrl = new CommonDutyConstant().getRedirectUrl(request);
		if(!"".equals(StrCmmntyCtgryCd)) {
			returnParam = "?cmmntyCtgryCd="+StrCmmntyCtgryCd;
		}
		//String url =returnUrl+"?cmmntyId="+strCmmntyId+"&langCode="+strLangCode;
		String loginUrl = loginchk.LoginCheckRtn(request);
		loginUrl= loginUrl.replaceAll("cm", "pt");
		String message = MessageHelper.getMsg(request, "requiredLogin");
		return responseJson(model, true, loginUrl+"?returnUrl=/"+returnUrl+"&returnParam=" + returnParam, message);
	}


	/**
	 * 업로드 이미지 픽셀 및 크기 체크
	 */
	@RequestMapping(value = "ND_uploadImgChk.do", method = RequestMethod.POST)
	public String uploadIMGCheck(HttpServletRequest request, ModelMap model){
		String inputName = request.getParameter("inputName");
		String fileExtPermit = request.getParameter("fileExt");
		//킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다.
		long maxFileSize = (long) (Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024);

		Float maxWidthSize = (float)Integer.parseInt(request.getParameter("maxWidthSize").isEmpty() != true ? request.getParameter("maxWidthSize") : "0");
		Float maxHeightSize = (float)Integer.parseInt(request.getParameter("maxHeightSize").isEmpty() != true ? request.getParameter("maxHeightSize") : "0");

		int result = 100;   // 100 : 패스
		String message = new String(); //retrun 메시지

		// 이미지 파일 체크
		@SuppressWarnings("unchecked")
		List<MultipartFile> files = (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY);

		if(files != null && !request.getParameter("maxFileSize").isEmpty()) {
			for(int i=0; i < files.size(); i++){
				MultipartFile fileVo = files.get(i);
				if(fileVo.getName().equals(inputName)) {

					String fileType = FileUtil.extension(fileVo.getOriginalFilename());

					if(fileExtPermit.indexOf(fileType) == -1) {
						result = 201; //허용하지 않는 파일유형(확장자)
						break;
					}

					Long fileSize = fileVo.getSize();

					if(maxFileSize > 0 && fileSize > maxFileSize) {
						result = 200; //파일 제한용량초가
						break;
					}else{
						if(maxWidthSize > 0 || maxHeightSize > 0) { //가로나 세로 제한값이 있을 때
							try {
								//BufferedImage bi = ImageIO.read(new File(GlobalConfig.WEBAPP_ROOT + fileVo.getFileUrl()));
								BufferedImage bi = ImageIO.read(fileVo.getInputStream());

								Float imgW = (float)bi.getWidth();
								Float imgH = (float)bi.getHeight();

								if(maxWidthSize > 0 && (maxWidthSize+10) < imgW) { //가로제한 값이 있고 제한값보다 클때
								   result = 301; //가로크기가 제한크기보다 클때
								}

								if(maxHeightSize > 0 && (maxHeightSize+10) < imgH) { //세로제한 값이 있고 제한값보다 클 때
								   result = 302; //세로크기가 제한크기보다 클때
								}

							   // Float ratioValue1 = (float) (maxWidthSize / maxHeightSize);
							   // Float ratioValue2 = (float) (imgW / imgH);

//                                //(maxWidthSize > 0 && maxHeightSize > 0 ) && !ratioValue1.equals(ratioValue2)
//                                if((maxWidthSize > 0 && maxHeightSize > 0 ) && (((ratioValue1-ratioValue2) > 0.05) || ((ratioValue2-ratioValue1) > 0.05))) {
//                                    result = 303; // 가로/세로 비율이 맞지 않음
//                                }

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
		}else{
			result = 500; // 500 : 업로드된 파일이나 최대용량 파라미터 값이 없을때
		}

		switch (result) {
			case 100:
				 message = "100";
				 break;
			case 200:
				 message = "파일의 용량이 "+ (request.getParameter("maxFileSize") != null ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
				 break;
			case 201:
				message = "이미지 파일의 유형(확장자)은 jpg, png 파일만 가능합니다.";
				break;
			case 301:
				 message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다.";
				 break;
			case 302:
				 message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다.";
				 break;
//            case 303:
//                 message = "이미지의 비율이 맞지 않습니다.";
//                 break;
			case 400:
				 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
				 break;
			default:
				 message = "이미지가 확인돼지 않았습니다.";
				 break;

		}

		return responseText(model, message);

	}
}
