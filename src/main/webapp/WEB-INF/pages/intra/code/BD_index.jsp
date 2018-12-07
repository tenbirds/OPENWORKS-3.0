<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>공통코드 관리</title>
    <op:jsTag type="spi" items="form,validate" />
    <script type="text/javascript">

    var rootId = '<%=zes.openworks.common.GlobalConfig.HIGH_TREE_CD%>';
    var DETAIL_URL = "INC_codeView.do";
    var BoxListConfig = {
        GR_LIST_URL : "INC_grList.do",
        CD_LIST_URL : "INC_cdList.do",
        DETAIL_URL  : "INC_codeView.do",
        GR_LIST_EL  : "GroupList",
        CD_LIST_EL  : "CodeList",
        DETAIL_EL   : "DetailView"
    };

    var grListLoad = function (config, langCode) {
        var doAjax = function (nodeEls) {

            $("#" + BoxListConfig.GR_LIST_EL).html('');
            var htmlStr = '<ul class="panList">';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<li id="tbListTextA'+i+'">';
                htmlStr += '    <a href="#"><span onclick="classOnA('+i+')" id="tbListText'+i+'" class="tx_b" langCode="'+nodeEls[i].langCode+'" grpCd="'+nodeEls[i].grpCd+'">'+nodeEls[i].grpNm+'</span></a>';
                htmlStr += '</li>';
            }
            $(htmlStr+'</ul>').appendTo("#" + config.GR_LIST_EL);
            $("#" + config.GR_LIST_EL).next('p').html('코드그룹 개수 : <span class="tx_b">'+nodeEls.length+'개</span>');


            // 이벤트 생성
            $("#" + config.GR_LIST_EL + "> ul > li").find('span.tx_b').click(function () {
                cdListLoad(config, $(this).attr('langCode'), $(this).attr('grpCd'));
                $("#" + config.DETAIL_EL).load(config.DETAIL_URL, {
               		    langCode : $(this).attr('langCode'), grpCd : $(this).attr('grpCd')
               		}, function(result) {
                });
            });
        };

		if(langCode == "undefined" || langCode == ""){
		    langCode = "00"; 
		}
		
        $.ajax({
            type:        "POST",
            url:         config.GR_LIST_URL,
            data: 		 {langCode:langCode},
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

    var cdListLoad = function (config, langCode, grpCd) {
        var doAjax = function (nodeEls) {

            $("#" + config.CD_LIST_EL).html('');
            var htmlStr = '<ul class="panList">';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<li id="tbListTextB'+i+'">';
                htmlStr += '    <a href="#"><span onclick="classOnB('+i+')" id="tbListText'+i+'" class="tx_b" prvCd="'+nodeEls[i].prvCd+'">'+nodeEls[i].prvNm+'</span></a>';
                htmlStr += '</li>';
            }
            $(htmlStr+'</ul>').appendTo("#" + config.CD_LIST_EL);
            $("#" + config.CD_LIST_EL).next('p').html('코드 개수 : <span class="tx_b">'+nodeEls.length+'개</span>');

            // 이벤트 생성
            $("#" + config.CD_LIST_EL + "> ul > li").find('span.tx_b').click(function () {
                $("#" + config.DETAIL_EL).load(config.DETAIL_URL
               	, {
               	    langCode : langCode, grpCd : grpCd, prvCd : $(this).attr('prvCd')
               	}
               	, function(result) {

               	});
            });
            //$("#jsExcelInsert").show();
        };
		
        $.ajax({
            type:        "POST",
            url:         config.CD_LIST_URL,
            data:        {langCode : langCode, grpCd: grpCd},
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
    
    var classOnA = function(no){
    	$("li[id^=tbListTextA").attr("style", "");
    	$("#tbListTextA"+no).attr("style", "font-weight:bold; background-color:#bdcae2;");
    }
    var classOnB = function(no){
    	$("li[id^=tbListTextB").attr("style", "");
    	$("#tbListTextB"+no).attr("style", "font-weight:bold; background-color:#bdcae2;");
    }

    var grpInsertForm = function() {
        var params = {};
        $("#DetailView").load( DETAIL_URL, params, function(result) {
        });
    };

      //코드 수정버튼 클릭 시
    var notCodeReadOnly = function() {
        document.codeForm.grpCd.readOnly = false;
        $('input[name=grpFlag]').val('N');
        document.codeForm.grpCd.focus();
        return;
    };
    var notPrvCodeInsReadOnly = function() {
        document.prvAddForm.prvCd.readOnly = false;
        $('input[name=grpFlag]').val('N');
        document.prvAddForm.prvCd.focus();
        return;
    };
    var notPrvCodeUdtReadOnly = function() {
        document.codeForm.prvCd.readOnly = false;
        $('input[name=grpFlag]').val('N');
        document.codeForm.prvCd.focus();
        return;
    };

      //개별코드 정보 슬라이드
    var prvCdDataSlide = function(){
        $("#prvAddForm").slideToggle("slow");
        $("#prvNm").focus();
    };

    $().ready(function () {
        $("#prvCdInsBtn").hide();
        //$("#jsExcelInsert").hide();

        grListLoad(BoxListConfig);

       	//코드목록 reload
        $("#grpReload").bind("click", BoxListConfig, function (e) {
            grListLoad(e.data, $("select[name='langList'] option:selected").val());
        });
        $("#prvReload").bind("click", BoxListConfig, function (e) {
            cdListLoad(e.data, $("select[name='langList'] option:selected").val(), $("#grpCd").val());
        });

        //전체코드 목록 창
        $("#totalCodeList").colorbox({
            title : '전체코드 목록',
            href  : "PD_totalCodeList.do",
            width : "850", height:"550",
            iframe: true
        });

        //전체코드 목록 창
        $("#jsExcelView").click(function() {
            if ($('#excelFr').length == 0) {
                $('body').append('<iframe id="excelFr" style="display: none;"/>');
            }

            var url = 'INC_codeListExcel.do';
            $('#excelFr').attr('src',url);
        });
    });
    
    //엑셀일괄등록
    var jsRegisterExcelEnBloc = function(){
        $("#jsExcelInsert").colorbox({
            title  : "엑셀일괄등록",
            href   : "PD_regExcelEnBloc.do",
            width  : "700" ,
            height : "400" ,
            iframe : true
        });
    };

    var jsLangRefresh = function(langCode) {
        var config = BoxListConfig;
        var doAjax = function (nodeEls) {

            $("#" + BoxListConfig.GR_LIST_EL).html('');
            var htmlStr = '<ul class="panList">';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<li id="tbListTextA'+i+'">';
                htmlStr += '    <a href="#"><span onclick="classOnA('+i+')" id="tbListText'+i+'" class="tx_b" langCode="'+nodeEls[i].langCode+'" grpCd="'+nodeEls[i].grpCd+'">'+nodeEls[i].grpNm+'</span></a>';
                htmlStr += '</li>';
            }
            $(htmlStr+'</ul>').appendTo("#" + config.GR_LIST_EL);
            $("#" + config.GR_LIST_EL).next('p').html('코드그룹 개수 : <span class="tx_b">'+nodeEls.length+'개</span>');


            // 이벤트 생성
            $("#" + config.GR_LIST_EL + "> ul > li").find('span.tx_b').click(function () {
                cdListLoad(config, $(this).attr('langCode'), $(this).attr('grpCd'));
                $("#" + config.DETAIL_EL).load(config.DETAIL_URL, {
               		    langCode : $(this).attr('langCode'), grpCd : $(this).attr('grpCd')
               		}, function(result) {
                });
            });
        };

        $.ajax({
            type:        "POST",
            url:         config.GR_LIST_URL,
            data: {langCode : langCode},
            dataType:    "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async:       false,
            success:     function(data) { 
                doAjax(data);
           	}, error:       function () { 
           	    jsErrorBox('정상적으로 처리되지 않았습니다.');
         	}
        });
    };
    </script>
</head>

<body>

	    <!-- 검색 -->
	    <div class="h_30">
	        <div class="float_r">
	            <a href="#"><button type="button" onclick="grpInsertForm();" class="w_blue">그룹코드 등록</button></a>
	            <a href="#"><button type="button" id="totalCodeList" class="w_blue">전체코드 목록</button></a>
	            <a href="#"><button type="button" id="jsExcelInsert" class="w_blue" onclick="jsRegisterExcelEnBloc();">개별코드 엑셀일괄등록</button></a>
	            <a href="#"><button type="button" id="jsExcelView" class="w_blue">엑셀로 출력하기</button></a>
	        </div>
	    </div>
	    <!-- //검색 -->
		<!-- 언어 목록 -->
		<input type="hidden" name="langList" id="langList" value="00"/>
        <%-- 
        <div class="b_list">
               언어선택 : 
	        <select name="langList" id="langList" onchange="jsLangRefresh(this.value);" class="select">
	            <c:forEach items="${langVo}" var="langVo" varStatus="status">
	                <option value="${langVo.langCode}" <c:if test="${param.langCode eq langVo.langCode}">selected="selected"</c:if>>${langVo.langNm}</option>
	            </c:forEach>
	        </select>
        </div>
         --%>
        <!-- //언어 목록 -->
	    <!-- 그룹코드-->
	    <div class="cord">
	        <!-- 그룹코드 목록 -->
	        <div class="b_list">
	            <div class="tree_tit">그룹코드 목록
	                <a href="#">
	                    <img id="grpReload" src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침" />
	                </a>
	            </div>
	            <div class="panel" id="GroupList" style="height:400px;"></div>
	            <p class="tree_num"></p>
	        </div>
	        <!-- //그룹코드 목록 -->
	
	        <!-- 해당코드 목록 -->
	        <div class="b_list">
	            <div class="tree_tit">해당코드 목록
	                <a href="#">
	                    <img id="prvReload" src="<c:url value="/resources/openworks/theme/default/images/btn/btn_refresh.gif" />" alt="새로고침" />
	                </a>
	            </div>
	            <div class="panel" id="CodeList" style="height:400px;">그룹코드를 선택하세요</div>
	            <p class="tree_num"></p>
                <p id="prvCdInsBtn" class="mar_t10 tx_r"><a href="#"><button type="button" onclick="prvCdDataSlide();" class="blue">개별코드 등록</button></a></p>
                <br/><br/><br/><br/>
	        </div>
	        <!-- //해당코드 목록 -->
	
	        <div id="DetailView">
	            <h4 class="tx_13">그룹코드 종합정보</h4>
	            <p class="gray_box">그룹코드를 선택하세요.</p>
	        </div>
	    </div>
	    <!--그룹코드-->

</body>
</html>
