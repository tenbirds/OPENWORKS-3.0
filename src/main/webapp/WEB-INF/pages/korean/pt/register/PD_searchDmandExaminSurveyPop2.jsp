<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!-- <base href="https://www.ceart.kr/korean/pt/register/BD_userUpdateForm.do?pwdChg=Y"> -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>조사표 다운로드</title>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>
    <script type="text/javascript" src="/component/javascript/MD_massageConfig.do"></script>
	<script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
	<script type="text/javascript" src="/resources/web/theme/common/js/html5shiv.js"></script> 
	<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <link rel="stylesheet" type="text/css" href="/resources/cmmnty/default/css/common.css" />
    <link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript">
    $().ready(function(){
    });
    var jsCancel = function() {
        parent.$.colorbox.close();
    }
    </script>
</head>

<body class="winPopup pwChng">
<form id="passwordForm" name="passwordForm">
        <input type="hidden" name="userId"   id="userId"   value=""/>
    <h2>조사표 다운로드<a href="#" onclick="jsCancel();">닫기</a></h2>
    <div style="padding:10px 10px 10px 10px;">
		<p style="line-height:20px;">
			‘19년 수요예보조사는 기관별 EA정보시스템의 정보가 반영된 조사표가 화면과 엑셀파일로 제공 됩니다.<br /><br />
			
			<b>‘19년 수요예보조사표를 다운로드하여 작성한 후 업로드 할 수 있습니다.<br />
			또한 18년에 제출된 조사표를 다운받아 참고할 수 있습니다.<br />
			<font color="red">
			(단, 18년 제출된 조사표가 없을 경우 다운로드 표시가 없습니다.)
			</font></b><br /><br />

		
		<div class="btnArea" style="padding-top:30px;">
			<!-- 
			<c:if test="${dataVo.fileSeq != null && dataVo.fileSeq > 0}">
				<a href="/component/file/ND_fileDownload.do?id=${dataVo.dmandExaminFile[0].fileId}" class="btns st1" style="width:190px;">‘18년 제출된 조사표 다운로드(구양식)</a>
			</c:if>
			 -->

			<c:if test="${hiddenYn eq 'Y'}">
			<a href="ND_dmandExaminDownloadAction3.do" class="btns st4" style="width:190px;">‘18년 수요예보조사표 다운로드</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>			
			<a href="ND_dmandExaminDownloadAction2.do" class="btns st44" style="width:190px;">‘19년 수요예보조사표 다운로드</a>			
		</div>
		
	</div>
	</form>
</body>
</html>