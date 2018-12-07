package zes.openworks.intra.store.cnslt;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistConstant;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.intra.store.goods.GoodsManageExcelVO;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.pop.PopService;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.register.RegisterUserVO;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  서비스관리 > 서비스관리
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 21.   김병욱     신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/store/cnslt")
public class CnslGoodsController extends IntraController  {


    @Autowired GoodsManageService service;
    @Autowired PopService popService;
    @Autowired CommonDutyService commonService;
    @Autowired AutoMailService amservice;
    @Autowired SmsTransHistService smsService;
    @Autowired RegisterService registerService;
    /** 파일 저장 경로 */
    public static final String GOODS_IMG_STORE = "goods" + File.separator;

    /**
     * 전체서비스목록
     * GoodsList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void goodsList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        vo.getDataMap().put("q_goodsTyCd", "1003");

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));

    }

    /**
     * 검토대기목록
     * GoodsExmntList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cnslExmntList.do")
    public void goodsExmntList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        vo.getDataMap().put("q_goodsTyCd", "1003");

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsExmntList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));

    }

    /**
     * 승인대기목록
     * GoodsConfnList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cnslConfnList.do")
    public void goodsConfnList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        vo.getDataMap().put("q_goodsTyCd", "1003");

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsConfnList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));

    }

    /**
     * 삭제서비스 목록
     * GoodsDeleteList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cnslDeleteList.do")
    public void goodsDeleteList(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        vo.getDataMap().put("q_goodsTyCd", "1003");

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsDeleteList(vo));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        //model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));

    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_dspyUpdateAction.do", method = RequestMethod.POST)
    public String dspyUpdateAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        
        /* 20150820 리스트에서 검토 승인 시 이력테이블에 Insert 시작  */
        vo.setMngrId(loginVo.getMngrId());
        vo.setReturnResn("");
        vo.setExmntConfmCd(vo.getGoodsRegistSttus());
        /* 20150820 리스트에서 검토 승인 시 이력테이블에 Insert 끝  */
        
        int affected = service.dspyUpdate(vo, request);
        if (affected == -1) {
            return responseJson(model, false, MessageHelper.getMsg(request, "invalidParam"));
        }

        if(affected != StringUtil.ZERO) {

            for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
                vo.setGoodsCode(vo.getGoodsCodes()[i]);
                /* 20150820 리스트에서 검토 승인 시 이력테이블에 Insert 시작  */
                Integer insertHistoryRows = service.reasonAction(vo);

                if(insertHistoryRows > 0 && vo.getGoodsRegistSttus() == 1004){ //즉시검토완료
                    // 검토완료 메일보내기
                    goodsExmntCompleteMail(request,model,vo);
                }else if(insertHistoryRows > 0 && vo.getGoodsRegistSttus() == 1007){//즉시 승인완료
                    //서비스완료 메일보내기
                    goodsCompleteMail(request,model,vo);
                }
                /* 20150820 리스트에서 검토 승인 시 이력테이블에 Insert 끝  */
            }

