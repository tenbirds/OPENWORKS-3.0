<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<jsp:useBean id="webEventVO" class="zes.openworks.web.webevent.WebEventVO"/>
<c:set var="userSession" value="${sessionScope['__usk'].userId}"/>
<style>
    .opacity_bg_layer {display:none;position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50); z-index:10;}
    .layer_pop_center {position:fixed;background:lightgray;padding: 10px;z-index:11;}
</style>
<script type="text/javascript">
    $().ready(function(){
        var userid = "<c:out value="${sessionScope['__usk'].userId}"/>";

        if(userid == ""){
            $('#event_cmt_form').css('display','none');
        }else{
            $('#event_cmt_form').css('display','block');
            $('#wrterNcnm_form').css('display','none');
        }
    });

    var jsList = function(){
        location.href = "BD_index.do?q_flag=" + "${dataVo.flag}";
    };

    var jsView = function(eventSn){
        //조회수
        $.post("ND_rcntUpdateAction.do",{eventSn:eventSn},
        function(response){
            try{
                if(eval(response)){
                    post_to_url("BD_eventView.do",{"eventSn":eventSn,"flag":"${dataVo.flag}"});
                }else{
                    alert(Message.msg.processFail);
                }
            }catch(e){
                alert(e);
                return;
            }
        });
    };

    //댓글 등록
    var jsLogin = function(kind, eventSn){
        if(kind == '1'){
            var link =  $(location).attr("pathname");
            var url = "eventSn=" + eventSn + "&flag=" + "${dataVo.flag}";
            location.href = "/${_pathLang}/pt/login/user/BD_index.do?returnUrl=" + link + "&returnParam=" + url + "&returnMethod=post";
        }else{
            $('#event_cmt_form').css('display','block');
            $('#eventCmtCn').focus();
        }
    };

    //댓글 등록
    var jsAnswerInsert = function(eventSn){
        var cn = $("#eventCmtCn").val();
        var wrterNcnm = $("#wrterNcnm").val();
        var wrterPassword = $("#wrterPassword").val();

        if(cn.bytes() <= 5 || cn.bytes() > 2000){
            alert(Message.msg.eventComment);
            return false;
        }

        var userid = "<c:out value="${sessionScope['__usk'].userId}"/>";

        if(userid == ""){
            if($("#wrterNcnm").val().length < 3 || $("#wrterNcnm").val().length > 10){
                alert("닉네임을 3자이상 10자 이하로 작성해주세요.");
                return false;
            };
            if($("#wrterPassword").val().length < 4 || $("#wrterPassword").val().length > 10){
                alert("비밀번호를 4자이상 10자 이하로 작성해주세요.");
                return false;
            };
        }

        var url = "eventCmtCn=" + cn + "&eventSn=" + eventSn + "&wrterNcnm=" + wrterNcnm + "&wrterPassword=" + wrterPassword + "&eventTyCd=" + "${dataVo.eventTyCd}" + "&flag=" + "${dataVo.flag}" + "&q_eventCmtCn=" + cn ;
        post_to_msgReturn("ND_answerInsertAction.do",url);
    };

    // 댓글 수정
    var jsAnswerUpdate = function(index, seq, cn){
        $("#commentRow_" + index).html(jsUpdateDiv(seq, cn));
    };

    var jsUpdateDiv = function(seq, cn){
        var html = "";
        html += "<td colspan='2' style='padding:5px 0;'>";
        html += "   <label>";
        html += "       <textarea id='eventCmtCn_cp' name='eventCmtCn_cp' style='width:650px; height:50px;'>" + cn.replace(/<br />/gi,"\n") + "</textarea>";
        html += "   </label>";
        html += "   <input type='button' class='input' id='' name='' title='수정' value='수정' onclick='jsUpdateAction(" + seq + ")' />";
        html += "   <input type='button' class='input' id='' name='' title='취소' value='취소' onclick='jsCommentCancel()' />";
        html += "</td>";

        return html;
    };

    var jsAnswerUpdate2 = function(index, seq, cn){
        $("#commentRow_" + index).html(jsUpdateDiv2(seq, cn));
    };

    var jsUpdateDiv2 = function(seq, cn){
        var html = "";
        html += "<td>";
        html += "    <span><textarea id='eventCmtCn_cp' name='eventCmtCn_cp' style='width:650px; height:48px; margin:5px 0;'>" + cn.replace(/<br />/gi,"\n") + "</textarea></span>";
        html += "    <div class='write' style='margin:0 0 5px 0;'>";
        html += "        <label for='passwd' style='margin-right:10px;'>비밀번호</label>";
        html += "            <input type='password' id='modPassword' name='modPassword' title='비밀번호를 입력해 주세요.' maxlength='20'/>";
        html += "        </label>";
        html += "    </div>";
        html += "</td>";
        html += "<td class='btn'>";
        html += "    <div class='modify_del'>";
        html += "        <span><a href='javascript:' onclick='jsUpdateAction(" + seq + ")'><b><font color='#000000'>수정</font></b></a></span>";
        html += "        <span><a href='javascript:' onclick='jsCommentCancel()'>취소</a></span>";
        html += "    </div>";
        html += "</td>";
        return html;
    };

    var jsAnswerDelete2 = function(index, seq, cn){
        $("#commentRow_" + index).html(jsDeleteDiv2(seq, cn));
    };

    var jsDeleteDiv2 = function(seq, cn){
        var html = "";
        html += "<td>";
        html += "    <span>" + cn + "</span>";
        html += "    <div class='write' style='margin:10px 0 5px 0;'>";
        html += "        <label for='passwd' style='margin-right:10px;'>비밀번호</label>";
        html += "            <input type='password' id='modPassword' name='modPassword' title='비밀번호를 입력해 주세요.' maxlength='20'/>";
        html += "        </label>";
        html += "    </div>";
        html += "</td>";
        html += "<td class='btn'>";
        html += "    <div class='modify_del'>";
        html += "        <span><a href='javascript:' onclick='jsAnswerDelete(" + seq + ")'><b><font color='#000000'>삭제</font></b></a></span>";
        html += "        <span><a href='javascript:' onclick='jsCommentCancel()'>취소</a></span>";
        html += "    </div>";
        html += "</td>";
        return html;
    };

    var jsUpdateAction = function(seq){
        var cn = $("#eventCmtCn_cp").val();
        var wrterPassword = $("#modPassword").val();
        if(cn.bytes() <= 5 || cn.bytes() > 2000){
            alert(Message.msg.eventComment);
            return false;
        }

        //var para = "?eventCmtSeq=" + seq;
        //para += "&wrterPassword=" + wrterPassword;
        //para += "&eventCmtCn=" + cn;

        //$.post("ND_answerUpdateAction.do" + para,
        $.post("ND_answerUpdateAction.do", {
            eventCmtSeq : seq,
            wrterPassword : wrterPassword,
            eventCmtCn : cn
        },
            function(response){
                try{
                    if(response.status == 0){
                        alert(response.statusMsg);
                        self.location.reload();
                    }else if(response.status == 1001){
                        alert(response.statusMsg);
                    }else{
                        alert(Message.msg.processFail);
                    }
                }catch(e){
                    alert(e);
                    return;
                }
            });
    };

    var jsCommentCancel = function(){
        self.location.reload();
    };

    // 댓글 삭제
    var jsAnswerDelete = function(vl){
        var wrterPassword = $("#modPassword").val();
        if(confirm(Message.msg.eventConf)){
            $.post("ND_answerDeleteAction.do?eventCmtSeq=" + vl + "&wrterPassword=" + wrterPassword,
                function(response){
                    try{
                        if(response.status == 0){
                            alert(response.statusMsg);
                            self.location.reload();
                        }else if(response.status == 1001){
                            alert(response.statusMsg);
                        }else{
                            alert(Message.msg.processFail);
                        }
                    }catch(e){
                        alert(e);
                        return;
                    }
                });
        }
    };

    //글자수체크
    var displayBytes = function (event, nm, id){
        var obj = document.getElementById(id);
        var sRad = "<span class='orange'>";
        var eRad = "</span>";
        var text = "";

        if(obj.value.bytes() > nm){
            text = sRad + eval('dataForm.'+id).value.bytes() + eRad;
        }else{
            text = eval('dataForm.'+id).value.bytes();
        }
        eval('document.all.' + id + '_bytes').innerHTML = text;
    };

    //글자수체크 bytes 계산 속성 추가
    String.prototype.bytes = function(){
        var str = this;
        var size = 0;
        for(var i = 0; i < str.length; i++){
            size += (str.charCodeAt(i) > 128) ? 2 : 1;
        }
        return size;
    };

    function post_to_msgReturn(path, url){
        $.post(path,getUrlToParams(url),
            function(response){
                try{
                    if(response.status == 0){
                        alert(response.statusMsg);
                        self.location.reload();
                    }else if(response.status == 1000){
                        //로그인 페이지로 이동
                        if(confirm(response.statusMsg)){
                            //URL 가져오기
                            var link =  $(location).attr("pathname");
                            location.href = "/${_pathLang}/pt/login/user/BD_index.do?returnUrl=" + link + "&returnParam=" + url + "&returnMethod=post";
                        }
                    }else if(response.status == 1001){
                        //이미 참여한 이벤트
                        alert(response.statusMsg);
                    }
                }catch(e){
                    alert(e);
                    return;
                }
            });
    }

    //Submit 전속 전송 (주소, 파라메터, 메소드)
    function post_to_url(path, params, method){
        method = method || "post"; // Post:Get 전송 기본설정은 Post

        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);

        //예 {"userId":"abcd","mgrId":"abcd"}
        for(var key in params){
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);

            form.appendChild(hiddenField);
        }

        document.body.appendChild(form);
        form.submit();
    }

    function getUrlToParams(url){
        //URL-> JSON 변환
        var hash;
        var myJson = {};
        var hashes = url.slice(url.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            myJson[hash[0]] = hash[1];
        }
        return myJson;
    }

    //팝업////////////////////////////////////////////////////////////////
    /* 불투명 배경 레이어 뛰우기 */
    function opacity_bg_layer(){
        if(!$('.opacity_bg_layer').length){
            $('<div class="opacity_bg_layer"></div>').appendTo($('body'));
        }

        var oj = $(".opacity_bg_layer");

        // 화면의 가로, 세로 알아내기
        var w = $(document).width();
        var h = $(document).height();

        oj.css({'width':w,'height':h}); // 불투명 배경 레이어 크기 설정
        oj.fadeIn(500); // 불투명 배경 레이어 보이기 속도
    }

    /* 레이어 생성
    cls : class
    cont : 내용
    기본 : 숨기기
    */
    function layer_pop_crt(cls, cont) {
        if(!cls) return false;
        if(!$(cls).length) {
            $('<div class="' + cls + '">' + cont + '</div>').appendTo($('body'));
        }

        return true;
    }

    /* 레이어 띄우기
    oj : 레이어 객체
    */
    function layer_pop_center(oj) {
        if(!oj.length) return false;
        oj.layer_pop_center_set();
    }

    /* 레이어 팝업 위치 설정 */
    $.fn.layer_pop_center_set = function () {
        this.css("top", ($(window).height() - $(this).outerHeight())/2);
        this.css("left", ($(window).width() - $(this).outerWidth())/2);
        return this;
    }

    /* 레이어 닫기 후 삭제
    oj : 레이어 객체
    */
    function layer_pop_close(oj) {
        if(oj.length) {
            oj.fadeOut(500, function() {
                oj.remove();
            });
        }else{
            var oj = $('.layer_pop_center');
            oj.fadeOut(500, function() {
                oj.remove();
            });
        }

        // 불투명 배경 레이어 삭제
        var oj = $('.opacity_bg_layer');
        if(oj.length) {
            oj.fadeOut(500, function() {
                oj.remove();
            });
        }
    }

    /* 화면을 불러온 후 처리 */
    $(document).ready(function() {
        var ly = 'layer_pop_center';
        var _ly;
        var ly_bg = $('.opacity_bg_layer');

        $(document).on('click', '.layer_pop_center_show', function() { // 레이어 팝업 띄우기
            if(!ly_bg.length) opacity_bg_layer(); // 불투명 배경 레이어 띄우기
            var str_html = "<img src='/resources/web/theme/default/images/popup/PrivacyUtilizationAgreement.jpg'/>"; // 레이어 팝업 내용

            str_html += "<div class='btn_area'>";
            str_html += "    <div class='btn_c'>";
            str_html += "        <div class='btn_navi'>";
            str_html += "            <a href='#'><span class='confirm'>닫기</span></a>";
            str_html += "        </div>";
            str_html += "    </div>";
            str_html += "</div>";

            if(layer_pop_crt(ly, str_html)) {
                _ly = $('.' + ly); // 레이어 팝업 생성 후 재 선언
                layer_pop_center(_ly);
                _ly.fadeIn(500);
            } else {
                if(ly_bg.length) ly_bg.remove();
            }
        }).on('click', '.layer_pop_center', function(e) { // 레이어 팝업 닫기
            if(_ly.length) layer_pop_close(_ly);
        });
        //}).on('click', '.opacity_bg_layer', function() { // 불투명 배경 레이어를 클릭하면 닫기
        //    layer_pop_close(_ly);
        //}).on('click', '.layer_pop_center', function(e) { // 레이어 팝업 닫기
        //    if(_ly.length) layer_pop_close(_ly);
        //});
    });

    // 브라우저 창 크기 변경에 따른 처리
    $(window).resize(function() {
        var oj = $('.layer_pop_center');
        if(oj.length) layer_pop_center(oj); // 레이어 팝업이 실행된 상태에서만 진행
        if($('.opacity_bg_layer').length) opacity_bg_layer(); // 불투명 배경 레이어가 실행된 상태에서만 진행
    });
    //팝업////////////////////////////////////////////////////////////////

