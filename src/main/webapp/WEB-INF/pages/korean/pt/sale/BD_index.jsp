<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">

/* 20170111 ���� ������ ��� */
/* $().ready(function() {
	<c:if test="${storeLangList[0].storeSction != 'Y'}">
	if (confirm("�ٱ��� �Ǹ��������� �������� �������� �ʾҽ��ϴ�. \n ȸ������ ���濡�� �ٱ��� �Ǹų������� ${storeLangNm.langNm} ������ �����Ͻðڽ��ϱ�?")) {
	    // �����ҽ�  
	    //location.href="/english/pt/register/BD_password.do";
	    
	    //{{ BH, 2015.11.24, �����ΰ��������� ���� �ҽ����� 
		// ����ҽ�
		location.href="/korean/pt/register/BD_password.do";	
		//}}
	    }
	</c:if>
}); */


 var jsView = function(el,seq,type){
    var type = (type == "1001" ? "�亯���" : "�亯����");
    $(el).colorbox({
        title : type,
        href : "/korean/pt/sale/support/qna/PD_insertForm.do?goodsInqryNo=" + seq,
        width : "778",
        height: "490",
        iframe: true
    });
  };
  
  var jsRegistBack = function(el,goodsCode,goodsRegistSttus) { 
      
	if(goodsRegistSttus == 1001 || goodsRegistSttus == 1002 || goodsRegistSttus == 1004){
	    alert("���δ��/�ӽ����� ���¿�����\n�ݷ������� �����ϴ�.");
        return false;
	}
      $(el).colorbox({
          title : "�ݷ�����",
          href : "/korean/pt/sale/goods/PD_returnReasonPop.do?goodsCode="+goodsCode,
          width : "500",
          height : "400",
          overlayClose : false,
          escKey : false,
          iframe : true
      });
  };

  
    // ��ȸ��ư Ŭ��
    function jsListSearch(page){
        $("#dataForm input[name=q_currPage]").val(page);
        document.dataForm.action = "/korean/pt/suplerCeart/BD_beforeRequestList.do";
    	document.dataForm.method = "GET";
    	document.dataForm.submit();
    }
    
    
