<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="zes.openworks.web.store.StoreincVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:scriptlet>
pageContext.setAttribute("newLineChar", "\n");
</jsp:scriptlet>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />
<jsp:scriptlet>
pageContext.setAttribute("newLineChar", "\n");
</jsp:scriptlet>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>서비스평</title>
<op:jsTag type="openworks" items="store-core" />
<op:jsTag type="spi" items="form" />
<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
<script type="text/javascript">

    
    var jsInsertAction = function(){

        <c:if test="${empty sessionScope['__usk']}">
        var url = window.parent.location;
        var  goodsTyCd= "";
        if(url.toString().indexOf("goodsTyCd=1002") > 0){
            goodsTyCd = "goodsTyCd=1002";
        }else if(url.toString().indexOf("goodsTyCd=1001") > 0){
            goodsTyCd = "goodsTyCd=1001";
        }else if(url.toString().indexOf("goodsTyCd=1003") > 0){
            goodsTyCd = "goodsTyCd=1003";
        }
        
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
                    + "?returnUrl=/korean/pt/store/software/BD_view.do&amp;returnParam=goodsCode=${searchMap.goodsCode}&"+goodsTyCd;

        }
        </c:if>
         
        
        <c:if test="${not empty sessionScope['__usk']}">
        var cn = $("#evlSntnc").val();
        
        if(5 > cn.length || cn.length > 300){
            
            alert(Message.msg.incCommentStringMin);
            return false;
        }
        
        $("#dataForm").ajaxSubmit({
            url : "../inc/ND_incCommentInsertAction.do",
            type : "POST",
            dataType : "text",
            //data : {},
            success : function(response){
                try {
                    if(response == "<%=StoreincVO.MSG.LOGIN_FAIL%>"){
                        if(confirm(Message.msg.userLoginCheck)){
                            parent.location.href = Config.url.userLogin;
                        }
                    }else if(response == "<%=StoreincVO.MSG.INSERT_CHK%>"){
                        alert(Message.msg.incCommentChk);
                    }else if(response == "<%=StoreincVO.MSG.INSERT_OK%>"){
                        alert(Message.msg.incCommentInsertOk);
                        self.location.reload();
                    }else{
                        alert(Message.msg.processFail);
                    }
                } catch (e) {
                    alert(e);
                    return;
                }
            }
        });
        </c:if>
        
    };
    
    var jsUpdateForm = function(index,evlSeq,evlSntnc){
       
        var view = jsUpdateDiv(index, evlSeq,evlSntnc);       
        $("#commentRow_" + index).html(view);
        
    };
    
    var jsUpdateAction = function(evlSeq){
        
        var cn = $("#evlSntnc_cp").val();
        if(5 > cn.length || cn.length > 300){
            alert(Message.msg.incCommentStringMin);
            return false;
        }
        
        var para = "?goodsEvlSeq=" + evlSeq ;
       // para += "&evlScore=" + $("#evlScore_cp").val();
        para += "&evlScore=0";
        para += "&evlSntnc=" + encodeURIComponent(cn);
        
        $.post("../inc/ND_incCommentUpdateAction.do" + para,
            function(response){
                try {
                    if(response == "<%=StoreincVO.MSG.UPDATE_OK%>"){
                        alert(Message.msg.incCmmentUpdateOk);
                        self.location.reload();
                    }else{
                        alert(Message.msg.processFail);
                    }
                } catch (e) {
                    alert(e);
                    return;
                }
            });
    };
    
    var jsCommentCancel = function(){
        self.location.reload();
    };

    var jsUpdateDiv = function(index, evlSeq,evlSntnc){
        
        var html = "<td >"+index;
     /*   html += "<div class=''>";
        html += "<p>평가</p>"
        html += "   <div class=''>";
        html += "       <select id='evlScore_cp' name='evlScore_cp' title='평점 선택' style='width:124px; font-size:15px;'>";
        html += "           <option value='1' " + ((evlScore ==1) ? "selected='selected'" : "") + " >★☆☆☆☆</option>";
        html += "           <option value='2' " + ((evlScore ==2) ? "selected='selected'" : "") + ">★★☆☆☆</option>";
        html += "           <option value='3' " + ((evlScore ==3) ? "selected='selected'" : "") + ">★★★☆☆</option>";
        html += "           <option value='4' " + ((evlScore ==4) ? "selected='selected'" : "") + ">★★★★☆</option>";
        html += "           <option value='5' " + ((evlScore ==5) ? "selected='selected'" : "") + ">★★★★★</option>";
        html += "       </select>";
        html += "   </div>";
        html += "</div>";
        */
        html += "</td>";
        html += "<td>";
        html += "   <label>";
        html += "       <textarea id='evlSntnc_cp' name='evlSntnc_cp'  style='width:650px; height:50px;'>" + evlSntnc.replace(/<br>/gi,"\n") + "</textarea>";
        html += "   </label>";
        html += "</td>";
        html += "<td>";
        html += "   <input type='button' class='s-btn mr10 type3' id='' name='' title='수정' value='수정' onclick='jsUpdateAction(" + evlSeq + ")' />";
        html += "   <input type='button' class='type1' id='' name='' title='취소' value='취소' onclick='jsCommentCancel()' />";
        html += "</div>";
        
        html += "</td>";
            
            
        return html;
    };
    
    
    var jsDeleteAction = function(evlSeq){
        if(confirm(Message.msg.incCommentDel)){

            $.post("../inc/ND_incCommentDeleteAction.do?goodsEvlSeq=" + evlSeq,
            function(response){
                try {
                    if(response == "<%=StoreincVO.MSG.DELETE_OK%>"){
                        alert(Message.msg.incCommentDeleteOk);
                        self.location.reload();
                    }else{
                        alert(Message.msg.processFail);
                    }
                } catch (e) {
                    alert(e);
                    return;
                }
            }); 
            
        }
    };

    //페이지 이동
    var jsMovePageComment = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }        
        $("#dataForm #q_currPageComment").val(p);        
        $("#dataForm").submit();
    };
     
    //글자수체크
    var displayBytes  = function (event, nm, id){
        var obj  = document.getElementById( id );
        var sRad = "<span class='orange'>";
        var eRad = "</span>";
        var text = "";
        
            if (obj.value.bytes() > nm){
                    text = sRad + eval('dataForm.'+id).value.bytes() + eRad;
            }else{
                text = eval('dataForm.'+id).value.bytes();
            }
            eval('document.all.'+id+'_bytes').innerHTML = text;
    };
    
    //글자수체크 bytes 계산 속성 추가
    String.prototype.bytes = function(){
        var str = this;
        var size = 0;
        for (var i=0; i<str.length; i++){
            size += (str.charCodeAt(i) > 128) ? 2 : 1;
        }
        return size;
    };


