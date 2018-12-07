package zes.openworks.intra.mgr;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;

public class ChangeLogExcelVO implements IExcelVO {

    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<LoggingMgrVO> list = (List<LoggingMgrVO>) model.get("_mgrList");

        HSSFSheet sheet = workbook.createSheet();
        // 번호, 변경구분, 변경내용, 등록자, 변경일자
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("번호");
        header.createCell(colIndex++).setCellValue("변경구분");
        header.createCell(colIndex++).setCellValue("변경내용");
        header.createCell(colIndex++).setCellValue("등록자");
        header.createCell(colIndex++).setCellValue("변경일자");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(LoggingMgrVO vo : list) {
            //if(vo.getChangeType() != null) {
                row = sheet.createRow(rowIndex++);
                row.createCell(colIndex++).setCellValue(list.size() - (rowIndex - 2));
                if(vo.getChangeType() != null) {
                    row.createCell(colIndex++).setCellValue(vo.getChangeType());
                }else{
                    row.createCell(colIndex++).setCellValue("단순저장");
                }
                if(vo.getChangeType() != null) {
                    row.createCell(colIndex++).setCellValue(vo.getChangeResutl());
                }else{
                    row.createCell(colIndex++).setCellValue("변경없음");
                }
                row.createCell(colIndex++).setCellValue(vo.getUpdtId());
                row.createCell(colIndex++).setCellValue(vo.getLogDt());
                colIndex = 0;
            //}
        }
    }

    @Override
    public String getFileName() {
        return "변경이력정보";
    }
}
