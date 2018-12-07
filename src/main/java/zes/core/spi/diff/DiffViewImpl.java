/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.spi.diff;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

import difflib.DiffRow;
import difflib.DiffRow.Tag;
import difflib.DiffRowGenerator;

/**
 * 두개의 컨텐츠를 비교하여 이전과 신규로 구분하여 변경 사항을 비교하여 결과를 반환한다.
 * <p />
 * 결과는 VO 객체로 반환하여 직접 관리 할 수 있는 방법과, 설정으로 지원되는 html 코드로 자체 적용되어 지원되는 타입을 지원한다.
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 20.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class DiffViewImpl implements DiffView {

    /**
     * 비교결과 유형. 기본값은 전체 유형
     * 
     * @see Type
     */
    protected Type type = Type.all;

    /**
     * 출력 유형. 기본값은 table 태그 사용
     * 
     * @see View
     */
    protected View view = View.table;

    /** 신규 컨텐츠 */
    protected List<String> newContent;

    /** 이전 컨텐츠 */
    protected List<String> oldContent;

    @Override
    public DiffView setType(Type type) {
        this.type = type;
        return this;
    }

    @Override
    public DiffView setView(View view) {
        this.view = view;
        return this;
    }

    /**
     * 신규 컨텐츠 설정
     * 
     * @return
     */
    @Override
    public <T> DiffView setNewContent(T content) {
        if(content instanceof CharSequence) {
            this.newContent = DiffUtil.getContents((CharSequence) content);
        } else if(content instanceof File) {
            this.newContent = DiffUtil.getContents((File) content);
        } else {
            new Throwable("지원되지 않는 컨텐츠 형식입니다.");
        }
        return this;

    }

    /**
     * 이전 컨텐츠 설정
     * 
     * @return
     */
    @Override
    public <T> DiffView setOldContent(T content) {
        if(content instanceof CharSequence) {
            this.oldContent = DiffUtil.getContents((CharSequence) content);
        } else if(content instanceof File) {
            this.oldContent = DiffUtil.getContents((File) content);
        } else {
            new Throwable("지원되지 않는 컨텐츠 형식입니다.");
        }
        return this;
    }

    @Override
    public List<String> getDiffStringList() {

        List<String> wrapList = new LinkedList<String>();
        List<DiffViewVO> rowList = getDiff();

        switch(this.view) {
            case div:
                wrapList = DiffUtil.getDivWrap(rowList);
                break;
            case ul:
                wrapList = DiffUtil.getUlWrap(rowList);
                break;
            case ol:
                wrapList = DiffUtil.getOlWrap(rowList);
                break;
            case span:
                wrapList = DiffUtil.getSpanWrap(rowList);
                break;
            default:
                wrapList = DiffUtil.getTableWrap(rowList);
                break;
        }

        return wrapList;
    }

    @Override
    public List<DiffViewVO> getDiffVoList() {

        return getDiff();
    }

    /**
     * 줄단위 비교 데이터 결과 반환
     * 
     * @return
     */
    private List<DiffViewVO> getDiff() {

        if(this.type.equals(Type.all)) {
            return getAllDiff();
        } else if(this.type.equals(Type.change)) {
            return getAllChangeDiff();
        }
        return getSelectDiff();
    }

    /**
     * 줄단위 비교 데이터 결과 전체 반환
     * 
     * @return
     */
    private List<DiffViewVO> getAllDiff() {

        DiffRowGenerator generator = new DiffRowGenerator.Builder()
            .columnWidth(Integer.MAX_VALUE).build();

        List<DiffRow> rowList = generator.generateDiffRows(this.oldContent, this.newContent);

        List<DiffViewVO> wrapList = new LinkedList<DiffViewVO>();

        DiffViewVO viewVo;
        Integer lineNum = 1;
        for(DiffRow row : rowList) {
            lineNum++;
            viewVo = new DiffViewVO(row);
            viewVo.setLineNum(lineNum);
            wrapList.add(viewVo);
        }

        return wrapList;
    }

    /**
     * 줄단위 비교 데이터 결과 변경 전체 반환
     * 
     * @return
     */
    private List<DiffViewVO> getAllChangeDiff() {

        DiffRowGenerator generator = new DiffRowGenerator.Builder()
            .columnWidth(Integer.MAX_VALUE).build();

        List<DiffRow> rowList = generator.generateDiffRows(this.oldContent, this.newContent);

        List<DiffViewVO> wrapList = new LinkedList<DiffViewVO>();

        DiffViewVO viewVo;
        Integer lineNum = 1;
        for(DiffRow row : rowList) {
            lineNum++;

            if(!row.getTag().equals(Tag.EQUAL)) {
                viewVo = new DiffViewVO(row);
                viewVo.setLineNum(lineNum);
                wrapList.add(viewVo);
            }
        }

        return wrapList;
    }

    /**
     * 줄단위 비교 데이터 결과 선택적 반환
     * <p />
     * 추가, 변경, 삭제, 동일 한 결과만 선택적으로 추출
     * 
     * @return
     */
    private List<DiffViewVO> getSelectDiff() {

        DiffRowGenerator generator = new DiffRowGenerator.Builder()
            .columnWidth(Integer.MAX_VALUE).build();

        List<DiffRow> rowList = generator.generateDiffRows(this.oldContent, this.newContent);
        List<DiffViewVO> wrapList = new LinkedList<DiffViewVO>();

        DiffViewVO viewVo;
        Integer lineNum = 1;

        for(DiffRow row : rowList) {
            lineNum++;
            if(Type.add.equals(this.type) && row.getTag().equals(Tag.INSERT)) {
                viewVo = new DiffViewVO(row);
                viewVo.setLineNum(lineNum);
                wrapList.add(viewVo);
            } else if(Type.delete.equals(this.type) && row.getTag().equals(Tag.DELETE)) {
                viewVo = new DiffViewVO(row);
                viewVo.setLineNum(lineNum);
                wrapList.add(viewVo);
            } else if(Type.modify.equals(this.type) && row.getTag().equals(Tag.CHANGE)) {
                viewVo = new DiffViewVO(row);
                viewVo.setLineNum(lineNum);
                wrapList.add(viewVo);
            } else if(Type.same.equals(this.type) && row.getTag().equals(Tag.EQUAL)) {
                viewVo = new DiffViewVO(row);
                viewVo.setLineNum(lineNum);
                wrapList.add(viewVo);
            }
        }

        return wrapList;
    }
}
