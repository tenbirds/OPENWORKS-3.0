package zes.openworks.intra.note;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.base.vo.TreeVO;
import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;
import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.mgr.MgrVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class NoteDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;
    private final String HIGH_TREE_CD = String.valueOf(GlobalConfig.HIGH_TREE_CD);

    /**
     * 쪽지함 목록
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<NoteVO> list(NoteVO noteVo) {
        Map<String, Object> parameterMap = noteVo.getDataMap();
        parameterMap.put("mgrId", noteVo.getMngrId());
        parameterMap.put("flag", String.valueOf(noteVo.getFlag()));
        List<NoteVO> dataList = list("_note.list", parameterMap);
        /* 목록에 파일시퀀스 추가 */
        for(NoteVO dataVO : dataList) {
            dataVO.setFileList(fileDao.getFiles(dataVO.getFileSeq()));
        }

        noteVo.setTotalNum((Integer) selectByPk("_note.listCount", parameterMap));

        return new Pager<NoteVO>(dataList, noteVo);
    }

    /**
     * 쪽지함 상세 얻기
     * 
     * @param vo
     * @return
     */
    public NoteVO noteView(NoteVO noteVo) {

        NoteVO dataVo = (NoteVO) selectByPk("_note.noteView", noteVo);
        /* 본인 수신 협조전 && 수신일이 없을 경우 수신일 업데이트 */
        if(noteVo.getMngrId().equals(noteVo.getMngrId()) &&
            Validate.isEmpty(noteVo.getReadDt())) {

            noteVo.setReadDt(DateFormatUtil.getTodayFull());
            dataVo.setReadDt(DateFormatUtil.parseDateFullISO(noteVo.getReadDt()));

            update("_note.noteReadUpdate", noteVo);
        }
        return dataVo;
    }

    /**
     * 관리자 상세 정보
     * 
     * @param mgrVo
     * @return
     */
    public MgrVO mgrView(MgrVO mgrVo) {
        MgrVO dataVo = (MgrVO) selectByPk("_note.mgrView", mgrVo);

        if(dataVo != null && Validate.isNotEmpty(dataVo.getMngrPassword())) {
            Crypto cry = CryptoFactory.getInstance();
            String encryptPwd = cry.decrypt(dataVo.getMngrPassword());

            dataVo.setMngrPassword(encryptPwd);
        }

        return dataVo;
    }

    /**
     * 쪽지 등록
     * 
     * @param noteVo
     * @return
     */
    public int insertAction(NoteVO noteVo) {
        /* 쪽지등록 시 파일 등록 추가 2013.04 김영상 */
        int fileSeq = fileDao.saveFile(noteVo.getFileList(), noteVo.getFileSeq());
        noteVo.setFileSeq(fileSeq);
        return update("_note.noteInsert", noteVo);
    }

    /**
     * 쪽지 삭제(복수)
     * 
     * @param noteVo
     * @return
     */
    public int deleteAll(NoteVO noteVo) {

        return update("_note.noteDeleteAll", noteVo);
    }

    /**
     * 쪽지 삭제
     * 
     * @param noteVo
     * @return
     */
    public int deleteOne(NoteVO noteVo) {
        return update("_note.noteDelete", noteVo);
    }

    /**
     * 받은 쪽지 알림
     */
    public Integer myNoteCount(String mgrId) {

        Integer myNoteCount = (Integer) selectByPk("_note.myNoteCount", mgrId);

        if(myNoteCount.intValue() > 0) {
            update("_note.myNoteAlimComplete", mgrId);
        }

        return myNoteCount;
    }

    /**
     * deptUserTreeList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<TreeVO> deptUserTreeList(NoteVO vo) {
        if(Validate.isEmpty(vo.getHighDeptCd())) {
            vo.setHighDeptCd(HIGH_TREE_CD);
        }

        return list("_note.TreeList", vo);
    }

    /**
     * depKey 설명
     * 
     * @param vo
     * @return
     */
    public NoteVO depKey(NoteVO vo) {
        return (NoteVO) selectByPk("_deptn.deptKey", vo);
    }

    /**
     * deptView 설명
     * 
     * @param vo
     * @return
     */
    public NoteVO deptView(NoteVO vo) {
        return (NoteVO) selectByPk("_deptn.view", vo);
    }

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    public boolean fileDelete(List<FileVO> fileList) {
        int deleteCnt = 0;
        if(Validate.isNotEmpty(fileList)) {
            // 물리적인 첨부파일 삭제
            for(FileVO fileVO : fileList) {
                if(FileUtil.delete(GlobalConfig.UPLOAD_ROOT + fileVO.getFileUrl())) {
                    deleteCnt++;
                }
            }
        }
        return (deleteCnt == fileList.size()) ? true : false;
    }
}
