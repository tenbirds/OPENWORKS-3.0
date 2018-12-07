/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.schedule.g2b.cntrctInfo;

import java.io.File;
//
import java.io.FileReader;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.LinkedHashSet;

import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.schedule.Processor;
import zes.openworks.web.g2b.cntrctInfo.CntrctInfoService;
import zes.openworks.web.g2b.cntrctInfo.CntrctInfoVO;
import zes.openworks.web.g2b.cntrctInfo.CntrctItemVO;

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
 * @see 나라장터 계약정보 배치
 */
public class CntrctInfoBatchProcessor implements Processor{
    @Autowired
    CntrctInfoService cntrctInfoService;

    @Override
    public void process() {

        try{
            InetAddress inet = InetAddress.getLocalHost();
            String svrIP = inet.getHostAddress();
            Calendar cal = Calendar.getInstance();

            //개발용
/*
            String yStr = ""+cal.get(Calendar.YEAR);            // 올해년도 얻기
            String mStr = ""+(cal.get(Calendar.MONTH) + 1);     // 현재 월 얻기 (월은 + 1 해줘야함)
            String saveFolder = GlobalConfig.G2B_XML_BAK + "CRNTLI/" + yStr + "/" + mStr;    //backup경로
            String todayFileNm = "CRNTLI";
*/

            //운영용
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/

            if(!svrIP.equals("202.30.77.182")){
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String todayFileNm = "CRNTLI" + sdf.format(cal.getTime());


            ArrayList<File> xmlFiles = new ArrayList<File>();
            File xmlDir = new File(GlobalConfig.G2B_XML_URL);
            CntrctInfoVO vo;
            CntrctItemVO itemVo;
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
                            NodeList lineItemList= document.getElementsByTagName("gb:LineItem");
                            for(int i = 0; i < lineItemList.getLength(); i++){
                                //vo초기화
                                vo = new CntrctInfoVO();

                                //헤더정보
                                vo.setSenderId(document.getElementsByTagName("cc:Message.Sender.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setMessType(document.getElementsByTagName("cc:Message.Type.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setMessNm(document.getElementsByTagName("cc:Message.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setDocuMangNo(document.getElementsByTagName("cc:Document.ManagementNumber.Text").item(0).getChildNodes().item(1).getTextContent().trim());

                                // LineItem 엘리먼트
                                Element lineItemElmnt = (Element) lineItemList.item(i);
                                // ContractDetails 엘리먼트 리스트
                                Element contractDetailsElmnt = (Element) lineItemElmnt.getElementsByTagName("gb:Contract.Details").item(0);

                                vo.setCntrctUnionNo(contractDetailsElmnt.getElementsByTagName("cc:Contract.UnionNumber.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setCntrctNo(contractDetailsElmnt.getElementsByTagName("cc:Contract.Number.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setCntrctNm(contractDetailsElmnt.getElementsByTagName("cc:Contract.Name.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setCntrctType(contractDetailsElmnt.getElementsByTagName("cc:Contract.Classification.Code").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setCntrctMth(contractDetailsElmnt.getElementsByTagName("cc:Contract.Means.Code").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setCntrctDate(contractDetailsElmnt.getElementsByTagName("cc:Contract.Date").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setCntrctPd(contractDetailsElmnt.getElementsByTagName("cc:Contract.Period.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                /*총계약금액*/
                                String cntrctAmt = contractDetailsElmnt.getElementsByTagName("cc:Contract.Amount").item(0).getChildNodes().item(1).getTextContent().trim();
                                if(Validate.isNotEmpty(cntrctAmt)){
                                    if(Validate.isNumeric(cntrctAmt)){
                                        vo.setCntrctAmt(cntrctAmt);
                                    }
                                }
                                /*금차계약금액*/
                                String cntrctThisTimeAmt = contractDetailsElmnt.getElementsByTagName("cc:Contract.ThisTime.Amount").item(0).getChildNodes().item(1).getTextContent().trim();
                                if(Validate.isNotEmpty(cntrctThisTimeAmt)){
                                    if(Validate.isNumeric(cntrctThisTimeAmt)){
                                        vo.setCntrctThisTimeAmt(cntrctThisTimeAmt);
                                    }
                                }

                                vo.setBidNotifyNo(contractDetailsElmnt.getElementsByTagName("cc:Notify.Information.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setOrderOrgnNm(contractDetailsElmnt.getElementsByTagName("cc:AgentOrganization.Name").item(0).getChildNodes().item(1).getTextContent().trim());

                                // ProcuringOrganizationDetails 엘리먼트  : 수요기관
                                Element procuringOrganizationDetailsElmnt = (Element) contractDetailsElmnt.getElementsByTagName("gb:ProcuringOrganization.Details").item(0);
                                // OrgItem 엘리먼트 리스트
                                NodeList proOrgItemList = procuringOrganizationDetailsElmnt.getElementsByTagName("gb:OrgItem");
                                LinkedHashSet<String> strRealOrgnNm = new LinkedHashSet<String>();
                                for(int j = 0; j < proOrgItemList.getLength(); j++){
                                    // OrgItem 엘리먼트
                                    Element orgItemElmnt = (Element) proOrgItemList.item(j);
                                    // organizationDetails 엘리먼트 : 수요기관상세정보
                                    if(orgItemElmnt.getElementsByTagName("gb:Organization.Details").getLength() > 0){
                                        Element organizationDetailsElmnt = (Element) orgItemElmnt.getElementsByTagName("gb:Organization.Details").item(0);
                                        if(organizationDetailsElmnt.getElementsByTagName("cc:Organization.Classification.Code").item(0).getChildNodes().item(1).getTextContent().trim().equals("02")) {
                                            vo.setRealOrgnCode(organizationDetailsElmnt.getElementsByTagName("cc:Organization.Classification.Code").item(0).getChildNodes().item(1).getTextContent().trim());
                                            strRealOrgnNm.add(organizationDetailsElmnt.getElementsByTagName("cc:Organization.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                        }
                                    }
                                }
                                vo.setRealOrgnNm(strRealOrgnNm.toString().substring(1, strRealOrgnNm.toString().length()-1));

                                // SupplierOrganizationDetails 엘리먼트  : 계약업체
                                Element supplierOrganizationDetailsElmnt = (Element) contractDetailsElmnt.getElementsByTagName("gb:SupplierOrganization.Details").item(0);
                                // OrgItem 엘리먼트 리스트
                                NodeList supOrgItemList = supplierOrganizationDetailsElmnt.getElementsByTagName("gb:OrgItem");
                                for(int j = 0; j < supOrgItemList.getLength(); j++){
                                    // OrgItem 엘리먼트
                                    Element orgItemElmnt = (Element) supOrgItemList.item(j);
                                    // organizationDetails 엘리먼트 : 수요기관상세정보
                                    if(orgItemElmnt.getElementsByTagName("gb:Organization.Details").getLength() > 0){
                                        Element organizationDetailsElmnt = (Element) orgItemElmnt.getElementsByTagName("gb:Organization.Details").item(0);
                                        if(organizationDetailsElmnt.getElementsByTagName("cc:Organization.Classification.Code").item(0).getChildNodes().item(1).getTextContent().trim().equals("00")) {
                                            vo.setMainCntrctEntrpsType(organizationDetailsElmnt.getElementsByTagName("cc:Organization.Classification.Code").item(0).getChildNodes().item(1).getTextContent().trim());
                                            vo.setMainCntrctEntrpsNm(organizationDetailsElmnt.getElementsByTagName("cc:Organization.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                        }
                                    }
                                }

                                //물품정보에 통합계약번호가 존재할경우 해당 물품 일괄삭제
                                if(cntrctInfoService.cntrctItemCheck(vo) > 0) {
                                    cntrctInfoService.cntrctItemDelete(vo);
                                }
                                // Product.Details 엘리먼트  : 물품정보
                                Element productDetailsElmnt = (Element) contractDetailsElmnt.getElementsByTagName("gb:Product.Details").item(0);
                                // ProductItem 엘리먼트 리스트
                                NodeList productItemList = productDetailsElmnt.getElementsByTagName("gb:ProductItem");
                                for(int j = 0; j < productItemList.getLength(); j++){
                                    //itemVo 초기화
                                    itemVo = new CntrctItemVO();

                                    itemVo.setCntrctUnionNo(vo.getCntrctUnionNo());

                                    // ProductItem 엘리먼트
                                    Element productItemElmnt = (Element) productItemList.item(j);

                                    // quantityDetails 엘리먼트 : 수량정보
                                    Element quantityDetailsElmnt = (Element) productItemElmnt.getElementsByTagName("gb:Quantity.Details").item(0);

                                    itemVo.setCntrctUnionSeq(j+1);
                                    itemVo.setItemClNo(productItemElmnt.getElementsByTagName("cc:Item.Classification.Identifier").item(0).getTextContent().trim());
                                    itemVo.setItemIdntfcNo(productItemElmnt.getElementsByTagName("cc:Item.Identifier").item(0).getTextContent().trim());
                                    itemVo.setCntrctItemNm(productItemElmnt.getElementsByTagName("cc:Item.Classification.Name").item(0).getChildNodes().item(1).getTextContent().trim());
                                    String cntrctItemAmt = productItemElmnt.getElementsByTagName("cc:Item.Amount").item(0).getChildNodes().item(1).getTextContent().trim();
                                    if(Validate.isNotEmpty(cntrctItemAmt)){
                                        if(Validate.isNumeric(cntrctItemAmt)){
                                            itemVo.setCntrctItemAmt(cntrctItemAmt);
                                        }
                                    }
                                    String cntrctItemUntpc = quantityDetailsElmnt.getElementsByTagName("cc:UnitPrice.Amount").item(0).getChildNodes().item(1).getTextContent().trim();
                                    if(Validate.isNotEmpty(cntrctItemUntpc)){
                                        if(Validate.isNumeric(cntrctItemUntpc)){
                                            itemVo.setCntrctItemUntpc(cntrctItemUntpc);
                                        }
                                    }
                                    itemVo.setCntrctItemQy(quantityDetailsElmnt.getElementsByTagName("cc:Item.Quantity").item(0).getChildNodes().item(1).getTextContent().trim());

                                    cntrctInfoService.cntrctItemInsertAction(itemVo);
                                }

                                if(cntrctInfoService.cntrctInfoCheck(vo) > 0) {
                                    updateCnt = updateCnt + cntrctInfoService.cntrctInfoUpdateAction(vo);
                                } else {
                                    insertCnt = insertCnt + cntrctInfoService.cntrctInfoInsertAction(vo);
                                }

                            }

                            
                            /* 클라우드는 배치 실행 후 파일을 이동시키지 않음(로컬테스트 및 로컬에서 운영반영시에 사용) */
/*
                            if((insertCnt + updateCnt) > 0){
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
                            }
*/
                        }
                    }
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
