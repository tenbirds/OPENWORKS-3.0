<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="extjs4" />

<script type="text/javascript">
	var jsReloadTerm = function(){
		var typeCd = $("#typeCd1").val();
		var year = $("#searchYear").val();
		var month = $("#searchMonth").val();
		var day = $("#searchDay").val();
		logTab.changeUrl(logTab.selectedIndex, 'INC_boardLog.do?typeCd=' + typeCd + '&searchYear=' + year + '&searchMonth=' + month + '&searchDay=' + day);
		logTab.refresh();
	};

	//차트 관련
	Ext.require(['Ext.chart.*',
				 'Ext.data.*',
				 'Ext.layout.container.Fit']);

	Ext.onReady(function(){
		var getData = function(){
			var fileds = ['name', '게시물등록갯수', '게시물삭제갯수', '댓글등록갯수'];
			var data   = [];

			 $('#dataList tbody tr').each(function(index){
				data[index] = { name			: $(this).find('th').eq(0).text(),					//구분
								게시물등록갯수	: parseInt($(this).find('td').eq(0).text(), 10),	//게시물 등록 갯수
								게시물삭제갯수	: parseInt($(this).find('td').eq(1).text(), 10),	//게시물 삭제 갯수
								댓글등록갯수	: parseInt($(this).find('td').eq(2).text(), 10)};	//댓글 등록 갯수
			});

			//항목 삭제
			data = data.slice(1, data.length);

			return Ext.create('Ext.data.JsonStore', {
				fields : fileds,
				data   : data
			});
		};

		var chart = Ext.create('Ext.chart.Chart', {
			xtype: 'chart',
			flex : 1,
			animate: true,
			shadow: true,
			legend: {
				position: 'bottom'
			},
			store: getData(),
			axes: [{
				type: 'Numeric',
				position: 'left',
				fields: ['게시물등록갯수', '게시물삭제갯수', '댓글등록갯수'],
				title: '건수',
				grid: true,
				minimum: 0
			}, {
				type: 'Category',
				position: 'bottom',
				fields: ['name'],
				title: '시간'
			}],
			series: [{
				type: 'column',
				axis: 'left',
				highlight: true,
				xField: 'name',
				yField: ['게시물등록갯수', '게시물삭제갯수', '댓글등록갯수'],
				tips: {
					trackMouse: true,
					maxWidth : 150,
					width: 150,
					height: 25,
					renderer: function(storeItem, item){
						var itemName = "";
						if(item.yField == "게시물등록갯수") itemName = "게시물 등록 갯수";
						else if(item.yField == "게시물삭제갯수") itemName = "게시물 삭제 갯수";
						else if(item.yField == "댓글등록갯수") itemName = "댓글 등록 갯수";

						this.setTitle(itemName + " : " + storeItem.get(item.yField) + "개");
					}
				},
				label: {
					display: 'insideEnd',
					'text-anchor': 'middle',
					field: ['게시물등록갯수', '게시물삭제갯수', '댓글등록갯수'],
					renderer: Ext.util.Format.numberRenderer('0'),
					orientation: 'horizontal',
					color: '#333'
				}
			}]
		});

		Ext.create('widget.panel', {
			height: 350,
			title: '${searchVO.searchYear}년 ${searchVO.searchMonth}월 ${searchVO.searchDay}일 시간당 게시물 통계',
			renderTo: '_chart1',
			layout: 'fit',
			items: chart
		});
	});
</script>

<div class="mar_b10">
	<form>
		<select id="typeCd1" onchange="jsReloadTerm();">
			<c:forEach items="${termCdList}" var="kvBean">
				<option value="${kvBean.key}"<c:if test="${searchVO.typeCd eq kvBean.key}"> selected="selected"</c:if>>${kvBean.value}</option>
			</c:forEach>
		</select>

		<select id="searchYear" onchange="jsReloadTerm();">
			<c:forEach items="${searchVO.yearList}" var="year">
				<option value="${year}"<c:if test="${searchVO.searchYear eq year}"> selected="selected"</c:if>>${year}년</option>
			</c:forEach>
		</select>

		<select id="searchMonth" onchange="jsReloadTerm();">
			<c:forEach items="${searchVO.monthList}" var="month">
				<option value="${month}"<c:if test="${searchVO.searchMonth eq month}"> selected="selected"</c:if>>${month}월</option>
			</c:forEach>
		</select>

		<select id="searchDay" onchange="jsReloadTerm();">
			<c:forEach items="${searchVO.dayList}" var="day">
				<option value="${day}"<c:if test="${searchVO.searchDay eq day}"> selected="selected"</c:if>>${day}일</option>
			</c:forEach>
		</select>
	</form>
