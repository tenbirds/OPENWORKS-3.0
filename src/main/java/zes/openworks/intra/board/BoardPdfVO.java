/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import java.awt.Color;
import java.util.List;
import java.util.Map;

import zes.base.vo.IPdfVO;
import zes.openworks.intra.boardconf.BoardConfConstant;
import zes.openworks.intra.boardconf.BoardConfVO;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;

/**
 * PDF 파일 생성 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 * 	수정일	             수정자                     수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 28.	       손재숙     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardPdfVO implements IPdfVO {

    /** 데이타 목록 */
    private List<BoardVO> itemList;

    /** 데이타 목록 */
    private BoardConvertOptionVO boardConvertOptionVO;

    /** 데이타 목록 */
    private BoardConfVO boardConfVO;

    public List<BoardVO> getItemList() {
        return itemList;
    }

    public void setItemList(List<BoardVO> itemList) {
        this.itemList = itemList;
    }

    public BoardConvertOptionVO getBbsConvertOptionVO() {
        return boardConvertOptionVO;
    }

    public void setBbsConvertOptionVO(BoardConvertOptionVO boardConvertOptionVO) {
        this.boardConvertOptionVO = boardConvertOptionVO;
    }

    public BoardConfVO getBbsConfVO() {
        return boardConfVO;
    }

    public void setBbsConfVO(BoardConfVO boardConfVO) {
        this.boardConfVO = boardConfVO;
    }

    /**
     * PDF 파일 생성
     */
    @Override
    public void createPdfDocument(Document document, @SuppressWarnings("rawtypes") Map model) throws Exception {
        String fontPath = this.getClass().getClassLoader().getResource("/zes/core/font/GULIM.TTC").toExternalForm();

        BaseFont baseFont = BaseFont.createFont(fontPath + ",0", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        Font koreanFont = new Font(baseFont, 10, Font.NORMAL, Color.black);

        PdfPTable table = new PdfPTable(14);
        table.setHorizontalAlignment(Element.ALIGN_CENTER);

        table.addCell(new PdfPCell(new Paragraph("순서", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("종류", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("제목", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("요약", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("등록일", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("수정일", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("작성자", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("매니저ID", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("유저ID", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("조회수", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("평가합계", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("평가횟수", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("신고", koreanFont)));
        table.addCell(new PdfPCell(new Paragraph("추천", koreanFont)));

        int colNum = 1;
        for(BoardVO boardVO : itemList) {
            table.addCell(new Paragraph(String.valueOf(colNum++), koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getNoticeBbscttUseYn())) ? (("Y".equals(boardVO.getNoticeBbscttAt())) ? "공지" : "게시글")
                : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getBbscttSjYn())) ? boardVO.getBbscttSj() : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getCnSumryYn())) ? boardVO.getCnSumry() : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getRegistDtYn())) ? boardVO.getRegistDt() : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getUpdtDtYn())) ? boardVO.getUpdtDt() : "", koreanFont));

            String regName = "";
            int viewCd = boardConfVO.getRegisterIndictCd().intValue();
            switch(viewCd) {
                case BoardConfConstant.GUBUN_SHOW_NM:
                    regName = boardVO.getMngrNm() + boardVO.getUserNm() + boardVO.getRegisterNm();
                    break;
                case BoardConfConstant.GUBUN_SHOW_ID:
                    regName = boardVO.getMngrId() + boardVO.getRegistId() + boardVO.getRegisterNm();
                    break;
                case BoardConfConstant.GUBUN_SHOW_DEPT_NM:
                    regName = boardVO.getDeptNm();
                    break;
                default:
                    regName = boardVO.getRegisterNm();
                    break;
            }
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getRegisterNmYn())) ? regName : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getMngrIdYn())) ? boardVO.getMngrId() : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getUserKeyYn())) ? boardVO.getUserKey() : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getRdcntYn())) ? String.valueOf(boardVO.getRdcnt()) : "", koreanFont));
            table
                .addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getAccuseCntYn())) ? String.valueOf(boardVO.getAccuseCnt()) : "", koreanFont));
            table.addCell(new Paragraph(("Y".equals(boardConvertOptionVO.getRecomendCntYn())) ? String.valueOf(boardVO.getRecomendCnt()) : "", koreanFont));
        }

        document.add(table);
    }
}
