/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.markMgmt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
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
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.file.FileService;
import zes.openworks.intra.login.LoginVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 24.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/store/markMgmt")
public class MarkController extends IntraController {
    
    @Autowired
    private MarkService service;
    @Resource
    private FileService fileService;
    
    /**
     * 마크/분류 이미지 등록폼
     * GoodsList 설명
     * 
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void codeList(HttpServletRequest request, ModelMap model, MarkVO vo) {

        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.markList());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.cntcImgList());
        model.addAttribute("markConfig", vo);
    }
    
    /**
     * 마크 이미지 정보
     * GoodsList 설명
     * 
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_markInfo.do")
    public String getMarkInfo(HttpServletRequest request, ModelMap model, MarkVO vo) throws Exception {
        MarkVO mvo = service.getMarkInfo(vo);
        return responseJson(model, mvo);
    }
    
    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }
    
    /**
     * 연계 이미지 정보
     * GoodsList 설명
     * 
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_cntcImgInfo.do")
    public String getCntcImgInfo(HttpServletRequest request, ModelMap model, MarkVO vo) throws Exception {
        MarkVO mvo = service.getCntcImgInfo(vo);
        return responseJson(model, mvo);
    }

    /**
     * 마크 이미지 변경사항 저장
     * GoodsList 설명
     * 
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_saveMarkInfo.do")
    public String saveMarkInfo(HttpServletRequest request, ModelMap model, MarkVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        int chkCnt = 0;
        int rstCnt = 0;
        if(loginVO == null){
            return responseText(model, Messages.LOGIN_NO_SESSION);
        }else{
            if(vo.getMarkCd() == null){
                return responseText(model, Messages.COMMON_PROCESS_FAIL);
            }else{
                chkCnt = service.chkCnt(vo);
                if(chkCnt > 0){
                    vo.setSepp("U");
                    vo.setUpdtId(loginVO.getMngrId());
                    List<FileVO> fileList = new ArrayList<FileVO>();
                    fileList = UploadHelper.upload(request, "markImageFile");
                    // 폼 업로드시 업로드 파일 용량을 체크한다.
                    if(!checkUploadFileSize(fileList, vo)) {
                        if(service.fileDelete(fileList)) {
                            return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
                        } else {
                            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
                        }
                    }
                    vo.setFileList(fileList);
                    rstCnt = service.saveMarkInfo(vo);
                }else{
                    vo.setSepp("I");
                    vo.setRegistId(loginVO.getMngrId());
                    List<FileVO> fileList = new ArrayList<FileVO>();
                    fileList = UploadHelper.upload(request, "markImageFile");
                    // 폼 업로드시 업로드 파일 용량을 체크한다.
                    if(!checkUploadFileSize(fileList, vo)) {
                        if(service.fileDelete(fileList)) {
                            return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
                        } else {
                            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
                        }
                    }
                    vo.setFileList(fileList);
                    rstCnt = service.saveMarkInfo(vo);
                }

                if(rstCnt > 0){
                    return responseText(model, Messages.COMMON_PROCESS_OK);
                }else{
                    return responseText(model, Messages.COMMON_PROCESS_FAIL);
                }
            }
        }
    }
    
    /**
     * 연계서비스 이미지 변경사항 저장
     * GoodsList 설명
     * 
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_saveCntcImgInfo.do")
    public String saveCntcImgInfo(HttpServletRequest request, ModelMap model, MarkVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        int chkCnt = 0;
        int rstCnt = 0;
        if(loginVO == null){
            return responseText(model, Messages.LOGIN_NO_SESSION);
        }else{
            if(vo.getCntcInsttCd() == null){
                return responseText(model, Messages.FALSE);
            }else{
                chkCnt = service.chkCnt(vo);
                if(chkCnt > 0){
                    vo.setSepp("U");
                    vo.setUpdtId(loginVO.getMngrId());
                    List<FileVO> fileList = new ArrayList<FileVO>();
                    fileList = UploadHelper.upload(request, "cntcImageFile");
                    // 폼 업로드시 업로드 파일 용량을 체크한다.
                    if(!checkUploadFileSize(fileList, vo)) {
                        if(service.fileDelete(fileList)) {
                            return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
                        } else {
                            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
                        }
                    }
                    vo.setFileList(fileList);
                    rstCnt = service.saveCntcImgInfo(vo);
                }else{
                    vo.setSepp("I");
                    vo.setRegistId(loginVO.getMngrId());
                    List<FileVO> fileList = new ArrayList<FileVO>();
                    fileList = UploadHelper.upload(request, "cntcImageFile");
                    // 폼 업로드시 업로드 파일 용량을 체크한다.
                    if(!checkUploadFileSize(fileList, vo)) {
                        if(service.fileDelete(fileList)) {
                            return alertAndBack(model, Messages.COMMON_FILE_SIZE_OVER);
                        } else {
                            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
                        }
                    }
                    vo.setFileList(fileList);
                    vo.setCntcGoodsImageSeq(-1);
                    rstCnt = service.saveCntcImgInfo(vo);
                }

                if(rstCnt > 0){
                    return responseText(model, Messages.COMMON_PROCESS_OK);
                }else{
                    return responseText(model, Messages.COMMON_PROCESS_FAIL);
                }
            }
        }
    }
    
    /**
     * 폼 업로드시 업로드 파일 용량을 체크한다.
     */
    private boolean checkUploadFileSize(List<FileVO> fileList, MarkVO vo) {
        Long totalFileSize = 0L;
        boolean uploadYn = true;
        // 업로드 파일 사이즈 제한이 있는 경우(사이즈 0일 경우 무제한 용량)
        for(FileVO baseFileVO : fileList) {
            try {
                Long fileSize = baseFileVO.getFileByteSize();

                if(vo.getMaxFileSize() > 0) {
                    Long maxFileSize = Long.valueOf(((Integer) (vo.getMaxFileSize() * 1024 * 1024)).toString());
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
        if(vo.getTotalFileSize() > 0) {
            Long totalMaxFileSize = Long.valueOf(((Integer) (vo.getTotalFileSize() * 1024 * 1024)).toString());
            if(totalFileSize > totalMaxFileSize) {
                return false;
            }
        }
        return uploadYn;
    }
    
    /**
     * 개별 파일 삭제(Ajsx로 파일 삭제)
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request, MarkVO vo) {
        int affected = service.fileDelete(fileVO, vo);
        
        if(affected == StringUtil.ONE) {
            return responseText(model, Boolean.TRUE);
        }

        return responseText(model, Boolean.FALSE);
    }
}
