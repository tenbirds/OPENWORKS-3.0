package zes.openworks.intra.mgr;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;

public class MgrListExcelVO implements IExcelVO {

    /*
     * (non-Javadoc)
     * @see
     * zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel
     * .HSSFWorkbook, java.util.Map)
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<MgrVO> list = (List<MgrVO>) model.get("_mgrList");

        HSSFSheet sheet = workbook.createSheet();
        // 번호, ID, 직급, 담당자명, 접속이력, 변경이력, 사용여부, 권한그룹
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("번호");
        header.createCell(colIndex++).setCellValue("ID");
        header.createCell(colIndex++).setCellValue("직위");
        header.createCell(colIndex++).setCellValue("담당자명");
        header.createCell(colIndex++).setCellValue("접속이력");
        header.createCell(colIndex++).setCellValue("변경이력");
        header.createCell(colIndex++).setCellValue("사용여부");
        header.createCell(colIndex++).setCellValue("권한그룹");

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(MgrVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(colIndex++).setCellValue(rowIndex - 1);
            row.createCell(colIndex++).setCellValue(vo.getMngrId());
            row.createCell(colIndex++).setCellValue(vo.getGradeNm());
            row.createCell(colIndex++).setCellValue(vo.getMngrNm());
            row.createCell(colIndex++).setCellValue(vo.getLoginDt());
            row.createCell(colIndex++).setCellValue(vo.getModiDt());
            row.createCell(colIndex++).setCellValue("Y".equals(vo.getUseYn()) ? "사용" : "미사용");
            row.createCell(colIndex++).setCellValue(vo.getAuthNm());
            colIndex = 0;
        }
    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {
        return "담당자목록";
    }
}
