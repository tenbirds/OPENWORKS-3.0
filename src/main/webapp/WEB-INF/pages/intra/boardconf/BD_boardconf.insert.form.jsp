<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>게시판 생성</title>

    <op:jsTag type="openworks" items="form, validate" />
    <op:jsTag type="spi" items="ui"/>

    <!-- 유효성 검증 BEAN Annotation 기반 자동 설정 -->
    <valid:script type="msgbox" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="/resources/intra/boardconf/boardconf.js"></script>

    <script type="text/javascript">


        /* 공통 초기화 */
        $(document).ready(function(){
            $("#bbsConfTabDiv").tabs();

            $("#dataForm").submit(function(){
                if(validate()){
                    return true;
                }
                return false;
            });
        });

        /*
         * validate() 호출시 사용자 정의 검증을 자동으로 호출함
         */
        var customValidate = function(){
            var ctgNmArray = $("input[name=ctgNms]").val();
            if($("input[name=ctgYn]:checked").val() == "Y" && ctgNmArray.length == 0){
                jsWarningBox("분류 사용 여부를 사용으로 선택 시 분류 정보를 설정해야 합니다.");
                $("#ctgNms").focus();
                return false;
            }
            return true;
        };

    </script>
</head>
<body>

    <div class="po_rel">
        <h4>게시판 생성</h4>
        <div class="h4_r">
            <span class="tx_red tx_b">*</span> 표시는 필수입력사항입니다.
        </div>
    </div>

    <!-- 탭 -->
    <div id="bbsConfTabDiv">
        <ul>
            <li><a href="#" class="on">기본 정보</a></li>
        </ul>
    </div>
    <!-- //탭 -->

    <form name="dataForm" id="dataForm" method="post" action="ND_boardconf.insert.do">

    <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
    <op:pagerParam view="view" />

    <input type="hidden" name="bbsCd" id="bbsCd" />

    <!-- 내용쓰기 -->
    <fieldset>
        <legend>글입력</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="게시판 내용 작성페이지입니다.">
            <caption class="hidden">게시판 생성 페이지</caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="domainCd">사이트 구분</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <select name="domainCd" id="domainCd" class="over">
                            <option value="">-- 전체 --</option>
                            <option value="2">국문사이트</option>
                            <option value="3">영어사이트</option>
                            <option value="4">스페인어사이트</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="bbsNm">게시판 명</label> <span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="text" name="bbsNm" id="bbsNm" class="w180" title="게시판 명" /> <span class="tx_blue_s">- 최대 30자</span>
                        <valid:msg name="bbsNm" />
                    </td>
                </tr>
                <tr>
                    <th><label for="bbsDc">게시판 개요</label></th>
                    <td>
                        <textarea id="bbsDc" name="bbsDc" rows="3" class="w99_p" title="게시판 개요"></textarea>
                        <span class="tx_blue_s">- 최대 300자</span>
                        <valid:msg name="bbsDc" />
                    </td>
                </tr>
                <tr>
                    <th><label for="kndCd">게시판 종류 <span class="tx_red tx_b">*</span></label></th>
                    <td>
                        <!-- <f:select path="dataVo.kndCd" id="kndCd" items="${kndCdMap}" />
                        <valid:msg name="kndCd" /> -->
                        목록 : <select id="listSkin" name="listSkin" class="mar_b5">
                            <c:forEach items="${listTemplates}" var="list">
                                <option value="${list.tmplatId}">${list.tmplatNm}</option>
                            </c:forEach>
                        </select><br />
                        읽기 : <select id="viewSkin" name="viewSkin" class="mar_b5">
                            <c:forEach items="${viewTemplates}" var="view">
                                <option value="${view.tmplatId}">${view.tmplatNm}</option>
                            </c:forEach>
                        </select><br />
                        쓰기 : <select id="formSkin" name="formSkin">
                            <c:forEach items="${formTemplates}" var="form">
                                <option value="${form.tmplatId}">${form.tmplatNm}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="ctgYn">분류 사용 여부 <span class="tx_red tx_b">*</span></label></th>
                    <td>
                        <input type="radio" name="ctgYn" id="ctgYn" value="Y" onclick="$('#ctgNmsTR').show();" />
                        <label for="ctgYnY">사용</label>
                        <input type="radio" name="ctgYn" id="ctgYn" value="N" checked="checked" onclick="$('#ctgNmsTR').hide();" />
                        <label for="ctgYnN">미사용</label>
                        <valid:msg name="ctgYn" />
                    </td>
                </tr>
                <tr id="ctgNmsTR" class="none">
                    <th><label for="ctgNms">분류 설정</label></th>
                    <td>
                        <input type="text" name="ctgNms" id="ctgNms" class="w85_p" title="분류명" />
                        <p class="tx_blue_s">- 쉼표로 구분하여 분류명을 입력해 주세요. 입력한 순서대로 정렬순번이 지정됩니다.</p>
                    </td>
                </tr>
                <tr>
                    <th><label for="noticeBbscttUseYn">공지 사용 여부 <span class="tx_red tx_b">*</span></label></th>
                    <td>
                        <input type="radio" name="noticeBbscttUseYn" id="noticeBbscttUseYn" value="Y" />
                        <label for="noticeBbscttUseYnY">사용</label>
                        <input type="radio" name="noticeBbscttUseYn" id="noticeBbscttUseYn" value="N" checked="checked" />
                        <label for="noticeBbscttUseYnN">미사용</label>
                        <valid:msg name="noticeBbscttUseYn" />
                    </td>
                </tr>
                <tr>
                    <th>의견글 사용 여부 <span class="tx_red tx_b">*</span></th>
                    <td>
                        <input type="radio" name="cmtYn" id="cmtYn" value="Y" />
                        <label for="cmtYnY">사용</label>
                        <input type="radio" name="cmtYn" id="cmtYn" value="N" checked="checked" />
                        <label for="cmtYnN">미사용</label>
                        <valid:msg name="cmtYn" />
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <!-- //내용쓰기 -->

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="submit" value="등록" class="w_blue" /></li>
            <li><input type="reset" value="취소" class="w_blue" /></li>
            <li><input type="button" value="목록" class="blue" onclick="jsList();" /></li>
        </ul>
    </div>
    <!-- //버튼 -->

    </form>

</body>
</html>