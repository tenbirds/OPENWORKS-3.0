/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;

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
 *  2012. 5. 28.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UserLogListCExcelVO implements IExcelVO {

    /*
     * (non-Javadoc)
     * @see
     * zes.base.vo.IExcelVO#createExcelDocument(org.apache.poi.hssf.usermodel
     * .HSSFWorkbook, java.util.Map)
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {
        @SuppressWarnings("unchecked")
        List<UserVO> list = (List<UserVO>) model.get("_userList");
        String userSttusCd = (String) model.get("q_userSttusCd");

        HSSFSheet sheet = workbook.createSheet();

        // 회원관리 목록
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);
        if(userSttusCd.equals("1002")){
            header.createCell(colIndex++).setCellValue("ID");
            header.createCell(colIndex++).setCellValue("회원구분");
            header.createCell(colIndex++).setCellValue("사용권한");
            header.createCell(colIndex++).setCellValue("기관·기업명");
            header.createCell(colIndex++).setCellValue("가입일");
            header.createCell(colIndex++).setCellValue("탈퇴일");
            header.createCell(colIndex++).setCellValue("탈퇴구분");
        } else {
            header.createCell(colIndex++).setCellValue("ID");
            header.createCell(colIndex++).setCellValue("이름");
            header.createCell(colIndex++).setCellValue("기관·기업명");
            header.createCell(colIndex++).setCellValue("이메일");
            header.createCell(colIndex++).setCellValue("국적");
            header.createCell(colIndex++).setCellValue("회원구분");
            header.createCell(colIndex++).setCellValue("사용권한");
            header.createCell(colIndex++).setCellValue("스토어");
            /*header.createCell(colIndex++).setCellValue("신고건수");
            header.createCell(colIndex++).setCellValue("회원등급");
            header.createCell(colIndex++).setCellValue("활동레벨");*/
            header.createCell(colIndex++).setCellValue("이메일 수신");
            header.createCell(colIndex++).setCellValue("뉴스레터 수신");
            header.createCell(colIndex++).setCellValue("입찰공고 수신");
            header.createCell(colIndex++).setCellValue("가입일");
            header.createCell(colIndex++).setCellValue("최근접속일");
        }

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(UserVO vo : list) {
            row = sheet.createRow(rowIndex++);
            if(userSttusCd.equals("1002")){
                row.createCell(colIndex++).setCellValue(vo.getUserId());
                if(vo.getUserTyNm().split(" ").length > 0){
                    row.createCell(colIndex++).setCellValue(vo.getUserTyNm().split(" ")[0]);
                    if(vo.getUserTyNm().split(" ")[1].length() > 2){
                        row.createCell(colIndex++).setCellValue(vo.getUserTyNm().split(" ")[1].substring(0, 2));
                    } else {
                        row.createCell(colIndex++).setCellValue(vo.getUserTyNm().split(" ")[1]);
                    }
                } else {
                    row.createCell(colIndex++).setCellValue("");
                    row.createCell(colIndex++).setCellValue("");
                }
                row.createCell(colIndex++).setCellValue(vo.getCmpnyNm());
                row.createCell(colIndex++).setCellValue(vo.getRegistDt());
                row.createCell(colIndex++).setCellValue(vo.getSecsnDt());
                row.createCell(colIndex++).setCellValue(vo.getUserSttusNm());
            } else {
                /*
                String storeLangs = "";
                for(int i = 0; i < vo.getUserstore().size(); ++i){
                    storeLangs += vo.getUserstore().get(i);
                    if((vo.getUserstore().size() - 1) != i){
                        storeLangs += ", ";
                    }
                }
                */
                row.createCell(colIndex++).setCellValue(vo.getUserId());
                row.createCell(colIndex++).setCellValue(vo.getUserNm());
                row.createCell(colIndex++).setCellValue(vo.getCmpnyNm());
                row.createCell(colIndex++).setCellValue(vo.getEmail());
                row.createCell(colIndex++).setCellValue(vo.getNationCode());
                row.createCell(colIndex++).setCellValue(vo.getUserTyNm().split(" ")[0]);
                row.createCell(colIndex++).setCellValue(vo.getUserTyNm().split(" ")[1].substring(0, vo.getUserTyNm().split(" ")[1].length()-2));
                row.createCell(colIndex++).setCellValue(vo.getLangStoreNm());
                /*row.createCell(colIndex++).setCellValue(vo.getAccuseAtCdCnt());
                row.createCell(colIndex++).setCellValue(vo.getUserGradNm());
                row.createCell(colIndex++).setCellValue(vo.getActLevelNm());*/
                if(Validate.isEmpty(vo.getEmailRecptnAgreCd())) {
                    row.createCell(colIndex++).setCellValue("");
                } else {
                    row.createCell(colIndex++).setCellValue(vo.getEmailRecptnAgreCd() == 1001 ? "동의" : "");
                }
                if(Validate.isEmpty(vo.getNsletRecptnAgreCd())) {
                    row.createCell(colIndex++).setCellValue("");
                } else {
                    row.createCell(colIndex++).setCellValue(vo.getNsletRecptnAgreCd() == 1001 ? "동의" : "");
                }
                if(Validate.isEmpty(vo.getBidRecptnAgreCd())) {
                    row.createCell(colIndex++).setCellValue("");
                } else {
                    row.createCell(colIndex++).setCellValue(vo.getBidRecptnAgreCd() == 1001 ? "동의" : "");
                }
                row.createCell(colIndex++).setCellValue(vo.getRegistDt());
                row.createCell(colIndex++).setCellValue(vo.getRecentLoginDt());
            }
            colIndex = 0;
        }
    }

    /*
     * (non-Javadoc)
     * @see zes.base.vo.IExcelVO#getFileName()
     */
    @Override
    public String getFileName() {

        return "회원관리목록";
    }

}
