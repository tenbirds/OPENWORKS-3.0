package zes.openworks.web.wish;
import zes.base.vo.BaseVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일                  수정자                 수정내용
 * --------------  --------  -------------------------------
 *  2016.02.01    엔키                    신규
 * </pre>
 * @see
 */
public class WishOrderVO extends BaseVO {

    public enum MSG {
        LOGIN_FAIL, INSERT_OK, INSERT_CHK, UPDATE_OK, DELETE_OK
    }
 

    private String  userId;
    private int     grpSeq;
    private String  auditlogNm;
    private String  goodsTyCd;
    private String  ctgryCode;
    private String  filterCon;
    private String  keyWord;    
    private String[] goodsCodes;
    private String[] goodsCodesSel;
    
    /**
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    
    /**
     * userId을 설정
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    
    
    /**
     * String grpSeq을 반환
     * @return String grpSeq
     */
    public int getGrpSeq() {
        return grpSeq;
    }


    
    /**
     * grpSeq을 설정
     * @param grpSeq 을(를) String grpSeq로 설정
     */
    public void setGrpSeq(int grpSeq) {
        this.grpSeq = grpSeq;
    }

    
    /**
     * String auditlogNm을 반환
     * @return String auditlogNm
     */
    public String getAuditlogNm() {
        return auditlogNm;
    }


    
    /**
     * auditlogNm을 설정
     * @param auditlogNm 을(를) String auditlogNm로 설정
     */
    public void setAuditlogNm(String auditlogNm) {
        this.auditlogNm = auditlogNm;
    }


    /**
     * String goodsTyCd을 반환
     * @return String goodsTyCd
     */
    public String getGoodsTyCd() {
        return goodsTyCd;
    }
    
    /**
     * goodsTyCd을 설정
     * @param goodsTyCd 을(를) String goodsTyCd로 설정
     */
    public void setGoodsTyCd(String goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }
    
    /**
     * String ctgryCode을 반환
     * @return String ctgryCode
     */
    public String getCtgryCode() {
        return ctgryCode;
    }
    
    /**
     * ctgryCode을 설정
     * @param ctgryCode 을(를) String ctgryCode로 설정
     */
    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }
    
    /**
     * String filterCon을 반환
     * @return String filterCon
     */
    public String getFilterCon() {
        return filterCon;
    }
    
    /**
     * filterCon을 설정
     * @param filterCon 을(를) String filterCon로 설정
     */
    public void setFilterCon(String filterCon) {
        this.filterCon = filterCon;
    }
    
    /**
     * String keyWord을 반환
     * @return String keyWord
     */
    public String getKeyWord() {
        return keyWord;
    }
    
    /**
     * keyWord을 설정
     * @param keyWord 을(를) String keyWord로 설정
     */
    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }
    
    /**
     * String[] goodsCodes을 반환
     * @return String[] goodsCodes
     */
    public String[] getGoodsCodes() {
        return goodsCodes;
    }
    
    /**
     * goodsCodes을 설정
     * @param goodsCodes 을(를) String[] goodsCodes로 설정
     */
    public void setGoodsCodes(String[] goodsCodes) {
        this.goodsCodes = goodsCodes;
    }
    
    /**
     * String[] goodsCodesSel을 반환
     * @return String[] goodsCodesSel
     */
    public String[] getGoodsCodesSel() {
        return goodsCodesSel;
    }
    
    /**
     * goodsCodesSel을 설정
     * @param goodsCodesSel 을(를) String[] goodsCodesSel로 설정
     */
    public void setGoodsCodesSel(String[] goodsCodesSel) {
        this.goodsCodesSel = goodsCodesSel;
    }
    
    
    
}
