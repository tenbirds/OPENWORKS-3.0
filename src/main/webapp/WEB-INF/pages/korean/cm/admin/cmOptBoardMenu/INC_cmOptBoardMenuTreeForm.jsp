<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<op:jsTag type="spi" items="form, validate" />
<script type="text/javascript">
    $().ready(function() {
        if ( $("#menuModiForm") ) {
            $("#menuModiForm").validate({
                rules: {
                    nodeText: { required:true, minlength:2, maxlength:15 }
                }
            });
        }

        $("#menuAddForm").validate({
            rules: {
                newNodeText: { required:true, minlength:2, maxlength:15 }
            }
        });
    });
   	//글자수체크
    var displayBytes  = function ( nm, id ){
        var obj  = document.getElementById( id );
            if (obj.value.bytes() > nm){
                if (event.keyCode != '8'){
                    alert(nm+'바이트까지 입력이 가능합니다.');
                }
                obj.value = obj.value.substring(0, obj.value.length-10);
            } 
            
            eval('document.all.'+id+'_bytes').innerHTML = eval('menuModiForm.'+id).value.bytes();
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
 	var formReset= function(){
       	$( '#menuModiForm' ).each( function() {
        		this.reset();
    	} );
 	 };
</script>

    <form id="menuModiForm" method="post">
    	<input type="hidden" name="cmmntyId" id="cmmntyId"  value="<c:out value="${cmmntyId}" />" />
		<table>
			<colgroup>
				<col style="width:25%">
				<col style="*">
			</colgroup>
			<tbody>
				<tr>
					<td class="tit">게시판 유형</td>
					<td><op:code id="cmmntyBbsTyCd" grpCd="2001" type="select" defaultValues="1001" /></td>
				</tr>
				<tr>
					<td class="tit"><span class="point">게시판 이름</span></td>
					<td><input type="text" id="cmmntyMenuNm" name="cmmntyMenuNm" title="게시판 이름 입력" value="" style="width:330px;"></td>
				</tr>
				<tr>
					<td class="tit">게시판 설명</td>
					<td>
						<textarea id="cmmntyMenuDc" name="cmmntyMenuDc" style="width:330px; height:170px;" onkeyup="javascript:displayBytes(1000,'cmmntyMenuDc');"  onblur="javascript:displayBytes(1000,'cmmntyMenuDc');" ></textarea>
						<span class="byte"><em><span id="cmmntyMenuDc_bytes">0</span></em>/1000byte</span>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_area">
					<div class="btn_navi"><a href="#none" onclick="jsInsertAction2('#menuModiForm');"><span class="save">저장</span></a></div>
					<div class="btn_navi_g"><a href="#none" onclick="formReset();" ><span class="cancel">취소</span></a></div>
	</div>
	</form>
	
	