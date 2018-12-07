package zes.openworks.intra.code;

import java.util.List;

import zes.base.vo.TreeVO;

/**
 * 코드 VO
 * 
 * @author wisepms
 * @version $Id: CodeVO.java 50 2011-07-17 04:15:32Z oworks $
 */
public class CodeVO extends TreeVO {

    private static final long serialVersionUID = -3185030586960462550L;

    /** 코드 카테고리 목록 */
    private List<String> ctgList;
    /** 할당코드 목록 */
    private String[] prvNms;
    /** 그룹 코드 */
    private String grpCds;
    /**  언어코드  */
    private String langCode;
    private String langCodes;
    /** 그룹 코드 */
    private Integer grpCd = 0;
    /** 이전그룹 코드 */
    private Integer oldGrpCd = 0;
    /** 그룹 코드 이름 */
    private String grpNm;
    /** 그룹 코드 설명 */
    private String grpDesc;

    private List<CodeVO> prvTotalCodeList;
    /** 개별 코드 */
    private String prvCds;
    /** 개별 코드 */
    private Integer prvCd = 0;
    /** 이전개별 코드 */
    private Integer oldPrvCd = 0;
    /** 개별 코드 이름 */
    private String prvNm;
    /** 정렬순서 */
    private Integer orderNo = 0;
    /** 20150901 이전정렬순서 */
    private Integer orderNoBefore = 0;
    /** 개별코드 사용여부 */
    private String useYn;
    /** 나라장터 연관코드 */
    private String relationCd;
    /** 등록일 */
    private String regDt;
    /** 수정일 */
    private String modiDt;
    /** 그룹코드 사용여부 */
    private String grpUseYn;
    /** 코드체크카운트 */
    private int codeCheckCount;
    private String modId;

    /**  수정 전 언어코드  */
    private String oldLangCode;
    /**  언어명  */
    private String langNm;
    /**  도메인코드  */
    private Integer domainCd;
    /**  언어영문약어  */
    private String langEngAbb;
    /**  언어영문명  */
    private String langEngNm;
    /**  비고  */
    private String rm;
    
    private String issuSttus;
    
    public String getGrpUseYn() {
        return grpUseYn;
    }

    public void setGrpUseYn(String grpUseYn) {
        this.grpUseYn = grpUseYn;
    }

    public Integer getGrpCd() {
        return grpCd;
    }

    public void setGrpCd(Integer grpCd) {
        this.grpCd = grpCd;
    }

    public String getGrpNm() {
        return grpNm;
    }

    public void setGrpNm(String grpNm) {
        this.grpNm = grpNm;
    }

    public String getGrpDesc() {
        return grpDesc;
    }

    public void setGrpDesc(String grpDesc) {
        this.grpDesc = grpDesc;
    }

    public Integer getPrvCd() {
        return prvCd;
    }

    public void setPrvCd(Integer prvCd) {
        this.prvCd = prvCd;
    }

    public String getPrvNm() {
        return prvNm;
    }

    public void setPrvNm(String prvNm) {
        this.prvNm = prvNm;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }
    
    /** 20150901 이전정렬순서 시작 */
    public Integer getOrderNoBefore() {
        return orderNoBefore;
    }

    public void setOrderNoBefore(Integer orderNoBefore) {
        this.orderNoBefore = orderNoBefore;
    }
    /** 20150901 이전정렬순서 끝 */

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public String getModiDt() {
        return modiDt;
    }

    public void setModiDt(String modiDt) {
        this.modiDt = modiDt;
    }

    public List<String> getCtgList() {
        return ctgList;
    }

    public void setCtgList(List<String> ctgList) {
        this.ctgList = ctgList;
    }

    public String[] getPrvNms() {
        return prvNms;
    }

    public void setPrvNms(String[] prvNms) {
        this.prvNms = prvNms;
    }

    public List<CodeVO> getPrvTotalCodeList() {
        return prvTotalCodeList;
    }

    public void setPrvTotalCodeList(List<CodeVO> prvTotalCodeList) {
        this.prvTotalCodeList = prvTotalCodeList;
    }

    public Integer getOldGrpCd() {
        return oldGrpCd;
    }

