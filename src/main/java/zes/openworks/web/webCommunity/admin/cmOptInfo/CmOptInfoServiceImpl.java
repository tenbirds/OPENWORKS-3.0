/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptInfo;

//import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.utils.Converter;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageDAO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardDAO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.web.common.CommonDutyConstant;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


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
 * 2014. 11. 4.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmOptInfoService") 
public class CmOptInfoServiceImpl extends AbstractServiceImpl implements CmOptInfoService{

    @Resource
    private CmManageDAO cmManageDAO;
    
    @Resource
    private CmManageBoardDAO cmBoardDao;
    
    @Resource
    private CmOptInfoDAO dao;
    
    @Resource 
    private FileDAO fileDao;
    
    @Autowired
    private AutoMailService amservice;
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptInfo.CmOptInfoService#cmOptInfoUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmOptInfoUpdate(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub
        
        String strResult ="N";
        int intResult1 = 0;
        String logoYN = vo.getLogoDirectRegistAt();
        int logoFileSeq = vo.getLogoFileSeq();
        
        vo.setMngrClsAt("");
        if("Y".equals(logoYN)){ // LogoDirectRegistAt 
            List<FileVO> fileList  = UploadHelper.upload( request, "cmmntylogo");
            if(fileList.size()> 0){
                fileDao.removeFile(logoFileSeq); // 기존 파일 삭제
                logoFileSeq = fileDao.saveFile(fileList);
            }
            vo.setLogoFileSeq(logoFileSeq);
            vo.setLogoTitleWidthLc(100);
            vo.setLogoTitleVrticlLc(100);
            vo.setLogoTitleFont("batang");
            vo.setLogoTitleColor("000000");
            vo.setLogoTitle("Open Market Place");
            vo.setLogoTitleFontSize(40);
        }else if("N".equals(logoYN)){
            if(logoFileSeq > 1){
                fileDao.removeFile(logoFileSeq);
            }
            vo.setLogoFileSeq(1);
        }
        intResult1 = dao.cmOptInfoUpdate(vo);
        
        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptInfo.CmOptInfoService#closeCmOptInfoUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String closeCmOptInfoUpdate(HttpServletRequest request, CmManageVO vo) throws Exception {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        vo.setCmmntySttusCd(1005); //  1001:신청     1002:승인     1003:승인보류    1004:폐쇄   1005:폐쇄중
        
        String time= "";
        Calendar cal = Calendar.getInstance();
        //time = DateFormatUtil.getDateFull (cal.getTime());
        cal.add(Calendar.DATE,  7 ); // 7일 이후 폐쇄 한다는 날짜 설정
        time = DateFormatUtil.getDateFull (cal.getTime());
        log.info("################7일 이후 time:::::::::::::::::::"+time);
        String strCnSumry=StringUtil.omit(Converter.cleanHtml(StringUtil.replace(vo.getCmmntyClsResn(), "\"", "'")), 900);
        log.info("strCnSumry:::::::::::>>>>>>strCnSumry>>>>>>>>>>"+strCnSumry);
        String strAccessBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        
        String strBbscttSj = "커뮤니티 폐쇄 공지 입니다.";
        String strAccessIpAdres = request.getRemoteAddr();
        CmManageBoardVO boardVO = new CmManageBoardVO ();
        vo.setCmmntyClsDt(time);
        intResult1 = dao.cmOptInfoUpdate(vo);
        
        if(intResult1>0){
            boardVO.setLangCode(vo.getLangCode());
            boardVO.setCmmntyId(vo.getCmmntyId());
            boardVO.setCmmntyMenuCode(vo.getCmmntyMenuCode());
            boardVO.setCmmntyBbsTyCd(1001);
            boardVO.setCmmntyBbsCd(1001);
            boardVO.setRegistId(vo.getUpdtId());
            boardVO.setBbscttSj(strBbscttSj);
            boardVO.setBbscttCn(vo.getCmmntyClsResn());
            boardVO.setCnSumry(strCnSumry);
            boardVO.setAtchFileSeq(-1);
            boardVO.setOthbcSetupCd(1001);
            boardVO.setAccessIpAdres(strAccessIpAdres);
            boardVO.setAccessBrwsrAgent(strAccessBrwsrAgent);
            boardVO.setNoticeBbscttAt("Y");
            boardVO.setWrterNcnm("운영자");
            intResult1 = cmBoardDao.cmManageBBSInsert(boardVO);
            
            CmManageVO copenm = cmManageDAO.openCmManageView(vo);
            
            /** 매일발송 시작 **/
            Map<String, Object> autoMap = new HashMap<String, Object>();
            boolean result = false;
            /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
            int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
            if(intJoinSiteDivCd == 2001 || intJoinSiteDivCd == 2002) { // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_CLSA);
            }
            
            List<CmManageVO> cmMngrInfoSelet = cmManageDAO.cmMngrInfoSelet(vo);
            
            if(cmMngrInfoSelet !=null){
                
                for(int i=0; i<cmMngrInfoSelet.size(); i++){
                    CmManageVO cvoList = cmMngrInfoSelet.get(i);
                   
                    /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
        
                    
                    oneToOneInfoMap.put("cmName", copenm.getCmmntyNm()); 
                    oneToOneInfoMap.put("rtnurl", copenm.getCmmntyUrl()); 
                    oneToOneInfoMap.put("cmUrl", copenm.getCmmntyUrl()); 
                    oneToOneInfoMap.put("nickName", "운영자"); 
                    oneToOneInfoMap.put("name", copenm.getUserNm()); 
                    oneToOneInfoMap.put("email", copenm.getEmail()); 
                    oneToOneInfoMap.put("cmCategory", copenm.getCmmntyCtgryNm()); 
                    oneToOneInfoMap.put("cmContents", copenm.getCmmntyDc()); 
                    oneToOneInfoMap.put("cmCloseReason", copenm.getEstblReqstResn());
                    
                    // 전송할 메일 정보 입력
                    autoMap.put("receiverName", cvoList.getMngrNm()); // 수신자명
                    autoMap.put("email", cvoList.getMngrEmail()); // 수신이메일주소
                    
                    // 치환정보 맵 입력
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
        
                    // 선택 입력 항목
                    autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓
        
                    // EMAIL 발송
                    result = amservice.sendAutoMail(autoMap);
                    
                    
                    if(result) {
                       /* System.out.println("########################################################");
                        System.out.println("####커뮤니티 폐쇄 신청 E-MAIL : " + cvoList.getMngrEmail() + "," + cvoList.getMngrNm() + "에게 발송 성공#########");
                        System.out.println("########################################################");*/
                    } else {
                        /*System.out.println("########################################################");
                        System.out.println("####커뮤니티 폐쇄 신청 E-MAIL : " + cvoList.getMngrEmail() + "," + cvoList.getMngrNm() + "에게 발송 실패#########");
                        System.out.println("########################################################");*/
                    }
                }
            }
        /** 매일발송 끝 **/
        }
        
        
        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptInfo.CmOptInfoService#closeCancleCmOptInfoUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String closeCancleCmOptInfoUpdate(HttpServletRequest request, CmManageVO vo) throws Exception {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        vo.setCmmntySttusCd(1002); //  1001:신청     1002:승인     1003:승인보류    1004:폐쇄   1005:폐쇄중

        vo.setCmmntyClsId("");
       vo.setCmmntyClsResn("");
        intResult1 = dao.closeCancleCmOptInfoUpdate(vo);
        
        
        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

}
