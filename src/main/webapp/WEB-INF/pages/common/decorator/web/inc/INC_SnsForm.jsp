<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="zes.base.support.OpHelper"%>
<%@ page import="zes.openworks.web.login.UserLoginVO"%>
<%@ page import="zes.core.utils.Converter"%>


<%
String fullUrl = request.getRequestURL().toString();
String menuUrl = request.getRequestURI().toString();

UserLoginVO userLogin = OpHelper.getUserSession(request);

String cur_userId  = "";

if(userLogin == null)	cur_userId = "guest";
else                    cur_userId = userLogin.getUserId(); 

int i = 0;

Enumeration eParam = request.getParameterNames();

while (eParam.hasMoreElements()) {
 String pName = (String)eParam.nextElement();
 String pValue = request.getParameter(pName);
	
  	if(!pValue.equals(""))
  	{
 
		i += 1;
	 
		if( i == 1)
		{
			 menuUrl += "?";
			 fullUrl += "?";
			 
		}
		else
		{
			menuUrl += "&"; 
			fullUrl += "&";
		}
	 
		menuUrl += pName+"="+pValue;
		fullUrl += pName+"="+pValue;
  	}
}
%>

<c:if test="${cmsVo.snsUseYn eq 'Y'}">


<input type="hidden" id="domain" name='domain' value='${cmsVo.domainCd}' />
<input type="hidden" id="menucd" name='menucd' value='${cmsVo.menuCode}' />
<%-- <input type="hidden" id="menuurl" name='menuurl' value='${cmsVo.userMenuUrl}' /> --%>
<input type="hidden" id="menuurl" name='menuurl' value='<%=Converter.XSS(menuUrl) %>' />