            return responseJson(model, true);
        }
        return responseJson(model, false);
    }

    /**
     * ctgryList (카테고리 목록)
     * @param vo
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_ctgryList.do", method=RequestMethod.POST)
    public String ctgryList(GoodsManageVO vo, ModelMap model){

        return responseJson(model, service.ctgryList(vo));
    }

    /**
     * 서비스 상세조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cnslDetail.do")
    public void goodsView(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));

    }

    /**
     * 서비스 상세조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cnslExmntDetail.do")
    public void goodsExmntView(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));

    }

    /**
     * 서비스 상세조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cnslConfnDetail.do")
    public void goodsConfnView(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));

    }

    /**
     * 서비스수정
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = {"ND_cnsltIndexUpdate.do","ND_cnsltExmntUpdate.do","ND_cnsltConfnUpdate.do"}, method=RequestMethod.POST )
    public String goodsUpdateAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {
        String urlIndex = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1);
//        OpHelper.bindSearchMap(vo, request);

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile  = new ArrayList<FileVO>();
        List<List<FileVO>> markCrtfcFileList  = new ArrayList<List<FileVO>>();
//        List<FileVO> markCrtfcFile  = new ArrayList<FileVO>();
        List<FileVO> mnlFile  = new ArrayList<FileVO>();


        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if (inputNm.startsWith("imageFile")) {
                imageFile.add(uploadFile.get(i));
            }

            if ("goodsFile".equals(inputNm)) {
                goodsFile.add(uploadFile.get(i));
            }

            if (inputNm.startsWith("markCrtfcFile")) {
                //markCrtfcFile.clear();
                List<FileVO> markCrtfcFile  = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            if (inputNm.startsWith("mnlFile")) {
                mnlFile.add(uploadFile.get(i));
//                uploadFile.get(i).getFileDesc();
            }
        }

        vo.setImageFile(imageFile);
        vo.setGoodsFile(goodsFile);
        vo.setMarkCrtfcFile(markCrtfcFileList);
        vo.setMnlFile(mnlFile);

        Integer[] archtcSeArry = vo.getArchtcSeArry();
        Integer archtcSe = 0;
        if (Validate.isNotEmpty(archtcSeArry)) {
            for (int i=0; i < archtcSeArry.length; i++)
            {
                archtcSe += archtcSeArry[i];
            }
        }
        vo.setArchtcSe(archtcSe);

        // 등록 실행
        Integer key = service.goodsUpdate(vo, request);
        if(Validate.isEmpty(key)) {
            return alertAndBack(model,MessageHelper.getMsg(request, "processFail"));
        } else if (key == -1) {
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsChangeStatus"));
        }

        String url="";
        if (urlIndex.equals("ND_cnsltIndexUpdate.do")) {
            url = "BD_index.do?" + OpHelper.getSearchQueryString(request);
        } else if (urlIndex.equals("ND_cnsltExmntUpdate.do")) {
            // 검토/승인
            vo.setMngrId(loginVo.getMngrId());
            vo.setExmntConfmCd(vo.getGoodsRegistSttus());
            vo.setReturnResn("");
            key = service.reasonAction(vo);

            if(key > 0 && vo.getGoodsRegistSttus() == 1004 ){ // 이메일보내기 ( 검토완료)
                // 검토완료 메일보내기
                goodsExmntCompleteMail(request,model,vo);
            }else if(key > 0 && vo.getGoodsRegistSttus() == 1007 ){ // 이메일보내기 ( 즉시승인)

              //서비스완료 메일보내기
                goodsCompleteMail(request,model,vo);
            }

            url = "BD_cnslExmntList.do?" + OpHelper.getSearchQueryString(request);
        } else if (urlIndex.equals("ND_cnsltConfnUpdate.do")) {
            // 검토/승인
            vo.setMngrId(loginVo.getMngrId());
            vo.setExmntConfmCd(vo.getGoodsRegistSttus());
            vo.setReturnResn("");
            key = service.reasonAction(vo);

            if(key > 0 && vo.getGoodsRegistSttus() == 1004 ){ // 이메일보내기 ( 검토완료)
                // 검토완료 메일보내기
                goodsExmntCompleteMail(request,model,vo);
            }else if(key > 0 && vo.getGoodsRegistSttus() == 1007 ){ // 이메일보내기 ( 즉시승인)

              //서비스완료 메일보내기
                goodsCompleteMail(request,model,vo);
            }

            url = "BD_cnslConfnList.do?" + OpHelper.getSearchQueryString(request);
        }

        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 서비스 등록폼
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cnslForm.do")
    public void goodsForm(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());
        vo.setUpdtId(loginVo.getMngrId());

        OpHelper.bindSearchMap(vo, request);


//        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
    }

    /**
     * 서비스등록
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_goodsInsertAction.do", method=RequestMethod.POST )
    public String goodsInsertAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) 
    {
        //OpHelper.bindSearchMap(vo, request);
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());
        vo.setUpdtId(loginVo.getMngrId());

        List<FileVO> uploadFile = UploadHelper.upload(request, GOODS_IMG_STORE);
        List<FileVO> imageFile = new ArrayList<FileVO>();
        List<FileVO> goodsFile  = new ArrayList<FileVO>();
        List<List<FileVO>> markCrtfcFileList  = new ArrayList<List<FileVO>>();
        //List<FileVO> markCrtfcFile  = new ArrayList<FileVO>();
        List<FileVO> mnlFile  = new ArrayList<FileVO>();

        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if (inputNm.startsWith("imageFile")) {
                imageFile.add(uploadFile.get(i));
            }

            if ("goodsFile".equals(inputNm)) {
                goodsFile.add(uploadFile.get(i));
            }

            if (inputNm.startsWith("markCrtfcFile")) {
                //markCrtfcFile.clear();
                List<FileVO> markCrtfcFile  = new ArrayList<FileVO>();
                markCrtfcFile.add(uploadFile.get(i));
                markCrtfcFileList.add(markCrtfcFile);
            }

            if (inputNm.startsWith("mnlFile")) {
                mnlFile.add(uploadFile.get(i));
            }
        }

        vo.setImageFile(imageFile);
        vo.setGoodsFile(goodsFile);
        vo.setMarkCrtfcFile(markCrtfcFileList);
        vo.setMnlFile(mnlFile);

        Integer[] archtcSeArry = vo.getArchtcSeArry();
        Integer archtcSe = 0;
        if (Validate.isNotEmpty(archtcSeArry)) {
            for (int i=0; i < archtcSeArry.length; i++)
            {
                archtcSe += archtcSeArry[i];
            }
        }
        vo.setArchtcSe(archtcSe);

        // 등록 실행
        Integer key = service.goodsInsert(vo, request);

        // 검토/승인
        vo.setMngrId(loginVo.getMngrId());
        vo.setExmntConfmCd(vo.getGoodsRegistSttus());
        vo.setReturnResn("");
        key = service.reasonAction(vo);
        //

        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }else{
            //서비스완료 메일보내기
            goodsCompleteMail(request,model,vo);
        }

        String url = "BD_cnslForm.do";
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 개별 파일 삭제(수정 폼 화면에서 Ajsx 방식으로 삭제)
     */
    @RequestMapping(value = "ND_fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(ModelMap model, FileVO fileVO, HttpServletRequest request) {
//        setBoardService(request); // 게시판 유형 서비스 설정
        int affected = service.fileDelete(fileVO);

        if(affected < 1) {
            return responseJson(model, StringUtil.ZERO);
        }

        return responseJson(model, affected);
    }

    /**
     * 삭제
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_goodsDeleteAction.do", method = RequestMethod.POST)
    public String goodsDeleteAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        Integer orderCnt = service.orderCnt(vo);
        if (orderCnt > 0) {
            return alertAndBack(model, "현재 구매가 진행중인 건이 있어 삭제를 진행할 수 없습니다.");
        }
        Integer cnt = service.goodsDelete(vo, request);
        if(cnt != 1) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }

        String url = "BD_index.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 검토대기로 보내기
     *
     * @param request
     * @param model
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_registUpdateAction.do", method = RequestMethod.POST)
    public String registUpdateAction(HttpServletRequest request, ModelMap model, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        Integer cnt = service.registUpdate(vo, request);
        if(cnt != 1) {
            return alertAndBack(model, Messages.COMMON_VALIDATE_FAIL);
        }

        String url = "BD_index.do?" + OpHelper.getSearchQueryString(request);
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * ctgrySelect (카테고리 선택)
     * @param vo
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_ctgrySelect.do", method=RequestMethod.POST)
    public String ctgrySelect(GoodsManageVO vo, ModelMap model) {

        return responseJson(model, service.ctgrySelect(vo));
    }

    @RequestMapping(value = "ND_fileCountChk.do", method = RequestMethod.POST)
    public String fileCountCheck(HttpServletRequest request, ModelMap model){
        Integer fileSeq = Integer.valueOf(request.getParameter("fileSeq"));
        Integer fCnt = Integer.valueOf(request.getParameter("fCnt"));
        Integer maxCnt = Integer.valueOf(request.getParameter("maxCnt"));

        String message = new String(); //retrun 메시지
        message = "";

        Integer cnt = service.fileCount(fileSeq);
        if ((cnt + fCnt) > maxCnt) {
            message = "최대 파일첨부 개수는 " + maxCnt + "개 입니다.";
        }

        return responseText(model, message);
    }

    /**
     * 업로드 파일 종류 및 크기 체크
     */
    @RequestMapping(value = "ND_uploadFileChk.do", method = RequestMethod.POST)
    public String uploadFileCheck(HttpServletRequest request, ModelMap model){

        String fileExtPermit = "";
        String inputName = request.getParameter("inputName");
        if(request.getParameter("fileExt")=="1") {
            fileExtPermit = "txt,gul,pdf,hwp,xls,xlsx,ppt,pptx,doc,docx,jpg,jpeg,gif,bmp,eps,tif,cdr,psd,psp,dxf,dwg,dwf,pp3,pict,png,ai,zip";
        }
//        String fileExtPermit = request.getParameter("fileExt").toLowerCase();

        //킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다.

        long maxFileSize = Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024;

        int result = 100;   // 100 : 패스

        String message = new String(); //retrun 메시지

        // 파일 체크
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
                        }
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
                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 break;
            case 201:
                 message = "파일의 종류는 " + fileExtPermit + " 파일만 가능합니다.";
                 break;
            default:
                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 break;
        }

        return responseText(model, message);

    }

    /**
     * 업로드 이미지 픽셀 및 크기 체크
     */
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
                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize").isEmpty() != true ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 break;
            case 201:
                message = "이미지 파일의 유형(확장자)은 jpg, gif, png 파일만 가능합니다.";
                break;
            case 301:
                 message = "이미지의 가로크기가 "+ minWidthSize +" 보다 작습니다.";
                 break;
            case 302:
                 message = "이미지의 세로크기가 "+ minHeightSize +" 보다 작습니다.";
                 break;
            case 303:
                 message = "이미지의 비율(4:3)이 맞지 않습니다.";
                 break;
            case 304:
                message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다..";
                break;
            case 305:
                message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다.";
                break;
            case 400:
                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 break;
            default:
                 message = "이미지가 확인되지 않았습니다.";
                 break;

        }

        return responseText(model, message);

    }

    /**
     * 서비스변경코드로 내역추가
     */
