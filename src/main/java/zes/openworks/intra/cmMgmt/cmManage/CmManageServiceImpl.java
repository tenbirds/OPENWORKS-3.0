/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc.
 */
package zes.openworks.intra.cmMgmt.cmManage;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import zes.openworks.web.common.CommonDutyConstant;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.utils.Converter;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardDAO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;


/**
 *
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       	수정자   	수정내용
 *--------------		--------  	-------------------------------
 * 2014. 10. 14.    		SON.H.S       	신규
 *</pre>
 * @see
 */
@Service("cmManageService")
public class CmManageServiceImpl extends AbstractServiceImpl implements CmManageService{


    @Resource
    private CmManageDAO dao;

    @Resource
    private CmManageBoardDAO cmBoardDao;

    @Resource
    private FileDAO fileDao;

    @Autowired
    private AutoMailService amservice;

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageVO> openCmManageList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.openCmManageList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageView(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO openCmManageView(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.openCmManageView(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#getOpenCmManageCheck(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public int getOpenCmManageCheck(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.getOpenCmManageCheck(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String openCmManageApprovalUpdate(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        String logoYN = vo.getLogoDirectRegistAt();
        vo.setCmmntySttusCd(1002); //  1001:신청     1002:승인     1003:승인보류

        int intDelte = dao.cmMenuUserDelete(vo);
        log.info("intDelte:::::::::::>>>>>>info>>>>>>>>>>"+intDelte);
        vo.setEssntlMenuAt("1");
        List<CmManageVO>  cmManagelist =  dao.cmMenuManageSelect(vo);

        if(cmManagelist.size() > 0){
            if("Y".equals(logoYN)){ // LogoDirectRegistAt
                List<FileVO> fileList  = UploadHelper.upload( request, "cmmntylogo");
                int logoFileSeq = 0;
                if(fileList.size()> 0){
                    logoFileSeq = fileDao.saveFile(fileList);
                    vo.setLogoFileSeq(logoFileSeq);
                }
            }
            intResult1 = dao.openCmManageApprovalUpdate(vo);
            CmManageVO cmvo = new CmManageVO();
            for(int j=0; j<cmManagelist.size(); j++ ){

                CmManageVO cvoList = cmManagelist.get(j);

                cmvo.setLangCode(vo.getLangCode());
                cmvo.setCmmntyId(vo.getCmmntyId());
                cmvo.setCmmntyMenuCode(cvoList.getCmmntyMenuCode());
                cmvo.setMenuBbsSe(cvoList.getMenuBbsSe());
                cmvo.setEssntlMenuAt(cvoList.getEssntlMenuAt());
                cmvo.setSortOrdr(cvoList.getSortOrdr());
                cmvo.setCmmntyMenuFolderNm(cvoList.getCmmntyMenuFolderNm());
                cmvo.setCmmntyMenuUrl(cvoList.getCmmntyMenuUrl());
                cmvo.setCmmntyMenuNm(cvoList.getCmmntyMenuNm());
                cmvo.setMenuCharctCd(cvoList.getMenuCharctCd());
                cmvo.setCmmntyBbsTyCd(cvoList.getCmmntyBbsTyCd());
                cmvo.setCmmntyBbsCd(cvoList.getCmmntyBbsCd());
                intResult1 =  dao.cmMenuUserInsert(cmvo);
            }
        }
        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageUserInsert(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String openCmManageUserInsert(HttpServletRequest request, CmManageVO vo){

        String strResult ="N";
        int intResult1 = 0;
        String logoYN = vo.getLogoDirectRegistAt();
        vo.setCmmntySttusCd(1001); //  1001:신청     1002:승인     1003:승인보류    1004: 폐쇄

        int logoFileSeq = 1;

        if("Y".equals(logoYN)){ // LogoDirectRegistAt
            List<FileVO> fileList  = UploadHelper.upload( request, "cmmntylogo");
            if(fileList.size()> 0){
                logoFileSeq = fileDao.saveFile(fileList);
            }
            vo.setLogoFileSeq(logoFileSeq);
            // 기본값으로 등록
            vo.setLogoTitleWidthLc(100);
            vo.setLogoTitleVrticlLc(100);
            vo.setLogoTitleFont("batang");
            vo.setLogoTitleColor("000000");
            vo.setLogoTitle("Open Market Place");
            vo.setLogoTitleFontSize(40);
        }else if("N".equals(logoYN)){
            vo.setLogoFileSeq(1);
        }
        intResult1 = dao.openCmManageUserInsert(vo);

        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String applyCmManageApprovalUpdate(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        String logoYN = vo.getLogoDirectRegistAt();
        vo.setCmmntySttusCd(1002); //  1001:신청     1002:승인     1003:승인보류    1004: 폐쇄

        vo.setCmmntyClsId(vo.getUpdtId());
       // vo.setMngrClsAt("Y");
//        if("Y".equals(logoYN)){ // LogoDirectRegistAt
//            List<FileVO> fileList  = UploadHelper.upload( request, "logotitle");
//            int logoFileSeq = 0;
//            if(fileList.size()> 0){
//                logoFileSeq = fileDao.saveFile(fileList);
//                vo.setLogoFileSeq(logoFileSeq);
//            }
//        }
        int logoFileSeq = vo.getLogoFileSeq();

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
        intResult1 = dao.openCmManageApprovalUpdate(vo);

        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String closeCmManageUpdate( HttpServletRequest request, CmManageVO vo ) throws Exception {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        vo.setCmmntySttusCd(1005); //  1001:신청     1002:승인     1003:승인보류    1004:폐쇄   1005:폐쇄중

        String time= "";
        Calendar cal = Calendar.getInstance();
        //time = DateFormatUtil.getDateFull (cal.getTime());
        cal.add(Calendar.DATE,  7 ); // 7일 이후 폐쇄 한다는 날짜 설정
        time = DateFormatUtil.getDateFull (cal.getTime());

        String strCnSumry=StringUtil.omit(Converter.cleanHtml(StringUtil.replace(vo.getCmmntyClsResn(), "\"", "'")), 900);
        log.info("strCnSumry:::::::::::>>>>>>strCnSumry>>>>>>>>>>"+strCnSumry);
        String strAccessBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";

        String strBbscttSj = "커뮤니티 폐쇄 공지 입니다.";
        String strAccessIpAdres = request.getRemoteAddr();
        CmManageBoardVO boardVO = new CmManageBoardVO ();

        vo.setCmmntyClsDt(time); //폐쇄날짜

        intResult1 = dao.closeCmManageUpdate(vo);

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

            CmManageVO copenm = dao.openCmManageView(vo);

            /** E 메일발송 시작 **/
            Map<String, Object> autoMap = new HashMap<String, Object>();
            boolean result = false;
            /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
            //int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
            if("00".equals(vo.getLangCode())) { // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_CLSA);
            }  else{
                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_CLSA);
            }

            List<CmManageVO> cmMngrInfoSelet = dao.cmMngrInfoSelet(vo);
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
                          /*  System.out.println("########################################################");
                            System.out.println("####커뮤니티 폐쇄 신청 E-MAIL : " + cvoList.getMngrEmail() + "," + cvoList.getMngrNm() + "에게 발송 성공#########");
                            System.out.println("########################################################");*/
                        } else {
                           /* System.out.println("########################################################");
                            System.out.println("####커뮤니티 폐쇄 신청 E-MAIL : " + cvoList.getMngrEmail() + "," + cvoList.getMngrNm() + "에게 발송 실패#########");
                            System.out.println("########################################################");*/
                        }
                    }
                }
            /** E 메일발송 끝 **/

        }


        strResult = "Y";
        return strResult;
    }
    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageRejectUpdate(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String openCmManageRejectUpdate(CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
         //  1001:신청     1002:승인     1003:승인보류
        vo.setCmmntySttusCd(1003);
        intResult1 = dao.openCmManageRejectUpdate(vo);
        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }
    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#userEntrprsOptionSelect(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO userEntrprsOptionSelect(CmManageVO vo) {
        // TODO Auto-generated method stub
        return  dao.userEntrprsOptionSelect(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#userOptionSelect(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO userOptionSelect(CmManageVO vo) {
        // TODO Auto-generated method stub
        return  dao.userOptionSelect(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageMutilView(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public List<CmManageVO> openCmManageMutilView(CmManageVO vo) {
        // TODO Auto-generated method stub
        String[] strSplit1;
        String[] strSplit2;
        String ckMultiBoxValue =vo.getMultiCheck();
        List<CmManageVO> templist = new ArrayList<CmManageVO>();

        strSplit1 = ckMultiBoxValue.split(",");


        if(strSplit1 != null){
           // log.info("strSplit1.length::::::????????>>>>>>>>>>>"+strSplit1.length);
            for(int i=0; i<strSplit1.length; i++ ){
                CmManageVO cmvo = new CmManageVO();
                strSplit2 = strSplit1[i].split("_"); //  <c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.userId}'/>
               // log.info("strSplit2.[0]::::::????--cmmntyId--????>>>>>>>>>>>"+strSplit2[0]);
              //  log.info("strSplit2.[1]::::::????--langCode--????>>>>>>>>>>>"+strSplit2[1]);
              //  log.info("strSplit2.[2]::::::????--userId--????>>>>>>>>>>>"+strSplit2[2]);
                cmvo.setCmmntyId(strSplit2[0]);
                cmvo.setLangCode(strSplit2[1]);
                cmvo.setUserId(strSplit2[2]);
                CmManageVO copen = dao.openCmInfoSelect(cmvo);
                cmvo.setCmmntyNm(copen.getCmmntyNm());
                //cmvo.setCmManageList(cmManageList);
                templist.add(cmvo);
            }
        }

        return templist;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageApprovalMultiUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String openCmManageApprovalMultiUpdate(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub

        String strResult ="N";
        int intResult1 = 0;
        String[] strSplit;
        String ckMultiBoxValue ="";

        List <String> listCkMultiBox  = vo.getCkMultiBox();
        List<CmManageVO> cmManagelist = null;
        if(listCkMultiBox != null){
           // log.info("listCkMultiBox.size::::::????????>>>>>>>>>>>"+listCkMultiBox.size());
            for(int i=0; i<listCkMultiBox.size(); i++ ){
                CmManageVO cmvo = new CmManageVO();

                ckMultiBoxValue =  listCkMultiBox.get(i);
                strSplit = ckMultiBoxValue.split("_"); //   <c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.userId}'/>
                cmvo.setCmmntySttusCd(1002);
                cmvo.setCmmntyId(strSplit[0]);
                cmvo.setLangCode(strSplit[1]);
                cmvo.setUserId(strSplit[2]);
                cmvo.setUpdtId(vo.getUpdtId());
                int intDelte = dao.cmMenuUserDelete(cmvo);

                log.info("dao.cmMenuUserDelete count :::::????????>>>>>>>>>>>"+intDelte);
                cmvo.setEssntlMenuAt("1");
                intResult1= dao.openCmManageApprovalMultiUpdate(cmvo);
                cmManagelist =  dao.cmMenuManageSelect(cmvo);

                if(intResult1 >0){

                    CmManageVO cmvo2 = new CmManageVO();
                    for(int j=0; j<cmManagelist.size(); j++ ){

                        CmManageVO cvoList = cmManagelist.get(j);
                        log.info("cvoList"+cvoList.getCmmntyMenuCode()+"]");
                        cmvo2.setLangCode(cmvo.getLangCode());
                        cmvo2.setCmmntyId(cmvo.getCmmntyId());
                        cmvo2.setCmmntyMenuCode(cvoList.getCmmntyMenuCode());
                        cmvo2.setMenuBbsSe(cvoList.getMenuBbsSe());
                        cmvo2.setEssntlMenuAt(cvoList.getEssntlMenuAt());
                        cmvo2.setSortOrdr(cvoList.getSortOrdr());
                        cmvo2.setCmmntyMenuFolderNm(cvoList.getCmmntyMenuFolderNm());
                        cmvo2.setCmmntyMenuUrl(cvoList.getCmmntyMenuUrl());
                        cmvo2.setCmmntyMenuNm(cvoList.getCmmntyMenuNm());
                        cmvo2.setMenuCharctCd(cvoList.getMenuCharctCd());
                        cmvo2.setCmmntyBbsTyCd(cvoList.getCmmntyBbsTyCd());
                        cmvo2.setCmmntyBbsCd(cvoList.getCmmntyBbsCd());
                        intResult1 =  dao.cmMenuUserInsert(cmvo2);
                    }
                }
            }

        }
        if(intResult1>0){
            strResult = "Y";
        }

        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#openCmManageRejectMultiUpdate(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String openCmManageRejectMultiUpdate(CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
         //  1001:신청     1002:승인     1003:승인보류
        String[] strSplit;
        String ckMultiBoxValue ="";

        List <String> listCkMultiBox  = vo.getCkMultiBox();

        if(listCkMultiBox != null){

            for(int i=0; i<listCkMultiBox.size(); i++ ){
                CmManageVO cmvo = new CmManageVO();

                ckMultiBoxValue =  listCkMultiBox.get(i);
                strSplit = ckMultiBoxValue.split("_");
                cmvo.setCmmntySttusCd(1003);
                cmvo.setConfmRejectResn(vo.getConfmRejectResn());
                cmvo.setCmmntyId(strSplit[0]);
                cmvo.setLangCode(strSplit[1]);
                cmvo.setUserId(strSplit[2]);

                intResult1 = dao.openCmManageRejectUpdate(cmvo);
            }
        }

        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMenuManageSelect(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public List<CmManageVO> cmMenuManageSelect(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmMenuManageSelect(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMenuManageUpdate(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmMenuManageUpdate(CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        String[] strSplit;
        String ckMultiBoxValue =vo.getMultiCheck();

        strSplit = ckMultiBoxValue.split(",");

      //  List <String> listCkMultiBox  = vo.getCkMultiBox();
        List <String> listCmmntyMenuMultiCode = vo.getCmmntyMenuMultiCode(); // 커뮤니티 메뉴 코드
        List <String> listCmmntyMenuMultiNm  = vo.getCmmntyMenuMultiNm(); // 커뮤니티 메뉴 이름

        //log.info("listCkMultiBox.size() :::::::>>>>>>>>>>"+ listCkMultiBox.size() );

      //  int intEssntlMenuAt = listCkMultiBox.size(); //  커뮤니티 개설 필수 체크 1:필수,2:필수아님

        if(listCmmntyMenuMultiNm != null){
            for(int i=0; i<listCmmntyMenuMultiCode.size(); i++ ){
                CmManageVO cvo = new CmManageVO();
                cvo.setEssntlMenuAt(strSplit[i]);
                cvo.setCmmntyMenuNm(listCmmntyMenuMultiNm.get(i));
                cvo.setUpdtId(vo.getUpdtId());
                cvo.setLangCode(vo.getLangCode());
                cvo.setCmmntyMenuCode(listCmmntyMenuMultiCode.get(i));

                intResult1 = dao.cmMenuManageUpdate(cvo);
            }
        }
        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMenuManageInsert(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmMenuManageInsert(CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;

        List <String> listCmmntyMenuMultiNm  = vo.getCmmntyMenuMultiNm(); // 커뮤니티 메뉴 이름
       // List <String> listCkMultiBox  = vo.getCkMultiBox();

        log.info("listCmmntyMenuMultiNm.size() :::::::>>>>>>>>>>"+ listCmmntyMenuMultiNm.size() );
       // log.info("listCkMultiBox.size() :::::::>>>>>>>>>>"+ listCkMultiBox.size() );

        String[] strSplit;
        String ckMultiBoxValue =vo.getMultiCheck();

        strSplit = ckMultiBoxValue.split(",");

        //int intEssntlMenuAt = listCkMultiBox.size();
        int intCmmntyMenuNm = listCmmntyMenuMultiNm.size();
        CmManageVO cmvo2 = new CmManageVO();
        cmvo2.setLangCode("00");
        List<CmManageVO>  cmManagelist =  dao.cmMenuManageSelect(cmvo2);

        if(cmManagelist.size() > 0){

            CmManageVO cmvo = new CmManageVO();
            for(int j=0; j<cmManagelist.size(); j++ ){

                CmManageVO cvoList = cmManagelist.get(j);

                cmvo.setLangCode(vo.getLangCode());
                cmvo.setCmmntyMenuCode(cvoList.getCmmntyMenuCode());
                cmvo.setMenuBbsSe(cvoList.getMenuBbsSe());
                cmvo.setEssntlMenuAt(strSplit[j]);
                cmvo.setSortOrdr(cvoList.getSortOrdr());
                cmvo.setCmmntyMenuFolderNm(cvoList.getCmmntyMenuFolderNm());
                cmvo.setCmmntyMenuUrl(cvoList.getCmmntyMenuUrl());

                if(intCmmntyMenuNm == cmManagelist.size()){
                    cmvo.setCmmntyMenuNm(listCmmntyMenuMultiNm.get(j));
                }else if (intCmmntyMenuNm > j){
                    cmvo.setCmmntyMenuNm(listCmmntyMenuMultiNm.get(j));
                }else{
                    cmvo.setCmmntyMenuNm(cvoList.getCmmntyMenuNm());
                }

                cmvo.setMenuCharctCd(cvoList.getMenuCharctCd());
                cmvo.setCmmntyBbsTyCd(cvoList.getCmmntyBbsTyCd());
                cmvo.setCmmntyBbsCd(cvoList.getCmmntyBbsCd());
                intResult1 =  dao.cmMenuManageInsert(cmvo);
            }
        }
        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMberInfoList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageVO> cmMberInfoList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmMberInfoList(vo);
    }

    /* (non-Javadoc)
     * 커뮤니티 회원 정보 수정 : 가입 승인, 가입 거절 , 강제 탈퇴
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMemberShipInfoUpdate(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmMemberShipInfoUpdate(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub

        String strResult ="N";
        int intResult1 = 0;
        String[] strSplit1;
        String[] strSplit2;
        String ckMultiBoxValue = vo.getMultiCheck();
        //List<CmManageVO> templist = new ArrayList<CmManageVO>();
        //log.info("ckMultiBoxValue::::::????????>>>>>>>>>>>"+ckMultiBoxValue);
        strSplit1 = ckMultiBoxValue.split(",");
        int intMberStateCd = vo.getMberStateCd();
        if(strSplit1 != null){
           // log.info("strSplit1.length::::::????????>>>>>>>>>>>"+strSplit1.length);
            for(int i=0; i<strSplit1.length; i++ ){
                CmManageVO cmvo = new CmManageVO();

                cmvo.setMberStateCd(intMberStateCd); // 회원상태   1001:가입중 1002:가입거절 1003:정상 1004:탈퇴
                strSplit2 = strSplit1[i].split("_"); // <c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMberId}'/>
                log.info("strSplit2.[0]::::::????--cmmntyId--???>>>>>>>>>>>"+strSplit2[0]);
                log.info("strSplit2.[1]::::::????--langCode--???>>>>>>>>>>>"+strSplit2[1]);
                log.info("strSplit2.[2]::::::????--cmmntyMberId--???>>>>>>>>"+strSplit2[2]);
                cmvo.setCmmntyId(strSplit2[0]);
                cmvo.setLangCode(strSplit2[1]);
                cmvo.setCmmntyMberId(strSplit2[2]);



                if(intMberStateCd == 1002){
                    cmvo.setSbscrbRejectResn("커뮤니티 회원 가입 거절 되었습니다. ");
                }
                if(intMberStateCd == 1004){
                    cmvo.setEnfrcSecsnCd(vo.getEnfrcSecsnCd());
                }
                intResult1 = dao.cmMemberShipInfoUpdate(cmvo);

                CmManageVO memberVO = cmMemberShipInfoView(cmvo);
                if(intResult1>0){
                    if(intMberStateCd == 1002 || intMberStateCd == 1003){ // 1002:가입거절       1003:정상
                        /** E 메일발송 시작 **/
                        Map<String, Object> autoMap = new HashMap<String, Object>();
                        boolean result = false;
                        /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
                       // int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
                        if("00".equals(cmvo.getLangCode())) { // 한국어사이트

                            if(intMberStateCd == 1002 ){
                                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSN);
                            }else if(intMberStateCd == 1003 ){
                                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSY);
                            }
                        }else{
                            if(intMberStateCd == 1002 ){
                                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSN);
                            }else if(intMberStateCd == 1003 ){
                                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSY);
                            }
                        }

                        // 전송할 메일 정보 입력
                        autoMap.put("receiverName", memberVO.getUserNm()); // 수신자명
                        autoMap.put("email", memberVO.getEmail()); // 수신이메일주소

                        /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
                        HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

                        oneToOneInfoMap.put("rtnurl", memberVO.getCmmntyUrl());
                        oneToOneInfoMap.put("cmName", memberVO.getCmmntyNm());
                        oneToOneInfoMap.put("nickName", memberVO.getNcnm());
                        oneToOneInfoMap.put("name", memberVO.getUserNm());
                        oneToOneInfoMap.put("memberSection", memberVO.getUserTyNm());

                        // 치환정보 맵 입력
                        autoMap.put("oneToOneInfo", oneToOneInfoMap);

                        // 선택 입력 항목
                        autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

                        // EMAIL 발송
                        result = amservice.sendAutoMail(autoMap);
                        if(result) {
                           /* System.out.println("########################################################");
                            System.out.println("####커뮤니티회원 가입  승인1003/거절1002 ("+intMberStateCd+") E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 성공#########");
                            System.out.println("########################################################");*/
                        } else {
                            /*System.out.println("########################################################");
                            System.out.println("####커뮤니티회원 가입 승인1003/거절1002 ("+intMberStateCd+") E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 실패#########");
                            System.out.println("########################################################");*/
                        }
                        /** E 메일발송 끝 **/
                    }
                }

            }
        }

        if(intResult1>0){
            strResult = "Y";
        }

        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMemberShipInfoView(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO cmMemberShipInfoView(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmMemberShipInfoView(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#userInfoSelect(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO userInfoOptionSelect(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.userInfoOptionSelect(vo);
    }

    /* (non-Javadoc)
     * 커뮤니티 회원 가입 신청
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMemberShipJoinInsert(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmMemberShipJoinInsert(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;

        intResult1 = dao.cmMemberShipJoinInsert(vo);
        String cmmntySbscrbMthd = vo.getCmmntySbscrbMthd();

        CmManageVO memberVO = cmMemberShipInfoView(vo);

        if(intResult1>0){

            /** E 메일발송 시작 **/
            Map<String, Object> autoMap = new HashMap<String, Object>();
            boolean result = false;
            /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
           // int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
            if("00".equals(vo.getLangCode())) { // 한국어사이트
                if("1".equals(cmmntySbscrbMthd)){ // 가입시 바로 승인
                    autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSY);
                }else{
                    autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SCRY);
                }
            }else{
                if("1".equals(cmmntySbscrbMthd)){ // 가입시 바로 승인
                    autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSY);
                }else{
                    autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SCRY);
                }
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", memberVO.getUserNm()); // 수신자명
            autoMap.put("email", memberVO.getEmail()); // 수신이메일주소

            /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

            oneToOneInfoMap.put("rtnurl", memberVO.getCmmntyUrl());
            oneToOneInfoMap.put("cmName", memberVO.getCmmntyNm());
            oneToOneInfoMap.put("nickName", memberVO.getNcnm());
            oneToOneInfoMap.put("name", memberVO.getUserNm());
            oneToOneInfoMap.put("memberSection", memberVO.getUserTyNm());

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
               /* System.out.println("########################################################");
                System.out.println("####커뮤니티회원 가입 신청 2 /승인 1 :  "+cmmntySbscrbMthd+"   E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            } else {
               /* System.out.println("########################################################");
                System.out.println("####커뮤니티회원 가입 신청 2 /승인 1-->  "+cmmntySbscrbMthd+"   E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
            /** E 메일발송 끝 **/
            strResult = "Y";
        }

        return strResult;
    }

    /* (non-Javadoc)
     * 커뮤니티 회원 재가입 수정
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMemberShipJoinUpdate(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmMemberShipJoinUpdate(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;

        String cmmntySbscrbMthd = vo.getCmmntySbscrbMthd();

        CmManageVO memberVO = cmMemberShipInfoView(vo);

        intResult1 = dao.cmMemberShipJoinUpdate(vo);

        if(intResult1>0){
            if(!"3".equals(cmmntySbscrbMthd)){
                /** E 메일발송 시작 **/
                Map<String, Object> autoMap = new HashMap<String, Object>();
                boolean result = false;
                /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
               // int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
                if("00".equals(vo.getLangCode())) { // 한국어사이트
                    if("1".equals(cmmntySbscrbMthd)){ // 가입시 바로 승인
                        autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSY);
                    }else{
                        autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SCRY);
                    }
                }else{
                    if("1".equals(cmmntySbscrbMthd)){ // 가입시 바로 승인
                        autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SRSY);
                    }else{
                        autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SCRY);
                    }
                }
                // 전송할 메일 정보 입력
                autoMap.put("receiverName", memberVO.getUserNm()); // 수신자명
                autoMap.put("email", memberVO.getEmail()); // 수신이메일주소

                /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
                HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

                oneToOneInfoMap.put("rtnurl", memberVO.getCmmntyUrl());
                oneToOneInfoMap.put("cmName", memberVO.getCmmntyNm());
                oneToOneInfoMap.put("nickName", memberVO.getNcnm());
                oneToOneInfoMap.put("name", memberVO.getUserNm());
                oneToOneInfoMap.put("memberSection", memberVO.getUserTyNm());

                // 치환정보 맵 입력
                autoMap.put("oneToOneInfo", oneToOneInfoMap);

                // 선택 입력 항목
                autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

                // EMAIL 발송
                result = amservice.sendAutoMail(autoMap);
                if(result) {
                    /*System.out.println("########################################################");
                    System.out.println("####커뮤니티회원 가입 신청 2 /승인 1 :  "+cmmntySbscrbMthd+"   E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 성공#########");
                    System.out.println("########################################################");*/
                } else {
                    /*System.out.println("########################################################");
                    System.out.println("####커뮤니티회원 가입 신청 2 /승인 1-->  "+cmmntySbscrbMthd+"   E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 실패#########");
                    System.out.println("########################################################");*/
                }
                /** E 메일발송 끝 **/
            }

            strResult = "Y";
        }

        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#getCmNcnmCheck(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public int getCmNcnmCheck(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.getCmNcnmCheck(vo);
    }

    /* (non-Javadoc)
     * 커뮤니티 회원 신청 취소
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMemberShipCancelDelete(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmMemberShipCancelDelete(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;

        CmManageVO memberVO = cmMemberShipInfoView(vo);

        intResult1 = dao.cmMemberShipCancelDelete(vo);

        if(intResult1>0){
            /** E 메일발송 시작 **/
            Map<String, Object> autoMap = new HashMap<String, Object>();
            boolean result = false;
            /* 필수 입력 항목 메일템플릿 번호 AutoMailTemplate.java참고 */
           // int intJoinSiteDivCd =  new Integer(new CommonDutyConstant().getJoinSiteDivCd(request));
            if("00".equals(vo.getLangCode())) { // 한국어사이트
                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SCRN);
            }else{
                autoMap.put("automailId", AutoMailTemplate.KOR_CMNT_SCRN);
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", memberVO.getUserNm()); // 수신자명
            autoMap.put("email", memberVO.getEmail()); // 수신이메일주소

            /* 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

            oneToOneInfoMap.put("rtnurl", memberVO.getCmmntyUrl());
            oneToOneInfoMap.put("cmName", memberVO.getCmmntyNm());
            oneToOneInfoMap.put("nickName", memberVO.getNcnm());
            oneToOneInfoMap.put("name", memberVO.getUserNm());
            oneToOneInfoMap.put("memberSection", memberVO.getUserTyNm());

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
               /* System.out.println("########################################################");
                System.out.println("####커뮤니티회원 가입 신청 취소 E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            } else {
                /*System.out.println("########################################################");
                System.out.println("####커뮤니티회원 가입 신청 취소 E-MAIL : " + memberVO.getEmail() + "," + memberVO.getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
            /** E 메일발송 끝 **/

            strResult = "Y";
        }

        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManage.CmManageService#cmMngrInfoSelet(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public List<CmManageVO> cmMngrInfoSelet(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmMngrInfoSelet(vo);
    }

    /* {{ 2016.05.04 BH.YANG 커뮤니티 개설자 아이디 정보 */
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptMain.CmOptMainService#cmOptMainInfo(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO CmOptMainInfo(CmManageVO vo) {
        return dao.CmOptMainInfo(vo);
    }
    /* }} */



}