<script type="text/javascript">
    //<![CDATA[
      
    var cuuentSns  = "";
    var cur_userId = '<%=cur_userId %>';
    var uFormUse   = 'N';
    var rFormUse   = 'N';
    var shortUrl   =  "";
    var fullUrl    = '<%=fullUrl %>';
    var firstSeq   = "";
    var snsTwitter  = 0;
    var snsFacebook = 0;
    $().ready(function() {
        
        
        //댓글 리스트
        $.ajax({
            url     : "/web/snsopinion/ND_opinionSearch.do",            
            type    : "POST",
            data : {
		                domain_cd : $('#domain').val(),
		                menu_code : $('#menucd').val(),
		                page_url  : $('#menuurl').val()
                   },
            dataType: "json",          
            async   : false,
            success : function(data) {
             	                
             	var opinion = "";
             	
             	$.each(data, function(idx, val){             	                 	    
             	    
             	   //단축url
             	   if(idx == 0){
             	       shortUrl = val.shorten_url;
             	       firstSeq = val.seq;  
             	   }
             	   
             	   //count
             	   if(data.length == val.cnt)  $('#cnt').html(val.cnt);
             	  
             	   
             	   //덧글생성
             	   if(val.depth > 1)
             	   {
             	       opinion += '<li id="seq'+val.seq+'" class="reply_'+val.depth+'" >';
             	       opinion += '<div class="comment_cont">';

             	   }
             	   else
             	   {
             	      opinion += '<li id="seq'+val.seq+'">';
             	   }	      	    
             	               	   
             	   opinion += '<span class="name"  id="name'+val.cnt+'" >'+ val.reg_id +'</span>';
             	   opinion += '<span class="date">('+ val.reg_dt +')</span>';
             	   opinion += '<p class="re_tx" id="re_tx'+val.seq+'">';
             	   
             	   if(val.del_yn == 'A')		opinion += "관리자에 의해 된 댓글입니다";
             	   else if(val.del_yn == 'Y')	opinion += "사용자에 의해 된 댓글입니다";
             	   else 						opinion += val.contents ;
             	   
             	   opinion += '</p>';
             	   
             	   
             	   opinion += '<span class="c_edit">';
             	   opinion += '<a href="JavaScript:jsUpdateForm('+val.depth+','+val.seq+',1);">답글</a>';
             	   
             	   if(val.reg_id == cur_userId){             	      
             	      opinion += ' ㅣ <a href="JavaScript:jsUpdateForm('+val.depth+','+val.seq+',2);" >수정</a>';
             	             
             	      opinion += ' ㅣ <a id="delbut'+val.seq+'"  href="JavaScript:jsDelete('+val.seq+', 3);" >삭제</a>';
             	      opinion += '<input type="hidden" id="pseq'+val.seq+'" class="parSeq" value="'+val.p_seq+'" />';             	     
             	   }             	                	   
             	   
             	   opinion += ' ㅣ <a id="report"  href="JavaScript:jsReport('+val.seq+', 4);"  >신고</a>';
             	                	   
               	   opinion += '</span>';
               	
               	   if(val.depth > 1)
	           	   {   
	           	       opinion += '</div>';
	           	   }
               	   
               	   opinion += '</li>';               	
               	
             	});
             	
             	$('.comment_ul').append(opinion);
             	
             	
             	$.each(data, function(idx, val){      
             	    
             		if(val.isleaf != 1 ) $("#delbut"+val.seq).hide();
             	});
             	
             	
             	//단축url
             	if(shortUrl == "" || shortUrl == null)	getBitlyShort(fullUrl);
            }
        });
        
                
        //재인증 관련
          $.ajax({
              url     : "/web/snsopinion/againLogin.do",            
              type    : "POST",              
              async   : false,
              success : function(data) {
              
	               	$.each(data, function(idx, val){
	               	    	               	    
	               	    //alert(val.login_YN);
	               	    
						if(val.login_YN == 'Y')
						{   
						    loginSuccess(val.prv_cd, 1, val.userId);
						}
	               	});
             	}
         
          });   
        
        
        
        //커멘트 글자수 표시 및 길이 제한 - 파폭, ie에서 keyup이벤트가 다르게 적용됨...!!!
      	$("#m_comment").keyup(function(){
      	    
      		var str = new String($("#m_comment").val());
      		var length = str.length;
      		if(length > 500){
      		    jsWarningBox("작성글은 최대 200자 입니다.");
      			$("#m_comment")[0].focus();
      		} 
      		return false;
      	});	
          
        
    });
  
    
    //덧글입력
    var jsCreate = function() {
               
        
        if(!loginChk()) return;   
        
        if(!messageChk($('#m_comment'))) return;
        
        $.ajax({
            url     : "/web/snsopinion/ND_opinionCreate.do",            
            type    : "POST",
            data : {
		                domain_cd : $('#domain').val(),
		                menu_code : $('#menucd').val(),
		                page_url  : $('#menuurl').val(),
		                contents  : $('#m_comment').val(),
		                p_seq     : '0',
		                shorten_url : shortUrl
                   },
            dataType: "json",          
            async   : false,
            success : function(result) {
                
                if(result.result == false)
                {
                    jsWarningBox(result.message);                    
                }
                else
                {   
					jsSuccessBox(result.message);					
					 
                    var chageFrom = formChange(result.value);
                    
                    if(result.value.isleaf != 1 ) $("#delbut"+result.value.seq).hide();
                    
                    $('#m_comment').val("");
                    
                    if(result.value.seq == 1)	$('.comment_ul').append(chageFrom);
                    else                        $("#seq"+firstSeq).before(chageFrom);                    
                    
                    $("#cnt").html(parseInt($("#cnt").html()) + 1);
                    firstSeq = result.value.seq;
                }                
            }
       });
        
    };
	
    
    // v2 = depth /  v3 = seq / type = action구분
	var jsUpdateForm = function( v2, v3, type) {
	  	       
	   if(!loginChk()) return;
	    
	   
  	   if(uFormUse == 'Y'){
  	       
  	       uFormUse = "N";
  	       $("#updateForm").remove();

  	       if(type == 2) return;  	     
  	   }
//   	   else if( uFormUse = 'N' )
  	 
  	   
  	   if(rFormUse == 'Y'){
  	  	  
  	       rFormUse = "N";
	       $("#updateForm").remove();  	   
	       
	       if(type == 1) return;  	     
	   }
  	   
       var uForm = "";
       var actGb = "";
       var imgGb = "";	       
     
       if(type == 1){
           actGb    = "답글";  
           imgGb    = "/resources/web/theme/default/images/btn/btn_comment_ok_s.gif";
           rFormUse = 'Y';
       }else{
           actGb    = "수정";
           imgGb    = "/resources/web/theme/default/images/btn/btn_edit.gif";
           uFormUse = 'Y';
       }
      
	    
	    //덧글생성
  	   if(v2 > 1){
	  	  uForm += '<li id="updateForm" class="reply_'+v2+'" >';
	  	  uForm += '<div class="comment_cont">';
	   }else{
  	       uForm += '<li id="updateForm" >';
  	   }	      	    
  	 
  	   uForm += '<fieldset class="com_write">';
  	   uForm += '<legend>'+actGb+'</legend>';
  	   uForm += '<label class="skip" for="commentText">'+actGb+'</label>';	    	       
  	   uForm += '<textarea id="s_comment" name="s_comment" rows="3" style="width:100%;height:50px;">';
  	   
  	   if(type == 2)  uForm += $("#re_tx"+v3).html();
  	 
  	   uForm += '</textarea>';
  	   uForm += '<div class="tx_r mar_t10">';
  	   uForm += '<a onclick="jsUpdate('+v3+', '+type+');">';
  	   uForm += '<img class="pad_0" src="'+imgGb+'" alt='+actGb+' />';	
  	   uForm += '</a></div>';	
  	   
	   
       uForm += '</fieldset>';
  	   
       if(v2 > 1)	uForm += '</div>';
  	   
  	   uForm += '</li>';
  	  // alert(uForm);
  	   
  	   $("#seq"+v3).after(uForm);
  	   
	  	     
    };
	    
   
  //수정
    var jsUpdate = function(seq, type) {        
        
        /*
        	type : 1 - 답글등록
        	       2 - 댓글수정
        	       3 - 댓글삭제
        	       4 - 댓글신고
        */	
      
        if(type  < 3)
        {
        	if(!messageChk($('#s_comment'))) return;
        }
                
        var url   = "";
        var data;
        
        if(type == 1)
        {
            url    = "/web/snsopinion/ND_opinionCreate.do";
            data   =  {
			                domain_cd   : $('#domain').val(),
			                menu_code   : $('#menucd').val(),
			                page_url    : $('#menuurl').val(),
			                p_seq       : seq,
			                contents    : $('#s_comment').html(),
			                shorten_url : shortUrl
		               };
        
        }
        else
        {
            url = "/web/snsopinion/ND_opinionUpdate.do";
            
            var del    = "N";
            var con    = $('#re_tx'+seq).html();
            var report = "N";
           
            if(type == 2)       	con    = $('#s_comment').html();
            else if((type == 3))    del    = 'Y';
            else if((type == 4))    report = 'Y';            
            
            
            data   =  {
			                domain_cd : $('#domain').val(),
			                menu_code : $('#menucd').val(),
			                page_url  : $('#menuurl').val(),
			                seq       : seq,
			                contents  : con,
			                del_yn    : del,
			                report_yn : report
		               };            
        }	
      
        
        $.ajax({
            url     : url,            
            type    : "POST",
            data    : data,
            dataType: "json",          
            async   : false,
            success : function(result) {                
                
                if(type == 1)
                {	
                    jsSuccessBox(result.message);                       
                    
                    var chageFrom = formChange(result.value);
                    
                    $("#delbut"+result.value.p_seq).hide();
                    
                    $("#updateForm").remove();
                    $("#seq"+seq).after(chageFrom);
                    
                    uFormUse = "N";
                }
                else if(type == 2)
                {	
 					jsSuccessBox(result.message);
                    
                    $("#re_tx"+seq).text($('#s_comment').html());
                    
                    $("#updateForm").remove();
                
                }
                else if(type == 3)
                {
                    jsSuccessBox('의견글이 삭제 되었습니다');
    				                    
	   				var pSeq = $("#pseq"+seq).val(); 
	   			
	   				
	   				//같은 depth에 답글이 있는지 확인후 없으면 상위 댓글의 삭제기능을 보여준다.
	   				if(pSeq != 0)
	   				 {	   		
	   				    var cnt = 0; 		   			  
	   				
	   				    $(".parSeq").each(function(index) {	   				        
		   			   		if(pSeq == $(this).val()) cnt += 1;
		   			     });		   				 
	   				   	
	   				    if(cnt == 1)  $("#delbut"+$("#pseq"+seq).val()).show();	   		
	   				 }
                    	   			  		     
                    
	   				 $("#seq"+seq).remove();    				 
	   				 $("#cnt").html(parseInt($("#cnt").html()) - 1);
	   				 
	   				 rFormUse = "N";	   				 
	   				
                }
                else if(type == 4)
                {
                    jsSuccessBox('의견글이 신고하였습니다.');
                }
       
            }
       });     
    };
    
 	//
    var jsDelete = function(seq, type) {
 	    
        //질의
        if(!confirm("정말 하시겠습니까?"))	return;        
        
        jsUpdate(seq, type);
    };
    
    //신고
	var jsReport = function(seq, type) {
        
        //질의
        if(!confirm("정말 신고하시겠습니까?"))	return;        
        
        jsUpdate(seq, type);
    };
   
  
    //변경될 폼 생성
    var formChange = function(val)
    {  
        var opinion = "";
       
  		//덧글생성
	   if(val.depth > 1)
	   {
	       opinion += '<li id="seq'+val.seq+'" class="reply_'+val.depth+'" >';
	       opinion += '<div class="comment_cont">';

	   }
	   else
	   {
	      opinion += '<li id="seq'+val.seq+'">';
	   }	      	    
	              	   
	   opinion += '<span class="name">'+ val.reg_id +'</span>';
	   opinion += '<span class="date">('+ val.reg_dt +')</span>';
	   opinion += '<p class="re_tx" id="re_tx'+val.seq+'">'+ val.contents +'</p>';
	   opinion += '<span class="c_edit">';
	   opinion += '<a href="JavaScript:jsUpdateForm('+val.depth+','+val.seq+',1);">답글</a>';
	   
	   if(val.reg_id == cur_userId){             	      
	      opinion += ' ㅣ <a href="JavaScript:jsUpdateForm('+val.depth+','+val.seq+',2);" >수정</a>';             	      
	                   	      
	      opinion += ' ㅣ <a id="delbut'+val.seq+'"  href="JavaScript:jsDelete('+val.seq+', 3);" >삭제</a>';  	      
  	      opinion += '<input type="hidden" id="pseq'+val.seq+'"class="parSeq"  value="'+val.p_seq+'" />'; 	  	   
  	  	   
	   }
	   
	   
	   
	   opinion += ' ㅣ <a id="report"  href="JavaScript:jsReport('+val.seq+', 4);"  >신고</a>';
	   
	   opinion += '</span>';
	
	   if(val.depth > 1)	opinion += '</div>';
	   
	   opinion += '</li>'; 
	  
	   return opinion;    
    };
    
    
    //로그인 체크
    var loginChk = function(){
        
        if(cur_userId == 'guest')
        {
            jsWarningBox("로그인 하신 후 이용가능합니다.");
        	return false;
        }
        
        return true;        
    };
    
    
    //메세지 길이 체크
    var messageChk = function(message){
        
        var errM = "";
        
        if(message.val().length == 0) 	    errM = "필수입력 사항입니다.";
        else if(message.val().length > 200) errM = "작성글은 최대 200자 입니다.";
        
        if(errM != "")
		{
            jsWarningBox(errM);
            message.focus();
            return false;
		}
        
        return true;        
    };
    
    //sns로그인
    var snsLogin = function (snsGb)
    {
        
        if(!loginChk()) return;
        
        cuuentSns = snsGb;
                
        $.ajax({
            url     : "/web/snsopinion/requestToken.do",            
            type    : "POST",
            data    : {
               			 prv_cd : cuuentSns
          			  },
            dataType: "json",
            async   : false,
            success : function(data) { 
                
                
                if(data.prv_cd == '1003')
                {
                    yozmRequset(data);
                }
                else
                {
                    window.open(data.request_url,'_blank');
                }    
               
            }
        });
        
    };
    
    
    //sns로그인
    var snsLogout = function (snsGb)
    {
        
        if(eval(snsTwitter+snsFacebook) == 0)
        {
        	alert("하나이상의 SNS를 로그인해 주십시요.");
        	return;
        }
        
        
        if(!confirm("로그아웃 하시겠습니까?"))	return;   
        
                
        $.ajax({
            url     : "/web/snsopinion/logout.do",            
            type    : "POST",
            data    : {
                		prv_cd : snsGb
          			  },
            dataType: "json",
            async   : false,
            success : function(data) { 
                
                if(data.result == false)
                {
                    jsWarningBox(result.message);                    
                }
                else
                {   
                    logoutSuccess(data.value);
                    
					jsSuccessBox("로그아웃 되었습니다.");	
                }
               
            }
        });
        
    };
    
    
    //콜백    
    function callback(oauth_token, oauth_verifier )
    {    
        
        $.ajax({
            url  : "/web/snsopinion/accessToken.do",            
            type : "POST",            
            data : {
                prv_cd         : cuuentSns,
                oauth_token    : oauth_token,
                oauth_verifier : oauth_verifier                
            },
            dataType     : "json",
            contentType  : 'application/x-www-form-urlencoded; charset=UTF-8',
            async   : false,
            success : function(data) {
                      
                loginSuccess(cuuentSns, 2, data.userId);
            }
        });
    }
    
    
    //로그인 성공 후 - 이벤트  / 링크걸기 / 이미지 변경 
    function loginSuccess(sns_gb, type, userId){
        
        var url = "";
        
        if(sns_gb == '1001'){
            
            if(type == 1)	url = "https://www.twitter.com/"+userId;
            else            url = "https://www.twitter.com/";             

            $("#twitter_A").attr({onclick: "", href:url, target : 'blank'});        
            $("#twitter_B").attr("src", "/resources/web/theme/default/images/btn/btn_twitter_on.gif");
            
            $("#twitter_logout_A").attr({onclick: "snsLogout('1001')"});
            $("#twitter_logout_B").attr("src", "/resources/web/theme/default/images/btn/btn_on.gif");
            
            snsTwitter  = 1;
            
            
        }
        else if(sns_gb == '1002'){       
            
            
            if(type == 1)	url = "https://www.facebook.com/"+userId;
            else            url = "https://www.facebook.com/me";
            
            $("#facebook_A").attr({onclick: "", href: url, target : 'blank'});            
            $("#facebook_B").attr("src", "/resources/web/theme/default/images/btn/btn_facebook_on.gif");       
            
            $("#facebook_logout_A").attr({onclick: "snsLogout('1002')"});
            $("#facebook_logout_B").attr("src", "/resources/web/theme/default/images/btn/btn_on.gif");
            
            snsFacebook = 1;
            
        }
        else if(sns_gb == '1003'){            
            $("#yozm_A").attr({onclick: "", href: 'http://yozm.daum.net/', target : 'blank'});            
            $("#yozm_B").attr("src", "/resources/web/theme/default/images/btn/btn_yozm_on.gif");            
        }        
    }
    
    
    //로그인아웃 후 - 이벤트  / 링크걸기 / 이미지 변경 
    function logoutSuccess(sns_gb){
      
        
        if(sns_gb == '1001' || sns_gb == 'all' ){
          
            $("#twitter_A").attr({onclick: "snsLogin('1001')"});
            $("#twitter_A").removeAttr("href");
            $("#twitter_A").removeAttr("target");
            $("#twitter_B").attr("src", "/resources/web/theme/default/images/btn/btn_twitter_off.gif");
            
            $("#twitter_logout_A").attr({onclick: ""});
            $("#twitter_logout_B").attr("src", "/resources/web/theme/default/images/btn/btn_off.gif");         
            
            snsTwitter  = 0;
            
        }
        
        if(sns_gb == '1002' || sns_gb == 'all' ){       
           
            $("#facebook_A").attr({onclick: "snsLogin('1002')"});        
            $("#facebook_A").removeAttr("href");
            $("#facebook_A").removeAttr("target");
            $("#facebook_B").attr("src", "/resources/web/theme/default/images/btn/btn_facebook_off.gif");       
            
            $("#facebook_logout_A").attr({onclick: ""});
            $("#facebook_logout_B").attr("src", "/resources/web/theme/default/images/btn/btn_off.gif");
            
            snsFacebook = 0;
            
        }
             
    }
    
    
    //임시단축URL
  	function getBitlyShort(fullUrl) {

  	  var chBit_ID      = "mo0562"; 
  	  var chBit_APIKey  = "R_aaf09f4ae0dc198c1cda810db27d8606";
  	  var chBit_LongUrl = fullUrl; //단축URL로 만들 주소
  	  
		$.ajax({
  	        url:"http://api.bit.ly/v3/shorten",
  	        data:{	
  	                 longUrl:chBit_LongUrl,
  	                 apiKey:chBit_APIKey,
  	                 login:chBit_ID
  	             },
  	        dataType:"jsonp",
  	        async: false,
    	    success:function(v)
  	        {     	        
  	            shortUrl = v.data.url; 				
  	        },
  	        error : function(hxr, status, error) {
  	            alert(error);
  	        }
  	    });
  	  
  	}
  	
    //]]>
