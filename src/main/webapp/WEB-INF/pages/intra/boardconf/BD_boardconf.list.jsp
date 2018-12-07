<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.utils.StringUtil" %>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>게시판 목록</title>

    <op:jsTag type="spi" items="highlight, colorbox" />
    <op:jsTag type="openworks" items="form, ui, ckeditor" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="/resources/intra/boardconf/boardconf.js"></script>

    <script type="text/javascript">
        /*
         * 공통 초기화 기능
         */
        $(document).ready(function(){

           jsSelected("q_domain_cd", "${param.q_domain_cd}");
           jsSelected("q_searchType", "${param.q_searchType}");
            
              /*   <c:if test="${auth.kmt_eng_pt_mng eq 'Y' || auth.kmt_eng_mob_mng eq 'Y'}">
                boardTypeList();
            </c:if>
            <c:if test="${auth.kmt_chn_pt_mng eq 'Y' || auth.kmt_chn_mob_mng eq 'Y'}">
                boardTypeList();
            </c:if>
            <c:if test="${auth.kmt_jpn_pt_mng eq 'Y' || auth.kmt_jpn_mob_mng eq 'Y'}">
                boardTypeList();
            </c:if> */
            
            <c:if test="${!empty param.q_domain_cd}">
//                 boardTypeList();
                jsSelected("q_bbs_cd", "${param.q_bbs_cd}");
            </c:if>

            //대상 체크박스 전체 선택 및 색상변경
            $("input[name=chk-all]").click(function(){
                var isChecked = this.checked;
                $("input[name=bbsCds]").attr('checked', isChecked);
                if(isChecked){
                    $(":checkbox").parent().parent().addClass("bg_blue");
                    $("tbody tr").each(function (i){
                        $("#bot_" + i).addClass("bg_blue");
                    });
                }else{
                    $(":checkbox").parent().parent().removeClass("bg_blue");
                    $("tbody tr").each(function (i){
                        $("#bot_" + i).removeClass("bg_blue");
                    });
                }
            });

            //대상 체크박스 선택에 따른 색상변경
            $("input[name=bbsCds]").click(function(){
                if($(this).is(":checked")){                 
                    $(this).parent().parent().addClass("bg_blue");
                    var row = $(this).parent().parent().attr("id");
                    $("#bot_" + row).addClass("bg_blue");
                }else{
                    $(this).parent().parent().removeClass("bg_blue");
                    var row = $(this).parent().parent().attr("id");
                    $("#bot_" + row).removeClass("bg_blue");
                }
            });

            //테이블 로우별 하버기능을 사용하지 않는다.
            /*$("tr", "tbody").each(function(i){
                $(this).unbind("mouseover");
                $(this).unbind("mouseout");
            });*/
            
            
            $("#q_domain_cd").bind("change", {}, function() {
                jsSearch();
            });
            
            
        });

        //게시판 관리창
        var jsViewBbs = function(domainCd, bbsCd){
            $("button[name=boardViewBtn]").colorbox({
                title : "게시판",
                href  : "<c:url value='/intra/board/BD_board.list.do?domainCd="+domainCd+"&bbsCd='/>"+bbsCd,
                width : "100%", height:"100%",
                iframe: true
            });
        };

        //게시판 미리보기
        var jsPreviewWeb = function(domainCd, bbsCd) {
            var domain = "";
            var href = "";
            
            <%-- 이전소스 
            if(domainCd == 3) {
                domain = "english";
            } else if(domainCd == 4) {
                domain = "spanish";
            } else {
                domain = "korean";
            }
           
            var port = "<%=request.getServerPort()%>";
            href = "http://" + domain + ".ceart.kr:" + port + "<c:url value='/web/board/BD_board.list.do?domainCd="+domainCd+"&bbsCd='/>"+bbsCd; --%>

            <%--{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
          	  변경소스--%>
            domain = "korean";
            var port = "<%=request.getServerPort()%>";
            href = "http://<%=GlobalConfig.DOMAIN_SUBNM %>"+":" + port + "<c:url value='/web/board/BD_board.list.do?domainCd="+domainCd+"&bbsCd='/>"+bbsCd;
          	<%--}} --%>
            var openNewWindow = window.open("about:blank");
            openNewWindow.location.href = href;
        };

        //게시판 복사
        var jsCopyForm = function(){
            var selectedBbsCds = jsCheckedArray();
            if(selectedBbsCds.length == 0){
                jsWarningBox("복사 대상 게시판을 먼저 선택하세요.");
                return;
            }else if(selectedBbsCds.length > 1){
                jsWarningBox("복사 대상 게시판을 1개만 선택하세요.");
                return;
            }else{
                $("#copyBtn").colorbox({
                    title : "게시판 복사",
                    href  : "PD_boardconf.copy.form.do",
                    width : "600", height:"475", 
                    iframe: true
                });
            }
        };

        //게시판 복사 시 체크 목록
        var jsCheckedArray = function(){
            var selectedBbsCds = new Array();
            $("input[name=bbsCds]:checked").each(function(i){
                selectedBbsCds[i] = $(this).val();
            });

            return selectedBbsCds;
        };

    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();">
        <input type="hidden" name="q_domainCd" id="q_domainCd" value="${domCd}" />
        <input type="hidden" name="q_bbsCd" id="q_bbsCd" />
        <input type="hidden" name="currentPage" id="currentPage" value="${param.currentPage}" />

        <div class="search">
            <fieldset>
                <legend>게시판 검색</legend>
                <label class="skip" for="boardsearch">게시판 검색항목</label>
                
                <table class="boardWrite" cellspacing="0" border="0" summary="사업목록 검색">
                    <caption class="hidden"> 검색 정보 </caption>
                    <colgroup>
                        <col width="10%" />
                        <col width="30%" />
                        <col width="10%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>사이트 구분 </th>
                            <td>
                                <select name="q_domain_cd" id="q_domain_cd" class="over" >
	                                        <option value="">-- 전체 --</option>
	                                        <option value="2" <c:if test="${param.q_domain_cd eq 2 }">selected="selected"</c:if> >한국어사이트</option>
	                                        <option value="3" <c:if test="${param.q_domain_cd eq 3 }">selected="selected"</c:if> >영어사이트</option>
	                                        <option value="4" <c:if test="${param.q_domain_cd eq 4 }">selected="selected"</c:if>>스페인어사이트</option>
