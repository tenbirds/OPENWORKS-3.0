package zes.openworks.intra.orderManage.cntrctManage;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일          수정자    수정내용
 * --------------  --------  -------------------------------
 *  2016.02.15      엔키      신규
 * </pre>
 * @see
 */
public class CntrctManageVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -2063958049023915828L;

    /*계약순번*/
    private int cntrctSn;
    /*계약순번 배열*/
    private String[] cntrctSns;
    /*회원아이디*/
    private String userId;
    /*서비스명*/
    private String svcNm;
    /*계약시작일자*/
    private String cntrctBeginDe;
    /*계약종료일자*/
    private String cntrctEndDe;
    /*계약금액*/
    private Long cntrctamount;
    /*구매기관*/
    private String purchsInsttNm;
    /*판매기관*/
    private String sleInsttNm;
    /*계약서순번*/
    private int ctrtcSn;
    /*등록아이디*/
    private String registId;
    /*등록일시*/
    private String registDt;
    /*수정아이디*/
    private String updtId;
    /*수정일시*/
    private String updtDt;
    /*삭제여부*/
    private String deleteAt;

    private List<FileVO> ctrtcFile;

    private String tempUserSn;
    private String cntrCount;
    private String goodsNm;
    private String cntrDt;
    private String bidGbnNm;
    
    /*계약실적여부 : Y: 계약실적, N: 계약관리*/
    private String useAt;
    
    /**
     * 2018.10.05 - eulro 추가
     * TCM_CNTRCT_MANAGE_I
     */
    private String  notifyNum;
    private int     notifySeq;
    private String  goodsCode;
    private String  cntrNum;
    private String  splyForm;
    private String  splyFormEtc;
    private String  commUserId;
    private String  certResultCode;
    private String  certResultDt;
    private Integer certResultFile;
    private String  ownerComment;
    private String  recogDt;
    private String  registMthdCode;
    private String  userSe;
    private String  sportAt;
    private String  buseoCode;
    private String  purchsInsttNm2;
    private String  asis;
    private String  ownerComment2;
    
    /**
     * 2018.10.05 - eulro 추가
     * TCM_CNTRCT_SERVICE_I
     */
    private Integer cntrctSvcSn; 
    private int     cntrctCount;
    private int     cntrctAmount;
    

    private String  suplerId;
    private String  sbscrbTyCd;
    private String  orgnCode;
    private String  orgnNm;
    private String  userSn;
    
    private List<FileVO> ctrtcSnList;
    private String rlCntrctInsttAt;  /*계약기관과 동일하지 않음 체크여부*/
    
    private String  commUserNm;
    

    private String  cntrUnum;
    private String  itemName;
    private String  manuName;
    private String  itemEntrDate;
    
    private String  deliveryNum;
    private String  itemDesptn;
    private String  itemUnit;
    private String  deliveryDate;
    private String  deliveryPlace;
    
    
    private int     itemQuantity;
    private int     unitPrice;
    private int     itemAmount;
    
    private String  naraDate;

    
    /**
     * String naraDate을 반환
     * @return String naraDate
     */
    public String getNaraDate() {
        return naraDate;
    }











    
    /**
     * naraDate을 설정
     * @param naraDate 을(를) String naraDate로 설정
     */
    public void setNaraDate(String naraDate) {
        this.naraDate = naraDate;
    }











    /**
     * String deliveryNum을 반환
     * @return String deliveryNum
     */
    public String getDeliveryNum() {
        return deliveryNum;
    }










    
    /**
     * deliveryNum을 설정
     * @param deliveryNum 을(를) String deliveryNum로 설정
     */
    public void setDeliveryNum(String deliveryNum) {
        this.deliveryNum = deliveryNum;
    }










    
    /**
     * String itemDesptn을 반환
     * @return String itemDesptn
     */
    public String getItemDesptn() {
        return itemDesptn;
    }










    
    /**
     * itemDesptn을 설정
     * @param itemDesptn 을(를) String itemDesptn로 설정
     */
    public void setItemDesptn(String itemDesptn) {
        this.itemDesptn = itemDesptn;
    }










    
    /**
     * String itemUnit을 반환
     * @return String itemUnit
     */
    public String getItemUnit() {
        return itemUnit;
    }










    
    /**
     * itemUnit을 설정
     * @param itemUnit 을(를) String itemUnit로 설정
     */
    public void setItemUnit(String itemUnit) {
        this.itemUnit = itemUnit;
    }










    
    /**
     * String deliveryDate을 반환
     * @return String deliveryDate
     */
    public String getDeliveryDate() {
        return deliveryDate;
    }










    
    /**
     * deliveryDate을 설정
     * @param deliveryDate 을(를) String deliveryDate로 설정
     */
    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }










    
    /**
     * String deliveryPlace을 반환
     * @return String deliveryPlace
     */
    public String getDeliveryPlace() {
        return deliveryPlace;
    }










    
    /**
     * deliveryPlace을 설정
     * @param deliveryPlace 을(를) String deliveryPlace로 설정
     */
    public void setDeliveryPlace(String deliveryPlace) {
        this.deliveryPlace = deliveryPlace;
    }










    
    /**
     * int itemQuantity을 반환
     * @return int itemQuantity
     */
    public int getItemQuantity() {
        return itemQuantity;
    }










    
    /**
     * itemQuantity을 설정
     * @param itemQuantity 을(를) int itemQuantity로 설정
     */
    public void setItemQuantity(int itemQuantity) {
        this.itemQuantity = itemQuantity;
    }










    
    /**
     * int unitPrice을 반환
     * @return int unitPrice
     */
    public int getUnitPrice() {
        return unitPrice;
    }










    
    /**
     * unitPrice을 설정
     * @param unitPrice 을(를) int unitPrice로 설정
     */
    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }










    
    /**
     * int itemAmount을 반환
     * @return int itemAmount
     */
    public int getItemAmount() {
        return itemAmount;
    }










    
    /**
     * itemAmount을 설정
     * @param itemAmount 을(를) int itemAmount로 설정
     */
    public void setItemAmount(int itemAmount) {
        this.itemAmount = itemAmount;
    }










    /**
     * String cntrUnum을 반환
     * @return String cntrUnum
     */
    public String getCntrUnum() {
        return cntrUnum;
    }









    
    /**
     * cntrUnum을 설정
     * @param cntrUnum 을(를) String cntrUnum로 설정
     */
    public void setCntrUnum(String cntrUnum) {
        this.cntrUnum = cntrUnum;
    }









    
    /**
     * String itemName을 반환
     * @return String itemName
     */
    public String getItemName() {
        return itemName;
    }









    
    /**
     * itemName을 설정
     * @param itemName 을(를) String itemName로 설정
     */
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }









    
    /**
     * String manuName을 반환
     * @return String manuName
     */
    public String getManuName() {
        return manuName;
    }









    
    /**
     * manuName을 설정
     * @param manuName 을(를) String manuName로 설정
     */
    public void setManuName(String manuName) {
        this.manuName = manuName;
    }









    
    /**
     * String itemEntrDate을 반환
     * @return String itemEntrDate
     */
    public String getItemEntrDate() {
        return itemEntrDate;
    }









    
    /**
     * itemEntrDate을 설정
     * @param itemEntrDate 을(를) String itemEntrDate로 설정
     */
    public void setItemEntrDate(String itemEntrDate) {
        this.itemEntrDate = itemEntrDate;
    }









    
    /**
     * int unitPric을 반환
     * @return int unitPric
     */
    public String getUnitPric() {
        return unitPric;
    }









    
    /**
     * unitPric을 설정
     * @param unitPric 을(를) int unitPric로 설정
     */
    public void setUnitPric(String unitPric) {
        this.unitPric = unitPric;
    }









    
    /**
     * int lineNum을 반환
     * @return int lineNum
     */
    public int getLineNum() {
        return lineNum;
    }









    
    /**
     * lineNum을 설정
     * @param lineNum 을(를) int lineNum로 설정
     */
    public void setLineNum(int lineNum) {
        this.lineNum = lineNum;
    }


    private String     unitPric;
    private int     lineNum;


   /**
     * String commUserNm을 반환
     * @return String commUserNm
     */
    public String getCommUserNm() {
        return commUserNm;
    }








    
    /**
     * commUserNm을 설정
     * @param commUserNm 을(를) String commUserNm로 설정
     */
    public void setCommUserNm(String commUserNm) {
        this.commUserNm = commUserNm;
    }








    /**
     * String rlCntrctInsttAt을 반환
     * @return String rlCntrctInsttAt
     */
    public String getRlCntrctInsttAt() {
        return rlCntrctInsttAt;
    }







    
    /**
     * rlCntrctInsttAt을 설정
     * @param rlCntrctInsttAt 을(를) String rlCntrctInsttAt로 설정
     */
    public void setRlCntrctInsttAt(String rlCntrctInsttAt) {
        this.rlCntrctInsttAt = rlCntrctInsttAt;
    }







    /**
     * List<FileVO> ctrtcSnList을 반환
     * @return List<FileVO> ctrtcSnList
     */
    public List<FileVO> getCtrtcSnList() {
        return ctrtcSnList;
    }






    
    /**
     * ctrtcSnList을 설정
     * @param ctrtcSnList 을(를) List<FileVO> ctrtcSnList로 설정
     */
    public void setCtrtcSnList(List<FileVO> ctrtcSnList) {
        this.ctrtcSnList = ctrtcSnList;
    }






    /**
     * String userSn을 반환
     * @return String userSn
     */
    public String getUserSn() {
        return userSn;
    }





    
    /**
     * userSn을 설정
     * @param userSn 을(를) String userSn로 설정
     */
    public void setUserSn(String userSn) {
        this.userSn = userSn;
    }





    /**
     * String suplerId을 반환
     * @return String suplerId
     */
    public String getSuplerId() {
        return suplerId;
    }




    
    /**
     * suplerId을 설정
     * @param suplerId 을(를) String suplerId로 설정
     */
    public void setSuplerId(String suplerId) {
        this.suplerId = suplerId;
    }




    
    /**
     * String sbscrbTyCd을 반환
     * @return String sbscrbTyCd
     */
    public String getSbscrbTyCd() {
        return sbscrbTyCd;
    }




    
    /**
     * sbscrbTyCd을 설정
     * @param sbscrbTyCd 을(를) String sbscrbTyCd로 설정
     */
    public void setSbscrbTyCd(String sbscrbTyCd) {
        this.sbscrbTyCd = sbscrbTyCd;
    }




    
    /**
     * String orgnCode을 반환
     * @return String orgnCode
     */
    public String getOrgnCode() {
        return orgnCode;
    }




    
    /**
     * orgnCode을 설정
     * @param orgnCode 을(를) String orgnCode로 설정
     */
    public void setOrgnCode(String orgnCode) {
        this.orgnCode = orgnCode;
    }




    
    /**
     * String orgnNm을 반환
     * @return String orgnNm
     */
    public String getOrgnNm() {
        return orgnNm;
    }




    
    /**
     * orgnNm을 설정
     * @param orgnNm 을(를) String orgnNm로 설정
     */
    public void setOrgnNm(String orgnNm) {
        this.orgnNm = orgnNm;
    }




    
    /**
     * String realOrgNm을 반환
     * @return String realOrgNm
     */
    public String getRealOrgNm() {
        return realOrgNm;
    }




    
    /**
     * realOrgNm을 설정
     * @param realOrgNm 을(를) String realOrgNm로 설정
     */
    public void setRealOrgNm(String realOrgNm) {
        this.realOrgNm = realOrgNm;
    }




    
    /**
     * String realBuesoCnt을 반환
     * @return String realBuesoCnt
     */
    public String getRealBuesoCnt() {
        return realBuesoCnt;
    }




    
    /**
     * realBuesoCnt을 설정
     * @param realBuesoCnt 을(를) String realBuesoCnt로 설정
     */
    public void setRealBuesoCnt(String realBuesoCnt) {
        this.realBuesoCnt = realBuesoCnt;
    }


    private String  realOrgNm;
    private String  realBuesoCnt;
    
    /**
     * String strCntrctSn을 반환
     * @return String strCntrctSn
     */
    public String getStrCntrctSn() {
        return strCntrctSn;
    }



    
    /**
     * strCntrctSn을 설정
     * @param strCntrctSn 을(를) String strCntrctSn로 설정
     */
    public void setStrCntrctSn(String strCntrctSn) {
        this.strCntrctSn = strCntrctSn;
    }


    private String  cntrctUnionNo;
    private String  realOrgnNm;

    private String  strCntrctSn;
    
    /**
     * String realOrgnNm을 반환
     * @return String realOrgnNm
     */
    public String getRealOrgnNm() {
        return realOrgnNm;
    }


    
    /**
     * realOrgnNm을 설정
     * @param realOrgnNm 을(를) String realOrgnNm로 설정
     */
    public void setRealOrgnNm(String realOrgnNm) {
        this.realOrgnNm = realOrgnNm;
    }


    /**
     * String cntrctUnionNo을 반환
     * @return String cntrctUnionNo
     */
    public String getCntrctUnionNo() {
        return cntrctUnionNo;
    }

    
    /**
     * cntrctUnionNo을 설정
     * @param cntrctUnionNo 을(를) String cntrctUnionNo로 설정
     */
    public void setCntrctUnionNo(String cntrctUnionNo) {
        this.cntrctUnionNo = cntrctUnionNo;
    }

    
    /**
     * String cntrctNo을 반환
     * @return String cntrctNo
     */
    public String getCntrctNo() {
        return cntrctNo;
    }

    
    /**
     * cntrctNo을 설정
     * @param cntrctNo 을(를) String cntrctNo로 설정
     */
    public void setCntrctNo(String cntrctNo) {
        this.cntrctNo = cntrctNo;
    }

    
    /**
     * String cntrctNm을 반환
     * @return String cntrctNm
     */
    public String getCntrctNm() {
        return cntrctNm;
    }

    
    /**
     * cntrctNm을 설정
     * @param cntrctNm 을(를) String cntrctNm로 설정
     */
    public void setCntrctNm(String cntrctNm) {
        this.cntrctNm = cntrctNm;
    }

    
    /**
     * String cntrctType을 반환
     * @return String cntrctType
     */
    public String getCntrctType() {
        return cntrctType;
    }

    
    /**
     * cntrctType을 설정
     * @param cntrctType 을(를) String cntrctType로 설정
     */
    public void setCntrctType(String cntrctType) {
        this.cntrctType = cntrctType;
    }

    
    /**
     * String cntrctMth을 반환
     * @return String cntrctMth
     */
    public String getCntrctMth() {
        return cntrctMth;
    }

    
    /**
     * cntrctMth을 설정
     * @param cntrctMth 을(를) String cntrctMth로 설정
     */
    public void setCntrctMth(String cntrctMth) {
        this.cntrctMth = cntrctMth;
    }

    
    /**
     * String cntrctDate을 반환
     * @return String cntrctDate
     */
    public String getCntrctDate() {
        return cntrctDate;
    }

    
    /**
     * cntrctDate을 설정
     * @param cntrctDate 을(를) String cntrctDate로 설정
     */
    public void setCntrctDate(String cntrctDate) {
        this.cntrctDate = cntrctDate;
    }

    
    /**
     * String cntrctPd을 반환
     * @return String cntrctPd
     */
    public String getCntrctPd() {
        return cntrctPd;
    }

    
    /**
     * cntrctPd을 설정
     * @param cntrctPd 을(를) String cntrctPd로 설정
     */
    public void setCntrctPd(String cntrctPd) {
        this.cntrctPd = cntrctPd;
    }

    
    /**
     * String bid_notifyNo을 반환
     * @return String bid_notifyNo
     */
    public String getBid_notifyNo() {
        return bid_notifyNo;
    }

    
    /**
     * bid_notifyNo을 설정
     * @param bid_notifyNo 을(를) String bid_notifyNo로 설정
     */
    public void setBid_notifyNo(String bid_notifyNo) {
        this.bid_notifyNo = bid_notifyNo;
    }

    
    /**
     * String bidNotifySeqNo을 반환
     * @return String bidNotifySeqNo
     */
    public String getBidNotifySeqNo() {
        return bidNotifySeqNo;
    }

    
    /**
     * bidNotifySeqNo을 설정
     * @param bidNotifySeqNo 을(를) String bidNotifySeqNo로 설정
     */
    public void setBidNotifySeqNo(String bidNotifySeqNo) {
        this.bidNotifySeqNo = bidNotifySeqNo;
    }

    
    /**
     * String orderOrgnNm을 반환
     * @return String orderOrgnNm
     */
    public String getOrderOrgnNm() {
        return orderOrgnNm;
    }

    
    /**
     * orderOrgnNm을 설정
     * @param orderOrgnNm 을(를) String orderOrgnNm로 설정
     */
    public void setOrderOrgnNm(String orderOrgnNm) {
        this.orderOrgnNm = orderOrgnNm;
    }

    
    /**
     * String realOrgn_code을 반환
     * @return String realOrgn_code
     */
    public String getRealOrgn_code() {
        return realOrgn_code;
    }

    
    /**
     * realOrgn_code을 설정
     * @param realOrgn_code 을(를) String realOrgn_code로 설정
     */
    public void setRealOrgn_code(String realOrgn_code) {
        this.realOrgn_code = realOrgn_code;
    }

    
    /**
     * String realOrgn_nm을 반환
     * @return String realOrgn_nm
     */
    public String getRealOrgn_nm() {
        return realOrgn_nm;
    }

    
    /**
     * realOrgn_nm을 설정
     * @param realOrgn_nm 을(를) String realOrgn_nm로 설정
     */
    public void setRealOrgn_nm(String realOrgn_nm) {
        this.realOrgn_nm = realOrgn_nm;
    }

    
    /**
     * String mainCntrctEntrpsType을 반환
     * @return String mainCntrctEntrpsType
     */
    public String getMainCntrctEntrpsType() {
        return mainCntrctEntrpsType;
    }

    
    /**
     * mainCntrctEntrpsType을 설정
     * @param mainCntrctEntrpsType 을(를) String mainCntrctEntrpsType로 설정
     */
    public void setMainCntrctEntrpsType(String mainCntrctEntrpsType) {
        this.mainCntrctEntrpsType = mainCntrctEntrpsType;
    }

    
    /**
     * String mainCntrctEntrpsNm을 반환
     * @return String mainCntrctEntrpsNm
     */
    public String getMainCntrctEntrpsNm() {
        return mainCntrctEntrpsNm;
    }

    
    /**
     * mainCntrctEntrpsNm을 설정
     * @param mainCntrctEntrpsNm 을(를) String mainCntrctEntrpsNm로 설정
     */
    public void setMainCntrctEntrpsNm(String mainCntrctEntrpsNm) {
        this.mainCntrctEntrpsNm = mainCntrctEntrpsNm;
    }

    
    /**
     * String senderId을 반환
     * @return String senderId
     */
    public String getSenderId() {
        return senderId;
    }

    
    /**
     * senderId을 설정
     * @param senderId 을(를) String senderId로 설정
     */
    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    
    /**
     * String messType을 반환
     * @return String messType
     */
    public String getMessType() {
        return messType;
    }

    
    /**
     * messType을 설정
     * @param messType 을(를) String messType로 설정
     */
    public void setMessType(String messType) {
        this.messType = messType;
    }

    
    /**
     * String messNm을 반환
     * @return String messNm
     */
    public String getMessNm() {
        return messNm;
    }

    
    /**
     * messNm을 설정
     * @param messNm 을(를) String messNm로 설정
     */
    public void setMessNm(String messNm) {
        this.messNm = messNm;
    }

    
    /**
     * String docuMangNo을 반환
     * @return String docuMangNo
     */
    public String getDocuMangNo() {
        return docuMangNo;
    }

    
    /**
     * docuMangNo을 설정
     * @param docuMangNo 을(를) String docuMangNo로 설정
     */
    public void setDocuMangNo(String docuMangNo) {
        this.docuMangNo = docuMangNo;
    }

    
    /**
     * String cntrctUnionSeq을 반환
     * @return String cntrctUnionSeq
     */
    public String getCntrctUnionSeq() {
        return cntrctUnionSeq;
    }

    
    /**
     * cntrctUnionSeq을 설정
     * @param cntrctUnionSeq 을(를) String cntrctUnionSeq로 설정
     */
    public void setCntrctUnionSeq(String cntrctUnionSeq) {
        this.cntrctUnionSeq = cntrctUnionSeq;
    }

    
    /**
     * String itemClNo을 반환
     * @return String itemClNo
     */
    public String getItemClNo() {
        return itemClNo;
    }

    
    /**
     * itemClNo을 설정
     * @param itemClNo 을(를) String itemClNo로 설정
     */
    public void setItemClNo(String itemClNo) {
        this.itemClNo = itemClNo;
    }

    
    /**
     * String itemIdntfcNo을 반환
     * @return String itemIdntfcNo
     */
    public String getItemIdntfcNo() {
        return itemIdntfcNo;
    }

    
    /**
     * itemIdntfcNo을 설정
     * @param itemIdntfcNo 을(를) String itemIdntfcNo로 설정
     */
    public void setItemIdntfcNo(String itemIdntfcNo) {
        this.itemIdntfcNo = itemIdntfcNo;
    }

    
    /**
     * String cntrctItemUntpc을 반환
     * @return String cntrctItemUntpc
     */
    public String getCntrctItemUntpc() {
        return cntrctItemUntpc;
    }

    
    /**
     * cntrctItemUntpc을 설정
     * @param cntrctItemUntpc 을(를) String cntrctItemUntpc로 설정
     */
    public void setCntrctItemUntpc(String cntrctItemUntpc) {
        this.cntrctItemUntpc = cntrctItemUntpc;
    }

    
    /**
     * String cntrctItemQy을 반환
     * @return String cntrctItemQy
     */
    public String getCntrctItemQy() {
        return cntrctItemQy;
    }

    
    /**
     * cntrctItemQy을 설정
     * @param cntrctItemQy 을(를) String cntrctItemQy로 설정
     */
    public void setCntrctItemQy(String cntrctItemQy) {
        this.cntrctItemQy = cntrctItemQy;
    }

    
    /**
     * String cntrctItemNm을 반환
     * @return String cntrctItemNm
     */
    public String getCntrctItemNm() {
        return cntrctItemNm;
    }

    
    /**
     * cntrctItemNm을 설정
     * @param cntrctItemNm 을(를) String cntrctItemNm로 설정
     */
    public void setCntrctItemNm(String cntrctItemNm) {
        this.cntrctItemNm = cntrctItemNm;
    }

    
    /**
     * int cntrctThisTimeAmt을 반환
     * @return int cntrctThisTimeAmt
     */
    public int getCntrctThisTimeAmt() {
        return cntrctThisTimeAmt;
    }

    
    /**
     * cntrctThisTimeAmt을 설정
     * @param cntrctThisTimeAmt 을(를) int cntrctThisTimeAmt로 설정
     */
    public void setCntrctThisTimeAmt(int cntrctThisTimeAmt) {
        this.cntrctThisTimeAmt = cntrctThisTimeAmt;
    }

    
    /**
     * int cntrctAmt을 반환
     * @return int cntrctAmt
     */
    public int getCntrctAmt() {
        return cntrctAmt;
    }

    
    /**
     * cntrctAmt을 설정
     * @param cntrctAmt 을(를) int cntrctAmt로 설정
     */
    public void setCntrctAmt(int cntrctAmt) {
        this.cntrctAmt = cntrctAmt;
    }

    
    /**
     * int cntrctItemAmt을 반환
     * @return int cntrctItemAmt
     */
    public int getCntrctItemAmt() {
        return cntrctItemAmt;
    }

    
    /**
     * cntrctItemAmt을 설정
     * @param cntrctItemAmt 을(를) int cntrctItemAmt로 설정
     */
    public void setCntrctItemAmt(int cntrctItemAmt) {
        this.cntrctItemAmt = cntrctItemAmt;
    }


    private String  cntrctNo;
    private String  cntrctNm;
    private String  cntrctType;
    private String  cntrctMth;
    private String  cntrctDate;
    private String  cntrctPd;
    private String  bid_notifyNo;
    private String  bidNotifySeqNo;
    private String  orderOrgnNm;
    private String  realOrgn_code;
    private String  realOrgn_nm;
    private String  mainCntrctEntrpsType;
    private String  mainCntrctEntrpsNm;
    private String  senderId;
    private String  messType;
    private String  messNm;
    private String  docuMangNo;
    private String  cntrctUnionSeq;
    private String  itemClNo;
    private String  itemIdntfcNo;
    private String  cntrctItemUntpc;
    private String  cntrctItemQy;
    private String  cntrctItemNm;

    private int  cntrctThisTimeAmt;
    private int  cntrctAmt;
    private int  cntrctItemAmt;    
    
    
    /**
     * int cntrctSn을 반환
     * @return int cntrctSn
     */
    public int getCntrctSn() {
        return cntrctSn;
    }

    /**
     * cntrctSn을 설정
     * @param cntrctSn 을(를) int cntrctSn로 설정
     */
    public void setCntrctSn(int cntrctSn) {
        this.cntrctSn = cntrctSn;
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
     * String svcNm을 반환
     * @return String svcNm
     */
    public String getSvcNm() {
        return svcNm;
    }

    /**
     * svcNm을 설정
     * @param svcNm 을(를) String svcNm로 설정
     */
    public void setSvcNm(String svcNm) {
        this.svcNm = svcNm;
    }

    /**
     * String cntrctBeginDe을 반환
     * @return String cntrctBeginDe
     */
    public String getCntrctBeginDe() {
        return cntrctBeginDe;
    }

    /**
     * cntrctBeginDe을 설정
     * @param cntrctBeginDe 을(를) String cntrctBeginDe로 설정
     */
    public void setCntrctBeginDe(String cntrctBeginDe) {
        this.cntrctBeginDe = cntrctBeginDe;
    }

    /**
     * String cntrctEndDe을 반환
     * @return String cntrctEndDe
     */
    public String getCntrctEndDe() {
        return cntrctEndDe;
    }

    /**
     * cntrctEndDe을 설정
     * @param cntrctEndDe 을(를) String cntrctEndDe로 설정
     */
    public void setCntrctEndDe(String cntrctEndDe) {
        this.cntrctEndDe = cntrctEndDe;
    }

    /**
     * Long cntrctamount을 반환
     * @return Long cntrctamount
     */
    public Long getCntrctamount() {
        return cntrctamount;
    }

    /**
     * cntrctamount을 설정
     * @param cntrctamount 을(를) Long cntrctamount로 설정
     */
    public void setCntrctamount(Long cntrctamount) {
        this.cntrctamount = cntrctamount;
    }

    /**
     * String purchsInsttNm을 반환
     * @return String purchsInsttNm
     */
    public String getPurchsInsttNm() {
        return purchsInsttNm;
    }

    /**
     * purchsInsttNm을 설정
     * @param purchsInsttNm 을(를) String purchsInsttNm로 설정
     */
    public void setPurchsInsttNm(String purchsInsttNm) {
        this.purchsInsttNm = purchsInsttNm;
    }

    /**
     * String sleInsttNm을 반환
     * @return String sleInsttNm
     */
    public String getSleInsttNm() {
        return sleInsttNm;
    }

    /**
     * sleInsttNm을 설정
     * @param sleInsttNm 을(를) String sleInsttNm로 설정
     */
    public void setSleInsttNm(String sleInsttNm) {
        this.sleInsttNm = sleInsttNm;
    }

    /**
     * int ctrtcSn을 반환
     * @return int ctrtcSn
     */
    public int getCtrtcSn() {
        return ctrtcSn;
    }

    /**
     * ctrtcSn을 설정
     * @param ctrtcSn 을(를) int ctrtcSn로 설정
     */
    public void setCtrtcSn(int ctrtcSn) {
        this.ctrtcSn = ctrtcSn;
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
     * List<FileVO> ctrtcFile을 반환
     * @return List<FileVO> ctrtcFile
     */
    public List<FileVO> getCtrtcFile() {
        return ctrtcFile;
    }


    /**
     * ctrtcFile을 설정
     * @param ctrtcFile 을(를) List<FileVO> ctrtcFile로 설정
     */
    public void setCtrtcFile(List<FileVO> ctrtcFile) {
        this.ctrtcFile = ctrtcFile;
    }

    /**
     * String [] cntrctSns을 반환
     * @return String [] cntrctSns
     */
    public String[] getCntrctSns() {
        return cntrctSns;
    }

    /**
     * cntrctSns을 설정
     * @param cntrctSns 을(를) String [] cntrctSns로 설정
     */
    public void setCntrctSns(String[] cntrctSns) {
        this.cntrctSns = cntrctSns;
    }

    
    /**
     * String tempUserSn을 반환
     * @return String tempUserSn
     */
    public String getTempUserSn() {
        return tempUserSn;
    }

    
    /**
     * tempUserSn을 설정
     * @param tempUserSn 을(를) String tempUserSn로 설정
     */
    public void setTempUserSn(String tempUserSn) {
        this.tempUserSn = tempUserSn;
    }

    
    /**
     * String cntrCount을 반환
     * @return String cntrCount
     */
    public String getCntrCount() {
        return cntrCount;
    }

    
    /**
     * cntrCount을 설정
     * @param cntrCount 을(를) String cntrCount로 설정
     */
    public void setCntrCount(String cntrCount) {
        this.cntrCount = cntrCount;
    }

    
    /**
     * String goodsNm을 반환
     * @return String goodsNm
     */
    public String getGoodsNm() {
        return goodsNm;
    }

    
    /**
     * goodsNm을 설정
     * @param goodsNm 을(를) String goodsNm로 설정
     */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    
    /**
     * String contrDt을 반환
     * @return String contrDt
     */
    public String getCntrDt() {
        return cntrDt;
    }

    
    /**
     * contrDt을 설정
     * @param contrDt 을(를) String contrDt로 설정
     */
    public void setCntrDt(String cntrDt) {
        this.cntrDt = cntrDt;
    }

    
    /**
     * String bidGbnNm을 반환
     * @return String bidGbnNm
     */
    public String getBidGbnNm() {
        return bidGbnNm;
    }

    
    /**
     * bidGbnNm을 설정
     * @param bidGbnNm 을(를) String bidGbnNm로 설정
     */
    public void setBidGbnNm(String bidGbnNm) {
        this.bidGbnNm = bidGbnNm;
    }

    
    /**
     * String useAt을 반환
     * @return String useAt
     */
    public String getUseAt() {
        return useAt;
    }

    
    /**
     * useAt을 설정
     * @param useAt 을(를) String useAt로 설정
     */
    public void setUseAt(String useAt) {
        this.useAt = useAt;
    }

    
    /**
     * String svcnm을 반환
     * @return String svcnm
     */
    public String getSvcnm() {
        return svcNm;
    }

    
    /**
     * svcnm을 설정
     * @param svcnm 을(를) String svcnm로 설정
     */
    public void setSvcnm(String svcNm) {
        this.svcNm = svcNm;
    }

    
    /**
     * String notifyNum을 반환
     * @return String notifyNum
     */
    public String getNotifyNum() {
        return notifyNum;
    }

    
    /**
     * notifyNum을 설정
     * @param notifyNum 을(를) String notifyNum로 설정
     */
    public void setNotifyNum(String notifyNum) {
        this.notifyNum = notifyNum;
    }

    
    /**
     * int notifySeq을 반환
     * @return int notifySeq
     */
    public int getNotifySeq() {
        return notifySeq;
    }

    
    /**
     * notifySeq을 설정
     * @param notifySeq 을(를) int notifySeq로 설정
     */
    public void setNotifySeq(int notifySeq) {
        this.notifySeq = notifySeq;
    }

    
    /**
     * String goodsCode을 반환
     * @return String goodsCode
     */
    public String getGoodsCode() {
        return goodsCode;
    }

    
    /**
     * goodsCode을 설정
     * @param goodsCode 을(를) String goodsCode로 설정
     */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }

    
    /**
     * String cntrNum을 반환
     * @return String cntrNum
     */
    public String getCntrNum() {
        return cntrNum;
    }

    
    /**
     * cntrNum을 설정
     * @param cntrNum 을(를) String cntrNum로 설정
     */
    public void setCntrNum(String cntrNum) {
        this.cntrNum = cntrNum;
    }

    
    /**
     * String splyForm을 반환
     * @return String splyForm
     */
    public String getSplyForm() {
        return splyForm;
    }

    
    /**
     * splyForm을 설정
     * @param splyForm 을(를) String splyForm로 설정
     */
    public void setSplyForm(String splyForm) {
        this.splyForm = splyForm;
    }

    
    /**
     * String splyFormEtc을 반환
     * @return String splyFormEtc
     */
    public String getSplyFormEtc() {
        return splyFormEtc;
    }

    
    /**
     * splyFormEtc을 설정
     * @param splyFormEtc 을(를) String splyFormEtc로 설정
     */
    public void setSplyFormEtc(String splyFormEtc) {
        this.splyFormEtc = splyFormEtc;
    }

    
    /**
     * String commUserId을 반환
     * @return String commUserId
     */
    public String getCommUserId() {
        return commUserId;
    }

    
    /**
     * commUserId을 설정
     * @param commUserId 을(를) String commUserId로 설정
     */
    public void setCommUserId(String commUserId) {
        this.commUserId = commUserId;
    }

    
    /**
     * String certResultCode을 반환
     * @return String certResultCode
     */
    public String getCertResultCode() {
        return certResultCode;
    }

    
    /**
     * certResultCode을 설정
     * @param certResultCode 을(를) String certResultCode로 설정
     */
    public void setCertResultCode(String certResultCode) {
        this.certResultCode = certResultCode;
    }

    
    /**
     * String certResultDt을 반환
     * @return String certResultDt
     */
    public String getCertResultDt() {
        return certResultDt;
    }

    
    /**
     * certResultDt을 설정
     * @param certResultDt 을(를) String certResultDt로 설정
     */
    public void setCertResultDt(String certResultDt) {
        this.certResultDt = certResultDt;
    }

    
    /**
     * Integer certResultFile을 반환
     * @return Integer certResultFile
     */
    public Integer getCertResultFile() {
        return certResultFile;
    }

    
    /**
     * certResultFile을 설정
     * @param certResultFile 을(를) Integer certResultFile로 설정
     */
    public void setCertResultFile(Integer certResultFile) {
        this.certResultFile = certResultFile;
    }

    
    /**
     * String ownerComment을 반환
     * @return String ownerComment
     */
    public String getOwnerComment() {
        return ownerComment;
    }

    
    /**
     * ownerComment을 설정
     * @param ownerComment 을(를) String ownerComment로 설정
     */
    public void setOwnerComment(String ownerComment) {
        this.ownerComment = ownerComment;
    }

    
    /**
     * String recogDt을 반환
     * @return String recogDt
     */
    public String getRecogDt() {
        return recogDt;
    }

    
    /**
     * recogDt을 설정
     * @param recogDt 을(를) String recogDt로 설정
     */
    public void setRecogDt(String recogDt) {
        this.recogDt = recogDt;
    }

    
    /**
     * String registMthdCode을 반환
     * @return String registMthdCode
     */
    public String getRegistMthdCode() {
        return registMthdCode;
    }

    
    /**
     * registMthdCode을 설정
     * @param registMthdCode 을(를) String registMthdCode로 설정
     */
    public void setRegistMthdCode(String registMthdCode) {
        this.registMthdCode = registMthdCode;
    }

    
    /**
     * String userSe을 반환
     * @return String userSe
     */
    public String getUserSe() {
        return userSe;
    }

    
    /**
     * userSe을 설정
     * @param userSe 을(를) String userSe로 설정
     */
    public void setUserSe(String userSe) {
        this.userSe = userSe;
    }

    
    /**
     * String sportAt을 반환
     * @return String sportAt
     */
    public String getSportAt() {
        return sportAt;
    }

    
    /**
     * sportAt을 설정
     * @param sportAt 을(를) String sportAt로 설정
     */
    public void setSportAt(String sportAt) {
        this.sportAt = sportAt;
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
     * String purchsInsttNm2을 반환
     * @return String purchsInsttNm2
     */
    public String getPurchsInsttNm2() {
        return purchsInsttNm2;
    }

    
    /**
     * purchsInsttNm2을 설정
     * @param purchsInsttNm2 을(를) String purchsInsttNm2로 설정
     */
    public void setPurchsInsttNm2(String purchsInsttNm2) {
        this.purchsInsttNm2 = purchsInsttNm2;
    }

    
    /**
     * String asis을 반환
     * @return String asis
     */
    public String getAsis() {
        return asis;
    }

    
    /**
     * asis을 설정
     * @param asis 을(를) String asis로 설정
     */
    public void setAsis(String asis) {
        this.asis = asis;
    }

    
    /**
     * String ownerComment2을 반환
     * @return String ownerComment2
     */
    public String getOwnerComment2() {
        return ownerComment2;
    }

    
    /**
     * ownerComment2을 설정
     * @param ownerComment2 을(를) String ownerComment2로 설정
     */
    public void setOwnerComment2(String ownerComment2) {
        this.ownerComment2 = ownerComment2;
    }

    
    /**
     * Integer cntrctSvcSn을 반환
     * @return Integer cntrctSvcSn
     */
    public Integer getCntrctSvcSn() {
        return cntrctSvcSn;
    }

    
    /**
     * cntrctSvcSn을 설정
     * @param cntrctSvcSn 을(를) Integer cntrctSvcSn로 설정
     */
    public void setCntrctSvcSn(Integer cntrctSvcSn) {
        this.cntrctSvcSn = cntrctSvcSn;
    }

    
    /**
     * int cntrctCount을 반환
     * @return int cntrctCount
     */
    public int getCntrctCount() {
        return cntrctCount;
    }

    
    /**
     * cntrctCount을 설정
     * @param cntrctCount 을(를) int cntrctCount로 설정
     */
    public void setCntrctCount(int cntrctCount) {
        this.cntrctCount = cntrctCount;
    }

    
    /**
     * int cntrctAmount을 반환
     * @return int cntrctAmount
     */
    public int getCntrctAmount() {
        return cntrctAmount;
    }

    
    /**
     * cntrctAmount을 설정
     * @param cntrctAmount 을(를) int cntrctAmount로 설정
     */
    public void setCntrctAmount(int cntrctAmount) {
        this.cntrctAmount = cntrctAmount;
    }

    
}
