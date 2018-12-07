package zes.openworks.intra.orderManage.cntrctManage;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.LinkedHashSet;

import java.io.FileReader;
import java.io.IOException;
import java.net.InetAddress;

import javax.xml.parsers.DocumentBuilderFactory;

import javax.annotation.Resource;
import zes.openworks.common.GlobalConfig;

import org.springframework.stereotype.Repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctGoodsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;

import zes.openworks.web.g2b.cntrctInfo.CntrctInfoVO;
import zes.openworks.web.g2b.cntrctInfo.CntrctItemVO;
import zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoService;
import zes.openworks.web.g2b.dvyfgInfo.DvyfgInfoVO;
import zes.openworks.web.g2b.cntrctInfo.CntrctInfoService;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 * 수정일          수정자    수정내용
 *--------------  --------  -------------------------------
 * 2016. 02. 15.   엔키      신규
 *</pre>
 * @see
 */
@Repository
@SuppressWarnings("unchecked")
public class CntrctManageDAO extends EgovAbstractMapper{

    @Resource
    private FileDAO fileDao;

    @Autowired
    CntrctInfoService cntrctInfoService;
    
    @Autowired
    DvyfgInfoService dvyfgInfoService;
    
    /**
     * cntrctManageList (계약관리 목록)
     * @param vo
     * @return
     */
    public Pager<CntrctManageVO> cntrctManageList(CntrctManageVO vo) {

        
        vo.setTotalNum((Integer) selectByPk("_cntrctManage.cntrctManageCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        
        List<CntrctManageVO> dataList = list("_cntrctManage.cntrctManageList", vo.getDataMap());
        
        for(CntrctManageVO dataVo : dataList){
            // 계약서 파일 정보
            if (Validate.isNotEmpty(dataVo.getCtrtcSn())) {
                dataVo.setCtrtcFile(fileDao.getFiles1(dataVo.getCtrtcSn()));
            }
        }
//        vo.setTotalNum((Integer) selectByPk("_cntrctManage.cntrctManageCount", vo.getDataMap()));;
        return new Pager<CntrctManageVO>(dataList, vo);
    }

    @SuppressWarnings("unchecked")
    public CntrctManageVO cntrctManageDetail(CntrctManageVO vo){
        String strCntrctSn = vo.getStrCntrctSn();

        CntrctManageVO gvo = new CntrctManageVO ();
        
        gvo = (CntrctManageVO)selectByPk("_cntrctManage.cntrctManageDetail", strCntrctSn);
        gvo.setCtrtcSnList(fileDao.getFiles(gvo.getCtrtcSn()));
        
        return gvo;
    }
    
    public List<SuplerCntrctGoodsVO> cntrctManageDetailList(CntrctManageVO vo) {
        return list("_cntrctManage.cntrctManageDetailList", vo);
    }
    
    /**
     * 조달청 나라장터 연계정보 - 계약실적목록
     * naraTotalCntrctInfoList 설명
     * @param vo
     * @return
     */
    public Pager<CntrctManageVO> naraTotalCntrctInfoList(CntrctManageVO vo) {

        
        vo.setTotalNum((Integer) selectByPk("_cntrctManage.naraTotalCntrctInfoCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        
        List<CntrctManageVO> dataList = list("_cntrctManage.naraTotalCntrctInfoList", vo.getDataMap());
        
        return new Pager<CntrctManageVO>(dataList, vo);
    }

    /**
     * cntrctManageView (계약관리 상세)
     * @param vo
     * @return
     */
    public CntrctManageVO cntrctManageView(CntrctManageVO vo) {
        CntrctManageVO dataVo = (CntrctManageVO) selectByPk("_cntrctManage.cntrctManageView",vo);
        // 계약서 파일 정보
        if (Validate.isNotEmpty(dataVo.getCtrtcSn())) {
            dataVo.setCtrtcFile(fileDao.getFiles(dataVo.getCtrtcSn()));
        }
        return dataVo;
    }

    /**
     * cntrctManageInsertAction (계약관리 등록)
     * @param vo
     * @return
     */
    public int cntrctManageInsertAction(CntrctManageVO vo) {

        // 첨부파일
        if(vo.getCtrtcFile().size() > 0) {
            vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcFile(), vo.getCtrtcSn()));
        }
        return insert("_cntrctManage.cntrctManageInsertAction", vo) ;
    }

    /**
     * cntrctManageUpdateAction (계약관리 수정)
     * @param vo
     * @return
     */
    public int cntrctManageUpdateAction(CntrctManageVO vo) {
        // 첨부파일
        if(vo.getCtrtcFile().size() > 0) {
            vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcFile(), vo.getCtrtcSn()));
        }
        return insert("_cntrctManage.cntrctManageUpdateAction", vo) ;
    }

