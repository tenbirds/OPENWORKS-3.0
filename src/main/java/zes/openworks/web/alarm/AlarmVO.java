package zes.openworks.web.alarm;

import zes.base.vo.BaseVO;
/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.7)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 * 
 * </pre>
 * @see
 */
public class AlarmVO extends BaseVO {
    
    /**  */
    private static final long serialVersionUID = 1L;
    public Integer alarmSeq;
    public String alarmBizGbn;
    public String userId;
    public String alarmTitle;
    public String confrmId;
    public String confrmGbn;
    public String entrDt;
    public String buseoCode;    /**기관코드*/
    public Integer userTyCd;    /**회원분류코드*/

    /**
     * String alarmSeq을 반환
     * @return String alarmSeq
     */
    public Integer getAlarmSeq() {
        return alarmSeq;
    }
    
    /**
     * alarmSeq을 설정
     * @param alarmSeq 을(를) String alarmSeq로 설정
     */
    public void setAlarmSeq(Integer alarmSeq) {
        this.alarmSeq = alarmSeq;
    }
    
    /**
     * String alarmBizGbn을 반환
     * @return String alarmBizGbn
     */
    public String getAlarmBizGbn() {
        return alarmBizGbn;
    }
    
    
    /**
     * String buseoCode을 반환
     * @return String buseoCode
     */
    public String getBuseoCode() {
        return buseoCode;
    }

    
    /**
     * buseoCode을 설정
     * @param buseoCode 을(를) String buseoCode로 설정
     */
    public void setBuseoCode(String buseoCode) {
        this.buseoCode = buseoCode;
    }

    
    /**
     * Integer userTyCd을 반환
     * @return Integer userTyCd
     */
    public Integer getUserTyCd() {
        return userTyCd;
    }

    
    /**
     * userTyCd을 설정
     * @param userTyCd 을(를) Integer userTyCd로 설정
     */
    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }

    /**
     * alarmBizGbn을 설정
     * @param alarmBizGbn 을(를) String alarmBizGbn로 설정
     */
    public void setAlarmBizGbn(String alarmBizGbn) {
        this.alarmBizGbn = alarmBizGbn;
    }
    
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
     * String alarmTitle을 반환
     * @return String alarmTitle
     */
    public String getAlarmTitle() {
        return alarmTitle;
    }
    
    /**
     * alarmTitle을 설정
     * @param alarmTitle 을(를) String alarmTitle로 설정
     */
    public void setAlarmTitle(String alarmTitle) {
        this.alarmTitle = alarmTitle;
    }
    
    /**
     * String confrmId을 반환
     * @return String confrmId
     */
    public String getConfrmId() {
        return confrmId;
    }
    
    /**
     * confrmId을 설정
     * @param confrmId 을(를) String confrmId로 설정
     */
    public void setConfrmId(String confrmId) {
        this.confrmId = confrmId;
    }
    
    /**
     * String confrmGbn을 반환
     * @return String confrmGbn
     */
    public String getConfrmGbn() {
        return confrmGbn;
    }
    
    /**
     * confrmGbn을 설정
     * @param confrmGbn 을(를) String confrmGbn로 설정
     */
    public void setConfrmGbn(String confrmGbn) {
        this.confrmGbn = confrmGbn;
    }
    
    /**
     * String entrDt을 반환
     * @return String entrDt
     */
    public String getEntrDt() {
        return entrDt;
    }
    
    /**
     * entrDt을 설정
     * @param entrDt 을(를) String entrDt로 설정
     */
    public void setEntrDt(String entrDt) {
        this.entrDt = entrDt;
    }
    
    
}
