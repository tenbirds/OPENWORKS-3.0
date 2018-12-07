<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>

    <form name="dataGroupForm" id="dataGroupForm" action="<c:url value="ND_pollGroupInsertAction.do" />" method="post" >
    
        <%-- 페이징 관련 파라미터 생성 --%>
        <op:pagerParam view="view" />
        
        <!-- 기본 조건 항목 -->
        <input type="hidden" name="seq" value='${dataVo.seq}' />

        <h4 class="tx_13">설문그룹 추가</h4>

        <table class="boardWrite" width="100%" border="0" cellspacing="0" cellpadding="0" summary="설문 항목 추가">
            <caption class="title">설문 항목 추가 정보를 입력합니다.</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>그룹제목<span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="text" name="groupTitle" id="groupTitle" maxlength="400" class="w_50p" />
                    </td>
                </tr>
                <tr>
                    <th>설문항목<span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" class="radio" name="type" id="typeC" value="C" onclick="jsAddType('C');" checked="checked" /><label for="typeC">선택형</label>
                        <input type="radio" class="radio" name="type" id="typeI" value="I" onclick="jsAddType('I');" />&nbsp;<label for="typeI">단답형</label>

                        <br class="blank"/>
                        <table class="boardWrite" id="addChoice" width="100%" border="0" cellspacing="0" cellpadding="0" summary="선택형 설문항목 등록">
                            <caption class="title">선택형 설문항목 등록</caption>
                            <colgroup>
                                <col width="15%" />
                                <col width="85%" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>항목<span class="tx_red tx_b">*</span></th>
                                    <td>
                                        <input type="text" name="items" id="items1" maxlength="100" style="width:50%;" />
                                        <button type="button" class="s_blue" onclick="jsAddItem();">항목추가</button>
                                        <div id="addItem" ></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>복수선택수<span class="tx_red tx_b">*</span></th>
                                    <td>
                                        <input type="text" name="multiChoiceCnt" id="multiChoiceCnt" class="w15" value='1' maxlength="2" />
                                        <span class="tx_blue_s">동시에 선택가능한 수치를 입력.</span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>의견글사용여부<span class="tx_red tx_b">*</span></th>
                                    <td>
                                        <input type="radio" class="radio" name="commentUseYn" id="commentUseYnY" value="Y" />&nbsp;<label for="commentUseYnY">사용</label>
                                        <input type="radio" class="radio" name="commentUseYn" id="commentUseYnN" value="N" checked="checked" />&nbsp;<label for="commentUseYnN">미사용</label>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                    </td>
                </tr>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><button type="submit" class="w_blue">추가</button></li>
                <li><button type="button" class="blue" onclick="jsPollList();">목록</button></li>
            </ul>
        </div>
        <!-- //버튼 -->

    </form>
