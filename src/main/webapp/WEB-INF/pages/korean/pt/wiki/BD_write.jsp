<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>지식 | 씨앗위키 | 위키대문</title>  
    <op:jsTag type="openworks" items="validate, ckeditor" />
    
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
	<script type="text/javascript" src="/new_cloud/js/common.js"></script>

    <!-- 사용자 정의 script -->
    <script type="text/javascript">
    
        function jsRegist(){
            // 에디터 등록 내용 체크
            if(CKEDITOR.instances.wikiCn.getData() == ""){
                alert(Message.msg.chkContent);
                $("#wikiCn").focus();
                return;
            }else{
                if(CKEDITOR.instances.wikiCn.getData().length < 11){
                    alert(Message.msg.characters10);
                    $("#wikiCn").focus();
                    return;
                }
            }
            
            var ret = confirm("적용 하시겠습니까?");

            if (ret == true) {
                // 등록내용 입력form에 바인딩
                $('#p_wikiCn').val(CKEDITOR.instances.wikiCn.getData());
                
                var srcForm = $("form[name=srcForm]").serialize();

                $.ajax({
                    type: "POST",
                    async:false,  // 리턴값이 올때까지 다음 처리 대기
                    url: "/korean/pt/wiki/BD_regist.do",
                    data: srcForm,
                    dataType: "text",
                    success:function(response){
                        if(response != ""){
                            alert(response);
                            // 정상 적용시 메인 페이지로 이동
                            jsPageMove();
                        }else{
                            ret = true;
                        }
                    }
                });
            }  

        }
        
        // 메인페이지로 이동
        var jsPageMove = function(){
            $('#p_wikiSn').val(""); // 되돌리기 이후에는 첫 글이 조회되어야 하므로
            $("form[name=srcForm]").attr("method","post");
        	$("form[name=srcForm]").attr("action","/korean/pt/wiki/BD_index.do");
        	$("form[name=srcForm]").submit();
        }

        //미리보기
        var jsWikiPreview = function(){
            // 위키 내용
            $('#p_wikiCn').val(CKEDITOR.instances.wikiCn.getData());

            window.open("/korean/pt/wiki/BD_wikiPreview.do","wikiPreview","width=1040, height=768, scrollbars=yes");
        };
    </script>
    <!-- //사용자 정의 script -->
    
</head>
<body>
    <!-- 파라미터 전달용 form -->
    <form id="srcForm" name="srcForm">
        <input type="hidden" name="p_procDiv" id="p_procDiv" value="${p_procDiv}"/>                   <!-- 등록/수정 구분 -->
        <input type="hidden" name="p_wikiSn"  id="p_wikiSn"  value="${wikiWiew.wikiSn}"/>             <!-- 조회된 위키 순번 -->
        <input type="hidden" name="p_wikiCn"  id="p_wikiCn"  />                                       <!-- 위키 컨텐츠 정보 -->
        <input type="hidden" name="p_userId"  id="p_userId" value="${sessionScope['__usk'].userId}"/> <!-- 현재 처리할 사용자ID -->
    </form>
    
	<!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<div class="title-area">
			<h2>씨앗위키</h2>
		</div>
		<!-- //title-area -->
		
		<!-- section -->
		<div class="section">
			<!-- view -->
			<div class="type-view">
				<table>
					<caption>view</caption>
					<colgroup>
					<col style="width:;"/>
					</colgroup>	

					<tbody>								
						<tr>
							<td>
								<div class="txt-cont">
								    <textarea name="wikiCn" id="wikiCn" rows="15" style="width: 690px; height: 360px;" cols="30" title="내용을 입력해주세요">${wikiWiew.wikiCn}</textarea>
								    <script type="text/javascript">
                                        CKEDITOR.replace('wikiCn', {
                                            height : 300,
                                            enterMode : "2",
                                            skin : "moono",
                                            toolbar : [{ name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
                                	          		   { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript' ] },
                                	          		   { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
                                	          		   { name: 'insert', items: [ 'Image',  'Link', 'Unlink'] }
                                	          	      ],
                                            //toolbar : toolbar_config.default_toolbar,
                                            allowedContent: true,
                                            filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
                                        });
                                    </script>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- //view -->
		</div>
		<!-- //section -->
		
		<!-- button-area -->
		<div class="btn-area mt10 ar">
		    <a href="javascript:jsPageMove();" class="b-btn position-ar type1"><strong><span class="ml10 mr10">취소</span></strong></a>
		    <a href="javascript:jsWikiPreview();" class="b-btn position-ar type2"><strong><span class="ml10 mr10">미리보기</span></strong></a>
		    <a href="javascript:jsRegist();" class="b-btn position-ar type3"><strong><span class="ml10 mr10">저장</span></strong></a>
		</div>
		<!-- //button-area -->

	</div>
	<!-- //contents -->
	  
</body>
</html>