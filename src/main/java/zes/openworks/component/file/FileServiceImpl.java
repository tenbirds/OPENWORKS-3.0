package zes.openworks.component.file;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("filesService")
public class FileServiceImpl extends AbstractServiceImpl implements FileService {

    @Resource
    private FileDAO dao;

    @Override
    public List<FileVO> getFiles(Integer fileSeq) {
        return dao.getFiles(fileSeq);
    }

    @Override
    public FileVO getFile(String fileId) {
        return dao.getFile(fileId);
    }

    @Override
    public int saveFile(List<FileVO> fileList) {
        return dao.saveFile(fileList);
    }

    @Override
    public int saveFile(List<FileVO> fileList, Integer fileSeq) {
        return dao.saveFile(fileList, fileSeq);
    }

    @Override
    public int saveFile(List<FileVO> fileList, Integer fileSeq, String inputNm) {
        return dao.saveFile(fileList, fileSeq, inputNm);
    }

    @Override
    public int updateFile(HttpServletRequest request) {

        String[] fileIds = request.getParameterValues("fileId");
        String[] orderNos = request.getParameterValues("orderNo");
        String[] localNms = request.getParameterValues("localNm");
        String[] fileDescs = request.getParameterValues("fileDesc");

        FileVO fileVo;
        List<FileVO> fileList = new ArrayList<FileVO>();

        int fileCnt = orderNos.length;
        for(int i = 0 ; i < fileCnt ; i++) {
            fileVo = new FileVO();
            fileVo.setFileId(fileIds[i]);
            fileVo.setOrderNo(new Integer(orderNos[i]));
            fileVo.setLocalNm(localNms[i]);
            fileVo.setFileDesc(fileDescs[i]);
            fileList.add(fileVo);
        }

        return dao.updateFile(fileList);
    }

    @Override
    public int removeFile(Integer fileSeq) {
        return dao.removeFile(fileSeq);
    }

    @Override
    public int removeFile(Integer fileSeq, String fileId) {
        return dao.removeFile(fileSeq, fileId);
    }

    @Override
    public int removeFile(Integer fileSeq, String[] fileIds) {
        return dao.removeFile(fileSeq, fileIds);
    }

    @Override
    public int updateFileDown(HttpServletRequest request, String fileId) {
        return dao.updateFileDown(request, fileId);
    }

    @Override
    public int replaceFile(List<FileVO> fileList, Integer fileSeq, String inputNm) {
        return dao.replaceFile(fileList, fileSeq, inputNm);
    }

    @Override
    public Pager<?> getFileLogs(FileLogVO vo) {
        return dao.fileLogList(vo);
    }

}
