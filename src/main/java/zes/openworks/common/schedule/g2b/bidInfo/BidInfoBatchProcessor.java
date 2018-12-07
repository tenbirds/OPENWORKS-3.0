/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.schedule.g2b.bidInfo;

import java.io.File;
import java.io.FileReader;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
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
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.schedule.Processor;
import zes.openworks.web.g2b.bidInfo.BidInfoService;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;

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
 * @see 나라장터 입찰정보 배치
 */
public class BidInfoBatchProcessor implements Processor{
    @Autowired
    BidInfoService bidInfoService;

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
            String saveFolder = GlobalConfig.G2B_XML_BAK + "INTDLI/" + yStr + "/" + mStr;    //backup경로
            String todayFileNm = "INTDLI";
*/

            //운영용
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/

            if(!svrIP.equals("202.30.77.182")){
                return;
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String todayFileNm = "INTDLI" + sdf.format(cal.getTime());


            ArrayList<File> xmlFiles = new ArrayList<File>();
            File xmlDir = new File(GlobalConfig.G2B_XML_URL);
            BidInfoVO vo;
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
                            
                            // LineItem 엘리먼트 리스트
                            NodeList lineItem = document.getElementsByTagName("gb:LineItem");
                            for(int i = 0; i < lineItem.getLength(); i++){
                                //vo초기화
                                vo = new BidInfoVO();
                                
                                //문서 헤더정보 셋팅
                                vo.setSenderId(document.getElementsByTagName("cc:Message.Sender.Identifier").item(0).getChildNodes().item(1).getTextContent());
                                vo.setMessType(document.getElementsByTagName("cc:Message.Type.Identifier").item(0).getChildNodes().item(1).getTextContent());
                                vo.setMessNm(document.getElementsByTagName("cc:Message.Name").item(0).getChildNodes().item(1).getTextContent());
                                vo.setDocuMangNo(document.getElementsByTagName("cc:Document.ManagementNumber.Text").item(0).getChildNodes().item(1).getTextContent());
                                
                                // LineItem 엘리먼트
                                Element lineItemElmnt = (Element) lineItem.item(i);
                                // Bidding.Details 엘리먼트 리스트
                                Element biddingDetailsElmnt = (Element) lineItemElmnt.getElementsByTagName("gb:Bidding.Details").item(0);
                                // DemandOrganization.Details 엘리먼트 리스트 : 발주정보
                                Element demandOrganizationDetailsElmnt = (Element) biddingDetailsElmnt.getElementsByTagName("gb:DemandOrganization.Details").item(0);
                                // RealOrganization.Details 엘리먼트 리스트 : 실공공기관(수요기관)정보
                                Element realOrganizationDetailsElmnt = (Element) biddingDetailsElmnt.getElementsByTagName("gb:RealOrganization.Details").item(0);
                                // NoticeBid.Details 엘리먼트 리스트 : 계약방법
                                Element noticeBidDetailsElmnt = (Element) lineItemElmnt.getElementsByTagName("gb:NoticeBid.Details").item(0);

                                vo.setBidUnionNo(biddingDetailsElmnt.getElementsByTagName("cc:Bidding.UnionNumber.Text").item(0).getChildNodes().item(1).getTextContent());
                                vo.setBidNotifyNo(biddingDetailsElmnt.getElementsByTagName("cc:Bidding.NotifyNumber.Text").item(0).getChildNodes().item(1).getTextContent());
                                vo.setBidNotifySeqNo(biddingDetailsElmnt.getElementsByTagName("cc:Bidding.NotifySequenceNumber.Text").item(0).getChildNodes().item(1).getTextContent());
                                vo.setBidNm(biddingDetailsElmnt.getElementsByTagName("cc:Bidding.Name").item(0).getChildNodes().item(1).getTextContent());
                                String pblancStartDate = biddingDetailsElmnt.getElementsByTagName("cc:Notify.DateTime").item(0).getChildNodes().item(1).getTextContent();
                                if(Validate.isNotEmpty(pblancStartDate) && pblancStartDate.length() == 12) {
                                    vo.setPblancStartDate(pblancStartDate + "00");
                                }
                                vo.setOrderOrgnNm(demandOrganizationDetailsElmnt.getElementsByTagName("cc:Organization.Name").item(0).getChildNodes().item(1).getTextContent());
                                vo.setRealOrgnNm(realOrganizationDetailsElmnt.getElementsByTagName("cc:Organization.Name").item(0).getChildNodes().item(1).getTextContent());
                                vo.setCntrctMth(noticeBidDetailsElmnt.getElementsByTagName("cc:Contract.Means.Code").item(0).getChildNodes().item(1).getTextContent());
                                vo.setBidMthd(biddingDetailsElmnt.getElementsByTagName("cc:Bidding.Means.Code").item(0).getChildNodes().item(1).getTextContent());
                                vo.setScsbidMth(biddingDetailsElmnt.getElementsByTagName("cc:SuccessfulBidding.Means.Text").item(0).getChildNodes().item(1).getTextContent());
                                vo.setBidType(biddingDetailsElmnt.getElementsByTagName("cc:Bidding.Type.Code").item(0).getChildNodes().item(1).getTextContent());
                                String bidStrtDate = biddingDetailsElmnt.getElementsByTagName("cc:Bidding.Start.DateTime").item(0).getChildNodes().item(1).getTextContent();
                                if(Validate.isNotEmpty(bidStrtDate) && bidStrtDate.length() == 12) {
                                    vo.setBidStrtDate(bidStrtDate + "00");
                                }
                                String bidEndDate = biddingDetailsElmnt.getElementsByTagName("cc:Bidding.End.DateTime").item(0).getChildNodes().item(1).getTextContent();
                                if(Validate.isNotEmpty(bidEndDate) && bidEndDate.length() == 12) {
                                    vo.setBidEndDate(bidEndDate + "00");
                                }
                                vo.setPrsmpAmt(biddingDetailsElmnt.getElementsByTagName("cc:Estimated.Amount").item(0).getChildNodes().item(1).getTextContent());
                                
                                if(bidInfoService.bidInfoCheck(vo) > 0) {
                                    updateCnt = updateCnt + bidInfoService.bidInfoUpdateAction(vo);
                                } else {
                                    insertCnt = insertCnt + bidInfoService.bidInfoInsertAction(vo);
                                }
                            }
                            
                            /* 클라우드서비스는 배치실행 후 파일을 이동시키지 않음(로컬테스트 및 로컬에서 운영반영시에 사용) */
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
