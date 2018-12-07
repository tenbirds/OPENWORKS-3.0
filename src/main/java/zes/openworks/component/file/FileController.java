package zes.openworks.component.file;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import zes.base.spring.GeneralController;
import zes.base.spring.view.DownloadView;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.spi.compress.ZipCompress;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;

@Controller
@RequestMapping(value = "/component/file")
public class FileController extends GeneralController {

    @Autowired
    FileService service;
    

    /**
     * 에디터 파일 업로드
     */
    @RequestMapping(value = "ND_fileUpload.do")
    public String fileUpload(HttpServletResponse response, HttpServletRequest request, ModelMap model) {

        response.setContentType("text/html");

        List<FileVO> fileList = UploadHelper.upload(request, "ckeditor", Boolean.TRUE);

        String fileUrl = "";
        String funcNum = request.getParameter("CKEditorFuncNum");

        FileVO fileVo = null;
        if(fileList.size() > 0) {
            service.saveFile(fileList, -1, "CKEditor");
            fileVo = fileList.get(0);
            fileUrl = fileVo.getFileUrl();
        }

        String script = "<script type='text/javascript'>parent.CKEDITOR.tools.callFunction('" + funcNum + "','" + fileUrl + "','');</script>";

        return responseHtml(model, script);

    }

    /**
     * 파일정보 수정 폼
     */
    @RequestMapping(value = "PD_fileUpdateForm.do")
    public void updateFileForm(HttpServletRequest request, ModelMap model,
        @RequestParam(value = "fileSeq", required = true) Integer fileSeq) {

        List<FileVO> fileList = service.getFiles(fileSeq);

        String fileName;
        int pos;
        for(FileVO fileVo : fileList) {
            fileName = fileVo.getLocalNm();
            pos = fileName.lastIndexOf(".");
            if(pos > -1) {
                fileVo.setLocalNm(fileName.substring(0, pos));
            }
        }

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, fileList);
    }

    /**
     * 파일 정보 수정
     */
    @RequestMapping(value = "ND_fileUpdate.do")
    public String updateFile(HttpServletRequest request, ModelMap model) {

        int updateCnt = service.updateFile(request);

        if(updateCnt <= 0) {
            return responseJson(model, Messages.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        return responseJson(model, Messages.TRUE, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 파일 다운로드
     * @throws Exception 
     */
    @RequestMapping(value = "ND_fileDownload.do", method = RequestMethod.GET)
    public String fileDownload(@RequestParam(value = "id", required = true) String id,
        HttpServletRequest request, ModelMap model, HttpServletResponse response ) {

        FileVO fileVo = service.getFile(id);
        if(fileVo != null) {
            service.updateFileDown(request, id);
        }
        
        return responseDownload(model, fileVo/*, response, request*/);
    }

    /**
     * 파일 다운로드 (파일 URL 직접 호출)
     */
    @RequestMapping(value = "ND_directDownload.do", method = RequestMethod.GET)
    public String directDownload(@RequestParam(value = "fn", required = true) String fn,
        @RequestParam(value = "fp", required = true) String fp, HttpServletRequest request,
        ModelMap model) {        
            
            // 보안문제를 발생시킬수 있는 파라이터가 있는 경우 강제 오류 발생
            if(fp.indexOf("..") > -1 || fp.indexOf("%") > -1 || fp.indexOf("&") > -1 || fn.indexOf("..") > -1) {
                return responseDownload(model, new String());
            }
            
            FileVO fileVo = new FileVO();
            File file = new File(GlobalConfig.UPLOAD_ROOT + fp);

            //파일이 없을수도 있음
            if(!file.isFile()){
                return responseDownload(model, new String()); 
            }
            
            if(file.exists()) {
                fileVo.setLocalNm(fn);
                fileVo.setFileUrl(fp);
                
            } else {
                fileVo.setLocalNm(StringUtil.EMPTY);
                fileVo.setFileUrl(StringUtil.EMPTY);

            }

            return responseDownload(model, fileVo);
            

    }

    /**
     * 첨부파일들 압축 다운로드
     * 
     * @throws Exception
     */
    @RequestMapping("zipdownload.do")
    public Object zipdownload(HttpServletRequest request, ModelMap model,
        @RequestParam("fileSeq") int fileSeq) throws Exception {

        List<FileVO> fileList = service.getFiles(fileSeq);

        String zipPath = GlobalConfig.WEBAPP_ROOT + "/zipdown";
        String zipFileName = "CompressDown_" + fileSeq + ".zip";

        File zipFile = null;

        try {
            zipFile = ZipCompress.compressVO(fileList, zipPath, zipFileName);
        } catch (Exception e) {}

        for(FileVO fileVo : fileList) {
            service.updateFileDown(request, fileVo.getFileId());
        }

        return responseDownload(model, zipFile);
    }

    /**
     * 파일 다운로드 로그 목록 조회
     */
    @RequestMapping(value = "PD_fileLogList.do", method = RequestMethod.GET)
    public void fileLogList(FileLogVO vo, HttpServletRequest request, ModelMap model) {

        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.getFileLogs(vo));
    }
}
