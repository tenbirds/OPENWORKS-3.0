<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
    <title>즐겨찾기 관리</title>
    <op:jsTag type="spi" items="form, validate, highlight" />
    <op:jsTag type="openworks" items="form, ui" />
    <style type="text/css">
        .popup-table th{
            border-top: none;
        }
    </style>
    <script type="text/javascript">
    <!--
        $().ready( function() {

            jsChangeSelect();

            $("#iForm").validate({
                rules: {
                    interestDesc: { required:true, minlength:2, maxlength:30 },
                    link:         { required:true, minlength:5, maxlength:200 }
                }
            });

            var doAjax = function (nodeEls) {
                var htmlStr = '';
                for (var i = 0; i < nodeEls.length; i++) {
                    htmlStr += '<option value="'+nodeEls[i]+'">'+nodeEls[i]+'</option>';
                    //console.log(htmlStr);
                }
                $('select[name=category]').each(function () {
                    $(this).append(htmlStr);
                    $(this).val($(this).siblings('input[name=categoryH]').val());
                });
            };

            $.ajax({
                type:        "POST",
                url:         "ND_categoryList.do",
                dataType:    "json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                async:       false,
                success:     function(data) { doAjax(data); },
                error:       function () { alert('정상적으로 처리되지 않았습니다.'); }
            });

        });

        var insertForm = function(el){
            $(el).colorbox({
                title : "즐겨찾기 추가",
                href : "PD_iLinkAddForm.do",
                width : "500",
                height : "300",
                iframe : true
            });
        };

        // 각 데이터를 보기/닫기 토글
        var jsViewDetail = function(vl) {
            var $detailEl = $('#_iLink' + vl);
            if ($detailEl.is(':visible')) {
                $detailEl.find('#_iLinkDiv' + vl).slideUp(250, function () {$detailEl.hide();});
                $detailEl.prev().find('button:contains("닫기")').text('보기');
            } else {
                $detailEl.show();
                $detailEl.find('#_iLinkDiv' + vl).hide().slideDown(250);
                $detailEl.prev().find('button:contains("보기")').text('닫기');
            }
        };

        // 수정액션
        var jsSaveILink = function(vl) {
            if ($("#iForm").valid() == false) return;
            
            if(confirm("수정 하시겠습니까?")){
                
                var $detailEl = $('#_iLink' + vl);
                var categoryVal = $detailEl.find('input[name=newCategory]').val();
                if(!categoryVal) {
                    categoryVal = $detailEl.find('select[name=category] option:selected').val();
                }
                $.ajax({
                    url      : "ND_iLinkInsertAction.do",
                    type     : "POST",
                    data     : {
                        seq           : $detailEl.find('input[name=seq]').val(),
                        category      : categoryVal,
                        interestDesc  : $detailEl.find('input[name=interestDesc]').val(),
                        link          : $detailEl.find('textarea[name=link]').val()
                   },
                    success  : function (response) {
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.updateOk);
                                parent.rightPanel.location.reload();
                                $('#sForm').submit();
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
                        } catch (e) {
                            jsSysErrorBox(response, e);
                            return;
                        }
                    }
                });
            }
        };

        // 게시물 하나삭제
        var jsDelILink = function(vl) {
            var $detailEl = $('#_iLink' + vl);
            
            if(confirm("삭제 하시겠습니까?")){
                $("#iForm").find('input[name=seq]').val($detailEl.find('input[name=seq]').val());

                $.ajax({
                    url      : "ND_iLinkDeleteAction.do",
                    type     : "POST",
                    data     : {seq : $detailEl.find('input[name=seq]').val()},
                    success  : function (response) {
                        if(response) {
                            jsSuccessBox(Message.msg.deleteOk);
                            parent.rightPanel.location.reload();
                            $('#sForm').submit();
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    }
                });
            }
        };

        // 카테고리 변경 이벤트
        var jsChangeCategory = function (el) {
            if ($(el).val() == '신규') {
                $(el).next().show();
            } else {
                $(el).next().hide();
            }
        };
        
        var jsChangeSelect = function(){
            if($('#q_searchKey').val() == ""){
                $('#q_searchText').attr("disabled", true);
                $("#q_searchText").val("");
            } else if($("#q_searchKey").val() != ""){
                $("#q_searchText").attr('disabled',false);
                
            }
        };

        var jsMovePage = function (page) {
            var p = 1;
            if (page == 'page') {
                p = $('input[name=page]').val();
            } else {
                p = page;
            }
            $('#sForm input[name=q_currPage]').val(p);
            $('#sForm').submit();
        };
    //-->
    </script>

</head>

<body>
    <form id="sForm" method="post">

    <div class="search">
        <fieldset>
            <legend>검색하세요</legend>
            <select name="q_searchKey" id="q_searchKey" class="over" onchange="jsChangeSelect();">
                <option value="">-- 선택 --</option>
                <option value="1001" <c:if test="${param.q_searchKey eq '1001'}">selected="selected"</c:if>>제목</option>
            </select>
            <input type="text" name="q_searchText" id="q_searchText" class="w215"
                   value="${param.q_searchText}" title="검색어를 입력하세요." />
            <button class="gray mar_l5">검색</button>
        </fieldset>
    </div>
    <!-- //검색 -->
    <op:pagerParam title="목록" />
    <%-- <div class="po_rel">
        <h4>검색결과 <span class="tx_normal">총 <em class="tx_blue">${pager.totalNum}</em>건 검색</span></h4>
        <fieldset class="h4_r">
            <legend>페이지당 목록갯수 선택</legend>
            <label>페이지당 목록</label>
            <op:rpp-tag rpp="<c:out value="${param.q_rpp}" default="10"/>" />
        </fieldset>
    </div> --%>
    </form>

    <form id="iForm">
<!--     <input type="hidden" name="seq" /> -->
<!--     <input type="hidden" name="category" /> -->
<!--     <input type="hidden" name="interestDesc" /> -->
<!--     <input type="hidden" name="link" /> -->
    

    <!-- 목록 테이블 -->
    <table class="boardList" summary="게시물 목록을 표시" >
        <colgroup>
            <!--col width="5%" /-->
            <col width="50" />
            <col width="150" />
            <col width="*" />
            <col width="100" />
            <col width="140" />
            <col width="120" />
        </colgroup>

        <thead>
            <tr>
                <!--th><input type="checkbox" id="checkAll" class="checkbox" /></th-->
                <th>순번</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>사용자</th>
                <th>등록일</th>
                <th class="lr_none">관리</th>
            </tr>
        </thead>

        <tbody>
        <c:set var="index" value="${pager.indexNo}" />
        <c:forEach items="${pager.list}" var="linkBean" varStatus="status">
            <tr <c:if test="${(index-status.index)%2==0}">class="bg_yellow"</c:if>>
                <!--td>
                    <input type="checkbox" name="seqs" value="${linkBean.seq}" class="checkbox" />
                </td-->
                <td>${pager.indexNo - status.index}</td>
                <td>${linkBean.category}</td>
                <td class="tx_l"><a href="#" onclick="jsViewDetail('${linkBean.seq}'); return false;">${linkBean.interestDesc}</a></td>
                <td>${linkBean.virKey}</td>
                <td>${linkBean.regDt}</td>
                <td class="lr_none">
                    <a href="#" class="btn" onclick="jsViewDetail('${linkBean.seq}');"><button type="button" class="s_blue">보기</button></a>
                    <a href="#" class="btn" onclick="jsDelILink('${linkBean.seq}');"><button type="button" class="s_blue">삭제</button></a>
                </td>

            </tr>
            <tr id="_iLink${linkBean.seq}" class="bg_dark_red" style="display: none;">
                <td colspan="6" class="lr_none">

                    <div id="_iLinkDiv${linkBean.seq}">
                        <table class="table_dark_red mar_t10">
                            <colgroup>
                                <col width="12%" />
                                <col width="" />
                            </colgroup>
                            <tbody>
                                <tr>
                                <!-- 
                                    <th>ID</th>
                                    <td class="lr_none"><input type="text" name="seq" value="${linkBean.seq}" readonly="readonly" /></td>
                                -->
                                    <th>카테고리</th>
                                    <td class="lr_none">
                                        <input type="hidden" name="seq" value="${linkBean.seq}" />
                                        <input type="hidden" name="categoryH"  id="categoryH" value="${linkBean.category}" />
                                        <select name="category" onchange="jsChangeCategory(this);">
                                            <option value="">카테고리 선택</option>
                                            <option value="신규">신규</option>
                                        </select>
                                        <span style="display: none;" ><input type="text" name="newCategory" /></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>제목</th>
                                    <td class="lr_none"><input type="text" name="interestDesc" maxlength="30" style="width:99%" value="${linkBean.interestDesc}" /></td>
                                </tr>
                                <tr>
                                    <th>링크</th>
                                    <td class="lr_none"><textarea name="link" rows="3" cols="80" style="width:99%;">${linkBean.link}</textarea></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="tx_r mar_t10 mar_b10">
                            <button type="button" class="blue" onclick="jsSaveILink('${linkBean.seq}');">수정</button>
                            <button type="button" class="blue" onclick="jsViewDetail('${linkBean.seq}');">닫기</button>
                        </div>
                    </div>

                </td>
            </tr>
        </c:forEach>
        <op:no-data obj="${pager}" colspan="6" />
        </tbody>
    </table>
    </form>
    <!-- 게시판 목록 끝 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <!-- 버튼 -->
    <div class="tx_l mar_t10 mar_b20">
        <a href="#" class="btn"><button type="button" onclick="insertForm();" class="blue">등록</button></a>
        <!--a href="#" class="btn" onclick="jsDelList();"><button type="button" class="blue">삭제</button></a-->
    </div>
</body>
</html>