<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">
  
</script>
</head>
<body>
<!-- container -->
		<div id="container" class="join-wrap">
       <!-- contents -->
		<div class="contents complete">

			<div class="ac mt30">
				<p class="ac"><img src="/new_cloud/images/sub/icon-x.png" alt="" /></p>
				<p class="mt30">���� <strong><c:out value='${userVo.userNm}'/></strong> ���� ����ȸ������ �Ǹű����� �����ϴ�.<br/>
				������ ���������� �����Ǹ�ȸ�� �Ǵ� ����Ǹ�ȸ������ ������ ȹ���� �� �ֽ��ϴ�.</p>
			</div>

			<%-- <div class="btn-area mt30 mb30 ac">
				 <c:if test="${sessionScope['__usk'].nationCode eq 410}">
                        <a href="/korean/pt/register/BD_userCrtfc.do??userTyCd=&nationCode=${sessionScope['__usk'].nationCode}" title="�Ǹ�ȸ�� ��ȯ�ϱ�" class="b-btn gift type3"><strong><span>�Ǹ� ȸ�� ��ȯ ��û�ϱ�</span></strong></a>
                    </c:if>
                    <c:if test="${sessionScope['__usk'].nationCode ne 410}">
                        <a href="/korean/pt/register/BD_index.do?userTyCd=&amp;nationCode=${loginData.nationCode}" title="�Ǹ�ȸ�� ��ȯ�ϱ�" class="b-btn gift type3"><strong><span>�Ǹ� ȸ�� ��ȯ ��û�ϱ�</span></strong></a>
                    </c:if>
			</div> --%>

		</div>
		<!-- //contents -->

</div>
<!-- //container -->
</body>
</html>