</div>

<!-- 그래프 -->
<div id="_chart1" class="mar_b10"></div>
<!-- //그래프 -->

<h4>조회기간 : ${searchVO.searchTerm}</h4>

<table width="100%">
	<tr>
		<td width="45%" class="vt">
			<table class="boardList" summary="기간별 통계">
				<caption>기간별 통계</caption>
				<colgroup>
					<col width="200px" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tr>
					<th>항목</th>
					<th>게시물등록</th>
					<th>게시물삭제</th>
					<th class="lr_none">덧글등록</th>
				</tr>
				<tr>
					<th>최대</th>
					<td>
						${dataVo.dataSetList[0].maxCnt}개
						<c:if test="${!empty dataVo.dataSetList[0].maxIndexList}">
							<span class="emphasis">${dataVo.dataSetList[0].maxIndexList}</span>
						</c:if>
					</td>
					<td>
						${dataVo.dataSetList[1].maxCnt}개
						<c:if test="${!empty dataVo.dataSetList[1].maxIndexList}">
							<span class="emphasis">${dataVo.dataSetList[1].maxIndexList}</span>
						</c:if>
					</td>
					<td class="lr_none">
						${dataVo.dataSetList[2].maxCnt}개
						<c:if test="${!empty dataVo.dataSetList[2].maxIndexList}">
							<span class="emphasis">${dataVo.dataSetList[2].maxIndexList}</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>전체평균</th>
					<td>${dataVo.dataSetList[0].avgCnt}개</td>
					<td>${dataVo.dataSetList[1].avgCnt}개</td>
					<td class="lr_none">${dataVo.dataSetList[2].avgCnt}개</td>
				</tr>
				<tr>
					<th>0초과 평균</th>
					<td>${dataVo.dataSetList[0].zeroAvgCnt}개</td>
					<td>${dataVo.dataSetList[1].zeroAvgCnt}개</td>
					<td class="lr_none">${dataVo.dataSetList[2].zeroAvgCnt}개</td>
				</tr>
				<tr>
					<th>최소</th>
					<td>
						${dataVo.dataSetList[0].minCnt}개
						<c:if test="${!empty dataVo.dataSetList[0].minIndexList}">
							<span class="emphasis">${dataVo.dataSetList[0].minIndexList}</span>
						</c:if>
					</td>
					<td>
						${dataVo.dataSetList[1].minCnt}개
						<c:if test="${!empty dataVo.dataSetList[1].minIndexList}">
							<span class="emphasis">${dataVo.dataSetList[1].minIndexList}</span>
						</c:if>
					</td>
					<td class="lr_none">
						${dataVo.dataSetList[2].minCnt}개
						<c:if test="${!empty dataVo.dataSetList[2].minIndexList}">
							<span class="emphasis">${dataVo.dataSetList[2].minIndexList}</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>전체</th>
					<td>${dataVo.dataSetList[0].totalCnt}개</td>
					<td>${dataVo.dataSetList[1].totalCnt}개</td>
					<td class="lr_none">${dataVo.dataSetList[2].totalCnt}개</td>
				</tr>
			</table>
		</td>
		<td class="vt pad_l12">
			<table id="dataList" class="boardList" summary="통계 상세">
				<caption>통계 상세</caption>
				<colgroup>
					<col width="150px" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tr>
					<th>항목</th>
					<th>${dataVo.dataSetList[0].dataSetNm}</th>
					<th>${dataVo.dataSetList[1].dataSetNm}</th>
					<th class="lr_none">${dataVo.dataSetList[2].dataSetNm}</th>
				</tr>
				<tbody>
					<c:forEach items="${dataVo.categoryList}" var="category" varStatus="status">
						<tr>
							<th>${category}</th>
							<td class="tx_r">${dataVo.dataSetList[0].dataList[status.index]}</td>
							<td class="tx_r">${dataVo.dataSetList[1].dataList[status.index]}</td>
							<td class="lr_none tx_r">${dataVo.dataSetList[2].dataList[status.index]}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</td>
	</tr>
</table>