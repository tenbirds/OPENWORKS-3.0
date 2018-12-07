<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>공통코드 관리</title>
    <op:jsTag type="spi" items="jquery, extjs, form, validate" />
    <script type="text/javascript">
    	var BoxListConfig = {
		    //CTG_LIST_URL 	: "INC_ctgList.do?grpCd=${grpCd}",
		    PRV_NM_LIST_URL : "INC_prvNmForCtgCd.do",
		    CTG_LIST_EL 	: "CtgList",
		    PRV_NM_LIST_EL  : "prvNmList",
		    DETAIL_EL   	: "DetailView"
		};

		var ctgListLoad = function (config) {
            var doAjax = function (nodeEls) {
                $("#" + config.CTG_LIST_EL).html('');
                var htmlStr = '<ul>';
                    htmlStr += '<li><a href="#" class="on">실렉터</a></li>';
                for (var i = 0; i < nodeEls.length; i++) {
                    htmlStr += '<li>';
                    htmlStr += '    <a href="#" id="tbListText'+i+'" class="tx_a" ctgCd="'+nodeEls[i].ctgCd+'" langCode="'+nodeEls[i].langCode+'" grpCd="'+nodeEls[i].grpCd+'">'+nodeEls[i].ctgCd+'</a>';
                    htmlStr += '</li>';
                }
                $(htmlStr+'</ul>').appendTo("#" + config.CTG_LIST_EL);

                // 이벤트 생성
                $("#" + config.CTG_LIST_EL + "> ul > li").find('a.tx_a').click(function () {
                    //$(this).addClass('');
                    cdListLoad(config, $(this).attr('langCode'), $(this).attr('grpCd'), $(this).attr('ctgCd'));

                    //수정화면
                    $('#DetailView').load( "INC_ctgUpdateForm.do", {
                        langCode : $("select[name='langCode'] option:selected").val(),
                        grpCd : '${param.grpCd}',
                        ctgCd :  $(this).attr('ctgCd')
                    });
                    $("#ctgIns").show();
                });

                //등록화면
                ctgInsertForm();
            };

            $.ajax({
                type:        "POST",
                url:         "INC_ctgList.do?langCode="+$("select[name='langCode'] option:selected").val()+"&grpCd=${grpCd}",//config.CTG_LIST_URL,
                dataType:    "json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                async:       false,
                success:     function(data) { 
                    doAjax(data);
                },
                error:       function () { 
                    jsErrorBox('정상적으로 처리되지 않았습니다.');
                }
            });
        };

        var cdListLoad = function (config, langCode, grpCd, ctgCd) {
            var doAjax = function (nodeEls) {

                $("#" + config.PRV_NM_LIST_EL).html('');
                var htmlStr = '<ul class="panList">';
                for (var i = 0; i < nodeEls.length; i++) {
                    htmlStr += '<li>';
                    htmlStr += '    <span id="tbListText'+i+'" class="tx_a">'+nodeEls[i].prvNm+'</span>';
                    htmlStr += '</li>';
                }
                $(htmlStr+'</ul>').appendTo("#" + config.PRV_NM_LIST_EL);
                $("#" + config.PRV_NM_LIST_EL).next('p').html('코드 개수 : <span class="tx_b">'+nodeEls.length+'개</span>');
            };

            $.ajax({
                type:        "POST",
                url:         config.PRV_NM_LIST_URL,
                data:        {langCode: langCode, grpCd: grpCd, ctgCd: ctgCd},
                dataType:    "json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                async:       false,
                success:     function(data) { 
                    doAjax(data);
                },
                error:       function () { 
                    jsErrorBox('정상적으로 처리되지 않았습니다.');
                }
            });
        };

        var ctgInsertForm = function(){
            cdListLoad(BoxListConfig, $("select[name='langCode'] option:selected").val(), $("#grpCd").val());
            $('#DetailView').load( "INC_ctgInsertForm.do", {
                langCode : $("select[name='langCode'] option:selected").val(),
                grpCd : '${param.grpCd}'
            },
            function(data) {
            });
            $("#ctgIns").hide();
        };

        $().ready(function () {
            ctgListLoad(BoxListConfig);
        });
        
        var jsLangRefresh = function(){
            ctgListLoad(BoxListConfig);
        }
    </script>
</head>
<body>
    <!-- 언어 목록 -->
    <div class="b_list">
           언어선택 : 
     <select name="langCode" id="langCode" onchange="jsLangRefresh();" class="select">
         <c:forEach items="${langVo}" var="langVo" varStatus="status">
             <option value="${langVo.langCode}" <c:if test="${param.langCode eq langVo.langCode}">selected="selected"</c:if>>${langVo.langNm}</option>
         </c:forEach>
     </select>
    </div>
    <!-- //언어 목록 -->
    <p class="mar_b10">
       <span class="tx_b">[${param.grpNm}(${param.grpCd})]</span> 코드에 대한 실렉터 정보를 관리합니다.<br/>
       등록, 수정화면에서 항목명 우측의 <span class="tx_red_s">*표시</span>는 필수 입력항목입니다.
    </p>
    <!-- 코드실렉터 -->
    <div class="cord_sil">
        <!-- 코드 실렉터 목록-->
        <div class="list_sel">
            <h2>코드 실렉터 목록</h2>
            <div id="CtgList" class="list_tx"></div>
            <div class="cord_2">
                <h3>해당코드</h3>
                <p class="mar_b10">실렉터를 선택하세요.</p>
                <div id="prvNmList" class="panel" style="background-color: white;"></div>
                <p class="mar_t10"></p>
            </div>
            <p id="ctgIns" class="mar_t10 tx_r" style="clear:left; display: none;">
                <a href="#"><button onclick="ctgInsertForm()" class="blue">코드실렉터 등록</button></a>
            </p>
        </div>
        <!-- //코드 실렉터 목록-->
        <div id="DetailView" class="b_write"></div>
    </div>
    <!-- //코드실렉터 -->
    <div style="clear:left;"></div>
</body>
</html>