package zes.openworks.intra.note;

import java.util.List;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.base.vo.TreeVO;
import zes.openworks.intra.mgr.MgrVO;

public interface NoteService {

    /**
     * 쪽지함 목록
     * 
     * @param vo
     * @return
     */
    Pager<NoteVO> list(NoteVO noteVo);

    /**
     * 쪽지함 상세조회
     * 
     * @param vo
     * @return
     */
    NoteVO noteView(NoteVO noteVo);

    /**
     * 담당자 상세조회
     * 
     * @param mgrId
     * @return
     */
    MgrVO mgrView(String mgrBean);

    /**
     * 쪽지 보내기
     * 
     * @param vo
     * @return
     */
    int insertAction(NoteVO noteVo);

    /**
     * 쪽지 삭제
     * 
     * @param vo
     * @return
     */
    int deleteAction(NoteVO noteVo);

    /**
     * 받은 쪽지 알림
     * 
     * @param vo
     * @return Integer
     */
    Integer myNoteCount(String mgrId);

    /**
     * deptUserTreeList 설명
     * 
     * @param vo
     * @return
     */
    List<TreeVO> deptUserTreeList(NoteVO vo);

    /**
     * deptKey 설명
     * 
     * @param vo
     * @return
     */
    NoteVO deptKey(NoteVO vo);

    /**
     * deptView 설명
     * 
     * @param vo
     * @return
     */
    NoteVO deptView(NoteVO vo);

    /**
     * 개별 파일 삭제 액션
     */
    int fileDelete(FileVO fileVO);

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    boolean fileDelete(List<FileVO> fileList);
}
