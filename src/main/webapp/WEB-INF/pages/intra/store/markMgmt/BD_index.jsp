<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>마크/분류 이미지 관리</title>

    <op:jsTag type="spi" items="form, validate, highlight, message" />
    <op:jsTag type="openworks" items="ui" />
    <script type="text/javascript">
        $(document).ready(function(){
            $("#dataForm").validate({
                submitHandler : function(form) {
                     $(form).ajaxSubmit({
                         url      : $("#dataForm").attr("action"),
                        type     : "POST",
                         dataType : "text",
                         success  : function(response) {
                             if (response) {
                                 jsSuccessBox(response);
                                    self.location.reload();
                             }else{
                                 jsErrorBox(response);
                             }
                         }
                     });
                 }
            });
        });//ready end
        
        var jsInputImgNm = function(sel){
            if(sel == "1"){
                $.ajax({
                    type:        "POST",
                    url:         "ND_markInfo.do",
                    dataType:    "json",
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    data    : {markCd : $("#markCd").val(), markNm : $("select[id='markCd'] option:selected").text()},
                    async    : false,
                    success  : function(response){
                        $("#markNm").val(response.markNm);
                        if(response.fileList != '' && response.fileList != null){
	                        $("#fileTitle").text(response.fileList[0].localNm);
	                        $(".markThumb").html("<img src=\""+response.fileList[0].fileUrl+"\" style=\"width: inherit; height: inherit;\"/>");
	                        $("#markImageFileSeq").val(response.markImageFileSeq);
	                        $("#fileSeq").val(response.markImageFileSeq);
	                        $("#fileId").val(response.fileList[0].fileId);
	                        $("#markImageFile").attr("disabled", true);
	                        $("#markFile").show();
                        } else {
                            $(".markThumb").empty();
                            $("#markImageFile").attr("disabled", false);
                            $("#markFile").hide();
                            $("#markImageFileSeq").val(-1);
                        }
                    },
                    error :  function(response) {
                        jsWarningBox(response.responseText);
                        return;
                    }
                });
             }
            if(sel == "2"){
                $.ajax({
                    type:        "POST",
                    url:         "ND_cntcImgInfo.do",
                    dataType:    "json",
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    data    : {cntcInsttCd : $('#cntcInsttCd').val(), cntcGoodsNm: $("select[id='cntcInsttCd'] option:selected").text()},
                    async    : false,
                    success  : function(response){
                        $("#cntcGoodsNm").val(response.cntcGoodsNm);
                        if(response.fileList != '' && response.fileList != null){
                            $("#fileTitle2").text(response.fileList[0].localNm);
                            $(".cntcThumb").html("<img src=\""+response.fileList[0].fileUrl+"\" style=\"width: inherit; height: inherit;\"/>");
                            $("#cntcGoodsImageSeq").val(response.cntcGoodsImageSeq);
                            $("#fileSeq").val(response.fileList[0].fileSeq);
                            $("#fileId").val(response.fileList[0].fileId);
                            $("#cntcImageFile").attr("disabled", true);
                            $("#cntcFile").show();
                        } else {
                            $(".cntcThumb").empty();
                            $("#cntcImageFile").attr("disabled", false);
                            $("#cntcFile").hide();
                            $("#cntcGoodsImageSeq").val(-1);
                        }
                    },
                    error :  function(response) {
                        jsWarningBox(response.responseText);
                        return;
                    }
                });
             }
        };
        
        var jsChkVal = function(no) {
            if(no == '1'){
                if($("#markNm").val() == ""){
                    alert("인증마크 이름을 선택해 주세요");
                    $("#markNm").focus();
                    return;
                }
                $(".cntcGoodsNm *").attr("disabled",true);
                $(".markNm *").attr("disabled",false);
                $("#dataForm").attr("action", "ND_saveMarkInfo.do");
            }else{
                if($("#cntcGoodsNm").val() == ""){
                    alert("서비스분류 이미지 이름을 선택해 주세요");
                    $("#cntcGoodsNm").focus();
                    return;
                }
                $(".markNm *").attr("disabled",true);
                $(".cntcGoodsNm *").attr("disabled",false);
                $("#dataForm").attr("action", "ND_saveCntcImgInfo.do");
            }
            //$("input[type=file][value!='']").trigger("onchange");
            $("#dataForm").submit();
        };
        
        var jsFileDelete = function(type){
            if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다.")){
                return false;
            }
            $("#dataForm").ajaxSubmit({
                url      : "ND_fileDelete.do",
                type     : "POST",
                async    : false,
                success  : function (response) {
                    if(response == 'true'){
                        jsSuccessBox("삭제가 완료되었습니다.");
                        document.location.reload();
                    }else{
                        jsWarningBox("삭제처리 도중 오류가 발생하였습니다.");
                    }
                }
            });
            
        };
        
        var readURL = function (input, target) {    <%-- 업로드 파일 미리보기 --%>
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    if(e.target.result.indexOf("image/gif") > 0 || e.target.result.indexOf("image/jpg") > 0
                            || e.target.result.indexOf("image/jpeg") > 0){
                        $("."+target).html("<img src=\""+e.target.result+"\" alt=\"업로드 이미지 미리보기\" style=\"width: inherit; height: inherit;\"/>");
                    }
                };
                reader.readAsDataURL(input.files[0]);
            }
        };
    </script>
    <style>
        .imgPreview {
            background: url("/resources/web/theme/default/images/common/bg/bg_store_back2.gif") no-repeat scroll 0 0 rgba(0, 0, 0, 0);
            background-size: 33px 33px;
            border: 1px solid #e4e4e4;
            height: 33px;
            width: 33px;
        }
    </style>