//    @RequestMapping(value = "ND_chngHistCodeInsert.do", method = RequestMethod.POST)
//    public Integer chngHistCodeInsert(HttpServletRequest request, GoodsManageVO vo, ModelMap model){
//        LoginVO loginVo = OpHelper.getMgrSession(request);
//        vo.setUpdtId(loginVo.getMngrId());
//        return service.chngHistCodeInsert(vo);
//    }

    /**
     * 서비스변경이력 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_goodsChngHist.do")
    public String goodsChngHist( GoodsManageVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsChngHist(vo));
        return "/intra/store/PD_goodsChngHist";
    }

    /**
     * 카테고리 팝업 메인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_categoryPop.do")
    public String categoryPop(CategoryVO vo, ModelMap model) {
        popService.categoryIndex(vo);
        return "/intra/store/PD_categoryPop";
    }

    /**
     * 카테고리 관리 목록 for treeList
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_categoryList.do")
    public String categoryList(CategoryVO vo, ModelMap model) {
        return responseJson(model, popService.categoryList(vo));
    }

    /**
     * 판매자 목록(팝업)
     */
    @RequestMapping(value = "PD_sellerListPop.do")
    public void sellerListPop(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.sellerListPop(vo));
        model.addAttribute("langList", commonService.serviceLangList());
    }

    /**
     * 서비스관리 엑셀
     */
    @RequestMapping(value = "INC_goodsExcel.do")
    public String goodsListExcel(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {

        OpHelper.bindSearchMap(vo, request);

        if(vo.getDataMap().get("q_excel").equals("4")){
            model.put("_goodsList", service.goodsList(vo));
            model.put("q_excelFileName", "승인완료 IT전문가서비스");
        } else if(vo.getDataMap().get("q_excel").equals("5")){
            model.put("_goodsList", service.goodsExmntList(vo));
            model.put("q_excelFileName", "검토대기 IT전문가서비스");
        } else if(vo.getDataMap().get("q_excel").equals("6")){
            model.put("_goodsList", service.goodsConfnList(vo));
            model.put("q_excelFileName", "승인대기 IT전문가서비스");
        }
        model.put("q_excel", vo.getDataMap().get("q_excel")); // 목록별 구분값

        GoodsManageExcelVO GoodsManageExcel = new GoodsManageExcelVO();
        GoodsManageExcel.setModel(model);

        return responseExcel(model, GoodsManageExcel);
    }

    /**
     * 서비스 검토대기 반려사유 팝업
     */
    @RequestMapping(value = "PD_returnReasonPop.do")
    public void returnReasonPop(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);

        if(  vo.getConfmReturnSection() != null && Validate.isNotEmpty(vo.getConfmReturnSection())  && vo.getConfmReturnSection() == 1005){ // 승인반려사유보기 팝업
            if(vo.getExmntConfmCd() == 1005){
                vo.setExmntConfmCd(1005);
                model.addAttribute("dataReason", service.reasonView(vo));
                //검토관리자 정보 조회
                GoodsManageVO eManagerVO = service.eManagerInfo(vo);
                eManagerVO.setConfmReturnSection(1005);
                model.addAttribute("dataVO", eManagerVO);
            }

        }else{//반려팝업
            if(vo.getExmntConfmCd() == 1003){ //검토대기페이지 팝업
                //판매자 정보 조회
                GoodsManageVO sellerInfoVO = service.sellerInfo(vo);
                sellerInfoVO.setExmntConfmCd(vo.getExmntConfmCd());
                model.addAttribute("dataVO",sellerInfoVO );
            }

            if(vo.getExmntConfmCd() == 1005){ // 승인대기페이지 팝업
                vo.setExmntConfmCd(1004);
                model.addAttribute("dataReason", service.reasonView(vo));
                //검토관리자 정보 조회
                GoodsManageVO eManagerVO = service.eManagerInfo(vo);
                model.addAttribute("dataVO", eManagerVO);
            }

        }
    }

    /**
     * 서비스 검토대기 반려사유 등록액션
     */
    @RequestMapping(value = "ND_reasonAction.do")
    public String reasonAction(ModelMap model, HttpServletRequest request, GoodsManageVO vo) {
        OpHelper.bindSearchMap(vo, request);
         LoginVO loginVo = OpHelper.getMgrSession(request);
         vo.setMngrId(loginVo.getMngrId());

         Integer result = service.reasonAction(vo); // 반려사유등록

        if(result != 1){
            return responseText(model, "false");
        }else{
            return responseText(model, "true");
        }
    }

    /**
     * 즉시승인, 관리자 서비스드록시 서비스등록완료 메일/SMS 보내기
     */
    public void goodsCompleteMail(HttpServletRequest request,ModelMap model,  GoodsManageVO vo) {

        GoodsManageVO sellerGoodsVo = vo; // 판매자정보
        GoodsManageVO goodVo = vo; // 서비스정보

        RegisterUserVO registerVo = new RegisterUserVO();

      //판매자+서비스정보 조회
        sellerGoodsVo = service.sellerInfo(vo);

        if(sellerGoodsVo != null && Validate.isNotEmpty(sellerGoodsVo.getGoodsChargerEmail())){
            registerVo.setUserNm(sellerGoodsVo.getGoodsChargerNm());
            registerVo.setEmail(sellerGoodsVo.getGoodsChargerEmail());
            registerVo.setMbtlnum(sellerGoodsVo.getGoodsChargerMbtlnum());
            registerVo.setUserTyCd(sellerGoodsVo.getUserTyCd());

            goodVo = service.goodsView(vo);
            goodVo.setMailSection(43);
            //이메일 전송
            emailCrtfcAction(request, model, goodVo, registerVo);
        }
    }

    /**
     * 검토대기완료 메일 보내기
     */
    public void goodsExmntCompleteMail(HttpServletRequest request,ModelMap model,  GoodsManageVO vo) {

        GoodsManageVO goodVo = vo; // 서비스정보

        RegisterUserVO registerVo = new RegisterUserVO();

      //관리자 정보(승인권한관리자)
        vo.setAuthCode("omp_gdcf_adm");
        List<GoodsManageVO> eManagerList = service.eManagerAuthInfo(vo);//구매자 정보

        for(int i = 0 ; i < eManagerList.size() ; i++) {
            if(Validate.isNotEmpty(eManagerList.get(i).getEmail())){

                registerVo.setUserNm(eManagerList.get(i).getMngrNm());
                registerVo.setEmail(eManagerList.get(i).getEmail());

                goodVo = service.goodsView(vo);
                goodVo.setMailSection(42);
                //이메일 전송
                emailCrtfcAction(request, model, goodVo, registerVo);
            }
        }
    }

    /**
     * 이메일 발송 액션
     * emailCrtfcAction 설명
     * @param request
     * @param model
     * @param vo
     * @return
     */
    public boolean emailCrtfcAction(HttpServletRequest request, ModelMap model, GoodsManageVO goodsVo, RegisterUserVO vo) {

        //이력 쌓기
//        registerService.mailCrtfcInsert(vo);
        String hostNm = ""; // 현재접속 서브도메인
        String rtnurl = ""; // 가입계속 시 들어오게 될 URL
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
            if("00".equals(goodsVo.getLangCode())) { // 한국어사이트
                if(goodsVo.getMailSection() == 42){autoMap.put("automailId", AutoMailTemplate.KOR_GOOD_CNFM);}
                if(goodsVo.getMailSection() == 43){autoMap.put("automailId", AutoMailTemplate.KOR_GOOD_REG);}
                hostNm="korean";
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm()); // 수신자명
            autoMap.put("email", vo.getEmail()); // 수신이메일주소
            /*
             * 메일 템플릿에 적용될 치환값 :
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("productTitle", goodsVo.getGoodsNm());
            oneToOneInfoMap.put("productContents",goodsVo.getGoodsSumry());

            oneToOneInfoMap.put("productImg", goodsVo.getImageFile().get(0).getFileUrl());
            // 이전소스
            //String productUrl = "http://" + hostNm + ".ceart.kr/" + hostNm+"/pt/store/premium/BD_view.do?goodsCode="+goodsVo.getGoodsCode();
            
            //{{ BH, 2015.12.03, 도메인관리삭제로 인한 소스변경 
            // 변경소스
            String productUrl = "http://"+GlobalConfig.DOMAIN_SUBNM+"/" + hostNm+"/pt/store/premium/BD_view.do?goodsCode="+goodsVo.getGoodsCode();
            //}}
            oneToOneInfoMap.put("productUrl", productUrl); // 상세페이지

            if(goodsVo.getMailSection() == 42){
                // 이전소스
                //rtnurl = "http://intra.ceart.kr/intra/explorer/ND_index.do";//관리자페이지
                
                //{{ BH, 2015.12.03, 도메인관리삭제로 인한 소스변경 
                // 변경소스
                rtnurl = "http://"+GlobalConfig.DOMAIN_ADMNM+"/intra/explorer/ND_index.do";//관리자페이지
                //}}
                
            }else if(goodsVo.getMailSection() == 43){
                //이전소스
                //rtnurl = "http://"+hostNm+".ceart.kr/"+hostNm+"/pt/sale/goods/BD_goodsList.do";//서비스관리목록페이지
                
                //{{ BH, 2015.12.03, 도메인관리삭제로 인한 소스변경 
                // 변경소스
                rtnurl = "http://"+GlobalConfig.DOMAIN_SUBNM+"/"+hostNm+"/pt/sale/goods/BD_goodsList.do";//서비스관리목록페이지
                //}}
            }
            oneToOneInfoMap.put("rtnurl", rtnurl);

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓

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

            /** SMS발송시작 **/
            if(goodsVo.getMailSection() == 43){
                if(vo.getMbtlnum() != null){
                    Map<String, Object> smsMap = new HashMap<String, Object>();

                    //SMS발송 및 전송이력쌓기
                    SmsTransHistConstant shc = new SmsTransHistConstant();
                    //수신번호-필수
                    smsMap.put("rcvNo", vo.getMbtlnum());
                    //발신내용-필수
                    if("00".equals(goodsVo.getLangCode())) { // 한국어사이트
                        smsMap.put("msg", shc.getSmsMsg("243"));
                    }else if("01".equals(goodsVo.getLangCode())) { // 영어사이트
                        smsMap.put("msg", shc.getSmsMsg("343"));
                    }else if("06".equals(goodsVo.getLangCode())) { // 스페인어사이트
                        smsMap.put("msg", shc.getSmsMsg("443"));
                    }

                    //업무코드
                    smsMap.put("dutyCd", "ST");
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
            }
                /** SMS발송끝 **/

            return result;
    }

}