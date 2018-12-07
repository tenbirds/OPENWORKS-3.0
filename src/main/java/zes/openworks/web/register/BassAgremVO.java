package zes.openworks.web.register;

import java.util.List;

import zes.base.vo.FileVO;


/**
*
*<pre>
*<< 개정이력(Modification Information) >>
*
*  기본협약관리>기본협약관리
*
* 수정일          수정자    수정내용
*--------------  --------  -------------------------------
* 2016. 10. 26.   엔키      신규
*</pre>
* @see
*/

public class BassAgremVO {

    /** 사용자아이디 */
    private String userId;
    /* 기본협약관리순번 */
    private int bassAgremManageSeq;
    /* 기본협약관리순번 배열 */
    private String[] bassAgremManageSeqs;
    /* 회사명 */
    private String cmpnyNm;
    /* 담당자명 */
    private String chargerNm;
    /* 전화번호 */
    private String telno;
    /* 핸드폰 */
    private String mbtlnum;
    /* 이메일 */
    private String email;
    /* 제출예정일자 */
    private String presentnPrearngeDe;
    /* 제출일자 */
    private String presentnDe;
    /* 체결완료일자 */
    private String cnclsComptDe;
    /* 발송일자 */
    private String sndngDe;
    /* 협약차수 */
    private String agremOrder;
    /* 협약종료일자 */
    private String agremEndDe;
    /* 기업로그seq */
    private int multiFileSeq = -1;
    /* 확정협약서파일seq */
    private int lastAgrmntFileSeq = -1;
    /* 체출협약서파일seq */
    private int bassAgrmntFileSeq = -1;
    /* 등기부등본파일seq */
    private int rgsbukTrnscrFileSeq = -1;
    /* 벤처기업증명서파일seq */
    private int vnentrCrtfFileSeq = -1;
    /* 직접생산증명서파일seq */
    private int directPrdctnCrtfFileSeq = -1;
    /* 신용평가서파일seq */
    private int cdltDocFileSeq = -1;
    /* 재무재표파일seq */
    private int fnlttFileSeq = -1;
    /* 협약번호 */
    private String agremNo;
    /* 등록자ID */
    private String registId;
    /* 등록일자 */
    private String registDt;
    /* 수정자ID */
    private String updtId;
    /* 수정일자 */
    private String updtDt;
    /* 삭제여부 */
    private String deleteAt;
    /* 서비스등록(카운트) */
    private int goodsCnt;
    /** 공급자 신청 상태 코드 **/
    private int agremStatCd;
    /* 소제지 grpCode = 2036 */
    private int cmpnyLoca;
    /* 사업자 등록번호 */
    private String bizrno;
    /* 회원유형코드 */
    private int userTyCd;
    /** 공급자 신청 상태  **/
    private String agremStat;
    /** 나의페이지/공급자관리에서 보는 페이지 구분  **/
    private String screenType;
    
    /** 관리자 알림내용 **/
    private String mangComt;
    
    private List<FileVO> multiFile;
    private List<FileVO> lastAgrmntFile;
    private List<FileVO> bassAgrmntFile;
    private List<FileVO> rgsbukTrnscrFile;
    private List<FileVO> vnentrCrtfFile;
    private List<FileVO> directPrdctnCrtfFile;
    private List<FileVO> cdltDocFile;
    private List<FileVO> fnlttFile;
    
    
    private String hdRgsbukTrnscrFile;;
    private String hdCdltDocFile;
    private String hdFnlttFile;
    private String hdVnentrCrtfFile;
    private String hdDirectPrdctnCrtfFile;

    
    /**
     * int lastAgrmntFileSeq을 반환
     * @return int lastAgrmntFileSeq
     */
    public int getLastAgrmntFileSeq() {
        return lastAgrmntFileSeq;
    }

    
    /**
     * lastAgrmntFileSeq을 설정
     * @param lastAgrmntFileSeq 을(를) int lastAgrmntFileSeq로 설정
     */
    public void setLastAgrmntFileSeq(int lastAgrmntFileSeq) {
        this.lastAgrmntFileSeq = lastAgrmntFileSeq;
    }

    
    /**
     * List<FileVO> lastAgrmntFile을 반환
     * @return List<FileVO> lastAgrmntFile
     */
    public List<FileVO> getLastAgrmntFile() {
        return lastAgrmntFile;
    }

    
    /**
     * lastAgrmntFile을 설정
     * @param lastAgrmntFile 을(를) List<FileVO> lastAgrmntFile로 설정
     */
    public void setLastAgrmntFile(List<FileVO> lastAgrmntFile) {
        this.lastAgrmntFile = lastAgrmntFile;
    }