</script>
</head>
<body>
<!-- layer popup -->
<div class="layer-pop">
	<div class="pop-cont blue">
  	<jsp:include page="INC_TABMENU.jsp" flush="true"></jsp:include>
	
      <form name="dataForm" id="dataForm" method="post" action="BD_view.do">
        <input type="hidden" id="userId" name="userId" value="${searchMap.userId}" /> 
        <input type="hidden" id="langCode" name="langCode" value="${searchMap.langCode}" /> 
        <input type="hidden" id="goodsCode" name="goodsCode" value="${searchMap.goodsCode}" />
        
     <div class="pop-detail">          
         
          
         <!-- btn-area -->
			<div class="register_form">
				<label> <textarea name="evlSntnc" id="evlSntnc" style="width: 750px;" onkeyup="javascript:displayBytes(event,300,'evlSntnc');" onblur="javascript:displayBytes(event,300,'evlSntnc');"></textarea></label>
				<input name="register" title="등록" class="btn_register" id="register" style="float: right;" onclick="jsInsertAction();" type="button">
				<div class="byte">
					<span id="evlSntnc_bytes">0</span> / 300 Byte
				</div>
			</div>
			<!-- //btn-area -->
			
          <!-- op:pagerParam page="param/webListPagerParam.jsp" / -->
          
          <!-- section -->
			<div class="section">
				<!-- list -->
				<div class="type-list">
				 <table>
						<caption>리스트</caption>
						<colgroup>
						<col style="width:10%;"/>
						<col style="width:*;"/>
						<col style="width:15%;"/>
						<!-- <col style="width:15%;"/> -->
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th></th>
								<!-- <th>작성일자</th> -->
							</tr>
						</thead>
		
			            <tbody>
			              <c:set var="index" value="${pager.indexNo}" />
			              <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
			                 <tr id="commentRow_${pager.indexNo}">
								<td>${pager.indexNo}</td>
								<td class="title">${fn:replace(baseVo.evlSntnc, newLineChar, ' <br/>')}<span class="caption ml10"><c:out value="${baseVo.registId}" />, <c:out value="${baseVo.registDt}" /></span></td>
								
								<td> <c:if test="${userSession eq baseVo.orgRegistId}">
								<a href="javascript:;" onclick="jsUpdateForm(${pager.indexNo},<c:out value='${baseVo.goodsEvlSeq}' />,'${fn:replace(baseVo.evlSntnc, newLineChar, '<br>')}');" class="s-btn mr10 type3"><strong><span>수정</span></strong></a>
								<a href="javascript:;" onclick="jsDeleteAction(<c:out value='${baseVo.goodsEvlSeq}' />)" class="s-btn type1"><strong><span>삭제</span></strong></a> </c:if></td>
								
							</tr>
							
			              
			              </c:forEach>
			            </tbody>
          			</table>
          			</div>	
          			<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePageComment" />
          		</div>
			<!-- //section -->

		</div>
		<!-- //pop-detail -->
	</div>
</div>
<!-- //layer popup -->

</body>
</html>