<%-- 	                                <c:choose> --%>
<%-- 	                                    <c:when test="${auth.kmt_tot_adm eq 'Y'}"> --%>
<%-- 	                                        <option value="">-- 전체 --</option> --%>
<%-- 	                                        <option value="2" >국문사이트</option> --%>
<%-- 	                                        <option value="3" >영문사이트</option> --%>
<%-- 	                                        <option value="4" >스페인어사이트</option> --%>
<%-- 	                                    </c:when> --%>
<%-- 	                                    <c:when test="${auth.kmt_eng_pt_mng eq 'Y' || auth.kmt_eng_mob_mng eq 'Y'}"> --%>
<%-- 	                                        <option value="2" >영어사이트</option> --%>
<%-- 	                                    </c:when> --%>
<%-- 	                                    <c:when test="${auth.kmt_jpn_pt_mng eq 'Y' || auth.kmt_jpn_mob_mng eq 'Y'}"> --%>
<%-- 	                                        <option value="3" >일본어사이트</option> --%>
<%-- 	                                    </c:when> --%>
<%-- 	                                    <c:when test="${auth.kmt_chn_pt_mng eq 'Y' || auth.kmt_chn_mob_mng eq 'Y'}"> --%>
<%-- 	                                        <option value="4" >중국어사이트</option> --%>
<%-- 	                                    </c:when> --%>
<%-- 	                                </c:choose> --%>
                                 </select>
                            </td>
                            <th>게시판 검색</th>
                            <td>
				                <label class="skip" for="boardsearch">게시판 검색항목</label>
				                <select name="q_searchType" id="q_searchType" class="over">
				                    <option value="">-- 전체 --</option>
				                    <option value="1001">게시판 명</option>
				                </select>
				                <label class="skip" for="searchText">검색단어 입력</label>
				                <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" class="w215" title="검색어를 입력하세요." />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <button type="button" class="gray mar_t10 mar_l5 mar_b5 float_r" onclick="jsSearchReset();">초기화</button>
                <button type="button" class="gray mar_t10 mar_l5 mar_b5 float_r" onclick="jsSearch();">검색</button>
            </fieldset>
        </div>
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam title="게시판 목록" />
    </form>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="기본게시판 목록으로 순번,분류,제목,작성자,작성일,조회 정보를 제공합니다.">
        <caption class="hidden">기본게시판 목록</caption>
        <colgroup>
            <col width="6%" />
            <col width="*%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
