package zes.openworks.common.schedule.g2b.dvyfgInfo;

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

import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.schedule.Processor;
import zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoService;
import zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoVO;

/**
 *
 *
 * @version 2.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 11. 29.    guest1          신규
 *</pre>
 * @see 나라장터 납품정보 배치
 */
public class DvyfgInfoBatchProcessor implements Processor{
  
    @Autowired
    DvyfgInfoService dvyfgInfoService;

    @Override
    public void process() {

        try{
            
            InetAddress inet = InetAddress.getLocalHost();
            String svrIP = inet.getHostAddress();
            Calendar cal = Calendar.getInstance();
            //개발용

            String yStr = ""+cal.get(Calendar.YEAR);            // 올해년도 얻기
            String mStr = ""+(cal.get(Calendar.MONTH) + 1);     // 현재 월 얻기 (월은 + 1 해줘야함)
            String saveFolder = GlobalConfig.G2B_XML_BAK + "DEIFLA/" + yStr + "/" + mStr;    //backup경로
           
            //운영용
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/

            if(!svrIP.equals("202.30.77.182")){
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String todayFileNm = "DEIFLA" + sdf.format(cal.getTime()); //DEIFNT

            ArrayList<File> xmlFiles = new ArrayList<File>();
            File xmlDir = new File(GlobalConfig.G2B_XML_URL);
            DvyfgInfoVO vo;
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
                            
                            NodeList lineItemList= document.getElementsByTagName("gb:LineItem");
                            for(int i = 0; i < lineItemList.getLength(); i++){
                                // vo 초기화
                                vo = new DvyfgInfoVO();
                                
                                // LineItem 엘리먼트
                                Element lineItemElmnt = (Element) lineItemList.item(i);
                                String deliveryNum = lineItemElmnt.getElementsByTagName("cc:Delivery.RequestNumber.Text").item(0).getChildNodes().item(1).getTextContent().trim();
                                vo.setDeliveryNum(deliveryNum.substring(0,10)); // 납품요구번호
                                vo.setDeliveryOrder(deliveryNum.substring(10,12)); // 납품요구번호차수                             
                                vo.setItemNum(lineItemElmnt.getElementsByTagName("Item.Number.Value").item(0).getChildNodes().item(1).getTextContent().trim());  //납품요구번호물품순번
                                vo.setDeliverDate(lineItemElmnt.getElementsByTagName("cc:Delivery.Request.Date").item(0).getChildNodes().item(1).getTextContent().trim());  //납품요구일자
                                vo.setItemClassIdentifier(lineItemElmnt.getElementsByTagName("cc:Item.Classification.Identifier").item(0).getChildNodes().item(1).getTextContent().trim()); //G2B물품분류번호
                                vo.setItemIdentifier(lineItemElmnt.getElementsByTagName("cc:Item.Identifier").item(0).getChildNodes().item(1).getTextContent().trim()); //G2B물품식별번호
                                vo.setItemName(lineItemElmnt.getElementsByTagName("cc:Item.Name").item(0).getChildNodes().item(1).getTextContent().trim()); //품명
                                vo.setItemEngName(lineItemElmnt.getElementsByTagName("cc:Item.English.Name").item(0).getChildNodes().item(1).getTextContent().trim()); //품명(영문)                          
                                vo.setItemDesptn(lineItemElmnt.getElementsByTagName("cc:Item.Description.Text").item(0).getChildNodes().item(1).getTextContent().trim()); //규격
                                vo.setItemQuantity(lineItemElmnt.getElementsByTagName("cc:Item.Quantity").item(0).getChildNodes().item(1).getTextContent().trim()); //수량
                                vo.setUnitPrice(lineItemElmnt.getElementsByTagName("cc:UnitPrice.Amount").item(0).getChildNodes().item(1).getTextContent().trim()); //단가
                                vo.setItemUnit(lineItemElmnt.getElementsByTagName("Item.Unit.Text").item(0).getChildNodes().item(1).getTextContent().trim());  //단위
                                vo.setItemAmount(lineItemElmnt.getElementsByTagName("cc:Item.Amount").item(0).getChildNodes().item(1).getTextContent().trim());    //금액
                                vo.setDeliveryDate(lineItemElmnt.getElementsByTagName("cc:Delivery.Date").item(0).getChildNodes().item(1).getTextContent().trim());
                                vo.setDeliveryPlace(lineItemElmnt.getElementsByTagName("cc:Delivery.Place.Text").item(0).getChildNodes().item(1).getTextContent().trim());
                                
                                if(lineItemElmnt.getElementsByTagName("ShopBasket.Connect.Indicator").getLength() > 0)
                                   vo.setShopBasket(lineItemElmnt.getElementsByTagName("ShopBasket.Connect.Indicator").item(0).getChildNodes().item(1).getTextContent().trim());
                                if(lineItemElmnt.getElementsByTagName("CloudStore.user.Identifier").getLength() > 0)
                                   vo.setCloudStoreUser(lineItemElmnt.getElementsByTagName("CloudStore.user.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                if(lineItemElmnt.getElementsByTagName("PublicOrganization.Identifier").getLength() > 0)
                                   vo.setPublicOrganization(lineItemElmnt.getElementsByTagName("PublicOrganization.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                                if(lineItemElmnt.getElementsByTagName("SupplierOrganization.Identifier").getLength() > 0)
                                   vo.setSupplierOrganization(lineItemElmnt.getElementsByTagName("SupplierOrganization.Identifier").item(0).getChildNodes().item(1).getTextContent().trim());
                               
                                
                                if(dvyfgInfoService.dvyfgInfoCheck(vo) > 0 ){
                                    updateCnt = updateCnt + dvyfgInfoService.dvyfgInfoUpdateAction(vo);
                                }else{
                                    insertCnt = insertCnt + dvyfgInfoService.dvyfgInfoInsertAction(vo);
                                }
                             
                            }     
                            
//                            if((insertCnt + updateCnt) > 0){
//                                File targetDir = new File(saveFolder);
//                                if(!targetDir.exists()) {   //디렉토리 없으면 생성.
//                                    targetDir.mkdirs();
//                                }
//
//                                if(FileUtil.move(GlobalConfig.G2B_XML_URL + xmlFile.getName(), saveFolder + "/" + xmlFile.getName(), true)){
//                                    File moveFile = new File(saveFolder + "/" + xmlFile.getName());
//                                    if(moveFile.isFile()){
//                                        FileUtil.delete(GlobalConfig.G2B_XML_URL + xmlFile.getName());
//                                    }
//                                }
//                            }
                        }
                    }    
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