    /**
     * cntrctManageDeleteAction (계약관리 삭제)
     * @param vo
     * @return
     */
    public int cntrctManageDeleteAction(CntrctManageVO vo) {
        int affected = 0;
        if(Validate.isNotEmpty(vo.getCntrctSns())){

            for(String cntrctSns : vo.getCntrctSns()) {
                CntrctManageVO cntrctVo  = new CntrctManageVO();
                cntrctVo.setCntrctSn(Integer.valueOf(cntrctSns));
                affected += update("_cntrctManage.cntrctManageDeleteAction", cntrctVo);

            }
        }

        return affected;
    }

    public int cntrctManageUpdateUseAction(CntrctManageVO vo) {
        
        return update("_cntrctManage.cntrctManageUpateUseAction", vo) ;
    }
    
    public int naraInfoInterface(CntrctManageVO basevo) {

        int inUpdateCnt = 0;
        
        try{

            Calendar cal = Calendar.getInstance();

            String naraDate = basevo.getNaraDate();
            
            naraDate = naraDate.replace("-", "");

            //운영용
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/

            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
            String todayFileNm = "";
            
            if("".equals(naraDate) || (naraDate.trim()).length() < 1){
                //todayFileNm = "CRNTLI" + sdf.format(cal.getTime());
                todayFileNm = "CRNTLI" + sdf1.format(cal.getTime());
            } else {
                todayFileNm = "CRNTLI" + naraDate;
            }

            ArrayList<File> xmlFiles = new ArrayList<File>();
            //File xmlDir = new File(GlobalConfig.G2B_XML_LOCAL); //D:/ceart 에 XML파일 넣고 테스트
            //File xmlDir2 = new File(GlobalConfig.G2B_XML_LOCAL2); //D:/ceart 에 XML파일 넣고 테스트
            File xmlDir = new File(GlobalConfig.G2B_XML_AFTER); //운영서버 반영시 실제 경로로 넣기
            File xmlDir2 = new File(GlobalConfig.G2B_XML_REALAPPLY); //운영서버 반영시 실제 경로로 넣기            
            
            if(xmlDir2.isDirectory()) {
                File[] allFiles1 = xmlDir2.listFiles();
                
                if(allFiles1.length > 0) {
                    for(File file1 : allFiles1) {
                        if(file1.getName().startsWith("CRNTLI") && file1.getName().endsWith(".0")) {
                            file1.delete();
                        }
                    }
                }
                
                File[] allFiles2 = xmlDir.listFiles();                
                if(allFiles2.length > 0) {
                    for(File file2 : allFiles2) {
                        if(file2.getName().startsWith(todayFileNm) && file2.getName().endsWith(".0")) {

                            File destFile = new File(GlobalConfig.G2B_XML_REALAPPLY,file2.getName());  //개발시
                            //File destFile = new File(GlobalConfig.G2B_XML_REALAPPLY,file2.getName());  //운영에 적용시
                            
                          copyFile(file2,destFile);//copyFile메소드 실행
                        }
                    }
                }
            }
            
            int y= 0;
            CntrctInfoVO vo;
            CntrctItemVO itemVo;
            if(xmlDir2.isDirectory()) {
                File[] allFiles = xmlDir2.listFiles();
                
                if(allFiles.length > 0) {
                    for(File file : allFiles) {
                        if(file.getName().startsWith(todayFileNm) && file.getName().endsWith("0")) {
                            xmlFiles.add(file);
                            Collections.sort(xmlFiles);
                        }
                    }

                    for(File xmlFile : xmlFiles) {

                        if(xmlFile.isFile()) {
                            // XML Document 객체 생성
                            InputSource is = new InputSource(new FileReader(GlobalConfig.G2B_XML_REALAPPLY + xmlFile.getName())); //개발시
                            //InputSource is = new InputSource(new FileReader(GlobalConfig.G2B_XML_REALAPPLY + xmlFile.getName())); //운영에 적용시                     
                            
                            //is.setEncoding("UTF-8");
                            
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
                                
                                //String strCntrctNm = contractDetailsElmnt.getElementsByTagName("cc:Contract.Name.Text").item(0).getChildNodes().item(1).getTextContent().trim();
                                //strCntrctNm = new String(strCntrctNm.getBytes("8859_1"),"utf-8");
                                //vo.setCntrctNm(strCntrctNm);
                                
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
                                vo.setOrderOrgnNm( contractDetailsElmnt.getElementsByTagName("cc:AgentOrganization.Name").item(0).getChildNodes().item(1).getTextContent().trim() );

                                //String strOrderOrgnNm = document.getElementsByTagName("cc:Document.ManagementNumber.Text").item(0).getChildNodes().item(1).getTextContent().trim();
                                //strOrderOrgnNm = new String(strOrderOrgnNm.getBytes("8859_1"),"utf-8");
                                //vo.setOrderOrgnNm(strOrderOrgnNm);
                                
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
                                    
                                    //String strCntrctItemNm = productItemElmnt.getElementsByTagName("cc:Item.Classification.Name").item(0).getChildNodes().item(1).getTextContent().trim();
                                    //strCntrctItemNm = new String(strCntrctItemNm.getBytes("8859_1"),"utf-8");
                                    //itemVo.setCntrctItemNm(strCntrctItemNm);
                                    
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
                                    inUpdateCnt = updateCnt;
                                } else {
                                    insertCnt = insertCnt + cntrctInfoService.cntrctInfoInsertAction(vo);
                                    inUpdateCnt = insertCnt;
                                }
                            }
                        }
                    }
                }
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        
        return inUpdateCnt;
    }

