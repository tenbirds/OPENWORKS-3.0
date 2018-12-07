<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="extjs4" />

<script type="text/javascript">
	var jsReloadTerm = function(){
		var typeCd = $("#typeCd2").val();
		var year = $("#searchYear2").val();
		logTab.changeUrl(logTab.selectedIndex, 'INC_fileLog.do?typeCd=' + typeCd + '&searchYear=' + year);
		logTab.refresh();
	};

	//차트 관련
	Ext.require(['Ext.chart.*',
				 'Ext.data.*',
				 'Ext.layout.container.Fit']);

	Ext.onReady(function(){
		var getData1 = function(){
			var fileds = ['name', '다운로드횟수', '다운로드사이즈'];
			var data   = [];

			$('#dataList2 tbody tr').each(function(index){
				data[index] = { name			: $(this).find('th').eq(0).text(),					//구분
								다운로드횟수	: parseInt($(this).find('td').eq(0).text(), 10),	//다운로드 갯수
								다운로드사이즈	: parseInt($(this).find('td').eq(1).text(), 10)};	//다운로드 사이즈
			});

			//항목 삭제
			data = data.slice(1, data.length);

			return Ext.create('Ext.data.JsonStore', {
				fields : fileds,
				data   : data
			});
		};

		var getData2 = function(){
			var fileds = ['name', '업로드횟수', '업로드사이즈'];
			var data   = [];

			$('#dataList2 tbody tr').each(function(index){
				data[index] = { name		: $(this).find('th').eq(0).text(),					//구분
								업로드횟수	: parseInt($(this).find('td').eq(2).text(), 10),	//업로드 갯수
								업로드사이즈: parseInt($(this).find('td').eq(3).text(), 10)};	//업로드 사이즈
			});

			//항목 삭제
			data = data.slice(1, data.length);

			return Ext.create('Ext.data.JsonStore', {
				fields : fileds,
				data   : data
			});
		};

		var chart1 = Ext.create('Ext.chart.Chart', {
			xtype: 'chart',
			flex : 1,
			animate: true,
			shadow: true,
			legend: {
				position: 'bottom'
			},
			store: getData1(),
			axes: [{
				type: 'Numeric',
				position: 'left',
				fields: ['다운로드횟수', '다운로드사이즈'],
				title: '건수',
				grid: true,
				minimum: 0
			}, {
				type: 'Category',
				position: 'bottom',
				fields: ['name'],
				title: '연도'
			}],
			series: [{
				type: 'column',
				axis: 'left',
				xField: 'name',
				yField: '다운로드횟수',
				tips: {
					trackMouse: true,
					maxWidth : 150,
					width: 150,
					height: 25,
					renderer: function(storeItem, item){
						this.setTitle("파일 다운 횟수 : " + storeItem.get('다운로드횟수') + "개");
					}
				},
				label: {
					display: 'insideEnd',
					'text-anchor': 'middle',
					field: '다운로드횟수',
					renderer: Ext.util.Format.numberRenderer('0'),
					orientation: 'horizontal',
					color: '#333'
				}
			}, {
				type: 'line',
				highlight: {
					size: 7,
					radius: 7
				},
				axis: 'left',
				fill: true,
				xField: 'name',
				yField: '다운로드사이즈',
				markerCfg: {
					type: 'cross',
					size: 4,
					radius: 4,
					'stroke-width': 0
				},
				tips: {
					trackMouse: true,
					maxWidth : 180,
					width: 180,
					height: 25,
					renderer: function(storeItem, item){
						this.setTitle("다운로드 사이즈(MB) : " + storeItem.get('다운로드사이즈') + "MB");
					}
				},
				label: {
					display: 'insideEnd',
					'text-anchor': 'middle',
					field: '다운로드사이즈',
					renderer: Ext.util.Format.numberRenderer('0'),
					orientation: 'horizontal',
					color: '#333'
				}
			}]
		});

		var chart2 = Ext.create('Ext.chart.Chart', {
			xtype: 'chart',
			flex : 1,
			animate: true,
			shadow: true,
			legend: {
				position: 'bottom'
			},
			store: getData2(),
			axes: [{
				type: 'Numeric',
				position: 'left',
				fields: ['업로드횟수', '업로드사이즈'],
				title: '건수',
				grid: true,
				minimum: 0
			}, {
				type: 'Category',
				position: 'bottom',
				fields: ['name'],
				title: '연도'
			}],
			series: [{
				type: 'column',
				axis: 'left',
				xField: 'name',
				yField: '업로드횟수',
				tips: {
					trackMouse: true,
					maxWidth : 150,
					width: 150,
					height: 25,
					renderer: function(storeItem, item){
						this.setTitle("파일 등록 횟수 : " + storeItem.get('업로드횟수') + "개");
					}
				},
				label: {
					display: 'insideEnd',
					'text-anchor': 'middle',
					field: '업로드횟수',
					renderer: Ext.util.Format.numberRenderer('0'),
					orientation: 'horizontal',
					color: '#333'
				}
			}, {
				type: 'line',
				highlight: {
					size: 7,
					radius: 7
				},
				axis: 'left',
				fill: true,
				xField: 'name',
				yField: '업로드사이즈',
				markerCfg: {
					type: 'cross',
					size: 4,
					radius: 4,
					'stroke-width': 0
				},
				tips: {
					trackMouse: true,
					maxWidth : 180,
					width: 180,
					height: 25,
					renderer: function(storeItem, item){
						this.setTitle("업로드 사이즈(MB) : " + storeItem.get('업로드사이즈') + "MB");
					}
				},
				label: {
					display: 'insideEnd',
					'text-anchor': 'middle',
					field: '업로드사이즈',
					renderer: Ext.util.Format.numberRenderer('0'),
					orientation: 'horizontal',
					color: '#333'
				}
			}]
		});

		Ext.create('widget.panel', {
			height: 350,
			title: '${searchVO.searchYear}년 연간 파일 다운로드 통계',
			renderTo: '_chart2',
			layout: 'fit',
			items: chart1
		});

		Ext.create('widget.panel', {
			height: 350,
			title: '${searchVO.searchYear}년 연간 파일 업로드 통계',
			renderTo: '_chart3',
			layout: 'fit',
			items: chart2
		});
	});
