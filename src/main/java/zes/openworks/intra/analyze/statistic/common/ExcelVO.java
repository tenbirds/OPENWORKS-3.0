/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.common;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.base.vo.IExcelVO;
import zes.core.lang.MethodUtil;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 16.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ExcelVO implements IExcelVO {

    /** 로깅 */
    private static Logger logger = LoggerFactory.getLogger(ExcelVO.class);

    private String fileNmae = "";

    public ExcelVO() {

    }

    public ExcelVO(String fileName) {
        super();
        this.fileNmae = fileName;
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel
     * .HSSFWorkbook, java.util.Map)
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        @SuppressWarnings("unchecked")
        List<ResultVO> list = (List<ResultVO>) model.get("_list");
        Object[] headers = (Object[]) model.get("_headers");
        String[] items = (String[]) model.get("_items");

        HSSFSheet sheet = workbook.createSheet();

        // 메뉴명, ID, 성명, 조회일시, 조회자, 조회자 ID, 조회사유
        colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        for(Object head : headers) {
            if(head instanceof String) {
                header.createCell(colIndex++).setCellValue(head.toString());
            } else if(head instanceof String[]) {
                for(String strHead : (String[]) head) {
                    header.createCell(colIndex++).setCellValue(strHead);
                }
            }
        }

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(ResultVO vo : list) {
            row = sheet.createRow(rowIndex++);
            for(String item : items) {

                Method method = MethodUtil.getMethod(vo.getClass(), "get" + item);
                Object value = new Object();
                try {
                    value = method.invoke(vo);
                } catch (Exception e) {
                    logger.error("create excel document failed", e);
                }
                if(value != null) {
                    setCellValue(row, value);
                } else {
                    row.createCell(colIndex++).setCellValue("");
                }
            }
            colIndex = 0;
        }
    }

    private int colIndex = 0;

    @SuppressWarnings("unchecked")
    private void setCellValue(HSSFRow row, Object value) {

        if(value instanceof Float) {
            row.createCell(colIndex++).setCellValue(((Float) value).doubleValue() + "%");

        } else if(value instanceof Integer) {
            row.createCell(colIndex++).setCellValue(((Integer) value).doubleValue());

        } else if(value instanceof List) {

            for(int i = 0 ; i < ((List<Integer>) value).size() ; i++) {
                Integer _value = ((List<Integer>) value).get(i);
                setCellValue(row, _value);
            }

        } else {
            row.createCell(colIndex++).setCellValue(value.toString());
        }
    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return this.fileNmae;
    }

}
