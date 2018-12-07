/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.spi.diff;

import java.util.List;

/**
 * 두개의 컨텐츠를 비교하여 이전과 신규로 구분하여 변경 사항을 비교하여 결과를 반환한다.
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
 * @see difflib.DiffRow
 * @see difflib.DiffRowGenerator
 */
public interface DiffView {

    /**
     * 비교결과 유형별 보기 설정
     * <p />
     * 전체, 변경 전체, 추가, 삭제, 수정, 동일 건에 대한 유형(기본값은 전체)
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
    enum Type {
        all, change, add, delete, modify, same
    }

    /**
     * 출력 포멧(html)을 설정
     * <p />
     * table, ul, ol, span, div 태그를 지원
     * 
     * <pre>
     * table : <table class="diffContent">
     *            <tr>
     *               <td class="diffType">결과유형</td>
     *               <td class="diffOld">이전내용</td>
     *               <td class="diffNew">신규내용</td>
     *            </tr>
     *         </table>
     * ul : <ul class="diffContent">
     *          <li class="diffType">변경유형</li>
     *          <li class="diffOld">이전내용</li>
     *          <li class="diffNew">신규내용</li>
     *      </ul>
     * ol : <ol class="diffContent">
     *          <li class="diffType">변경유형</li>
     *          <li class="diffOld">이전내용</li>
     *          <li class="diffNew">신규내용</li>
     *      </ol>
     * span : <span class="diffContent">
     *          <span class="diffType">결과유형</span>
     *          <span class="diffOld">이전내용</span>
     *          <span class="diffNew">신규내용</span>
     *        </span>
     * 
     * div : <div class="diffContent">
     *         <span class="diffType">결과유형</span>
     *         <span class="diffOld">이전내용</span>
     *         <span>신규내용</span class="diffNew">
     *       </div>
     * </pre>
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
    enum View {
        table, ul, ol, span, div
    }

    /**
     * 비교결과 유형 설정
     * 
     * @param type
     */
    DiffView setType(Type type);

    /**
     * 출력 유형 설정
     * 
     * @param view
     */
    DiffView setView(View view);

    /**
     * 신규 컨텐츠 설정
     * 
     * @return
     */
    <T> DiffView setNewContent(T newContent);

    /**
     * 이전 컨텐츠 설정
     * 
     * @return
     */
    <T> DiffView setOldContent(T oldContent);

    /**
     * 신규/이전 내용 비교 결과를 한줄로 합하여 반환한다
     * <p />
     * {@link View} 설정을 참조하여 html 태그로 생성된다.
     * 
     * @return
     */
    List<String> getDiffStringList();

    /**
     * 직접 화면을 만들기 위한 정보만을 반환한다.
     * 
     * @return
     */
    List<DiffViewVO> getDiffVoList();

}