</script> 


<div class="mar_b10">
	<form>
		<select id="typeCd2" onchange="jsReloadTerm();">
			<c:forEach items="${termCdList}" var="kvBean">
				<option value="${kvBean.key}"<c:if test="${searchVO.typeCd eq kvBean.key}"> selected="selected"</c:if>>${kvBean.value}</option>
			</c:forEach>
		</select>

		<select id="searchYear2" onchange="jsReloadTerm();">
			<c:forEach items="${searchVO.yearList}" var="year">
				<option value="${year}"<c:if test="${searchVO.searchYear eq year}"> selected="selected"</c:if>>${year}년</option>
			</c:forEach>
		</select>
	</form>
</div>

<!-- 그래프 -->
<div id="_chart2" class="mar_b10"></div>
<div id="_chart3" class="mar_b10"></div>
<!-- //그래프 -->

<h4>조회기간 : ${searchVO.searchTerm}</h4>

<table width="100%">
	<tr>
		<td width="45%" class="vt">
			<table class="boardList" summary="기간별 통계">
				<caption>기간별 통계</caption>
				<colgroup>
					<col width="150px" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tr>
					<th>항목</th>
					<th>다운로드횟수</th>
					<th>다운로드사이즈</th>
					<th>업로드횟수</th>
					<th class="lr_none">업로드사이즈</th>
				</tr>
				<tr>
					<th>최대</th>
					<td>
						${dataVo.dataSetList[0].maxCnt}회
						<c:if test="${!empty dataVo.dataSetList[0].maxIndexList}">
							<span class="emphasis">${dataVo.dataSetList[0].maxIndexList}</span>
						</c:if>
					</td>
					<td>
						${dataVo.dataSetList[1].maxCnt}MB
						<c:if test="${!empty dataVo.dataSetList[1].maxIndexList}">
							<span class="emphasis">${dataVo.dataSetList[1].maxIndexList}</span>
						</c:if>
					</td>
					<td>
						${dataVo2.dataSetList[0].maxCnt}회
						<c:if test="${!empty dataVo2.dataSetList[0].maxIndexList}">
							<span class="emphasis">${dataVo2.dataSetList[0].maxIndexList}</span>
						</c:if>
					</td>
					<td>
						${dataVo2.dataSetList[1].maxCnt}MB
						<c:if test="${!empty dataVo2.dataSetList[1].maxIndexList}">
							<span class="emphasis">${dataVo2.dataSetList[1].maxIndexList}</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>전체 평균</th>
					<td>${dataVo.dataSetList[0].avgCnt}회</td>
					<td>${dataVo.dataSetList[1].avgCnt}Mb</td>
					<td>${dataVo2.dataSetList[0].avgCnt}회</td>
					<td>${dataVo2.dataSetList[1].avgCnt}Mb</td>
				</tr>
				<tr>
					<th>0초과 평균</th>
					<td>${dataVo.dataSetList[0].zeroAvgCnt}회</td>
					<td>${dataVo.dataSetList[1].zeroAvgCnt}Mb</td>
					<td>${dataVo2.dataSetList[0].zeroAvgCnt}회</td>
					<td>${dataVo2.dataSetList[1].zeroAvgCnt}Mb</td>
				</tr>
				<tr>
					<th>최소</th>
					<td>
						${dataVo.dataSetList[0].minCnt}회
						<c:if test="${!empty dataVo.dataSetList[0].minIndexList}">
							<span class="emphasis">${dataVo.dataSetList[0].minIndexList}</span>
						</c:if>
					</td>						
					<td>
						${dataVo.dataSetList[1].minCnt}MB
						<c:if test="${!empty dataVo.dataSetList[1].minIndexList}">
							<span class="emphasis">${dataVo.dataSetList[1].minIndexList}</span>
						</c:if>
					</td>						
					<td>
						${dataVo2.dataSetList[0].minCnt}회
						<c:if test="${!empty dataVo2.dataSetList[0].minIndexList}">
							<span class="emphasis">${dataVo2.dataSetList[0].minIndexList}</span>
						</c:if>
					</td>						
					<td>
						${dataVo2.dataSetList[1].minCnt}MB
						<c:if test="${!empty dataVo2.dataSetList[1].minIndexList}">
							<span class="emphasis">${dataVo2.dataSetList[1].minIndexList}</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>전체</th>
					<td>${dataVo.dataSetList[0].totalCnt}회</td>
					<td>${dataVo.dataSetList[1].totalCnt}MB</td>
					<td>${dataVo2.dataSetList[0].totalCnt}회</td>
					<td>${dataVo2.dataSetList[1].totalCnt}MB</td>
				</tr>
			</table>
		</td>
		<td class="vt pad_l12">
			<table id="dataList2" class="boardList" summary="통계 상세">
				<caption>통계 상세</caption>
				<colgroup>
					<col width="150px" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tr>
					<th>항목</th>
					<th>${dataVo.dataSetList[0].dataSetNm}</th>
					<th>${dataVo.dataSetList[1].dataSetNm}</th>
					<th>${dataVo2.dataSetList[0].dataSetNm}</th>
					<th class="lr_none">${dataVo2.dataSetList[1].dataSetNm}</th>
				</tr>
				<tbody>
					<c:forEach items="${dataVo.categoryList}" var="category" varStatus="status">
						<tr>
							<th>${category}</th>
							<td class="tx_r">${dataVo.dataSetList[0].dataList[status.index]}</td>
							<td class="tx_r">${dataVo.dataSetList[1].dataList[status.index]}</td>
							<td class="tx_r">${dataVo2.dataSetList[0].dataList[status.index]}</td>
							<td class="lr_none tx_r">${dataVo2.dataSetList[1].dataList[status.index]}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</td>
	</tr>
</table>