    public void setOldGrpCd(Integer oldGrpCd) {
        this.oldGrpCd = oldGrpCd;
    }

    public Integer getOldPrvCd() {
        return oldPrvCd;
    }

    public void setOldPrvCd(Integer oldPrvCd) {
        this.oldPrvCd = oldPrvCd;
    }

    /**
     * int codeCheckCount을 반환
     * 
     * @return int codeCheckCount
     */
    public int getCodeCheckCount() {
        return codeCheckCount;
    }

    /**
     * codeCheckCount을 설정
     * 
     * @param codeCheckCount 을(를) int codeCheckCount로 설정
     */
    public void setCodeCheckCount(int codeCheckCount) {
        this.codeCheckCount = codeCheckCount;
    }

    public String getModId() {
        return modId;
    }

    public void setModId(String modId) {
        this.modId = modId;
    }

    /**
     * String grpCds을 반환
     * 
     * @return String grpCds
     */
    public String getGrpCds() {
        return grpCds;
    }

    /**
     * grpCds 설정
     * 
     * @param grpCds 을(를) String grpCds로 설정
     */
    public void setGrpCds(String grpCds) {
        this.grpCds = grpCds;
    }

    /**
     * String grpCds을 반환
     * 
     * @return String grpCds
     */
    public String getPrvCds() {
        return prvCds;
    }

    /**
     * prvCds 설정
     * 
     * @param prvCds 을(를) String prvCds로 설정
     */
    public void setPrvCds(String prvCds) {
        this.prvCds = prvCds;
    }
   
    /**
     * String langNm을 반환
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }

    
    /**
     * langNm을 설정
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    
    /**
     * Integer domainCd을 반환
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    
    /**
     * domainCd을 설정
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    
    /**
     * String langEngAbb을 반환
     * @return String langEngAbb
     */
    public String getLangEngAbb() {
        return langEngAbb;
    }

    
    /**
     * langEngAbb을 설정
     * @param langEngAbb 을(를) String langEngAbb로 설정
     */
    public void setLangEngAbb(String langEngAbb) {
        this.langEngAbb = langEngAbb;
    }

    
    /**
     * String langEngNm을 반환
     * @return String langEngNm
     */
    public String getLangEngNm() {
        return langEngNm;
    }

    
    /**
     * langEngNm을 설정
     * @param langEngNm 을(를) String langEngNm로 설정
     */
    public void setLangEngNm(String langEngNm) {
        this.langEngNm = langEngNm;
    }

    
    /**
     * String rm을 반환
     * @return String rm
     */
    public String getRm() {
        return rm;
    }

    
    /**
     * rm을 설정
     * @param rm 을(를) String rm로 설정
     */
    public void setRm(String rm) {
        this.rm = rm;
    }

    
    /**
     * String oldLangCode을 반환
     * @return String oldLangCode
     */
    public String getOldLangCode() {
        return oldLangCode;
    }

    
    /**
     * oldLangCode을 설정
     * @param oldLangCode 을(를) String oldLangCode로 설정
     */
    public void setOldLangCode(String oldLangCode) {
        this.oldLangCode = oldLangCode;
    }

    /**
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }

    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    /**
     * String langCodes을 반환
     * @return String langCodes
     */
    public String getLangCodes() {
        return langCodes;
    }

    /**
     * langCodes을 설정
     * @param langCodes 을(를) String langCodes로 설정
     */
    public void setLangCodes(String langCodes) {
        this.langCodes = langCodes;
    }

    /**
     * String relationCd을 반환
     * @return String relationCd
     */
    public String getRelationCd() {
        return relationCd;
    }

    /**
     * relationCd을 설정
     * @param relationCd 을(를) String relationCd로 설정
     */
    public void setRelationCd(String relationCd) {
        this.relationCd = relationCd;
    }

    
    /**
     * String issuSttus을 반환
     * @return String issuSttus
     */
    public String getIssuSttus() {
        return issuSttus;
    }

    
    /**
     * issuSttus을 설정
     * @param issuSttus 을(를) String issuSttus로 설정
     */
    public void setIssuSttus(String issuSttus) {
        this.issuSttus = issuSttus;
    }

    
}