</script>
</head>
<body>

	<!-- contents -->
	<div class="contents sale-main">

	
	<div class="supAdm dash">
		<ul>
			<!-- �ֱٰԽù�1 -->
			<li>
				<h3>
					ó���ؾ��� ������û��<!-- before_title : ó���ؾ� �� ���� ���� ���� -->
					<i class="total">${orderGCount}</i>
					<!-- <a href="orderManage/BD_orderList.do">������</a> -->
					<a href="/korean/pt/suplerCeart/BD_beforeRequestList.do">������</a>
				</h3>
				<table class="tbl_st1 la_1" summary="ó���ؾ��� ������û��">
					<caption>ó���ؾ��� ������û��</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<!-- <th>��ȣ</th> -->
							<th scope="col">���� ��</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<!-- <th>��ȣ</th> -->
							<th scope="col">���� ��</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${orderG}" var="_orderG" varStatus="status">
            <tr>
            	<td>
								<a href="/korean/pt/suplerCeart/BD_beforeRequestDetailView.do?p_notifyNum=${_orderG.notifyNum}&p_notifySeq=${_orderG.notifySeq}&p_endsUserId=${_orderG.userId}"> ${fn:substring(_orderG.goodsNm,0,30)}<c:if test="${fn:length(_orderG.goodsNm) > 30}">...</c:if></a>
              </td>
              <td><c:out value='${_orderG.rplyDt}'/></td>
            </tr>
            </c:forEach>
            <op:no-data obj="${orderG}" colspan="2" />                  	
					</tbody>
				</table>
			</li>
			<!--// �ֱٰԽù�1 -->
			<!-- �ֱٰԽù�2 -->
			<li>
				<h3>
					���� ��� ������Ȳ<!-- before_title : ���� ��� ��� ��Ȳ -->
					<i class="total">${waitGCount}</i>
					<a href="goods/BD_waitingList.do">������</a>
				</h3>
				<table class="tbl_st1 la_1" summary="���� ��� ������Ȳ">
				<caption>���� ��� ������Ȳ</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">���� ��</th>
							<th scope="col">����</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<!-- <th>��ȣ</th> -->
							<th scope="col">���� ��</th>
							<th scope="col">����</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${waitG}" var="_waitG" varStatus="status">
		                   <tr>
		                       <td>
		                       <a href="javascript:;" title="[���񽺸�](�˾� â ����)" onclick="jsRegistBack(this,'${_waitG.goodsCode}','${_waitG.goodsRegistSttus}');">
		                       <c:out value='${_waitG.goodsNm}'/>
		                       </a>
		                       </td>
		                       <td>
			                       <c:choose>
				                        <c:when test="${_waitG.goodsRegistSttus eq 1003  || _waitG.goodsRegistSttus eq 1005 || _waitG.goodsRegistSttus eq 1010}">
					                        <span class="condi_c">�ݷ�</span><br/>
					                        <a style="width: 80px;" href="#none" title="�˾� â ����" onclick="jsRegistBack(this,'${_waitG.goodsCode}', '${_waitG.goodsRegistSttus}');">�ݷ���������</a>
				                        </c:when>
				                        <c:when test="${_waitG.goodsRegistSttus eq 1001 || _waitG.goodsRegistSttus eq 1008}">
				                            <span class="condi_b">�ӽ�����</span>
				                        </c:when>
				                        <c:when test="${_waitG.goodsRegistSttus eq 1002 || _waitG.goodsRegistSttus eq 1004 || _waitG.goodsRegistSttus eq 1009}">
						                    <span class="condi_d">���δ��</span>
				                        </c:when>
				                    </c:choose>
			                    </td>
		                   </tr>
		           		</c:forEach>
		                <op:no-data obj="${waitG}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// �ֱٰԽù�2 -->
		</ul>
		<ul>
			<!-- �ֱٰԽù�3 -->
			<li>
				<h3>
					��������(����) ��Ȳ
					<a href="/korean/pt/suplerCeart/BD_bidPartcptnList.do">������</a>
				</h3>
				<table class="tbl_st1 la_3" summary="��������(����) ��Ȳ">
				<caption>��������(����) ��Ȳ</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">���� ��</th>
							<th scope="col">������</th>
							<th scope="col">����</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">���� ��</th>
							<th scope="col">������</th>
							<th scope="col">����</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${buying}" var="_buying" varStatus="status">
            <tr>
	            <td>
	            	<a href="/korean/pt/suplerCeart/BD_bidSttusDetailView.do?p_notifyNum=${_buying.notifyNum}&p_notifySeq=${_buying.notifySeq}">${fn:substring(_buying.bidNotifyNm,0,30)}<c:if test="${fn:length(_buying.bidNotifyNm) > 30}">...</c:if></a>
	            </td>
	             <td><c:out value='${_buying.cntrMothodNm}'/></td>
	             <td><c:out value='${_buying.bidPgesStatNm}'/></td>
            </tr>
           	</c:forEach>
	                <op:no-data obj="${buying}" colspan="3"/>
					</tbody>
				</table>
			</li>
			<!--// �ֱٰԽù�3 -->
			<!-- �ֱٰԽù�4 -->
			<li>
				<h3>
					���Ѱ���
					<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1019">������</a>
				</h3>
				<table class="tbl_st1 la_1" summary="���Ѱ���">
				<caption>���Ѱ���</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">����</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">����</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</tfoot>
					<tbody>						
						<c:forEach items="${noti}" var="_noti" varStatus="status">
	            <tr>
	              <td>
	              	<a href="/web/board/BD_board.view.do?domainCd=${_noti.domainCd}&bbsCd=${_noti.bbsCd}&bbscttSeq=${_noti.bbscttSeq}">${fn:substring(_noti.bbscttSj,0,30)}<c:if test="${fn:length(_noti.bbscttSj) > 30}">...</c:if></a>
	              </td>
	              <td><c:out value='${_noti.registDt}'/></td>
	            </tr>
            </c:forEach>
            <op:no-data obj="${noti}" colspan="2" />
					</tbody>							
				</table>
			</li>
			<!--// �ֱٰԽù�4 -->
		</ul>
		<ul>
			<!-- �ֱٰԽù�5 -->
			<li class="total">
				<h3>
					�亯��� Q&amp;A <!-- before_title : �亯��� ���� Q&A���� -->
					<i>${inqrCount}</i>
					<a href="/korean/pt/sale/support/qna/BD_index.do">������</a>
				</h3>
				<table class="tbl_st1 la_4" summary="�亯��� Q&amp;A">
				<caption>�亯��� Q&amp;A</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">����</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">����</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</tfoot>
					<tbody>
					<c:forEach items="${inqr}" var="_inqr" varStatus="status">
		                <tr>
		                    <td class="title"><a href="javascript:;" onclick="jsView(this,'${_inqr.goodsInqryNo}','${_inqr.answerSttusCd}');"><c:out value='${_inqr.inqrySj}'/></a></td>
		                    <td><c:out value='${_inqr.registDt}'/></td>
		                </tr>
		           	</c:forEach>
		           	<op:no-data obj="${inqr}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// �ֱٰԽù�5 -->
			<!-- �ֱٰԽù�6 -->
			<li>
				<h3>
					�亯��� �����Ī<!-- before_title : �����Ī �ű� ��� ��Ȳ -->
					<i>${bizCount}</i>
					<a href="/korean/pt/sale/bizMatching/BD_index.do?domainCd=2&bbsCd=1010">������</a>
				</h3>
				<table class="tbl_st1 la_4" summary="�亯��� �����Ī">
					<caption>�亯��� �����Ī</caption>
						<colgroup>
							<col width="*"/>
							<col width="80px"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">����</th>
								<th scope="col">�ۼ���</th>
							</tr>							
						</thead>
						<tfoot>
							<tr hidden="hidden">
								<th scope="col">����</th>
								<th scope="col">�ۼ���</th>
							</tr>							
						</tfoot>
						<tbody>
							<c:forEach items="${biz}" var="_biz" varStatus="status">
		          <tr>
		            <td>
		            	<a href="/web/board/BD_board.view.do?domainCd=${_biz.domainCd}&bbsCd=${_biz.bbsCd}&bbscttSeq=${_biz.bbscttSeq}">${fn:substring(_biz.bbscttSj,0,30)}<c:if test="${fn:length(_biz.bbscttSj) > 30}">...</c:if></a>
		            </td>
		          	<td><c:out value='${_biz.registDt}'/></td>
		          </tr>
		          </c:forEach>
		          <op:no-data obj="${biz}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// �ֱٰԽù�6 -->
		</ul>
		<ul>
			<!-- �ֱٰԽù�7 -->
			<li>
				<h3>
					�ǰ߰���
					<a href="/korean/pt/masub/BD_subBoardList.do">������</a>
				</h3>
				<table class="tbl_st1 la_4" summary="�ǰ߰���">
					<caption>�ǰ߰���</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">����</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">����</th>
							<th scope="col">�ۼ���</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${subBoard}" var="_subBoard" varStatus="status">
	          <tr>
	          	<td>
	          		<a href="/korean/pt/masub/BD_subBoardForm.do?masterId=${_subBoard.masterId}&masubNum=${_subBoard.masubNum}">${fn:substring(_subBoard.masubTitle,0,30)}<c:if test="${fn:length(_subBoard.masubTitle) > 30}">...</c:if></a>
	          	</td>
	            <td><c:out value='${_subBoard.masubEntrDate}'/></td>
	          </tr>
	          </c:forEach>
	          <op:no-data obj="${subBoard}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// �ֱٰԽù�7 -->
		</ul>
	
	</div>
	</div>
	<!-- //contents -->
</body>
</html>