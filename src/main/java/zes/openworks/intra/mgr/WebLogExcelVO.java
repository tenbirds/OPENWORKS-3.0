package zes.openworks.intra.mgr;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;
import zes.openworks.intra.login.LoggingWebLoginVO;

public class WebLogExcelVO implements IExcelVO {

    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<LoggingWebLoginVO> list = (List<LoggingWebLoginVO>) model.get("_mgrList");

        HSSFSheet sheet = workbook.createSheet();
        // 번호, 일시, 로그인기록, 접속메뉴, 결과, IP
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("일시");
        header.createCell(colIndex++).setCellValue("로그인기록");
        header.createCell(colIndex++).setCellValue("접속메뉴");
        header.createCell(colIndex++).setCellValue("결과");
        header.createCell(colIndex++).setCellValue("IP");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(LoggingWebLoginVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(vo.getLoginPnttm());
            row.createCell(colIndex++).setCellValue(vo.getLoginTy());
            row.createCell(colIndex++).setCellValue(vo.getMngrLoginMenu());
            row.createCell(colIndex++).setCellValue(vo.getLoginResult());
            row.createCell(colIndex++).setCellValue(vo.getLoginIp());
            colIndex = 0;
        }
    }

    @Override
    public String getFileName() {
        return "접속이력정보";
    }
}
