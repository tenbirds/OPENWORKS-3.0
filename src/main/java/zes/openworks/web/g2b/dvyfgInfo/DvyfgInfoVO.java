/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.dvyfgInfo;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 2.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)엔키소프트
 *<pre>
 *<< 납품정보(Modification Information) >>
 *   
 *    수정일                       수정자             수정내용
 *--------------  --------  -------------------------------
  *  2016. 11. 29.    guest1       신규
 *</pre>
 * @see
 */
public class DvyfgInfoVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 8066298618131160918L;
    
    /* 납품요구번호 */
    private String deliveryNum; 
    /* 납품요구번호차수 */
    private String deliveryOrder; 
    /* 납품요구번호물품순번 */    
    private String itemNum;
    /*납품요구일자*/
    private String  deliverDate;    
    /* G2B물품분류번호 */
    private String itemClassIdentifier; 
    /* G2B물품식별번호 */
    private String itemIdentifier; 
    /* 품명 */
    private String itemName; 
    /* 품명(영문) */
    private String itemEngName;
    /* 규격 */
    private String itemDesptn; 
    /* 수량 */
    private String itemQuantity; 
    /* 단가 */
    private String unitPrice; 
    /* 단위 */
    private String itemUnit; 
    /* 금액 */
    private String itemAmount; 
    /* 납품기한 */
    private String deliveryDate; 
    /* 납품장소 */
    private String deliveryPlace;    
    /* 작성일자 */
    private String issueDate;
    /* 장바구니연계상품여부 */
    private String shopBasket;
    /* 씨앗회원ID */
    private String cloudStoreUser;
    /* 수요기관LDAP */
    private String publicOrganization;
    /* 판매자사업자번호 */
    private String supplierOrganization;
    
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
     * String deliveryOrder을 반환
     * @return String deliveryOrder
     */
    public String getDeliveryOrder() {
        return deliveryOrder;
    }
    
    /**
     * deliveryOrder을 설정
     * @param deliveryOrder 을(를) String deliveryOrder로 설정
     */
    public void setDeliveryOrder(String deliveryOrder) {
        this.deliveryOrder = deliveryOrder;
    }
    
    /**
     * String itemNum을 반환
     * @return String itemNum
     */
    public String getItemNum() {
        return itemNum;
    }
    
    /**
     * itemNum을 설정
     * @param itemNum 을(를) String itemNum로 설정
     */
    public void setItemNum(String itemNum) {
        this.itemNum = itemNum;
    }
       
    
    /**
     * String deliverDate을 반환
     * @return String deliverDate
     */
    public String getDeliverDate() {
        return deliverDate;
    }

    
    /**
     * deliverDate을 설정
     * @param deliverDate 을(를) String deliverDate로 설정
     */
    public void setDeliverDate(String deliverDate) {
        this.deliverDate = deliverDate;
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
     * String itemEngName을 반환
     * @return String itemEngName
     */
    public String getItemEngName() {
        return itemEngName;
    }
    
    /**
     * itemEngName을 설정
     * @param itemEngName 을(를) String itemEngName로 설정
     */
    public void setItemEngName(String itemEngName) {
        this.itemEngName = itemEngName;
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
     * String itemQuantity을 반환
     * @return String itemQuantity
     */
    public String getItemQuantity() {
        return itemQuantity;
    }
    
    /**
     * itemQuantity을 설정
     * @param itemQuantity 을(를) String itemQuantity로 설정
     */
    public void setItemQuantity(String itemQuantity) {
        this.itemQuantity = itemQuantity;
    }
    
    /**
     * String unitPrice을 반환
     * @return String unitPrice
     */
    public String getUnitPrice() {
        return unitPrice;
    }
    
    /**
     * unitPrice을 설정
     * @param unitPrice 을(를) String unitPrice로 설정
     */
    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
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
     * String itemAmount을 반환
     * @return String itemAmount
     */
    public String getItemAmount() {
        return itemAmount;
    }
    
    /**
     * itemAmount을 설정
     * @param itemAmount 을(를) String itemAmount로 설정
     */
    public void setItemAmount(String itemAmount) {
        this.itemAmount = itemAmount;
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
     * String issueDate을 반환
     * @return String issueDate
     */
    public String getIssueDate() {
        return issueDate;
    }
    
    /**
     * issueDate을 설정
     * @param issueDate 을(를) String issueDate로 설정
     */
    public void setIssueDate(String issueDate) {
        this.issueDate = issueDate;
    }

    /**
     * String shopBasket을 반환
     * @return String shopBasket
     */
    public String getShopBasket() {
        return shopBasket;
    }

    /**
     * shopBasket을 설정
     * @param shopBasket 을(를) String shopBasket로 설정
     */
    public void setShopBasket(String shopBasket) {
        this.shopBasket = shopBasket;
    }

    
    /**
     * String cloudStoreUser을 반환
     * @return String cloudStoreUser
     */
    public String getCloudStoreUser() {
        return cloudStoreUser;
    }

    
    /**
     * cloudStoreUser을 설정
     * @param cloudStoreUser 을(를) String cloudStoreUser로 설정
     */
    public void setCloudStoreUser(String cloudStoreUser) {
        this.cloudStoreUser = cloudStoreUser;
    }

    
    /**
     * String publicOrganization을 반환
     * @return String publicOrganization
     */
    public String getPublicOrganization() {
        return publicOrganization;
    }

    
    /**
     * publicOrganization을 설정
     * @param publicOrganization 을(를) String publicOrganization로 설정
     */
    public void setPublicOrganization(String publicOrganization) {
        this.publicOrganization = publicOrganization;
    }

    
    /**
     * String supplierOrganization을 반환
     * @return String supplierOrganization
     */
    public String getSupplierOrganization() {
        return supplierOrganization;
    }

    
    /**
     * supplierOrganization을 설정
     * @param supplierOrganization 을(를) String supplierOrganization로 설정
     */
    public void setSupplierOrganization(String supplierOrganization) {
        this.supplierOrganization = supplierOrganization;
    }
   
}
