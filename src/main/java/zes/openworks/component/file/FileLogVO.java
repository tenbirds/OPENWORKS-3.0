package zes.openworks.component.file;

import zes.base.vo.PaggingVO;

public class FileLogVO extends PaggingVO {

    private static final long serialVersionUID = -4388433407599052073L;

    private Integer fileSeq = -1;
    private String fileId;
    private Integer orderNo = -1;
    private String workerNm;
    private String regDt;

    public Integer getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public String getWorkerNm() {
        return workerNm;
    }

    public void setWorkerNm(String workerNm) {
        this.workerNm = workerNm;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }
}
