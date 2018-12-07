package zes.openworks.component.file;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.web.login.UserLoginVO;

@SuppressWarnings("unchecked")
@Repository("filesDAO")
public class FileDAO extends EgovAbstractMapper {

    /**
     * 신규 파일 일련번호 추출
     * 
     * @param fileList 첨부파일 목록(업로드 파일이 있는지 확인용)
     * @return
     */
    private synchronized int getMaxFileSeq(List<FileVO> fileList) {

        if(Validate.isEmpty(fileList)) {
            return -1;
        }

        return (Integer) selectByPk("zes.openworks.component.file.getMaxFileSeq", null);
    }

    /**
     * 파일 일련번호와 일치하는 모든 파일목록을 반환
     * 
     * @param fileSeq 첨부파일 일련번호
     * @return
     */
    public List<FileVO> getFiles(Integer fileSeq) {

        return list("zes.openworks.component.file.getFiles", fileSeq);
    }
    public List<FileVO> getFiles1(Integer fileSeq) {

        return list("zes.openworks.component.file.getFiles1", fileSeq);
    }

    /**
     * 파일 고유 ID로 하나의 파일 정보를 반환
     * 
     * @param fileId 파일 고유 ID
     * @return
     */
    public FileVO getFile(String fileId) {

        return (FileVO) selectByPk("zes.openworks.component.file.getFile", fileId);
    }

    /**
     * 파일 목록 저장
     * 
     * @param fileList 추가할 파일 목록
     * @return
     */
    public int saveFile(List<FileVO> fileList) {

        return saveFile(fileList, -1);
    }

    /**
     * 이미 저장되어 있는 일련번호 그룹에 추가 저장
     * 
     * @param fileList 추가할 파일 목록
     * @param fileSeq 저장할 파일들의 일련번호
     * @return
     */
    public int saveFile(List<FileVO> fileList, Integer fileSeq) {

        return saveFile(fileList, fileSeq, null);
    }

    /**
     * 이미 저장되어 있는 일련번호 그룹에 추가 저장하며, 화면 UI의 input 태그의 name 속성을 함께 저장한다.
     * 
     * @param fileList 추가할 파일 목록
     * @param fileSeq 저장할 파일들의 일련번호
     * @param inputNm 화면 UI의 input 태그의 name 속성
     * @return
     */
    public int saveFile(List<FileVO> fileList, Integer fileSeq, String inputNm) {

        int _fileSeq = fileSeq;

        if(Validate.isNotEmpty(fileList)) {

            if(_fileSeq <= 0) {
                _fileSeq = getMaxFileSeq(fileList);
            }

            for(FileVO baseFileVo : fileList) {
                baseFileVo.setFileSeq(_fileSeq);
                
                insert("zes.openworks.component.file.insertFile", baseFileVo);
            }
        }
        return _fileSeq;
    }

    public int saveFileToFirst(List<FileVO> fileList, Integer fileSeq) {

        int _fileSeq = fileSeq;

        if(Validate.isNotEmpty(fileList)) {

            if(_fileSeq <= 0) {
                _fileSeq = getMaxFileSeq(fileList);
            }

            for(FileVO baseFileVo : fileList) // 어차피 하나만 들어옴.. 
            {
                baseFileVo.setFileSeq(_fileSeq);
                //update("zes.openworks.component.file.updateFileShiftOrdNo", baseFileVo);
                delete("zes.openworks.component.file.deleteFileOrdNo", baseFileVo);
//                insert("zes.openworks.component.file.insertFileToFirst", baseFileVo);
                update("zes.openworks.component.file.updateMainFile", baseFileVo);                
            }
        }
        return _fileSeq;
    }
    public int saveFileToFirstUpdate(List<FileVO> fileList, Integer fileSeq, String goodsCode) {

        int _fileSeq = fileSeq;
//
        if(Validate.isNotEmpty(fileList)) {

            if(_fileSeq <= 0) {
                _fileSeq = getMaxFileSeq(fileList);
                               
            }

            
            //int _fileSeq2 = (Integer) selectByPk("zes.openworks.component.file.getFileSeqByFileId", goodsCode);
            
            
            
            for(FileVO baseFileVo : fileList) // 어차피 하나만 들어옴.. 
            {
                baseFileVo.setFileSeq(_fileSeq);
                //baseFileVo.setGoodsImageFileSeq(_fileSeq2);                
                //update("zes.openworks.component.file.updateFileShiftOrdNo", baseFileVo);
                delete("zes.openworks.component.file.deleteFileOrdNo", baseFileVo);
                //insert("zes.openworks.component.file.insertFileToFirst", baseFileVo);
                update("zes.openworks.component.file.updateMainFile", baseFileVo);                
            }
        }
        return _fileSeq;
    }