</head>
<body>
    <div id="globalDiv">
        <form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" >
            <input type="hidden" name="fileId" id="fileId" value="" /><%-- 파일삭제시 fileId세팅부분 --%>
            <input type="hidden" name="fileSeq" id="fileSeq" value="" /><%-- 파일삭제시 fileSeq세팅부분 --%>
            <h4>인증정보 관리</h4>
            <table class="boardWrite markNm" border="0" cellspacing="0" cellpadding="0" summary="인증정보" >
                <caption>입력표 설정</caption>
                <colgroup>
                    <col width="250" />
                    <col width="20" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>인증 마크 분류명</th>
                        <th></th>
                        <th>선택한 인증정보</th>
                    </tr>
                    <tr>
                        <td>
                            <select id="markCd" name="markCd" style="width:230px;" size="10" onchange="jsInputImgNm('1');">
                                <c:forEach items="${codeList}" var="markList">
                                    <option value="${markList.prvCd}">${markList.prvNm}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td></td>
                        <td>
                            <table class="boardWrite" border="0" cellspacing="0" cellpadding="0" summary="상세 배치">
                                <caption>입력표 설정</caption>
                                <colgroup>
                                    <col width="150" />
                                    <col width="*" />
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>인증 마크 이름</th>
                                        <td><input type="text" id="markNm" name="markNm" value="" class="w_100p" readonly="readonly" /></td>
                                    </tr>
                                    <tr>
                                        <th>마크 이미지
                                            <br/>사이즈[33 X 33]
                                        </th>
                                        <td>
                                            <div class="markThumb imgPreview" style="float:left; margin-right:5%;"><!--  이미지 미리보기 영역 --></div>
                                            <input type="file" name="markImageFile" id="markImageFile" class="w400 multi max-1" value="찾아보기" accept="${markConfig.fileExts}" onchange="readURL(this, 'markThumb');" disabled="disabled"/>
                                            <div id="markFile" style="display: none;">
                                                <a href="#none" onclick="jsFileDelete('mark');">
                                                    <img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm" />
                                                </a>
                                                <span id="fileTitle"></span>
	                                            <input type="hidden" name="markImageFileSeq" id="markImageFileSeq" value="" />
                                            </div>
                                            <span class="file_exp" style="display: block;">※ jpg, jpeg, gif형식의 1MB 미만 파일만 업로드 가능합니다.<br />※ 업로드된 파일은 33 x 33 사이즈로 확대 또는 축소되어 표시됩니다.</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    
                </tbody>
            </table>
            <div class="btn_r">
                <ul>
                    <li><input type="button" onclick="jsChkVal('1');" value="적용" class="w_blue" /></li>
                </ul>
            </div>
            <br class="blank"/>
            
            <h4>연계서비스 분류 이미지 관리</h4>
            <table class="boardWrite cntcGoodsNm" border="0" cellspacing="0" cellpadding="0" summary="연계서비스 정보" >
                <caption>입력표 설정</caption>
                <colgroup>
                    <col width="250" />
                    <col width="20" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>연계서비스 분류명</th>
                        <th></th>
                        <th>선택한 서비스 분류 이미지 정보</th>
                    </tr>
                    <tr>
                        <td>
                            <select id="cntcInsttCd" name="cntcInsttCd" style="width:230px;" size="10" onchange="jsInputImgNm('2');">
                                <c:forEach items="${dataList}" var="cntcList">
                                    <option value="${cntcList.prvCd}">${cntcList.prvNm}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td></td>
                        <td>
                            <table class="boardWrite" border="0" cellspacing="0" cellpadding="0" summary="상세 배치">
                                <caption>입력표 설정</caption>
                                <colgroup>
                                    <col width="150" />
                                    <col width="*" />
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>이미지 이름</th>
                                        <td><input type="text" id="cntcGoodsNm" name="cntcGoodsNm" value="" class="w_100p" readonly="readonly" /></td>
                                    </tr>
                                    <tr>
                                        <th>이미지
                                            <br/>사이즈[100 X 150]
                                        </th>
                                        <td>
                                            <div class="cntcThumb imgPreview" style="float:left; margin-right:5%;"><!--  이미지 미리보기 영역 --></div>
                                            <input type="file" name="cntcImageFile" id="cntcImageFile" class="w400 multi max-1" value="찾아보기" accept="${markConfig.fileExts}" onchange="readURL(this, 'cntcThumb');" disabled="disabled"/>
                                            <div id="cntcFile" style="display: none;">
                                                <a href="#none" onclick="jsFileDelete('cntc');">
                                                    <img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm" />
                                                </a>
                                                <span id="fileTitle2"></span>
                                                <input type="hidden" name="cntcGoodsImageSeq" id="cntcGoodsImageSeq" value="" />
                                            </div>
                                            <span class="file_exp" style="display: block;">※ jpg, jpeg, gif형식의 1MB 미만 파일만 업로드 가능합니다.<br />※ 업로드된 파일은 35 x 15 사이즈로 확대 또는 축소되어 표시됩니다.</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>    
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="btn_r">
                <ul>
                    <li><input type="button" onclick="jsChkVal('2');" value="적용" class="w_blue" /></li>
                </ul>
            </div>
        </form>
    </div>
</body>
</html>