<%--             <col width="10%" /> --%>
<%--             <col width="10%" /> --%>
<%--             <col width="10%" /> --%>
        </colgroup>
        <thead>
            <tr>
                <th rowspan="2"><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
                <th rowspan="2"><span class="sort" id="A.BBS_NM">게시판 명</span></th>
                <th><span class="sort" id="A.USE_YN">게시판 사용</span></th>
                <th><span class="sort" id="B.CTG_YN">분류 사용</span></th>
                <th><span class="sort" id="C.FILE_YN">첨부파일 사용</span></th>
<!--                 <th><span class="sort" id="C.CAPTCHA_YN">스팸방지</span></th> -->
<!--                 <th><span class="sort" id="D.RECOMEND_YN">추천기능</span></th> -->
<!--                 <th><span class="sort" id="B.CMT_YN">의견글 사용</span></th> -->
                <th class="lr_none">게시물 관리</th>
            </tr>
            <tr>
                <th><span class="sort" id="B.NOTICE_BBSCTT_AT">공지글 사용</span></th>
                <th><span class="sort" id="C.USER_EDITOR_YN">에디터 사용<br/>(사용자)</span></th>
                <th><span class="sort" id="E.DWLD_YN">목록 다운로드</span></th>
<!--                 <th><span class="sort" id="E.FEED_YN">FEED 사용</span></th> -->
<!--                 <th><span class="sort" id="D.SUE_YN">신고기능</span></th> -->
<!--                 <th><span class="sort" id="D.SATISFY_YN">만족도 사용</span></th> -->
                <th class="lr_none">적용화면보기</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="confVo" varStatus="status">
                <c:set var="style" value="${status.count % 2 == 1 ? 'bg_yellow' : ''}" />
                <c:set var="useYnNm" value="${confVo.useYn == 'Y' ? '사 용' : '미사용'}" />
                <c:set var="ctgYnNm" value="${confVo.ctgYn == 'Y' ? '사 용' : '미사용'}" />
                <c:set var="fileYnNm" value="${confVo.fileYn == 'Y' ? '사 용' : '미사용'}" />
<%--                 <c:set var="captchaYnNm" value="${confVo.captchaYn == 'Y' ? '사 용' : '미사용'}" /> --%>
<%--                 <c:set var="recomendYnNm" value="${confVo.recomendYn == 'Y' ? '사 용' : '미사용'}" /> --%>
<%--                 <c:set var="cmtYnNm" value="${confVo.cmtYn == 'Y' ? '사 용' : '미사용'}" /> --%>
                <c:set var="noticeBbscttUseYnNm" value="${confVo.noticeBbscttUseYn == 'Y' ? '사 용' : '미사용'}" />
                <c:set var="usrEditorYnNm" value="${confVo.userEditorYn == 'Y' ? '사 용' : '미사용'}" />
                <c:set var="dwldYnNm" value="${confVo.dwldYn == 'Y' ? '사 용' : '미사용'}" />