    /**
     * 저장되어 있는 파일정보를 수정한다.
     * 수정 내용은 파일명, 정렬순서, 파일설명(이미지의 경우 접근성 내용)만 가능하다.
     * 
     * @param fileList
     * @return
     */
    public int updateFile(List<FileVO> fileList) {
        int updateCnt = 0;

        for(FileVO fileVo : fileList) {
            fileVo.setFileDesc(fileVo.getFileDesc().trim());
            updateCnt += update("zes.openworks.component.file.updateFile", fileVo);
        }

        return updateCnt;
    }
    
    //{{BH, 2016.01.15 서비스메인이미지 수정 추가
    public int updateMainFile(List<FileVO> fileList, Integer fileSeq) {
        int updateCnt = 0;

        for(FileVO fileVo : fileList) {
            fileVo.setFileSeq(fileSeq);
            // 기존 이미지파일 다운로드 로그 삭제
            delete("zes.openworks.component.file.downLoadFileLog", fileVo);
            
            updateCnt += update("zes.openworks.component.file.updateMainFile", fileVo);
        }

        return updateCnt;
    }
    //}}

    /**
     * 파일 일련번호,ordrNo 에 해당하는 한개의 파일을 삭제한다.
     * DB와 물리적 파일을 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @return
     */
    public int removeFile(Integer fileSeq,Integer fileOrdrNo) {

        int affected = 0;

        if (fileSeq <= 0) { return affected; }
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("fileSeq", fileSeq);
        map.put("fileOrdrNo", fileOrdrNo);        

        List<FileVO> fileList = list("zes.openworks.component.file.getFilesOrdr", map);

        // DB 파일을 삭제한다.
        affected = delete("zes.openworks.component.file.deleteFilesOrdr", map);

        if (affected > 0) 
        {
            // 물리적 파일을 삭제한다.
            for(FileVO baseFileVo : fileList) 
            {
                FileUtil.delete(GlobalConfig.UPLOAD_ROOT + baseFileVo.getFileUrl());
            }
        }
        return affected;
    }

    /**
     * 파일 일련번호에 해당하는 모든 파일을 삭제한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @return
     */
    public int removeFile(Integer fileSeq) {

        int affected = 0;

        if(fileSeq <= 0) {
            return affected;
        }

        List<FileVO> fileList = list("zes.openworks.component.file.getFiles", fileSeq);

        affected = delete("zes.openworks.component.file.deleteFiles", fileSeq);

        if(affected > 0) {
            for(FileVO baseFileVo : fileList) {
                FileUtil.delete(GlobalConfig.UPLOAD_ROOT + baseFileVo.getFileUrl());
            }
        }
        return affected;
    }

    /**
     * 파일 고유 ID를 통하여 하나의 파일을 삭제 한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @param fileId 삭제할 파일의 고유 id
     * @return
     */
    public int removeFile(Integer fileSeq, String fileId) {

        return removeFile(fileSeq, new String[] { fileId });
    }