</script>
<form id="dataForm"  method="post">
				<!-- title-area -->
				<div class="title-area">
					<h2>이벤트</h2>
				</div>
				<!-- //title-area -->

				<!-- section -->
				<div class="section side">
					<!-- view -->
					<div class="type-view">
						<dl>
							<fmt:parseDate value='${dataVo.beginDate}' var='beginDate' pattern="yyyy-MM-dd" scope="page"/>
							<fmt:parseDate value='${dataVo.endDate}' var='endDate' pattern="yyyy-MM-dd" scope="page"/>
							<dt>${dataVo.eventTitle}(<fmt:formatDate value="${beginDate}" pattern="MM/dd"/> ~ <fmt:formatDate value="${endDate}" pattern="MM/dd"/>)</dt>
							<dd><strong><c:out value="${dataVo.registDt}"/></strong></dd>
							<dd class="cont">
								<div>${dataVo.eventCn}</div>
							</dd>
							<dd class="prev-next">
								<div class="prev">
									<c:if test="${not empty dataVo.preSeq and not empty dataVo.preTitle}">
										<strong>이전글</strong><a href="javascript:;" onclick="jsView('${dataVo.preSeq}');">${dataVo.preTitle}</a>
				               		</c:if>
				               		<c:if test="${empty dataVo.preSeq and empty dataVo.preTitle}">
				                   		<strong>이전글</strong><a href="javascript:;">이전글이 없습니다.</a>
				               		</c:if>
								</div>
								<div class="next">
									<c:if test="${not empty dataVo.nextSeq and not empty dataVo.nextTitle}">
					                   <strong>다음글</strong><a href="javascript:;" onclick="jsView('${dataVo.nextSeq}');">${dataVo.nextTitle}</a>
					               	</c:if>
					               	<c:if test="${empty dataVo.nextSeq and empty dataVo.nextTitle}">
					                   <strong>다음글</strong><a href="javascript:;">다음글이 없습니다.</a>
					               	</c:if>
								</div>
							</dd>
						</dl>
					</div>
					<!-- //view -->
				</div>
				<!-- //section -->
</form>