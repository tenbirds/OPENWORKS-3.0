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
public class CntrctManageExcelVO  implements IExcelVO {
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
        header.createCell(colIndex++).setCellValue("수요자ID");
        header.createCell(colIndex++).setCellValue("공급자ID");
        header.createCell(colIndex++).setCellValue("사업명");
        header.createCell(colIndex++).setCellValue("판매서비스");
        header.createCell(colIndex++).setCellValue("계약체결일");
        header.createCell(colIndex++).setCellValue("계약기간");
        header.createCell(colIndex++).setCellValue("계약금액");
        header.createCell(colIndex++).setCellValue("판매수량");
        header.createCell(colIndex++).setCellValue("구매기관");
        header.createCell(colIndex++).setCellValue("판매기관");
        header.createCell(colIndex++).setCellValue("계약서(PDF)");
        header.createCell(colIndex++).setCellValue("계약종류");

        Pager<CntrctManageVO> list = (Pager<CntrctManageVO>) model.get("_cntrctList");
        String type = "";
        int totalCnt = list.getTotalNum(); // 리스트 전체 갯수
        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;

        for(CntrctManageVO vo : list.getList()) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(totalCnt);
           if(vo.getTempUserSn() == null || vo.getTempUserSn() .equals("0")  ){
               row.createCell(colIndex++).setCellValue(vo.getRegistId());
           }else 
               row.createCell(colIndex++).setCellValue("비회원");
            row.createCell(colIndex++).setCellValue(vo.getUserId());
            row.createCell(colIndex++).setCellValue(vo.getSvcNm());
            row.createCell(colIndex++).setCellValue(vo.getGoodsNm());
            row.createCell(colIndex++).setCellValue(vo.getCntrDt());
            row.createCell(colIndex++).setCellValue(vo.getCntrctBeginDe().substring(0,4)+"-"+vo.getCntrctBeginDe().substring(4,6)+"-"+vo.getCntrctBeginDe().substring(6,8)
                                                 +"~"+vo.getCntrctEndDe().substring(0,4)+"-"+vo.getCntrctEndDe().substring(4,6)+"-"+vo.getCntrctEndDe().substring(6,8));
            row.createCell(colIndex++).setCellValue(String.format("%,d", Validate.isEmpty(vo.getCntrctamount())? 0 : vo.getCntrctamount()));  // cntrctamount
            row.createCell(colIndex++).setCellValue(vo.getCntrCount());   //cntrCount
            row.createCell(colIndex++).setCellValue(vo.getPurchsInsttNm());   //purchsInsttNm
            row.createCell(colIndex++).setCellValue(vo.getSleInsttNm());  //sleInsttNm
            row.createCell(colIndex++).setCellValue(vo.getCtrtcFile() != null ? "Y" : "N");
            row.createCell(colIndex++).setCellValue("Y".equals(vo.getUseAt()) ? "계약실적" : "이용실적");
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
