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
 *  2012. 5. 29.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UserLogListSExcelVO implements IExcelVO {

    @Override
    public void createExcelDocument(HSSFWorkbook workbook, Map<String, Object> model) {

        @SuppressWarnings("unchecked")
        List<UserVO> list = (List<UserVO>) model.get("_userList");
        @SuppressWarnings("unchecked")
        Map<String, Object> userListYn = (Map<String, Object>) model.get("_userListYn");

        HSSFSheet sheet = workbook.createSheet();

        // 메뉴명, ID, 성명, 조회일시, 조회자, 조회자 ID, 조회사유
        int colIndex = 0;
        HSSFRow header = sheet.createRow(0);

        if(Validate.isNotEmpty(userListYn.get("userId"))) {
            header.createCell(colIndex++).setCellValue("ID");
        }
        if(Validate.isNotEmpty(userListYn.get("userNm"))) {
            header.createCell(colIndex++).setCellValue("성명");
        }
        if(Validate.isNotEmpty(userListYn.get("langCode"))) {
            header.createCell(colIndex++).setCellValue("언어");
        }
        if(Validate.isNotEmpty(userListYn.get("nationCode"))) {
            header.createCell(colIndex++).setCellValue("국가");
        }
        if(Validate.isNotEmpty(userListYn.get("email"))) {
            header.createCell(colIndex++).setCellValue("이메일");
        }
        if(Validate.isNotEmpty(userListYn.get("intrlTelno"))) {
            header.createCell(colIndex++).setCellValue("국가전화번호");
        }
        if(Validate.isNotEmpty(userListYn.get("telno"))) {
            header.createCell(colIndex++).setCellValue("전화번호");
        }
        if(Validate.isNotEmpty(userListYn.get("zip"))) {
            header.createCell(colIndex++).setCellValue("우편번호");
        }
        if(Validate.isNotEmpty(userListYn.get("bassAdres"))) {
            header.createCell(colIndex++).setCellValue("기본주소");
        }
        if(Validate.isNotEmpty(userListYn.get("detailAdres"))) {
            header.createCell(colIndex++).setCellValue("상세주소");
        }
        if(Validate.isNotEmpty(userListYn.get("loginCnt"))) {
            header.createCell(colIndex++).setCellValue("로그인횟수");
        }
        if(Validate.isNotEmpty(userListYn.get("userTyCd"))) {
            header.createCell(colIndex++).setCellValue("회원구분");
        }
        if(Validate.isNotEmpty(userListYn.get("userGradCode"))) {
            header.createCell(colIndex++).setCellValue("회원등급");
        }
        if(Validate.isNotEmpty(userListYn.get("userSttusCd"))) {
            header.createCell(colIndex++).setCellValue("회원상태");
        }
        if(Validate.isNotEmpty(userListYn.get("passwordChangeDe"))) {
            header.createCell(colIndex++).setCellValue("비밀번호변경일");
        }
        if(Validate.isNotEmpty(userListYn.get("mbtlnum"))) {
            header.createCell(colIndex++).setCellValue("휴대전화");
        }
        if(Validate.isNotEmpty(userListYn.get("brthdy"))) {
            header.createCell(colIndex++).setCellValue("생년월일");
        }
        if(Validate.isNotEmpty(userListYn.get("sexdstnCd"))) {
            header.createCell(colIndex++).setCellValue("성별");
        }
        if(Validate.isNotEmpty(userListYn.get("smsRecptnAgreCd"))) {
            header.createCell(colIndex++).setCellValue("SMS수신여부");
        }
        if(Validate.isNotEmpty(userListYn.get("emailRecptnAgreCd"))) {
            header.createCell(colIndex++).setCellValue("이메일수신여부(광고홍보)");
        }
        if(Validate.isNotEmpty(userListYn.get("nsletRecptnAgreCd"))) {
            header.createCell(colIndex++).setCellValue("이메일수신여부(뉴스레터/세미나)");
        }
        if(Validate.isNotEmpty(userListYn.get("bidRecptnAgreCd"))) {
            header.createCell(colIndex++).setCellValue("이메일수신여부(입찰공고)");
        }
        if(Validate.isNotEmpty(userListYn.get("cmpnyNm"))) {
            header.createCell(colIndex++).setCellValue("회사명");
        }
        if(Validate.isNotEmpty(userListYn.get("cmpnyZip"))) {
            header.createCell(colIndex++).setCellValue("회사 우편번호");
        }
        if(Validate.isNotEmpty(userListYn.get("cmpnyBassAdres"))) {
            header.createCell(colIndex++).setCellValue("회사 기본주소");
        }
        if(Validate.isNotEmpty(userListYn.get("cmpnyDetailAdres"))) {
            header.createCell(colIndex++).setCellValue("회사 상세주소");
        }
        if(Validate.isNotEmpty(userListYn.get("cmpnyTelno"))) {
            header.createCell(colIndex++).setCellValue("회사 전화번호");
        }
        if(Validate.isNotEmpty(userListYn.get("cmpnyRprsntvNm"))) {
            header.createCell(colIndex++).setCellValue("회사 대표자명");
        }
        if(Validate.isNotEmpty(userListYn.get("faxRecptnAgreCd"))) {
            header.createCell(colIndex++).setCellValue("팩스 수신여부");
        }

        int rowIndex = 1;
        colIndex = 0;
        HSSFRow row;
        for(UserVO vo : list) {
            row = sheet.createRow(rowIndex++);
            if(Validate.isNotEmpty(userListYn.get("userId"))) {
                row.createCell(colIndex++).setCellValue(vo.getUserId());
            }
            if(Validate.isNotEmpty(userListYn.get("userNm"))) {
                row.createCell(colIndex++).setCellValue(vo.getUserNm());
            }
            if(Validate.isNotEmpty(userListYn.get("langCode"))) {
                row.createCell(colIndex++).setCellValue(vo.getLangNm());
            }
            if(Validate.isNotEmpty(userListYn.get("nationCode"))) {
                row.createCell(colIndex++).setCellValue(vo.getNationCode());
            }
            if(Validate.isNotEmpty(userListYn.get("email"))) {
                row.createCell(colIndex++).setCellValue(vo.getEmail());
            }
            if(Validate.isNotEmpty(userListYn.get("intrlTelno"))) {
                row.createCell(colIndex++).setCellValue(vo.getIntrlTelno());
            }
            if(Validate.isNotEmpty(userListYn.get("telno"))) {
                row.createCell(colIndex++).setCellValue(vo.getTelno());
            }
            if(Validate.isNotEmpty(userListYn.get("zip"))) {
                row.createCell(colIndex++).setCellValue(vo.getZip());
            }
            if(Validate.isNotEmpty(userListYn.get("bassAdres"))) {
                row.createCell(colIndex++).setCellValue(vo.getBassAdres());
            }
            if(Validate.isNotEmpty(userListYn.get("detailAdres"))) {
                row.createCell(colIndex++).setCellValue(vo.getDetailAdres());
            }
            if(Validate.isNotEmpty(userListYn.get("loginCnt"))) {
                row.createCell(colIndex++).setCellValue(vo.getLoginCnt());
            }
            if(Validate.isNotEmpty(userListYn.get("userTyCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getUserTyNm());
            }
            if(Validate.isNotEmpty(userListYn.get("userGradCode"))) {
                row.createCell(colIndex++).setCellValue(vo.getUserGradNm());
            }
            if(Validate.isNotEmpty(userListYn.get("userSttusCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getUserSttusNm());
            }
            if(Validate.isNotEmpty(userListYn.get("passwordChangeDe"))) {
                row.createCell(colIndex++).setCellValue(vo.getPasswordChangeDe());
            }
            if(Validate.isNotEmpty(userListYn.get("mbtlnum"))) {
                row.createCell(colIndex++).setCellValue(vo.getMbtlnum());
            }
            if(Validate.isNotEmpty(userListYn.get("brthdy"))) {
                row.createCell(colIndex++).setCellValue(vo.getBrthdy());
            }
            if(Validate.isNotEmpty(userListYn.get("sexdstnCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getSexdstnNm());
            }
            if(Validate.isNotEmpty(userListYn.get("smsRecptnAgreCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getSmsRecptnAgreNm());
            }
            if(Validate.isNotEmpty(userListYn.get("emailRecptnAgreCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getEmailRecptnAgreNm());
            }
            if(Validate.isNotEmpty(userListYn.get("nsletRecptnAgreCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getNsletRecptnAgreNm());
            }
            if(Validate.isNotEmpty(userListYn.get("bidRecptnAgreCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getBidRecptnAgreNm());
            }
            if(Validate.isNotEmpty(userListYn.get("cmpnyNm"))) {
                row.createCell(colIndex++).setCellValue(vo.getCmpnyNm());
            }
            if(Validate.isNotEmpty(userListYn.get("cmpnyZip"))) {
                row.createCell(colIndex++).setCellValue(vo.getCmpnyZip());
            }
            if(Validate.isNotEmpty(userListYn.get("cmpnyBassAdres"))) {
                row.createCell(colIndex++).setCellValue(vo.getCmpnyBassAdres());
            }
            if(Validate.isNotEmpty(userListYn.get("cmpnyDetailAdres"))) {
                row.createCell(colIndex++).setCellValue(vo.getCmpnyDetailAdres());
            }
            if(Validate.isNotEmpty(userListYn.get("cmpnyTelno"))) {
                row.createCell(colIndex++).setCellValue(vo.getCmpnyTelno());
            }
            if(Validate.isNotEmpty(userListYn.get("cmpnyRprsntvNm"))) {
                row.createCell(colIndex++).setCellValue(vo.getCmpnyRprsntvNm());
            }
            if(Validate.isNotEmpty(userListYn.get("faxRecptnAgreCd"))) {
                row.createCell(colIndex++).setCellValue(vo.getFaxRecptnAgreNm());
            }
            colIndex = 0;
        }

    }

    @Override
    public String getFileName() {

        return "회원관리목록";
    }

}
