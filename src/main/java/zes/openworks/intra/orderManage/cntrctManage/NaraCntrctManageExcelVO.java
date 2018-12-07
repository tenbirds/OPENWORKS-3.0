package zes.openworks.intra.orderManage.cntrctManage;

import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.pager.Pager;
import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;

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
public class NaraCntrctManageExcelVO  implements IExcelVO {
    Map<String, Object> model;

    String hostNm;

    public void setModel(Map<String, Object> model) {
        this.model = model;
    }

    public void setHostNm(String hostNm) {
        this.hostNm = hostNm;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        HSSFSheet sheet = workbook.createSheet();

        // 메뉴명, ID, 성명, 조회일시, 조회자, 조회자 ID, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue(getMsg("excelHeader0"));// 
        
        
        header.createCell(colIndex++).setCellValue("계약번호");
        header.createCell(colIndex++).setCellValue("물품일련번호");        
        header.createCell(colIndex++).setCellValue("규격명");        
        header.createCell(colIndex++).setCellValue("금액");        
        header.createCell(colIndex++).setCellValue("제조사명");        
        header.createCell(colIndex++).setCellValue("클라우드서비스코드");        
        
        header.createCell(colIndex++).setCellValue("물품번호");
        
        header.createCell(colIndex++).setCellValue("제공기업명");
        header.createCell(colIndex++).setCellValue("수요기관명");
        header.createCell(colIndex++).setCellValue("사업명(계약건명)");
        header.createCell(colIndex++).setCellValue("계약일자(시작일/종료일)");
        header.createCell(colIndex++).setCellValue("계약금액(총액)");

        header.createCell(colIndex++).setCellValue("계약번호");
        
        header.createCell(colIndex++).setCellValue("납품요구번호");
        header.createCell(colIndex++).setCellValue("납품단가");
        header.createCell(colIndex++).setCellValue("납품단위");
        header.createCell(colIndex++).setCellValue("납품금액");
        header.createCell(colIndex++).setCellValue("납품기한");
        
        Pager<CntrctManageVO> list = (Pager<CntrctManageVO>) model.get("_cntrctList");
        String type = "";
        int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;

        for(CntrctManageVO vo : list.getList()) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(totalCnt);

            row.createCell(colIndex++).setCellValue(vo.getCntrNum());
            row.createCell(colIndex++).setCellValue(vo.getLineNum());
            row.createCell(colIndex++).setCellValue(vo.getItemName());
            row.createCell(colIndex++).setCellValue(vo.getUnitPric());
            row.createCell(colIndex++).setCellValue(vo.getManuName());
            row.createCell(colIndex++).setCellValue(vo.getGoodsCode());
            row.createCell(colIndex++).setCellValue(vo.getItemIdntfcNo());            
            
            row.createCell(colIndex++).setCellValue(vo.getMainCntrctEntrpsNm());
            row.createCell(colIndex++).setCellValue(vo.getRealOrgnNm());
            row.createCell(colIndex++).setCellValue(vo.getCntrctNm());
            row.createCell(colIndex++).setCellValue(vo.getCntrctDate() +"~"+ vo.getCntrctPd());
            row.createCell(colIndex++).setCellValue(vo.getCntrctThisTimeAmt());

            row.createCell(colIndex++).setCellValue(vo.getCntrctNo());
            
            row.createCell(colIndex++).setCellValue(vo.getDeliveryNum());            
            row.createCell(colIndex++).setCellValue(vo.getUnitPrice());            
            row.createCell(colIndex++).setCellValue(vo.getItemUnit());            
            row.createCell(colIndex++).setCellValue(vo.getItemAmount());            
            row.createCell(colIndex++).setCellValue(vo.getDeliveryDate());            
            
            --totalCnt;
            type = "";
            colIndex = 0;
         
        }
            --totalCnt;
            type = "";
            colIndex = 0;
        
    } 
 
    @Override
    public String getFileName() {
        return (String) model.get("q_excelFileName");
    }

    public String getMsg(String string) {
        String key = "";
        String upKey = "";
        if(Validate.isEmpty(hostNm) || "intra".equals(hostNm) || "korean".equals(hostNm)) {
            upKey = "msg";
        } else {
            upKey = hostNm + "Msg";
        }
        key = upKey + "." + string;
        return Config.getString(key);
    }
}
