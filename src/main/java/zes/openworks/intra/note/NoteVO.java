package zes.openworks.intra.note;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.Required;

public class NoteVO extends PaggingVO {

    private static final long serialVersionUID = 5191395027553292087L;

    /** 보낸 쪽지함 구분 키 */
    public static final int RECEIVE = 1;
    /** 받은 쪽지함 구분 키 */
    public static final int SEND = 2;
    /** 상위코드 */
    private String highDeptCd;
    /** 부서코드 */
    private String deptCd;

    /** KEY */
    private Integer seq;
    /** 담당자 ID */
    private String mngrId;
    /** 내용 */
    @Required(message = "내용은 필수 입력입니다.")
    @RangeLength(min = 10, max = 200)
    private String contents;
    /** 내용요약(제목) */
    private String summary;
    /** 송신자 ID */
    private String senderId;

    /** 등록일 */
    private String regDt;
    /** 수신일 */
    private String readDt;

    /** 담당자 부서명 */
    private String deptNm;
    /** 송신자 부서명 */
    private String senderDeptNm;
    /** 담당자 이름 */
    private String mgrNm;
    /** 송신자 이름 */
    private String senderNm;

    /** 받은, 보낸 쪽지함 구분 */
    private Integer flag = RECEIVE;

    /** 보낸 쪽지함 저장 여부 */
    private String senderDelYn;
    /** 수신자 목록 (','로 구분해서 넘어옴) */
    private String receivers;

    /** 부서키 */
    private String deptKey;

    /** 파일순번 */
    private Integer fileSeq = -1;
    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 체크된 첨부파일 목록 (수정 시) */
    private String[] fileIds;
    /** 첨부파일 수 */
    private Integer fileCnt = 0;

    /** 첨부파일 사용여부 */
    private String fileYn = "Y";
    /** 업로더 종류 */
    private Integer uploadType = 1000;
    /** 최대 업로드 파일수 */
    private Integer maxFileCnt = 3;
    /** 파일 최대 사이즈 */
    private Integer maxFileSize = 0;
    /** 전체 업로드 사이즈 */
    private Integer totalFileSize = 0;
    /** 첨부파일 허용 확장자 ('|' 구분자) */
    private String fileExts;

    /**
     * String deptKey을 반환
     * 
     * @return String deptKey
     */
    public String getDeptKey() {
        return deptKey;
    }

    /**
     * deptKey을 설정
     * 
     * @param deptKey 을(를) String deptKey로 설정
     */
    public void setDeptKey(String deptKey) {
        this.deptKey = deptKey;
    }

    /**
     * String highDeptCd을 반환
     * 
     * @return String highDeptCd
     */
    public String getHighDeptCd() {
        return highDeptCd;
    }

    /**
     * String deptCd을 반환
     * 
     * @return String deptCd
     */
    public String getDeptCd() {
        return deptCd;
    }

    /**
     * highDeptCd을 설정
     * 
     * @param highDeptCd 을(를) String highDeptCd로 설정
     */
    public void setHighDeptCd(String highDeptCd) {
        this.highDeptCd = highDeptCd;
    }

    /**
     * deptCd을 설정
     * 
     * @param deptCd 을(를) String deptCd로 설정
     */
    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    /** 쪽지 목록 : 다중처리 시 사용 */
    private String[] seqs;

    /**
     * @return the seq
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * @return the mgrId
     */
    public String getMngrId() {
        return mngrId;
    }

    /**
     * @return the contents
     */
    public String getContents() {
        return contents;
    }

    /**
     * @return the summary
     */
    public String getSummary() {
        return summary;
    }

    /**
     * @return the senderId
     */
    public String getSenderId() {
        return senderId;
    }

    /**
     * @return the regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * @return the readDt
     */
    public String getReadDt() {
        return readDt;
    }

    /**
     * @return the deptNm
     */
    public String getDeptNm() {
        return deptNm;
    }

    /**
     * @return the senderDeptNm
     */
    public String getSenderDeptNm() {
        return senderDeptNm;
    }

    /**
     * @return the mgrNm
     */
    public String getMgrNm() {
        return mgrNm;
    }

    /**
     * @return the senderNm
     */
    public String getSenderNm() {
        return senderNm;
    }

    /**
     * @return the flag
     */
    public Integer getFlag() {
        return flag;
    }