</script>



<br/><br/><br/><br/>

<form name="snsForm" id="snsForm" >
	<div class="comment_box">                
	    <h4><img src="/resources/web/theme/default/images/common/comment_ti.gif" alt="답글" /></h4> <span><strong id="cnt">0</strong>개</span>
		<div class="comment_bg">
			<div class="sns_select">
				<a id="twitter_A"  onclick="snsLogin('1001');"  ><img id="twitter_B"  src="/resources/web/theme/default/images/btn/btn_twitter_off.gif"   alt="트위터"  /></a>
				<a id="facebook_A" onclick="snsLogin('1002');" ><img  id="facebook_B" src="/resources/web/theme/default/images/btn/btn_facebook_off.gif"  alt="페이스북" /></a>

				<a onclick="snsLogout('all');"><img src="/resources/web/theme/default/images/btn/btn_snslogout.gif" alt="전체로그아웃" /></a>
			</div>
			<div class="sns_select">
				<a id="twitter_logout_A"  onclick="" ><img id="twitter_logout_B"  src="/resources/web/theme/default/images/btn/btn_off.gif"   alt="트위터"  /></a>
				<a id="facebook_logout_A" onclick="" ><img  id="facebook_logout_B" src="/resources/web/theme/default/images/btn/btn_off.gif"  alt="페이스북" /></a>
			</div>
			<div>
				<fieldset class="com_write">
					<legend>답글입력영역</legend>
					<label class="skip" for="commentText">답글작성</label>
					<textarea id="m_comment" name="m_comment" rows="3" style="width:100%;height:50px;"></textarea>				
					<div class="tx_r mar_t10">
						<a onclick="jsCreate();">
						<img class="pad_0" src="/resources/web/theme/default/images/btn/btn_comment_ok_s.gif" alt="등록" />
						</a>
					</div>
					                                                                  
				</fieldset>	
			</div>
			
			<!--덧글시작 -->
			<div class="comment">			
				<ul class="comment_ul">
				
				</ul>
			</div>
			<!-- //덧글끝 -->
		</div>
	</div>
</form>




</c:if>
