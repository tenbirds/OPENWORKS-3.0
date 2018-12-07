/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.schedule.g2b.goodsInfo;

import java.io.File;
import java.io.FileReader;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;

import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.schedule.Processor;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsPPSVO;

import com.ibm.icu.text.SimpleDateFormat;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 12. 07.    최강식          신규
 *</pre>
 * @see 나라장터 서비스정보 배치
 */
public class GoodsInfoBatchProcessor implements Processor{

    @Autowired
    GoodsManageService goodsManageService;

    @Override
    public void process() {

        try{
           
            InetAddress inet = InetAddress.getLocalHost();
            String svrIP = inet.getHostAddress();
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/
            if(!svrIP.equals("202.30.77.182")){
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

            Calendar cal = Calendar.getInstance();
            String yStr = ""+cal.get(Calendar.YEAR);            // 올해년도 얻기
            String mStr = ""+(cal.get(Calendar.MONTH) + 1);     // 현재 월 얻기 (월은 + 1 해줘야함)
            String saveFolder = GlobalConfig.G2B_XML_BAK + "SHITLI/" + yStr + "/" + mStr;    //backup경로

            //로컬(모든일자파일명)
            //String todayFileNm = "SHITLI";

            //운영(현재일자파일명)
            String todayFileNm = "SHITLI" + sdf.format(cal.getTime());
             
         
            ArrayList<File> xmlFiles = new ArrayList<File>();
            File xmlDir = new File(GlobalConfig.G2B_XML_URL);
            GoodsPPSVO vo;
            if(xmlDir.isDirectory()) {
                File[] allFiles = xmlDir.listFiles();
                if(allFiles.length > 0) {
                    for(File file : allFiles) {
                        if(file.getName().startsWith(todayFileNm) && file.getName().endsWith(".0")) {
                            xmlFiles.add(file);
                            Collections.sort(xmlFiles);
                        }
                    }
                    
                    for(File xmlFile : xmlFiles) {

                        if(xmlFile.isFile()) {
                            // XML Document 객체 생성
                            InputSource is = new InputSource(new FileReader(GlobalConfig.G2B_XML_URL + xmlFile.getName()));
                            Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
                            document.getDocumentElement().normalize();

                            int insertCnt = 0;
                            int updateCnt = 0;
                                                         
                             // LineItem 리스트
                            NodeList lineItemList = document.getElementsByTagName("LineItem");
                            for (int i = 0; i < lineItemList.getLength(); i++) {
                                // LineItem 엘리먼트
                                Element lineItemElmnt = (Element) lineItemList.item(i);
                               
                                // 계약정보 엘리먼트
                                Element contractDetailsElmnt = (Element) lineItemElmnt.getElementsByTagName("Contract.Details").item(0);
                                
                                // 물품정보 엘리먼트
                                Element productDetailsElmnt = (Element) lineItemElmnt.getElementsByTagName("Product.Details").item(0);
                                // 물품정보 아이템 리스트
                                NodeList productItemList = productDetailsElmnt.getElementsByTagName("ProductItem");
                                for(int j = 0; j < productItemList.getLength(); j++){
                                    //vo 초기화
                                    vo = new GoodsPPSVO();
                                    
                                    //통합계약번호
                                    vo.setCntrUnum(contractDetailsElmnt.getElementsByTagName("cc:Contract.UnionNumber.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                    
                                    //계약번호+차수
                                    vo.setCntrNum(contractDetailsElmnt.getElementsByTagName("cc:Contract.Number.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                    
                                    // 물품정보 엘리먼트(j)
                                    Element productItemElmnt = (Element) productItemList.item(j);
                                    // G2B물품분류번호
                                    vo.setItemClassIdentifier(productItemElmnt.getElementsByTagName("cc:Item.Classification.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                    // G2B물품식별번호
                                    vo.setItemIdentifier(productItemElmnt.getElementsByTagName("cc:Item.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                    
                                    //물품일련번호(gtwob_number)
                                    String gtwobNumber = productItemElmnt.getElementsByTagName("cc:Line.Number.Value").item(0).getChildNodes().item(1).getTextContent().trim();
                                    if(Validate.isNotEmpty(gtwobNumber)){
                                        if(Validate.isNumeric(gtwobNumber)){
                                            vo.setLineNum(gtwobNumber);
                                        }
                                    }
                                    
                                    // 세부물품분류번호                           
                                    vo.setItemDetailClsIden(productItemElmnt.getElementsByTagName("Item.Detail.Classification.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //규격명
                                    vo.setItemName(productItemElmnt.getElementsByTagName("cc:Item.Identification.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //단위
                                    vo.setItemUnit(productItemElmnt.getElementsByTagName("Item.Quantity.Unit.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //단가금액정보
                                    vo.setUnitPric(productItemElmnt.getElementsByTagName("cc:UnitPrice.Amount").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //제품대이미지URL
                                    vo.setItemImgurl(productItemElmnt.getElementsByTagName("Item.ImageURL.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //품질관련인증정보
                                    vo.setItemCertf(productItemElmnt.getElementsByTagName("cc:Item.Certification.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                      
                                    // 납품정보 엘리먼트
                                    Element deliveryDetailsElmnt = (Element) productItemElmnt.getElementsByTagName("Delivery.Details").item(0);
                                    //납품일수
                                    vo.setDeliverDay(deliveryDetailsElmnt.getElementsByTagName("cc:Delivery.Days.Value").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //납품기한내용    
                                    vo.setDeliverContent(productItemElmnt.getElementsByTagName("Delivery.Date.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                    
                                    //원산지정보
                                    Element countryOriginDetailsElmnt = (Element) productItemElmnt.getElementsByTagName("CountryOfOrigin.Details").item(0);
                                    //원산지코드
                                    vo.setOrgnCode(countryOriginDetailsElmnt.getElementsByTagName("cc:CountryOfOrigin.Code").item(0).getChildNodes().item(1).getTextContent().trim());                                    
                                    //원산지명
                                    vo.setOrgnName(countryOriginDetailsElmnt.getElementsByTagName("CountryOfOrigin.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                    
                                    //분류정보
                                    Element CategoryDetailsElmnt = (Element) productItemElmnt.getElementsByTagName("Category.Details").item(0);
                                    //대분류코드
                                    vo.setLgsCateCode(CategoryDetailsElmnt.getElementsByTagName("LargeScale.Category.code").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //대분류코드명
                                    vo.setLgsCateName(CategoryDetailsElmnt.getElementsByTagName("LargeScale.Category.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //중분류코드
                                    vo.setMdsCateCode(CategoryDetailsElmnt.getElementsByTagName("MediumScale.Category.code").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //중분류코드명
                                    vo.setMdsCateName(CategoryDetailsElmnt.getElementsByTagName("MediumScale.Category.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                    
                                    //업체추가정보
                                    Element supplierAddDetailsElmnt = (Element) productItemElmnt.getElementsByTagName("Supplier.Addition.Details").item(0);
                                    //제조사명
                                    vo.setManuName(supplierAddDetailsElmnt.getElementsByTagName("Manufacturer.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //소재지
                                    vo.setLocalAddr(supplierAddDetailsElmnt.getElementsByTagName("Supplier.location.Address.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //공급업체담당부서명
                                    vo.setSupyDeptName(supplierAddDetailsElmnt.getElementsByTagName("SuplyEntrps.Department.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //공급업체담당부서전화번호
                                    vo.setSupuDeptNum(supplierAddDetailsElmnt.getElementsByTagName("SuplyEntrps.Telephone.Number.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                    
                                    //상태정보
                                    Element conditionDetailsElmnt = (Element) productItemElmnt.getElementsByTagName("Condition.Details").item(0);
                                    //사용여부
                                    vo.setItemUse(conditionDetailsElmnt.getElementsByTagName("Item.Use.Code").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //삭제여부
                                    vo.setItemDelete(conditionDetailsElmnt.getElementsByTagName("Item.Delete.Code").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //거래정지여부
                                    vo.setItemDealstop(conditionDetailsElmnt.getElementsByTagName("Item.DealStop.code").item(0).getChildNodes().item(1).getTextContent().trim());
                                    //주문차단여부
                                    vo.setItemOrderBlock(conditionDetailsElmnt.getElementsByTagName("Item.OrderBlock.code").item(0).getChildNodes().item(1).getTextContent().trim());
                                    // 중분류 코드  04 (대분류 01: 물품, 31:카테고리서비스 )
                                    if(( Validate.isNotEmpty(vo.getLgsCateCode()) && vo.getLgsCateCode().equals("04") && Validate.isNotEmpty(vo.getCntrNum()) && vo.getMdsCateCode().equals("11") ) ||
                                       ( Validate.isNotEmpty(vo.getLgsCateCode()) && vo.getLgsCateCode().equals("31") && Validate.isNotEmpty(vo.getCntrNum()) && vo.getMdsCateCode().equals("03") ) ) {
                                       if(goodsManageService.g2bGoodsCount(vo) > 0) {
                                           updateCnt = updateCnt + goodsManageService.g2bGoodsUpdate(vo);
                                        } else {
                                           insertCnt = insertCnt + goodsManageService.g2bGoodsInsert(vo);
                                        }
                                   }
                                }
                            }


                            
                          // 소프트웨어스토어 씨앗에서 배치 실행함. 이에 백업 기능 주석처리함
                          /* if((insertCnt + updateCnt) > 0){
                                File targetDir = new File(saveFolder);
                                if(!targetDir.exists()) {   //디렉토리 없으면 생성.
                                    targetDir.mkdirs();
                                }

                                if(FileUtil.move(GlobalConfig.G2B_XML_URL + xmlFile.getName(), saveFolder + "/" + xmlFile.getName(), true)){
                                    File moveFile = new File(saveFolder + "/" + xmlFile.getName());
                                    if(moveFile.isFile()){
                                        FileUtil.delete(GlobalConfig.G2B_XML_URL + xmlFile.getName());
                                    }
                                }
                           }*/
                        }
                    }
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}