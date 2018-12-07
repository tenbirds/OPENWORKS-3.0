package zes.openworks.intra.code;

import java.util.List;

import zes.base.vo.BaseVO;

/**
 * 코드 카테고리 VO
 * 
 * @author wisepms
 * @version $Id: CodeCtgVO.java 50 2011-07-17 04:15:3Z oworks $
 */
public class CodeCtgVO extends BaseVO {

    private static final long serialVersionUID = -318803058696046550L;

    /** 개별코드 목록 */
    private List<CodeVO> prvList;
    /** 개별코드 목록 */
    private List<CodeVO> prvList1;
    /** 할당코드 목록 */
    private String[] prvCds;

    /** 그룹 코드 */
    private Integer grpCd = 0;
    private Integer oldGrpCd = 0;
    /** 개별 코드 */
    private Integer prvCd = 0;
    private Integer oldPrvCd = 0;
    /** 개별 코드명 */
    private String prvNm = "";
    /** 카테고리 코드 */
    private String ctgCd;

    /**  언어코드  */
    private String langCode;
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
    
    public List<CodeVO> getPrvList() {
        return prvList;
    }

    public void setPrvList(List<CodeVO> prvList) {
        this.prvList = prvList;
    }

    public Integer getGrpCd() {
        return grpCd;
    }

    public void setGrpCd(Integer grpCd) {
        this.grpCd = grpCd;
    }

    public Integer getPrvCd() {
        return prvCd;
    }

    public void setPrvCd(Integer prvCd) {
        this.prvCd = prvCd;
    }

    public String getCtgCd() {
        return ctgCd;
    }

    public void setCtgCd(String ctgCd) {
        this.ctgCd = ctgCd;
    }

    public String[] getPrvCds() {
        return prvCds;
    }

    public void setPrvCds(String[] prvCds) {
        this.prvCds = prvCds;
    }

    public List<CodeVO> getPrvList1() {
        return prvList1;
    }

    public void setPrvList1(List<CodeVO> prvList1) {
        this.prvList1 = prvList1;
    }

    public String getPrvNm() {
        return prvNm;
    }

    public void setPrvNm(String prvNm) {
        this.prvNm = prvNm;
    }

    public Integer getOldPrvCd() {
        return oldPrvCd;
    }

    public void setOldPrvCd(Integer oldPrvCd) {
        this.oldPrvCd = oldPrvCd;
    }

    public Integer getOldGrpCd() {
        return oldGrpCd;
    }

    public void setOldGrpCd(Integer oldGrpCd) {
        this.oldGrpCd = oldGrpCd;
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
    
    
}