    public int tcnDvyfgInfoLInterface(CntrctManageVO basevo) {

        int inUpdateCnt = 0;
        
        try{
            
            InetAddress inet = InetAddress.getLocalHost();
            String svrIP = inet.getHostAddress();
            Calendar cal = Calendar.getInstance();
            
            String naraDate = basevo.getNaraDate();

            naraDate = naraDate.replace("-", "");
            
            //개발용

            String yStr = ""+cal.get(Calendar.YEAR);            // 올해년도 얻기
            String mStr = ""+(cal.get(Calendar.MONTH) + 1);     // 현재 월 얻기 (월은 + 1 해줘야함)
            String saveFolder = GlobalConfig.G2B_XML_BAK + "DEIFLA/" + yStr + "/" + mStr;    //backup경로
            String todayFileNm = "";

            
            
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
            //String todayFileNm = "DEIFLA" + sdf.format(cal.getTime()); //DEIFNT

            if("".equals(naraDate) || (naraDate.trim()).length() < 1){
                //todayFileNm = "CRNTLI" + sdf.format(cal.getTime());
                todayFileNm = "DEIFLA" + sdf1.format(cal.getTime());
            } else {
                todayFileNm = "DEIFLA" + naraDate;
            }            
            
            
            ArrayList<File> xmlFiles = new ArrayList<File>();
            //File xmlDir = new File(GlobalConfig.G2B_XML_LOCAL); //D:/ceart 에 XML파일 넣고 테스트
            //File xmlDir2 = new File(GlobalConfig.G2B_XML_LOCAL2); //D:/ceart 에 XML파일 넣고 테스트
            File xmlDir = new File(GlobalConfig.G2B_XML_AFTER); //운영서버 반영시 실제 경로로 넣기
            File xmlDir2 = new File(GlobalConfig.G2B_XML_REALAPPLY); //운영서버 반영시 실제 경로로 넣기

            if(xmlDir2.isDirectory()) {
                File[] allFiles1 = xmlDir2.listFiles();

                if(allFiles1.length > 0) {
                    for(File file1 : allFiles1) {
                        if(file1.getName().startsWith("DEIFLA") && file1.getName().endsWith("0")) {
                            file1.delete();
                        }
                    }
                }

                File[] allFiles2 = xmlDir.listFiles();
                if(allFiles2.length > 0) {
                    for(File file2 : allFiles2) {
                        if(file2.getName().startsWith(todayFileNm) && file2.getName().endsWith("0")) {

                            File destFile = new File(GlobalConfig.G2B_XML_REALAPPLY,file2.getName());  //개발시
                            //File destFile = new File(GlobalConfig.G2B_XML_REALAPPLY,file2.getName());  //운영에 적용시

                          copyFile(file2,destFile);//copyFile메소드 실행
                        }
                    }
                }
            }            
            
            DvyfgInfoVO vo;
            if(xmlDir2.isDirectory()) {
                File[] allFiles = xmlDir2.listFiles();
                
                if(allFiles.length > 0) {
                    for(File file : allFiles) {
                        if(file.getName().startsWith(todayFileNm) && file.getName().endsWith("0")) {
                            xmlFiles.add(file);
                            Collections.sort(xmlFiles);
                        }
                    } 
                   
                    for(File xmlFile : xmlFiles) {
                          
                       
                        if(xmlFile.isFile()) {
                            // XML Document 객체 생성
                            InputSource is = new InputSource(new FileReader(GlobalConfig.G2B_XML_REALAPPLY + xmlFile.getName()));
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
                                    inUpdateCnt = updateCnt;
                                }else{
                                    insertCnt = insertCnt + dvyfgInfoService.dvyfgInfoInsertAction(vo);
                                    inUpdateCnt = updateCnt;
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
        
        
        return inUpdateCnt;
    }

        
    
    /**
     * 
     * copyFile 설명
     * @param source
     * @param dest
     */
    private static void copyFile(File source,File dest) {
        long startTime = System.currentTimeMillis();

        int count = 0;
        long totalSize = 0;
        byte[] b = new byte[128];

        FileInputStream in = null;
        FileOutputStream out = null; 
        
        //성능향상을 위한 버퍼 스트림 사용
        BufferedInputStream bin = null;
        BufferedOutputStream bout = null;
        try { 
            in = new FileInputStream(source);
            bin = new BufferedInputStream(in);

            out = new FileOutputStream(dest);
            bout = new BufferedOutputStream(out);
                
            while((count = bin.read(b))!= -1){
                bout.write(b,0,count);
                totalSize += count;
            }
        } catch (Exception e) {
        // TODO: handle exception
            e.printStackTrace();
        } finally{// 스트림 close 필수
            try {
                    if(bout!=null){
                        bout.close();
                    }    
                    
                    if (out != null){
                        out.close();
                    }
        
                    if(bin!=null){
                        bin.close();
                    }
        
                    if (in != null){
                        in.close();
                    }

            } catch (IOException r) {
                // TODO: handle exception
                System.out.println("close 도중 에러 발생.");
            }
        }
        //복사 시간 체크 
        StringBuffer time = new StringBuffer("소요시간 : ");
        time.append(System.currentTimeMillis() - startTime);
        time.append(",FileSize : " + totalSize);
        System.out.println(time);
    }
    
    /**
     * fileDelete (계약서 파일 삭제)
     * @param fileVO
     * @return
     */
    public int fileDelete(FileVO fileVO) {
        int affected = fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
        return affected;
    }
    
    @SuppressWarnings("unchecked")
    public Map<String, Object> mainCntInfo() {
        Map<String, Object> map = new HashMap<String, Object>();
        return (Map<String, Object>) selectByPk("_cntrctManage.serviceCnt", map);
    }
    
    public int updateCntrctCmpl(SuplerCntrctVO vo) {

        // 비회원구매자일경우 엡데이트
        /*
         * if(vo.getUserSn() > 0 )
         * update("_suplerCeart.updateSuplerTempUser", vo);
         * 게약 등록시 구매담담아이디가 없을시 비회원으로 등록
         * if(vo.getCommUserId().equals("") && vo.getUserSn() == 0 ){
         * int userSn = insert("_suplerCeart.insertSuplerTempUser", vo);
         * }
         */

        // 첨부파일 - 계약서 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(), vo.getCtrtcSn()));
        }
        int result = 0;

        if(vo.getRlCntrctInsttAt() == null) {
            delete("_suplerCeart.deleteRLuserInitInfo", vo);
        }

        // 계약정보 등록 혹은 수정{{{
        if(vo.getSbscrbTyCd().equals(2002))
            vo.setBuseoCode("ZZZZZZZ");
        vo.setBuseoNm(vo.getPurchsInsttNm());
        vo.setRlCntrctInsttAt("N");
        result = insert("_suplerCeart.mergeRLuserInfo", vo);
        // }}}

        // 등록된 체결서비스중 삭제, 등록 , 수정 {{{{{
        if(vo.getCntrctSvcSns() != null && vo.getCntrctSvcSns().length > 0)
            result = delete("_suplerCeart.cntrctGoodsNotDelete", vo);

        if(vo.getGoodsCodes() != null && vo.getGoodsCodes().length > 0) {
            SuplerCntrctGoodsVO gvo = new SuplerCntrctGoodsVO();
            gvo.setCntrctSn(vo.getCntrctSn());
            for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
                gvo.setGoodsCode(vo.getGoodsCodes()[i]);
                gvo.setCntrctSvcSn(vo.getCntrctSvcSns()[i]);
                gvo.setCntrctAmount(vo.getCntrctAmounts()[i]);
                /* gvo.setCntrctCount(vo.getCntrctCounts()[i]); */
                gvo.setSplyForm(vo.getSplyForms()[i]);
                gvo.setSplyFormEtc(vo.getSplyFormEtcs()[i]);
                result = insert("_suplerCeart.mergeCntrctGoodsInfo", gvo);
            }
        }
        // }}}

        // 실이용자 민간기업으로 선택시
        if(vo.getUserSe() != null && vo.getUserSe().equals("2")) {
            // 공공기관 있을시 삭제
            vo.setBuseoCode("");
            delete("_suplerCeart.deleteRLuserInfo", vo);

            // 실제이용정보 민간기업시 등록
            vo.setBuseoCode("ZZZZZZZ");
            vo.setBuseoNm(vo.getRealCmpny());
            vo.setRlCntrctInsttAt("Y");
            insert("_suplerCeart.mergeRLuserInfo", vo);
        } else if(vo.getUserSe() != null && vo.getUserSe().equals("3")) {
            vo.setBuseoCode("ZZZZZZZ");
            delete("_suplerCeart.deleteRLuserInfo", vo);
            
            //insert("_suplerCeart.mergeRLuserInfo", vo);            
        }
        return update("_suplerCeart.updateSuplerCntrctCmpl", vo);
    }
    
    public int updateCntrctCmpl2(SuplerCntrctVO vo) {

        // 비회원구매자일경우 엡데이트
        /*
         * if(vo.getUserSn() > 0 )
         * update("_suplerCeart.updateSuplerTempUser", vo);
         * 게약 등록시 구매담담아이디가 없을시 비회원으로 등록
         * if(vo.getCommUserId().equals("") && vo.getUserSn() == 0 ){
         * int userSn = insert("_suplerCeart.insertSuplerTempUser", vo);
         * }
         */

        // 첨부파일 - 계약서 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(), vo.getCtrtcSn()));
        }
        int result = 0;

        if(vo.getRlCntrctInsttAt() == null) {
            delete("_suplerCeart.deleteRLuserInitInfo", vo);
        }

        // 계약정보 등록 혹은 수정{{{
        if(vo.getSbscrbTyCd().equals(2002))
            vo.setBuseoCode("ZZZZZZZ");
        vo.setBuseoNm(vo.getPurchsInsttNm());
        vo.setRlCntrctInsttAt("N");
        result = insert("_suplerCeart.mergeRLuserInfo", vo);
        // }}}

        // 등록된 체결서비스중 삭제, 등록 , 수정 {{{{{
        if(vo.getCntrctSvcSns() != null && vo.getCntrctSvcSns().length > 0)
            result = delete("_suplerCeart.cntrctGoodsNotDelete", vo);

        if(vo.getGoodsCodes() != null && vo.getGoodsCodes().length > 0) {
            SuplerCntrctGoodsVO gvo = new SuplerCntrctGoodsVO();
            gvo.setCntrctSn(vo.getCntrctSn());
            for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
                gvo.setGoodsCode(vo.getGoodsCodes()[i]);
                gvo.setCntrctSvcSn(vo.getCntrctSvcSns()[i]);
                gvo.setCntrctAmount(vo.getCntrctAmounts()[i]);
                /* gvo.setCntrctCount(vo.getCntrctCounts()[i]); */
                gvo.setSplyForm(vo.getSplyForms()[i]);
                gvo.setSplyFormEtc(vo.getSplyFormEtcs()[i]);
                result = insert("_suplerCeart.mergeCntrctGoodsInfo", gvo);
            }
        }
        // }}}

        // 실이용자 민간기업으로 선택시
        if(vo.getUserSe() != null && vo.getUserSe().equals("2")) {
            // 공공기관 있을시 삭제
            vo.setBuseoCode("");
            delete("_suplerCeart.deleteRLuserInfo", vo);

            // 실제이용정보 민간기업시 등록
            vo.setBuseoCode("ZZZZZZZ");
            vo.setBuseoNm(vo.getRealCmpny());
            vo.setRlCntrctInsttAt("Y");
            insert("_suplerCeart.mergeRLuserInfo", vo);
        } else if(vo.getUserSe() != null && vo.getUserSe().equals("3")) {
            vo.setBuseoCode("ZZZZZZZ");
            delete("_suplerCeart.deleteRLuserInfo", vo);
            
            //insert("_suplerCeart.mergeRLuserInfo", vo);            
        }
        return update("_suplerCeart.updateSuplerCntrctCmpl2", vo);
    }
    
    public int insertCntrctCmpl(SuplerCntrctVO vo) {

        /*****************************************************
         * 2017-12-07
         * 비회원 사용안함, 파일 첨부 멀티로 변경하면서 로찍 빠짐
         * {{{{{{{
         */
        /* 게약 등록시 구매담담다아자 수기 등록 */
        /*
         * if(vo.getCommUserId().equals("")){
         * int userSn = insert("_suplerCeart.insertSuplerTempUser", vo);
         * }
         */
        // 첨부파일 - 계약서 - 첨부파일이 있고 새 파일이 존재할 경우에만 파일 upload
        /*
         * if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
         * if(vo.getCtrtcSn() == 0){
         * vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList(),
         * vo.getCtrtcSn()));
         * }
         * }
         */
        /* }}}}}}}} */
        if(vo.getCtrtcSnList() != null && vo.getCtrtcSnList().size() > 0) {
            if(vo.getCtrtcSn() <= 0) {
                vo.setCtrtcSn(fileDao.saveFile(vo.getCtrtcSnList()));
            }
        }
        int result = insert("_suplerCeart.insertSuplerCntrctCmpl", vo);
        if(vo.getSbscrbTyCd().equals(2002))
            vo.setBuseoCode("ZZZZZZZ");
        vo.setBuseoNm(vo.getPurchsInsttNm());
        vo.setRlCntrctInsttAt("N");
        result = insert("_suplerCeart.mergeRLuserInfo", vo);

        SuplerCntrctGoodsVO gvo = new SuplerCntrctGoodsVO();
        gvo.setCntrctSn(vo.getCntrctSn());
        if(vo.getGoodsCodes() != null)
            for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
                if(!vo.getGoodsCodes()[i].equals("")) {
                    gvo.setGoodsCode(vo.getGoodsCodes()[i]);
                    gvo.setCntrctAmount(vo.getCntrctAmounts()[i]);
                    /* gvo.setCntrctCount(vo.getCntrctCounts()[i]); */
                    gvo.setSplyForm(vo.getSplyForms()[i]);
                    gvo.setSplyFormEtc(vo.getSplyFormEtcs()[i]);
                    insert("_suplerCeart.mergeCntrctGoodsInfo", gvo);
                }
            }
        return result;
    }
    public int InsertImmeServiceRegist(SuplerCntrctVO vo) {

        //int result = insert("_suplerCeart.insertSuplerCntrctCmpl", vo);
        
        //String immeGoodsCode = (String) selectByPk("_suplerCeart.immeGoodsCode", "1111"); 
        
        int result = insert("_suplerCeart.InsertImmeServiceRegist", vo);

        return result;
    }
        
    
}
