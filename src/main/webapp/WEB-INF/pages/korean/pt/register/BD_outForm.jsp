<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원 가입</title>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
    var jsConfirm = function(){
        if (confirm(Message.msg.confirmWithdraw)) {
            self.location.href = "ND_userOutConfirm.do";
        }
    };
</script>
</head>


<body>
	<div class="join_info modify memOut">
		<h3 class="fcol_1">
			<i class="quot">
				<i>
					회원탈퇴란, 클라우드스토어 씨앗에 대한 이용해지를 의미합니다. <br />
					클라우드스토어 씨앗에서 발송하는 광고성 이메일의 경우 회원탈퇴 요청 접수 후 24시간 이내에 발송이 중지됩니다.<br />
					다만, 드물게 데이터 처리사정상 일부 지연될 수 있으니 혹 회원탈퇴 요청 후 48시간이 <br />
					지난 후에 광고성 이메일/SMS를 접수하시는 경우 당사에 연락하여 주시기 바랍니다.<br />
				</i>
			</i>
		</h3>
		
		<div class="notice">
			<img src="/cloud_ver2/new_cloud/images/img_join_out_1.png" alt="회원탈퇴시 유의사항" />
			<img src="/cloud_ver2/new_cloud/images/img_join_out_2.png" alt="회원탈퇴 회원정보 보존기간" />
		</div>

		<div class="btnArea rig">					
			<a href="#" onclick="jsConfirm();" class="btns st1 icn icnPs">회원탈퇴 신청</a>
		</div>
	</div>
	
   	
</body>
</html>

