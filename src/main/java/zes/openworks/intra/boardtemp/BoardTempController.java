/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardtemp;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.mgr.MgrController;


/**
 * 게시판 템플릿 관리 Controller
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 6. 7.    Administrator   신규 생성
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/boardtemp")
public class BoardTempController extends MgrController {

    @Autowired
    private BoardTempService boardTempService;

    /**
     * 게시판 템플릿 목록 조회
     */
    @AuthIntra(authType = AuthType.READ, authParams = { "tmplatTy" })
    @RequestMapping(value = "BD_boardTemplateList.do", method = RequestMethod.GET)
    public void boardTemplateList(HttpServletRequest request, ModelMap model, BoardTempVO vo) {
        // OpHelper.bindSearchMap(boardTempVO, request);
        // model.addAttribute(GlobalConfig.KEY_PAGER, boardTempService.boardTempPager(boardTempVO));
        
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, boardTempService.boardTempList(vo));
    }

    /**
     * 게시판 템플릿 상세 조회
     */
    @AuthIntra(authType = AuthType.READ, authParams = { "tmplatTy"  })
    @RequestMapping(value = "BD_boardTemplateForm.do", method = RequestMethod.GET)
    public void BD_boardTemplateForm(HttpServletRequest request, ModelMap model, BoardTempVO vo) {
        if(Validate.isNotEmpty(vo) && Validate.isNotEmpty(vo.getTmplatId())){
            BoardTempVO dataVo = boardTempService.boardTempView(vo);
            // 템플릿 현재 게시판 사용 여부
            model.addAttribute("cntTemplateUsed", boardTempService.checkTemplateUsed(dataVo));
            // 템플릿 정보
            model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVo);
        }
    }

    /**
     * 게시판 템플릿 ID 중복확인
     */
    @RequestMapping(value = "ND_templateIdDupCheck.do")
    public String templateIdDupCheck(BoardTempVO vo, ModelMap model) {
        return responseText(model, boardTempService.dupCheckTemplateId(vo));
    }

    /**
     * 게시판 템플릿 저장 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE, authParams = { "tmplatTy" })
    @RequestMapping(value = "ND_templateSaveAction.do", method = RequestMethod.POST)
    public String templateSaveAction(BoardTempVO vo, HttpServletRequest request, ModelMap model) {
        // 사용자 정보 설정
        LoginVO loginVo = getLoginSession(request);
        if(Validate.isNotEmpty(loginVo)) {
            vo.setRegistId(loginVo.getMngrId());
            vo.setUpdtId(loginVo.getMngrId());
        }

        // 파일 업로드
        List<FileVO> fileList = UploadHelper.upload(request, "boardtemplate");
        for(FileVO fileVo : fileList) {
            if("file1".equals(fileVo.getInputNm())) {
                vo.setTmplatFilePath(fileVo.getFileUrl());
                // 게시판 템플릿 폴더로 파일 복사
                moveTemplateFile(vo.getTmplatTy(), vo.getTmplatId(), fileVo.getFileUrl());
//                vo.setScreenshotFilePath("");
            }
            if("file2".equals(fileVo.getInputNm())) {
                vo.setScreenshotFilePath(fileVo.getFileUrl());
            }
        }

        String returnMessage = "";
        if(vo.getOldtemplateId() == null ||"".equals(vo.getOldtemplateId()) ) {
            int key = (Integer) boardTempService.insertBoardTemplate(vo);
            
            if(key != StringUtil.ONE) {
                returnMessage = Messages.COMMON_PROCESS_FAIL;
            } else {
                returnMessage = Messages.COMMON_INSERT_OK;
            }
        } else {
            int affected = boardTempService.updateBoardTemplate(vo);
            if(affected != StringUtil.ONE) {
                returnMessage = Messages.COMMON_PROCESS_FAIL;
            } else {
                returnMessage = Messages.COMMON_UPDATE_OK;
            }
        }

        return responseText(model, returnMessage);
    }

    /**
     * 템플릿 파일 실제 템플릿 관련 폴더로 복사
     */
    private void moveTemplateFile(String templateType, String templateId, String fileUrl) {
        String moveFileNm = "";
        if(templateType.equals("L")) {
            moveFileNm = "BD_board.list.jsp";
        } else if(templateType.equals("V")) {
            moveFileNm = "BD_board.view.jsp";
        } else if(templateType.equals("F")) {
            moveFileNm = "BD_board.form.jsp";
        }

        // 디렉토리 생성
        String uploadFolderPath = GlobalConfig.WEBAPP_ROOT + "WEB-INF" + File.separator + "pages"
            + File.separator + "web" + File.separator + "board" + File.separator + "templates" + File.separator + templateId;
        FileUtil.mkdirs(uploadFolderPath);
        // 파일 복사
        FileUtil.copy(GlobalConfig.UPLOAD_ROOT + fileUrl, uploadFolderPath + File.separator + moveFileNm);
        // 원본 삭제
//        FileUtil.delete(GlobalConfig.UPLOAD_ROOT + fileUrl);
    }

    /**
     * 게시판 템플릿 삭제
     */
    @AuthIntra(authType = AuthType.GENERALIZE, authParams = { "tmplatTy" })
    @RequestMapping(value = "ND_templateDeleteAction.do", method = RequestMethod.POST)
    public String authSaveDelete(BoardTempVO vo, ModelMap model) {
        BoardTempVO dataVo = boardTempService.boardTempView(vo);
        String tmplatFilePath = dataVo.getTmplatFilePath();
        String screenshotFilePath = (dataVo.getScreenshotFilePath() == null? "":dataVo.getScreenshotFilePath());
        
        int affected = boardTempService.deleteBoardTemplate(vo);
        if(affected == StringUtil.ONE) {
            
            // 템플릿, 스크린샷 파일 삭제
            if(FileUtil.delete(GlobalConfig.WEBAPP_ROOT + tmplatFilePath) || FileUtil.delete(GlobalConfig.WEBAPP_ROOT + screenshotFilePath)){
                return responseText(model, Messages.COMMON_DELETE_OK);
            } else {
                return responseText(model, Messages.COMMON_PROCESS_FAIL);
            }
        } else {
            return responseText(model, Messages.COMMON_PROCESS_FAIL);
        }
    }

}