package zes.openworks.intra.code;

import java.util.List;
import java.util.Map;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import zes.base.vo.IExcelVO;

public class CodeExcelVO implements IExcelVO {

    /*
     * (non-Javadoc)
     * @see
     * zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel
     * .HSSFWorkbook, java.util.Map)
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<CodeVO> list = (List<CodeVO>) model.get("_codeList");

        HSSFSheet sheet = workbook.createSheet();
        // 번호, 언어, 그룹코드명, 그룹코드, 개별코드명, 개별코드, 사용여부
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        header.createCell(colIndex++).setCellValue("번호");
        header.createCell(colIndex++).setCellValue("언어명");
        header.createCell(colIndex++).setCellValue("언어코드");
        header.createCell(colIndex++).setCellValue("그룹코드명");
        header.createCell(colIndex++).setCellValue("그룹코드");
        header.createCell(colIndex++).setCellValue("개별코드명");
        header.createCell(colIndex++).setCellValue("개별코드");
        header.createCell(colIndex++).setCellValue("사용여부");

        int rowIndex = 1;
        int rowNum = 1;
        HSSFRow row;
        for(CodeVO vo : list) {
            row = sheet.createRow(rowIndex++);
            row.createCell(0).setCellValue(rowNum++);
            row.createCell(1).setCellValue(vo.getLangNm());
            row.createCell(2).setCellValue(vo.getLangCode());
            row.createCell(3).setCellValue(vo.getGrpNm());
            row.createCell(4).setCellValue(vo.getGrpCd());

            CodeVO prvCodeVo;
            for(int i = 0 ; i < vo.getPrvTotalCodeList().size() ; i++) {
                prvCodeVo = vo.getPrvTotalCodeList().get(i);
                if(i != 0) {
                    row = sheet.createRow(rowIndex++);
                }
                row.createCell(5).setCellValue(prvCodeVo.getPrvNm());
                row.createCell(6).setCellValue(prvCodeVo.getPrvCd());
                row.createCell(7).setCellValue(prvCodeVo.getUseYn());
            }
        }
    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {
        return "전체그룹코드목록";
    }
}
