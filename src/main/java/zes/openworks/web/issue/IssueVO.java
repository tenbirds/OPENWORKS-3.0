package zes.openworks.web.issue;

import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 5. 8.    neteran   신규 생성
 *  2013. 5.22.    구선모    sns댓글 관련 변수 추가
 * </pre>
 * @see
 */
public class IssueVO extends PaggingVO {

    private static final long serialVersionUID = -9066643876847956548L;

    private String bbsCd;
    private String bbsSeq;
    private String bbsNm;
    private String issueTitle;
    private String readCnt;
    private String hotMenuName;

    private String sns_name;
    private String sns_screen_name;
    private String sns_ago;
    private String sns_content;

    public String getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(String bbsCd) {
        this.bbsCd = bbsCd;
    }

    public String getBbsSeq() {
        return bbsSeq;
    }

    public void setBbsSeq(String bbsSeq) {
        this.bbsSeq = bbsSeq;
    }

    public String getBbsNm() {
        return bbsNm;
    }

    public void setBbsNm(String bbsNm) {
        this.bbsNm = bbsNm;
    }

    public String getIssueTitle() {
        return issueTitle;
    }

    public void setIssueTitle(String issueTitle) {
        this.issueTitle = issueTitle;
    }

    public String getReadCnt() {
        return readCnt;
    }

    public void setReadCnt(String readCnt) {
        this.readCnt = readCnt;
    }

    public String getHotMenuName() {
        return hotMenuName;
    }

    public void setHotMenuName(String hotMenuName) {
        this.hotMenuName = hotMenuName;
    }

    /**
     * String sns_name을 반환
     * 
     * @return String sns_name
     */
    public String getSns_name() {
        return sns_name;
    }

    /**
     * sns_name을 설정
     * 
     * @param sns_name 을(를) String sns_name로 설정
     */
    public void setSns_name(String sns_name) {
        this.sns_name = sns_name;
    }

    /**
     * String sns_screen_name을 반환
     * 
     * @return String sns_screen_name
     */
    public String getSns_screen_name() {
        return sns_screen_name;
    }

    /**
     * sns_screen_name을 설정
     * 
     * @param sns_screen_name 을(를) String sns_screen_name로 설정
     */
    public void setSns_screen_name(String sns_screen_name) {
        this.sns_screen_name = sns_screen_name;
    }

    /**
     * String sns_ago을 반환
     * 
     * @return String sns_ago
     */
    public String getSns_ago() {
        return sns_ago;
    }

    /**
     * sns_ago을 설정
     * 
     * @param sns_ago 을(를) String sns_ago로 설정
     */
    public void setSns_ago(String sns_ago) {
        this.sns_ago = sns_ago;
    }

    /**
     * String sns_content을 반환
     * 
     * @return String sns_content
     */
    public String getSns_content() {
        return sns_content;
    }

    /**
     * sns_content을 설정
     * 
     * @param sns_content 을(를) String sns_content로 설정
     */
    public void setSns_content(String sns_content) {
        this.sns_content = sns_content;
    }

}