<%--                 <c:set var="feedYnNm" value="${confVo.feedYn == 'Y' ? '사 용' : '미사용'}" /> --%>
<%--                 <c:set var="accuseYnNm" value="${confVo.accuseYn == 'Y' ? '사 용' : '미사용'}" /> --%>
<%--                 <c:set var="stfyYnNm" value="${confVo.stsfdgYn == 'Y' ? '사 용' : '미사용'}" /> --%>

                <tr class="${style}" id="${status.count}">
                    <td rowspan="2"><input type="checkbox" value="${confVo.domainCd}|${confVo.bbsCd}" name="bbsCds" class="checkbox" /></td>
                    <td rowspan="2" class="tx_l">
                        <a href="#" id="${confVo.bbsCd}_bbsNm" onclick="jsUpdateForm('${confVo.domainCd}', '${confVo.bbsCd}'); return false;">${confVo.bbsNm}&lt;${confVo.bbsCd}&gt;</a>
                        <span class="t_article" title="등록글 ${confVo.articleCnt}개">${confVo.articleCnt}</span>
                        <span class="t_file" title="첨부파일 ${confVo.fileCnt}개">${confVo.fileCnt}</span>
<%--                         <span class="t_reply" title="의견글 ${confVo.commentCnt}개">${confVo.commentCnt}</span> --%>
                        <div id="${confVo.bbsCd}_bbsDc" class="td-summary">${confVo.bbsDc}</div>
                    </td>
                    <c:choose>
                        <c:when test="${auth.kmt_tot_adm ne 'Y'}"> <!--  ★★★ 아래모양으로 수정하기 -->
<%--                         <c:when test="${auth.kmt_tot_adm eq 'Y'}"> --%>
                    <td>
                                <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= StringUtil.ZERO %>'); return false;"><span id="useYn" class="${confVo.useYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.useYn}">${useYnNm}</span></a>
                    </td>
                    <td>
                                <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_GLOBAL %>'); return false;"><span id="ctgYn" class="${confVo.ctgYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.ctgYn}">${ctgYnNm}</span></a>
                    </td>
                    <td>
                                <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_FORM %>'); return false;"><span id="fileYn" class="${confVo.fileYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.fileYn}">${fileYnNm}</span></a>
                    </td>
<!--                     <td> -->
<%--                                 <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_FORM %>'); return false;"><span id="captchaYn" class="${confVo.captchaYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.captchaYn}">${captchaYnNm}</span></a> --%>
<!--                     </td> -->
<!--                     <td> -->
<%--                                 <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_VIEW %>'); return false;"><span id="recomendYn" class="${confVo.recomendYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.recomendYn}">${recomendYnNm}</span></a> --%>
<!--                     </td> -->
<!--                     <td> -->
<%--                                 <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_GLOBAL %>'); return false;"><span id="cmtYn" class="${confVo.cmtYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.cmtYn}">${cmtYnNm}</span></a> --%>
<!--                     </td> -->
                        </c:when>
                        <c:otherwise>
                            <td><span id="useYn" class="${confVo.useYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.useYn}">${useYnNm}</span></td>
                            <td><span id="ctgYn" class="${confVo.ctgYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.ctgYn}">${ctgYnNm}</span></td>
                            <td><span id="fileYn" class="${confVo.fileYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.fileYn}">${fileYnNm}</span></td>
<%--                             <td><span id="captchaYn" class="${confVo.captchaYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.captchaYn}">${captchaYnNm}</span></td> --%>
<%--                             <td><span id="recomendYn" class="${confVo.recomendYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.recomendYn}">${recomendYnNm}</span></td> --%>
<%--                             <td><span id="cmtYn" class="${confVo.cmtYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.cmtYn}">${cmtYnNm}</span></td> --%>
                        </c:otherwise>
                    </c:choose>
                    <td class="lr_none"><button type="button" name="boardViewBtn" class="gray" onclick="jsViewBbs('${confVo.domainCd}', '${confVo.bbsCd}');">게시물 관리</button></td>
                </tr>
                <tr class="${style}" id="bot_${status.count}">
                    <c:choose>
                    <c:when test="${auth.kmt_tot_adm ne 'Y'}"> <!--  ★★★ 아래모양으로 수정하기 -->