    /**
     * 일련번호에 해당하는 파일중 지정된 고유 ID에 해당하는 파일들을 삭제한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @param fileIds 삭제할 파일의 고유 id 목록
     * @return
     */
    public int removeFile(Integer fileSeq, String[] fileIds) {

        int affected = 0;

        if(fileSeq <= 0) {
            return affected;
        }

        if(Validate.isNotEmpty(fileIds)) {

            List<FileVO> fileList = list("zes.openworks.component.file.getFiles", fileSeq);

            for(String fileId : fileIds) {
                for(FileVO baseFileVo : fileList) {
                    if(fileId.equals(baseFileVo.getFileId())) {

                        FileUtil.delete(GlobalConfig.UPLOAD_ROOT + baseFileVo.getFileUrl());

                        affected += delete("zes.openworks.component.file.deleteFile", baseFileVo);
                        break;
                    }
                }
            }
        }
        return affected;
    }

    /**
     * 파일 교체(기존 파일 삭제후 신규 등록)
     * 
     * @param fileList 파일 목록
     * @param fileSeq 파일 일련 번호
     * @param inputNm 화면 UI의 input 태그의 name 속성
     * @return
     */
    public int replaceFile(List<FileVO> fileList, Integer fileSeq, String inputNm) {

        int affected = 0;

        if(fileSeq <= 0) {
            return affected;
        }
        if(Validate.isEmpty(inputNm)) {
            return affected;
        }
        if(Validate.isEmpty(fileList)) {
            return affected;
        }

        List<FileVO> dataList = list("zes.openworks.component.file.getFiles", fileSeq);
        for(FileVO baseFileVo : dataList) {
            if(inputNm.equals(baseFileVo.getInputNm())) {
                FileUtil.delete(GlobalConfig.UPLOAD_ROOT + baseFileVo.getFileUrl());
                affected += delete("zes.openworks.component.file.deleteFile", baseFileVo);
            }
        }

        return saveFile(fileList, fileSeq, inputNm);
    }

    /**
     * 파일 다운로드 이력을 남기고 다운로드
     * 
     * @param request 웹 요청 객체
     * @param fileId 첨부파일 고유 ID
     * @return
     */
    public int updateFileDown(HttpServletRequest request, String fileId) {

        int affected = update("zes.openworks.component.file.updateFileDown", fileId);

        if(affected == StringUtil.ONE) {

            // 다운로드 로그 기록
            FileLogVO logVo = new FileLogVO();
            logVo.setFileId(fileId);
            LoginVO mgrVo = OpHelper.getMgrSession(request);
            if(Validate.isNotEmpty(mgrVo) && Validate.isNotEmpty(mgrVo.getMngrId())) {
                logVo.setWorkerNm(mgrVo.getMngrNm());
            } else {
                UserLoginVO userLoginVo = OpHelper.getUserSession(request);
                if(Validate.isNotEmpty(userLoginVo) && Validate.isNotEmpty(userLoginVo.getUserId())) {
                    logVo.setWorkerNm(userLoginVo.getUserNm());
                } else {
                    logVo.setWorkerNm("비회원");
                }
            }
            Integer fileSeq = (Integer) selectByPk(
                "zes.openworks.component.file.getFileSeqByFileId", fileId);
            if(fileSeq != null) {
                logVo.setFileSeq(fileSeq);
                insert("zes.openworks.component.file.insertFileLog", logVo);
            }
        }
        return affected;
    }

    /**
     * 파일별 파일 다운로드 이력 목록
     * 
     * @param vo 이력을 확인 할 파일 정보
     * @return
     */
    public Pager<?> fileLogList(FileLogVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("fileSeq", vo.getFileSeq());
        parameterMap.put("fileId", vo.getFileId());

        List<FileLogVO> dataList = list("zes.openworks.component.file.getFileLogs", parameterMap);
        vo.setTotalNum((Integer) selectByPk("zes.openworks.component.file.getFileLogCount",
            parameterMap));

        return new Pager<FileLogVO>(dataList, vo);
    }
}