    /**
     * int bassAgremManageSeq을 반환
     * @return int bassAgremManageSeq
     */
    public int getBassAgremManageSeq() {
        return bassAgremManageSeq;
    }

    /**
     * bassAgremManageSeq을 설정
     * @param bassAgremManageSeq 을(를) int bassAgremManageSeq로 설정
     */
    public void setBassAgremManageSeq(int bassAgremManageSeq) {
        this.bassAgremManageSeq = bassAgremManageSeq;
    }

    /**
     * String[] bassAgremManageSeqs을 반환
     * @return String[] bassAgremManageSeqs
     */
    public String[] getBassAgremManageSeqs() {
        return bassAgremManageSeqs;
    }

    /**
     * bassAgremManageSeqs을 설정
     * @param bassAgremManageSeqs 을(를) String[] bassAgremManageSeqs로 설정
     */
    public void setBassAgremManageSeqs(String[] bassAgremManageSeqs) {
        this.bassAgremManageSeqs = bassAgremManageSeqs;
    }

    /**
     * String cmpnyNm을 반환
     * @return String cmpnyNm
     */
    public String getCmpnyNm() {
        return cmpnyNm;
    }

    /**
     * cmpnyNm을 설정
     * @param cmpnyNm 을(를) String cmpnyNm로 설정
     */
    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }

    /**
     * String chargerNm을 반환
     * @return String chargerNm
     */
    public String getChargerNm() {
        return chargerNm;
    }

    /**
     * chargerNm을 설정
     * @param chargerNm 을(를) String chargerNm로 설정
     */
    public void setChargerNm(String chargerNm) {
        this.chargerNm = chargerNm;
    }

    /**
     * String telno을 반환
     * @return String telno
     */
    public String getTelno() {
        return telno;
    }

    /**
     * telno을 설정
     * @param telno 을(를) String telno로 설정
     */
    public void setTelno(String telno) {
        this.telno = telno;
    }

    /**
     * String mbtlnum을 반환
     * @return String mbtlnum
     */
    public String getMbtlnum() {
        return mbtlnum;
    }

    /**
     * mbtlnum을 설정
     * @param mbtlnum 을(를) String mbtlnum로 설정
     */
    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    /**
     * String email을 반환
     * @return String email
     */
    public String getEmail() {
        return email;
    }

    /**
     * email을 설정
     * @param email 을(를) String email로 설정
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * String presentnPrearngeDe을 반환
     * @return String presentnPrearngeDe
     */
    public String getPresentnPrearngeDe() {
        return presentnPrearngeDe;
    }

    /**
     * presentnPrearngeDe을 설정
     * @param presentnPrearngeDe 을(를) String presentnPrearngeDe로 설정
     */
    public void setPresentnPrearngeDe(String presentnPrearngeDe) {
        this.presentnPrearngeDe = presentnPrearngeDe;
    }

    /**
     * String presentnDe을 반환
     * @return String presentnDe
     */
    public String getPresentnDe() {
        return presentnDe;
    }

    /**
     * presentnDe을 설정
     * @param presentnDe 을(를) String presentnDe로 설정
     */
    public void setPresentnDe(String presentnDe) {
        this.presentnDe = presentnDe;
    }

    /**
     * String cnclsComptDe을 반환
     * @return String cnclsComptDe
     */
    public String getCnclsComptDe() {
        return cnclsComptDe;
    }

    /**
     * cnclsComptDe을 설정
     * @param cnclsComptDe 을(를) String cnclsComptDe로 설정
     */
    public void setCnclsComptDe(String cnclsComptDe) {
        this.cnclsComptDe = cnclsComptDe;
    }

    /**
     * String sndngDe을 반환
     * @return String sndngDe
     */
    public String getSndngDe() {
        return sndngDe;
    }

    /**
     * sndngDe을 설정
     * @param sndngDe 을(를) String sndngDe로 설정
     */
    public void setSndngDe(String sndngDe) {
        this.sndngDe = sndngDe;
    }

    /**
     * String agremOrder을 반환
     * @return String agremOrder
     */
    public String getAgremOrder() {
        return agremOrder;
    }

    /**
     * agremOrder을 설정
     * @param agremOrder 을(를) String agremOrder로 설정
     */
    public void setAgremOrder(String agremOrder) {
        this.agremOrder = agremOrder;
    }

    /**
     * String agremEndDe을 반환
     * @return String agremEndDe
     */
    public String getAgremEndDe() {
        return agremEndDe;
    }

    /**
     * agremEndDe을 설정
     * @param agremEndDe 을(를) String agremEndDe로 설정
     */
    public void setAgremEndDe(String agremEndDe) {
        this.agremEndDe = agremEndDe;
    }

    /**
     * int getMultiFileSeq을 반환
     * @return int getMultiFileSeq
     */
    public int getMultiFileSeq() {
        return this.multiFileSeq;
    }

    /**
     * MultiFileSeq을 설정
     * @param MultiFileSeq 을(를) int MultiFileSeq로 설정
     */
    public void setMultiFileSeq(int value) {
        this.multiFileSeq = value;
    }
    
    /**
     * int bassAgrmntFileSeq을 반환
     * @return int bassAgrmntFileSeq
     */
    public int getBassAgrmntFileSeq() {
        return bassAgrmntFileSeq;
    }

    /**
     * bassAgrmntFileSeq을 설정
     * @param bassAgrmntFileSeq 을(를) int bassAgrmntFileSeq로 설정
     */
    public void setBassAgrmntFileSeq(int bassAgrmntFileSeq) {
        this.bassAgrmntFileSeq = bassAgrmntFileSeq;
    }

    /**
     * int rgsbukTrnscrFileSeq을 반환
     * @return int rgsbukTrnscrFileSeq
     */
    public int getRgsbukTrnscrFileSeq() {
        return rgsbukTrnscrFileSeq;
    }

    /**
     * rgsbukTrnscrFileSeq을 설정
     * @param rgsbukTrnscrFileSeq 을(를) int rgsbukTrnscrFileSeq로 설정
     */
    public void setRgsbukTrnscrFileSeq(int rgsbukTrnscrFileSeq) {
        this.rgsbukTrnscrFileSeq = rgsbukTrnscrFileSeq;
    }

    /**
     * int vnentrCrtfFileSeq을 반환
     * @return int vnentrCrtfFileSeq
     */
    public int getVnentrCrtfFileSeq() {
        return vnentrCrtfFileSeq;
    }

    /**
     * vnentrCrtfFileSeq을 설정
     * @param vnentrCrtfFileSeq 을(를) int vnentrCrtfFileSeq로 설정
     */
    public void setVnentrCrtfFileSeq(int vnentrCrtfFileSeq) {
        this.vnentrCrtfFileSeq = vnentrCrtfFileSeq;
    }

    /**
     * int directPrdctnCrtfFileSeq을 반환
     * @return int directPrdctnCrtfFileSeq
     */
    public int getDirectPrdctnCrtfFileSeq() {
        return directPrdctnCrtfFileSeq;
    }

    /**
     * directPrdctnCrtfFileSeq을 설정
     * @param directPrdctnCrtfFileSeq 을(를) int directPrdctnCrtfFileSeq로 설정
     */
    public void setDirectPrdctnCrtfFileSeq(int directPrdctnCrtfFileSeq) {
        this.directPrdctnCrtfFileSeq = directPrdctnCrtfFileSeq;
    }

    /**
     * int cdltDocFileSeq을 반환
     * @return int cdltDocFileSeq
     */
    public int getCdltDocFileSeq() {
        return cdltDocFileSeq;
    }

    /**
     * cdltDocFileSeq을 설정
     * @param cdltDocFileSeq 을(를) int cdltDocFileSeq로 설정
     */
    public void setCdltDocFileSeq(int cdltDocFileSeq) {
        this.cdltDocFileSeq = cdltDocFileSeq;
    }

    /**
     * int fnlttFileSeq을 반환
     * @return int fnlttFileSeq
     */
    public int getFnlttFileSeq() {
        return fnlttFileSeq;
    }

    /**
     * fnlttFileSeq을 설정
     * @param fnlttFileSeq 을(를) int fnlttFileSeq로 설정
     */
    public void setFnlttFileSeq(int fnlttFileSeq) {
        this.fnlttFileSeq = fnlttFileSeq;
    }

    /**
     * String agremNo을 반환
     * @return String agremNo
     */
    public String getAgremNo() {
        return agremNo;
    }

    /**
     * agremNo을 설정
     * @param agremNo 을(를) String agremNo로 설정
     */
    public void setAgremNo(String agremNo) {
        this.agremNo = agremNo;
    }

    /**
     * String registId을 반환
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }

    /**
     * registId을 설정
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }

    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    /**
     * String updtId을 반환
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }

    /**
     * updtId을 설정
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    /**
     * String updtDt을 반환
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }

    /**
     * updtDt을 설정
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    /**
     * String deleteAt을 반환
     * @return String deleteAt
     */
    public String getDeleteAt() {
        return deleteAt;
    }

    /**
     * deleteAt을 설정
     * @param deleteAt 을(를) String deleteAt로 설정
     */
    public void setDeleteAt(String deleteAt) {
        this.deleteAt = deleteAt;
    }

    /**
     * List<FileVO> MultiFile을 반환
     * @return List<FileVO> MultiFile
     */
    public List<FileVO> getMultiFile() {
        return this.multiFile;
    }

    /**
     * MultiFile을 설정
     * @param MultiFile 을(를) List<FileVO> MultiFile로 설정
     */
    public void setMultiFile(List<FileVO> value) {
        this.multiFile = value;
    }
    
    /**
     * List<FileVO> bassAgrmntFile을 반환
     * @return List<FileVO> bassAgrmntFile
     */
    public List<FileVO> getBassAgrmntFile() {
        return bassAgrmntFile;
    }

    /**
     * bassAgrmntFile을 설정
     * @param bassAgrmntFile 을(를) List<FileVO> bassAgrmntFile로 설정
     */
    public void setBassAgrmntFile(List<FileVO> bassAgrmntFile) {
        this.bassAgrmntFile = bassAgrmntFile;
    }

    /**
     * List<FileVO> rgsbukTrnscrFile을 반환
     * @return List<FileVO> rgsbukTrnscrFile
     */
    public List<FileVO> getRgsbukTrnscrFile() {
        return rgsbukTrnscrFile;
    }

    /**
     * rgsbukTrnscrFile을 설정
     * @param rgsbukTrnscrFile 을(를) List<FileVO> rgsbukTrnscrFile로 설정
     */
    public void setRgsbukTrnscrFile(List<FileVO> rgsbukTrnscrFile) {
        this.rgsbukTrnscrFile = rgsbukTrnscrFile;
    }

    /**
     * List<FileVO> vnentrCrtfFile을 반환
     * @return List<FileVO> vnentrCrtfFile
     */
    public List<FileVO> getVnentrCrtfFile() {
        return vnentrCrtfFile;
    }

    /**
     * vnentrCrtfFile을 설정
     * @param vnentrCrtfFile 을(를) List<FileVO> vnentrCrtfFile로 설정
     */
    public void setVnentrCrtfFile(List<FileVO> vnentrCrtfFile) {
        this.vnentrCrtfFile = vnentrCrtfFile;
    }

    /**
     * List<FileVO> directPrdctnCrtfFile을 반환
     * @return List<FileVO> directPrdctnCrtfFile
     */
    public List<FileVO> getDirectPrdctnCrtfFile() {
        return directPrdctnCrtfFile;
    }

    /**
     * directPrdctnCrtfFile을 설정
     * @param directPrdctnCrtfFile 을(를) List<FileVO> directPrdctnCrtfFile로 설정
     */
    public void setDirectPrdctnCrtfFile(List<FileVO> directPrdctnCrtfFile) {
        this.directPrdctnCrtfFile = directPrdctnCrtfFile;
    }

    /**
     * List<FileVO> cdltDocFile을 반환
     * @return List<FileVO> cdltDocFile
     */
    public List<FileVO> getCdltDocFile() {
        return cdltDocFile;
    }

    /**
     * cdltDocFile을 설정
     * @param cdltDocFile 을(를) List<FileVO> cdltDocFile로 설정
     */
    public void setCdltDocFile(List<FileVO> cdltDocFile) {
        this.cdltDocFile = cdltDocFile;
    }

    /**
     * List<FileVO> fnlttFile을 반환
     * @return List<FileVO> fnlttFile
     */
    public List<FileVO> getFnlttFile() {
        return fnlttFile;
    }

    /**
     * fnlttFile을 설정
     * @param fnlttFile 을(를) List<FileVO> fnlttFile로 설정
     */
    public void setFnlttFile(List<FileVO> fnlttFile) {
        this.fnlttFile = fnlttFile;
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
     * int goodsCnt을 반환
     * @return int goodsCnt
     */
    public int getGoodsCnt() {
        return goodsCnt;
    }

    /**
     * goodsCnt을 설정
     * @param goodsCnt 을(를) int goodsCnt로 설정
     */
    public void setGoodsCnt(int goodsCnt) {
        this.goodsCnt = goodsCnt;
    }

    /**
     * int agremStatCd을 반환
     * @return int agremStatCd
     */
    public int getAgremStatCd() {
        return agremStatCd;
    }

    /**
     * agremStatCd을 설정
     * @param agremStatCd 을(를) int agremStatCd로 설정
     */
    public void setAgremStatCd(int agremStatCd) {
        this.agremStatCd = agremStatCd;
    }

    /**
     * String bizrno을 반환
     * @return String bizrno
     */
    public String getBizrno() {
        return bizrno;
    }

    /**
     * bizrno을 설정
     * @param bizrno 을(를) String bizrno로 설정
     */
    public void setBizrno(String bizrno) {
        this.bizrno = bizrno;
    }

    /**
     * int cmpnyLoca을 반환
     * @return int cmpnyLoca
     */
    public int getCmpnyLoca() {
        return cmpnyLoca;
    }

    /**
     * cmpnyLoca을 설정
     * @param cmpnyLoca 을(를) int cmpnyLoca로 설정
     */
    public void setCmpnyLoca(int cmpnyLoca) {
        this.cmpnyLoca = cmpnyLoca;
    }

    /**
     * 유저상태코드
     * @return int userTyCd
     */
    public int getUserTyCd() {
        return this.userTyCd;
    }

   /**
     * 유저상태코드
     * @param userTyCd 을(를) int userTyCd로 설정
     */
    public void setUserTyCd(int value) {
        this.userTyCd = value;
 
    }

    /**
     * 공급자신청상태
     * @return String agremStat
     */
    public String getAgremStat() {
        return agremStat;
    }

    /**
     *공급자신청상태
     * @param agremStat 을(를) String agremStat로 설정
     */
    public void setAgremStat(String agremStat) {
        this.agremStat = agremStat;
    }

    
    /**
     * String screenType을 반환
     * @return String screenType
     */
    public String getScreenType() {
        return screenType;
    }

    
    /**
     * screenType을 설정
     * @param screenType 을(를) String screenType로 설정
     */
    public void setScreenType(String screenType) {
        this.screenType = screenType;
    }

    
    /**
     * String mangComt을 반환
     * @return String mangComt
     */
    public String getMangComt() {
        return mangComt;
    }

    
    /**
     * mangComt을 설정
     * @param mangComt 을(를) String mangComt로 설정
     */
    public void setMangComt(String mangComt) {
        this.mangComt = mangComt;
    }


    /**
     * String hdRgsbukTrnscrFile을 반환
     * @return String hdRgsbukTrnscrFile
     */
    public String getHdRgsbukTrnscrFile() {
        return hdRgsbukTrnscrFile;
    }


    /**
     * hdRgsbukTrnscrFile을 설정
     * @param hdRgsbukTrnscrFile 을(를) String hdRgsbukTrnscrFile로 설정
     */
    public void setHdRgsbukTrnscrFile(String hdRgsbukTrnscrFile) {
        this.hdRgsbukTrnscrFile = hdRgsbukTrnscrFile;
    }


    /**
     * String hdCdltDocFile을 반환
     * @return String hdCdltDocFile
     */
    public String getHdCdltDocFile() {
        return hdCdltDocFile;
    }


    /**
     * hdCdltDocFile을 설정
     * @param hdCdltDocFile 을(를) String hdCdltDocFile로 설정
     */
    public void setHdCdltDocFile(String hdCdltDocFile) {
        this.hdCdltDocFile = hdCdltDocFile;
    }


    /**
     * String hdFnlttFile을 반환
     * @return String hdFnlttFile
     */
    public String getHdFnlttFile() {
        return hdFnlttFile;
    }


    /**
     * hdFnlttFile을 설정
     * @param hdFnlttFile 을(를) String hdFnlttFile로 설정
     */
    public void setHdFnlttFile(String hdFnlttFile) {
        this.hdFnlttFile = hdFnlttFile;
    }


    /**
     * String hdVnentrCrtfFile을 반환
     * @return String hdVnentrCrtfFile
     */
    public String getHdVnentrCrtfFile() {
        return hdVnentrCrtfFile;
    }


    /**
     * hdVnentrCrtfFile을 설정
     * @param hdVnentrCrtfFile 을(를) String hdVnentrCrtfFile로 설정
     */
    public void setHdVnentrCrtfFile(String hdVnentrCrtfFile) {
        this.hdVnentrCrtfFile = hdVnentrCrtfFile;
    }


    /**
     * String hdDirectPrdctnCrtfFile을 반환
     * @return String hdDirectPrdctnCrtfFile
     */
    public String getHdDirectPrdctnCrtfFile() {
        return hdDirectPrdctnCrtfFile;
    }


    /**
     * hdDirectPrdctnCrtfFile을 설정
     * @param hdDirectPrdctnCrtfFile 을(를) String hdDirectPrdctnCrtfFile로 설정
     */
    public void setHdDirectPrdctnCrtfFile(String hdDirectPrdctnCrtfFile) {
        this.hdDirectPrdctnCrtfFile = hdDirectPrdctnCrtfFile;
    }
    
 
}