<%--                         <c:when test="${auth.kmt_tot_adm eq 'Y'}"> --%>
                    <td>
                                <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_GLOBAL %>'); return false;"><span id="noticeBbscttUseYn" class="${confVo.noticeBbscttUseYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.noticeBbscttUseYn}">${noticeBbscttUseYnNm}</span></a>
                    </td>
                    <td>
                                <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_FORM %>'); return false;"><span id="userEditorYn" class="${confVo.userEditorYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.userEditorYn}">${usrEditorYnNm}</span></a>
                    </td>
                    <td>
                                <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_LIST %>'); return false;"><span id="dwldYn" class="${confVo.dwldYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.dwldYn}">${dwldYnNm}</span></a>
                    </td>
<!--                     <td> -->
<%--                                 <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_LIST %>'); return false;"><span id="feedYn" class="${confVo.feedYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.feedYn}">${feedYnNm}</span></a> --%>
<!--                     </td> -->
<!--                     <td> -->
<%--                                 <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_VIEW %>'); return false;"><span id="accuseYn" class="${confVo.accuseYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.accuseYn}">${accuseYnNm}</span></a> --%>
<!--                     </td> -->
<!--                     <td> -->
<%--                                 <a href="#" onclick="jsYnAction(this, '${confVo.domainCd}', '${confVo.bbsCd}', '<%= BoardConfConstant.GUBUN_CD_VIEW %>'); return false;"><span id="stsfdgYn" class="${confVo.stsfdgYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.stsfdgYn}">${stfyYnNm}</span></a> --%>
<!--                     </td> -->
                        </c:when>
                        <c:otherwise>
                            <td><span id="noticeBbscttUseYn" class="${confVo.noticeBbscttUseYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.noticeBbscttUseYn}">${noticeBbscttUseYnNm}</span></td>
                            <td><span id="userEditorYn" class="${confVo.userEditorYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.userEditorYn}">${usrEditorYnNm}</span></td>
                            <td><span id="dwldYn" class="${confVo.dwldYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.dwldYn}">${dwldYnNm}</span></td>
<%--                             <td><span id="feedYn" class="${confVo.feedYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.feedYn}">${feedYnNm}</span></td> --%>
<%--                             <td><span id="accuseYn" class="${confVo.accuseYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.accuseYn}">${accuseYnNm}</span></td> --%>
<%--                             <td><span id="stsfdgYn" class="${confVo.stsfdgYn == 'Y' ? 'icon-use' : 'icon-not-use'}" yn="${confVo.stsfdgYn}">${stfyYnNm}</span></td> --%>
                        </c:otherwise>
                    </c:choose>
                    <td class="lr_none"><button type="button" name="boardViewBtn2" class="gray" onclick="jsPreviewWeb('${confVo.domainCd}', '${confVo.bbsCd}');">적용화면보기</button></td>
                </tr>
            </c:forEach>

            <c:if test="${empty pager.list}">
                <op:no-data obj="${pager}" colspan="6" />
            </c:if>

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <!-- 버튼 -->
    <div>
        <div class="float_l">
<%--             <c:if test="${auth.kmt_tot_adm eq 'Y'}"> --%>
            <button type="button" class="w_blue" onclick="jsDeleteList();">선택삭제</button>
<%--             </c:if> --%>
        </div>
        <div class="float_r">
<%--             <c:if test="${auth.kmt_tot_adm eq 'Y'}"> --%>
            <button type="button" class="w_blue mar_r5" onclick="jsInsertForm();">신규등록</button>
            <button type="button" class="w_blue" id="copyBtn" onclick="jsCopyForm();">게시판복사</button>
<%--             </c:if> --%>
        </div>
    </div>

</body>
</html>