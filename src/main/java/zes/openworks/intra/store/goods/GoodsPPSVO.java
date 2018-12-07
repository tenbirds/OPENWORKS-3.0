/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.goods;

import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)앤키소프트
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 12. 01.   guest1       신규
 * </pre>
 * @see
 */

public class GoodsPPSVO extends PaggingVO {
    
    private String cntrUnum;                   //통합계약번호
    private String cntrNum;                    //계약번호+차수
    private String lineNum;                    //물품일련번호
    private String itemClassIdentifier;        //G2B물품분류번호
    private String itemIdentifier;             //G2B물품식별번호
    private String itemDetailClsIden;          //세부물품분류번호
    private String itemName;                   //규격명
    private String itemUnit;                   //단위
    private String unitPric;                   //단가금액정보
    private String itemImgurl;                 //제품대이미지URL
    private String itemCertf;                  //품질관련인증정보
    private String deliverDay;                 //납품일수
    private String deliverContent;             //납품기한내용
    private String orgnCode;                   //원산코드
    private String orgnName;                   //원산지명
    private String lgsCateCode;                //대분류코드
    private String lgsCateName;                //대분류코드명
    private String mdsCateCode;                //중분류코드
    private String mdsCateName;                //중분류코드명
    private String manuName;                   //제조사명
    private String localAddr;                  //소재지
    private String supyDeptName;               //공급업체담당부서명
    private String supuDeptNum;                //공급업체담당부서전화번호
    private String itemUse;                    //사용여부
    private String itemDelete;                 //삭제여부
    private String itemDealstop;               //거래정지여부
    private String itemOrderBlock;             //주문차단여부
   
    /* 20161208 추가 */
    private String itemEntrDate;                //등록일
    private String goodsCode;                   //서비스코드

    private String[] cntrNums;                  //계약번호+차수배열
    private String[] lineNums;                  //물품일련번호배열
    private String[] goodsCodes;                //서비스코드배열
    

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
     * String lineNum을 반환
     * @return String lineNum
     */
    public String getLineNum() {
        return lineNum;
    }
    
    /**
     * lineNum을 설정
     * @param lineNum 을(를) String lineNum로 설정
     */
    public void setLineNum(String lineNum) {
        this.lineNum = lineNum;
    }
    
    /**
     * String itemClassIdentifier을 반환
     * @return String itemClassIdentifier
     */
    public String getItemClassIdentifier() {
        return itemClassIdentifier;
    }
    
    /**
     * itemClassIdentifier을 설정
     * @param itemClassIdentifier 을(를) String itemClassIdentifier로 설정
     */
    public void setItemClassIdentifier(String itemClassIdentifier) {
        this.itemClassIdentifier = itemClassIdentifier;
    }
    
    /**
     * String itemIdentifier을 반환
     * @return String itemIdentifier
     */
    public String getItemIdentifier() {
        return itemIdentifier;
    }
    
    /**
     * itemIdentifier을 설정
     * @param itemIdentifier 을(를) String itemIdentifier로 설정
     */
    public void setItemIdentifier(String itemIdentifier) {
        this.itemIdentifier = itemIdentifier;
    }
    
    /**
     * String itemDetailClsIden을 반환
     * @return String itemDetailClsIden
     */
    public String getItemDetailClsIden() {
        return itemDetailClsIden;
    }
    
