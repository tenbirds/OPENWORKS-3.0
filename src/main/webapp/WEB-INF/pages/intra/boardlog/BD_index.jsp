<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>게시판 통계</title>
    <op:jsTag type="openworks" items="ui" />

    <script type="text/javascript">
        var logTab;
        /* 공통 초기화 */
        $(document).ready(function(){
            var option = {
                //내용을 표시할 컨테이너는 지정할 수도 있으며 미지정 시 임의로 생성됨.
                tabContainer : "tabContainer",
                //공통 파라미터를 지정할 수 있음.
                baseParam: {
                    domainCd: "${domainCd}",
                    bbsCd: "${bbsCd}",
                    ctgCd: "${ctgCd}"
                }

            };
            
            var domaimCode = "${domainCd}";
            var boardCode = "${bbsCd}";
            
            if(boardCode == 1003){
                $("#boardCtgCds").show();
            }
            
            if(domaimCode != "" && boardCode != "") {
                logTab = $("#bbsLogTabDiv").jsTabUi(option);
            }
            
            //탭이동시 에
            $('a').click(function(e){
                
                var q_domainCd = $("#q_domainCd option:selected").val();
                var boards = $("#boards option:selected").val();
                if(q_domainCd == "" ) {
                    alert("도메인을 선택해주세요");
                    e.preventDefault();
//                  return false;
                }else if(boards == ""){
                    alert("게시판을 선택해주세요");
                    e.preventDefault();
//                  return false;
                }
            });
        });

        //게시판 목록 가져오기
        var jsLoadBbsList = function(){
            var domainCd = $("#q_domainCd").val();
            var boardCode = "${bbsCd}";
            
            if(domainCd == null || domainCd == "") {
                $("select[name='boards']").empty();
                $("select[name='boards']").append('<option value=""> == 게시판 선택 == </option>');
                $("select[name='boardCtgCds']").empty();
                $("select[name='boardCtgCds']").append('<option value=""> == 분류명 선택 == </option>');
            }
            
            $.ajax({
                url: "/intra/boardlog/ND_bbsList.do?",
                type: "GET",
                data: {domainCd:domainCd},
                dataType: "JSON",
                cache: false,
                async: false,
                success: function(datalist) {
                    $("select[name='boards']").empty();
                    $("select[name='boards']").append('<option value=""> == 게시판 선택 == </option>');
                    $("select[name='boardCtgCds']").empty();
                    $("select[name='boardCtgCds']").append('<option value=""> == 분류명 선택 == </option>');
                    if(datalist.length > 0) {
                        for(var i = 0; i < datalist.length; i++) {
                            $("select[name='boards']").append('<option value="'+datalist[i].bbsCd+'">'+datalist[i].bbsNm+'</option>');
                        }
                    }
                }
            });
        };
        
        var jsReloadBbs = function(){
            
            var domainCd = $("#q_domainCd option:selected").val();
            var bbsCd = $("#boards").val();
            var ctgCd = $("#boardCtgCds").val();
            if (domainCd == "") {
                alert("사이트를 선택해 주세요.");
            }
            
            self.location.href = "BD_index.do?domainCd=" + domainCd + "&bbsCd=" + bbsCd+"&ctgCd="+ctgCd;
        };
        
    </script>
    <style>
        .weblog-top{
            padding: 0px 14px 8px 5px;
            margin-bottom: 10px;
            color: #79abe7;
        }
    </style>
</head>

<body>
    <div class="weblog-top" >
        <select id="q_domainCd" name="q_domainCd" onchange="jsLoadBbsList(this);">
            <option value="">== 선택 ==</option>
<%--            <c:choose> --%>
<%--                <c:when test="${auth.kmt_tot_adm == 'Y'}"> --%>
<%--                    <c:forEach items="${domainList}" var="domainList" varStatus="status"> --%>
<%--                        <option value="${domainList.domainCd}"<c:if test="${domainCd eq domainList.domainCd}"> selected="selected"</c:if>>${domainList.domainDesc}</option> --%>
<%--                    </c:forEach> --%>
<%--                </c:when> --%>
<%--                <c:otherwise> --%>
                    <c:forEach items="${domainList}" var="domainList" varStatus="status">
<%--                        <c:if test="${domainList.domainCd eq auth.q_domCd}"> --%>
                            <option value="${domainList.domainCd}"<c:if test="${domainCd eq domainList.domainCd}"> selected="selected"</c:if>>${domainList.domainDesc}</option>
<%--                        </c:if> --%>
                    </c:forEach>
<%--                </c:otherwise> --%>
<%--            </c:choose> --%>
        </select>
        <select id="boards" name="boards" onchange="jsReloadBbs(this);">
            <option value="">== 게시판 선택 ==</option>
            <c:forEach items="${dataList}" var="boardConfVo" varStatus="status">
                <option value="${boardConfVo.bbsCd}"<c:if test="${bbsCd eq boardConfVo.bbsCd}"> selected="selected"</c:if>>${boardConfVo.bbsNm}</option>
            </c:forEach>
        </select>
        
        <select id="boardCtgCds" name="boardCtgCds" style="display: none;" onchange="jsReloadBbs(this);">
            <option value="">== 분류명 선택 ==</option>
            <c:forEach items="${ctgList}" var="boardConfVo" varStatus="status">
                <option value="${boardConfVo.ctgCd}"<c:if test="${ctgCd eq boardConfVo.ctgCd}"> selected="selected"</c:if>>${boardConfVo.ctgNm}</option>
            </c:forEach>
        </select>
        
    </div>
    <div id="bbsLogTabDiv">
        <ul class="tab">
            <li><a href="<c:url value="/intra/boardlog/INC_overviewLog.do" />" class="on">Overview</a></li>
            <li><a href="<c:url value="/intra/boardlog/INC_boardLog.do" />">게시물 통계</a></li>
            <li><a href="<c:url value="/intra/boardlog/INC_fileLog.do" />">첨부파일 통계</a></li>
            <li><a href="<c:url value="/intra/boardlog/INC_cmtLog.do" />">댓글 통계</a></li>
        </ul>
    </div>
</body>
</html>