    /**
     * @return the senderDelYn
     */
    public String getSenderDelYn() {
        return senderDelYn;
    }

    /**
     * @return the receivers
     */
    public String getReceivers() {
        return receivers;
    }

    /**
     * @return the seqs
     */
    public String[] getSeqs() {
        return seqs;
    }

    /**
     * @param seq the seq to set
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * @param mgrId the mgrId to set
     */
    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    /**
     * @param contents the contents to set
     */
    public void setContents(String contents) {
        this.contents = contents;
    }

    /**
     * @param summary the summary to set
     */
    public void setSummary(String summary) {
        this.summary = summary;
    }

    /**
     * @param senderId the senderId to set
     */
    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    /**
     * @param regDt the regDt to set
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    /**
     * @param readDt the readDt to set
     */
    public void setReadDt(String readDt) {
        this.readDt = readDt;
    }

    /**
     * @param deptNm the deptNm to set
     */
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    /**
     * @param senderDeptNm the senderDeptNm to set
     */
    public void setSenderDeptNm(String senderDeptNm) {
        this.senderDeptNm = senderDeptNm;
    }

    /**
     * @param mgrNm the mgrNm to set
     */
    public void setMgrNm(String mgrNm) {
        this.mgrNm = mgrNm;
    }

    /**
     * @param senderNm the senderNm to set
     */
    public void setSenderNm(String senderNm) {
        this.senderNm = senderNm;
    }

    /**
     * @param flag the flag to set
     */
    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    /**
     * @param senderDelYn the senderDelYn to set
     */
    public void setSenderDelYn(String senderDelYn) {
        this.senderDelYn = senderDelYn;
    }

    /**
     * @param receivers the receivers to set
     */
    public void setReceivers(String receivers) {
        this.receivers = receivers;
    }

    /**
     * @param seqs the seqs to set
     */
    public void setSeqs(String[] seqs) {
        this.seqs = seqs;
    }

    public String getFileYn() {
        return fileYn;
    }

    public void setFileYn(String fileYn) {
        this.fileYn = fileYn;
    }

    public Integer getUploadType() {
        return uploadType;
    }

    public void setUploadType(Integer uploadType) {
        this.uploadType = uploadType;
    }

    public Integer getMaxFileCnt() {
        return maxFileCnt;
    }

    public void setMaxFileCnt(Integer maxFileCnt) {
        this.maxFileCnt = maxFileCnt;
    }

    public Integer getMaxFileSize() {
        return maxFileSize;
    }

    public void setMaxFileSize(Integer maxFileSize) {
        this.maxFileSize = maxFileSize;
    }

    public Integer getTotalFileSize() {
        return totalFileSize;
    }

    public void setTotalFileSize(Integer totalFileSize) {
        this.totalFileSize = totalFileSize;
    }

    public String getFileExts() {
        return fileExts;
    }

    public void setFileExts(String fileExts) {
        this.fileExts = fileExts;
    }

    /**
     * List<FileVO> fileList을(를) 반환
     * 
     * @return List<FileVO> fileList
     */
    public List<FileVO> getFileList() {
        return fileList;
    }

    /**
     * fileList을(를) 설정
     * 
     * @param fileList을(를) List<FileVO> fileList로 설정
     */
    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }

    /**
     * String[] fileIds을(를) 반환
     * 
     * @return String[] fileIds
     */
    public String[] getFileIds() {
        return fileIds;
    }

    /**
     * fileIds을(를) 설정
     * 
     * @param fileIds을(를) String[] fileIds로 설정
     */
    public void setFileIds(String[] fileIds) {
        this.fileIds = fileIds;
    }

    /**
     * Integer fileSeq을(를) 반환
     * 
     * @return Integer fileSeq
     */
    public Integer getFileSeq() {
        return fileSeq;
    }

    /**
     * fileSeq을(를) 설정
     * 
     * @param fileSeq을(를) Integer fileSeq로 설정
     */
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    /**
     * Integer fileCnt을(를) 반환
     * 
     * @return Integer fileCnt
     */
    public Integer getFileCnt() {
        return fileCnt;
    }

    /**
     * fileCnt을(를) 설정
     * 
     * @param fileCnt을(를) Integer fileCnt로 설정
     */
    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }
}