    /**
     * itemDetailClsIden을 설정
     * @param itemDetailClsIden 을(를) String itemDetailClsIden로 설정
     */
    public void setItemDetailClsIden(String itemDetailClsIden) {
        this.itemDetailClsIden = itemDetailClsIden;
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
     * String unitPric을 반환
     * @return String unitPric
     */
    public String getUnitPric() {
        return unitPric;
    }
    
    /**
     * unitPric을 설정
     * @param unitPric 을(를) String unitPric로 설정
     */
    public void setUnitPric(String unitPric) {
        this.unitPric = unitPric;
    }
    
    /**
     * String itemImgurl을 반환
     * @return String itemImgurl
     */
    public String getItemImgurl() {
        return itemImgurl;
    }
    
    /**
     * itemImgurl을 설정
     * @param itemImgurl 을(를) String itemImgurl로 설정
     */
    public void setItemImgurl(String itemImgurl) {
        this.itemImgurl = itemImgurl;
    }
    
    /**
     * String itemCertf을 반환
     * @return String itemCertf
     */
    public String getItemCertf() {
        return itemCertf;
    }
    
    /**
     * itemCertf을 설정
     * @param itemCertf 을(를) String itemCertf로 설정
     */
    public void setItemCertf(String itemCertf) {
        this.itemCertf = itemCertf;
    }
    
    /**
     * String deliverDay을 반환
     * @return String deliverDay
     */
    public String getDeliverDay() {
        return deliverDay;
    }
    
    /**
     * deliverDay을 설정
     * @param deliverDay 을(를) String deliverDay로 설정
     */
    public void setDeliverDay(String deliverDay) {
        this.deliverDay = deliverDay;
    }
    
    /**
     * String deliverContent을 반환
     * @return String deliverContent
     */
    public String getDeliverContent() {
        return deliverContent;
    }
    
    /**
     * deliverContent을 설정
     * @param deliverContent 을(를) String deliverContent로 설정
     */
    public void setDeliverContent(String deliverContent) {
        this.deliverContent = deliverContent;
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
     * String orgnName을 반환
     * @return String orgnName
     */
    public String getOrgnName() {
        return orgnName;
    }
    
    /**
     * orgnName을 설정
     * @param orgnName 을(를) String orgnName로 설정
     */
    public void setOrgnName(String orgnName) {
        this.orgnName = orgnName;
    }
    
    /**
     * String lgsCateCode을 반환
     * @return String lgsCateCode
     */
    public String getLgsCateCode() {
        return lgsCateCode;
    }
    
    /**
     * lgsCateCode을 설정
     * @param lgsCateCode 을(를) String lgsCateCode로 설정
     */
    public void setLgsCateCode(String lgsCateCode) {
        this.lgsCateCode = lgsCateCode;
    }
    
    /**
     * String lgsCateName을 반환
     * @return String lgsCateName
     */
    public String getLgsCateName() {
        return lgsCateName;
    }
    
    /**
     * lgsCateName을 설정
     * @param lgsCateName 을(를) String lgsCateName로 설정
     */
    public void setLgsCateName(String lgsCateName) {
        this.lgsCateName = lgsCateName;
    }
    
    /**
     * String mdsCateCode을 반환
     * @return String mdsCateCode
     */
    public String getMdsCateCode() {
        return mdsCateCode;
    }
    
    /**
     * mdsCateCode을 설정
     * @param mdsCateCode 을(를) String mdsCateCode로 설정
     */
    public void setMdsCateCode(String mdsCateCode) {
        this.mdsCateCode = mdsCateCode;
    }
    
    /**
     * String mdsCateName을 반환
     * @return String mdsCateName
     */
    public String getMdsCateName() {
        return mdsCateName;
    }
    
    /**
     * mdsCateName을 설정
     * @param mdsCateName 을(를) String mdsCateName로 설정
     */
    public void setMdsCateName(String mdsCateName) {
        this.mdsCateName = mdsCateName;
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
     * String localAddr을 반환
     * @return String localAddr
     */
    public String getLocalAddr() {
        return localAddr;
    }
    
    /**
     * localAddr을 설정
     * @param localAddr 을(를) String localAddr로 설정
     */
    public void setLocalAddr(String localAddr) {
        this.localAddr = localAddr;
    }
    
    /**
     * String supyDeptName을 반환
     * @return String supyDeptName
     */
    public String getSupyDeptName() {
        return supyDeptName;
    }
    
    /**
     * supyDeptName을 설정
     * @param supyDeptName 을(를) String supyDeptName로 설정
     */
    public void setSupyDeptName(String supyDeptName) {
        this.supyDeptName = supyDeptName;
    }
    
    /**
     * String supuDeptNum을 반환
     * @return String supuDeptNum
     */
    public String getSupuDeptNum() {
        return supuDeptNum;
    }
    
    /**
     * supuDeptNum을 설정
     * @param supuDeptNum 을(를) String supuDeptNum로 설정
     */
    public void setSupuDeptNum(String supuDeptNum) {
        this.supuDeptNum = supuDeptNum;
    }
    
    /**
     * String itemUse을 반환
     * @return String itemUse
     */
    public String getItemUse() {
        return itemUse;
    }
    
    /**
     * itemUse을 설정
     * @param itemUse 을(를) String itemUse로 설정
     */
    public void setItemUse(String itemUse) {
        this.itemUse = itemUse;
    }
    
    /**
     * String iitemDelete을 반환
     * @return String iitemDelete
     */
    public String getItemDelete() {
        return itemDelete;
    }
    
    /**
     * iitemDelete을 설정
     * @param iitemDelete 을(를) String iitemDelete로 설정
     */
    public void setItemDelete(String iitemDelete) {
        this.itemDelete = iitemDelete;
    }
    
    /**
     * String itemDealstop을 반환
     * @return String itemDealstop
     */
    public String getItemDealstop() {
        return itemDealstop;
    }
    
    /**
     * itemDealstop을 설정
     * @param itemDealstop 을(를) String itemDealstop로 설정
     */
    public void setItemDealstop(String itemDealstop) {
        this.itemDealstop = itemDealstop;
    }
    
    /**
     * String itemOrderBlock을 반환
     * @return String itemOrderBlock
     */
    public String getItemOrderBlock() {
        return itemOrderBlock;
    }
    
    /**
     * itemOrderBlock을 설정
     * @param itemOrderBlock 을(를) String itemOrderBlock로 설정
     */
    public void setItemOrderBlock(String itemOrderBlock) {
        this.itemOrderBlock = itemOrderBlock;
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
     * String[] cntrNums을 반환
     *
     * @return String[] cntrNums
     */
    public String[] getCntrNums() {
        return cntrNums;
    }

    /**
     * cntrNums을 설정
     *
     * @param cntrNums 을(를) String[] cntrNums로 설정
     */
    public void setCntrNums(String[] cntrNums) {
        this.cntrNums = cntrNums;
    }
    /**
     * String[] lineNums 을 반환
     *
     * @return String[] lineNums
     */
    public String[] getLineNums() {
        return lineNums;
    }

    /**
     * lineNums을 설정
     *
     * @param lineNums 을(를) String[] lineNums 로 설정
     */
    public void setLineNums(String[] lineNums) {
        this.lineNums = lineNums;
    }
 
    
    /**
     * String[] goodsCodes을 반환
     *
     * @return String[] goodsCodes
     */
    public String[] getGoodsCodes() {
        return goodsCodes;
    }

    /**
     * goodsCodes을 설정
     *
     * @param goodsCodes 을(를) String[] goodsCodes로 설정
     */
    public void setGoodsCodes(String[] goodsCodes) {
        this.goodsCodes = goodsCodes;
    }
     
    
}
