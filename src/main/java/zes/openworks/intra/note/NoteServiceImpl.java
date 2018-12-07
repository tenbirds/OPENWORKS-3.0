package zes.openworks.intra.note;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.mgr.MgrVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("noteService")
public class NoteServiceImpl extends AbstractServiceImpl implements NoteService {

    @Resource
    private FileDAO fileDao;

    @Resource
    private NoteDAO dao;

    /**
     * 쪽지함 목록
     */
    @Override
    public Pager<NoteVO> list(NoteVO noteVo) {
        return dao.list(noteVo);
    }

    /**
     * 쪽지함 상세 조회
     */
    @Override
    public NoteVO noteView(NoteVO noteVo) {
        return dao.noteView(noteVo);
    }

    /**
     * 담당자 상세 조회
     */
    @Override
    public MgrVO mgrView(String mgrId) {
        MgrVO _mgrBean = new MgrVO();
        _mgrBean.setMngrId(mgrId);
        return dao.mgrView(_mgrBean);
    }

    /**
     * 쪽지 등록
     */
    @Override
    public int insertAction(NoteVO noteVo) {

        String datas = noteVo.getReceivers();
        /* 보낸 협조전 저장여부 */
        if("Y".equals(noteVo.getSenderDelYn())) {
            noteVo.setSenderDelYn("N");
        }
        else {
            noteVo.setSenderDelYn("Y");
        }

        if(Validate.isNotEmpty(datas)) {
            String[] receivers = StringUtil.split(datas, ",");
            for(int i = 0 ; i < receivers.length ; i++) {
                if(Validate.isEmpty(receivers[i])) {
                    continue;
                }
                noteVo.setMngrId(receivers[i]);
                dao.insertAction(noteVo);
            }
        }

        return StringUtil.ONE;
    }

    /**
     * 쪽지 삭제
     */
    @Override
    public int deleteAction(NoteVO noteVo) {
        String[] seqs = noteVo.getSeqs();
        if(Validate.isNotEmpty(seqs)) {
            return dao.deleteAll(noteVo);
        } else {
            return dao.deleteOne(noteVo);
        }
    }

    /**
     * 받은 쪽지 알림
     * 
     * @param vo
     * @return Integer
     */
    @Override
    public Integer myNoteCount(String mgrId) {
        return dao.myNoteCount(mgrId);
    }

    @Override
    public List<TreeVO> deptUserTreeList(NoteVO vo) {
        return dao.deptUserTreeList(vo);
    }

    @Override
    public NoteVO deptKey(NoteVO vo) {

        return dao.depKey(vo);
    }

    @Override
    public NoteVO deptView(NoteVO vo) {

        return dao.deptView(vo);
    }

    /**
     * 첨부파일 개별 삭제 액션
     */
    @Override
    public int fileDelete(FileVO fileVO) {
        int affected = fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
        return affected;
    }

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    @Override
    public boolean fileDelete(List<FileVO> fileList) {
        return dao.fileDelete(fileList);
    }
}
