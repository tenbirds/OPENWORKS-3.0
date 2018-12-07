<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>이벤트 상세</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="highlight" />
<script type="text/javascript">

    $().ready(function () {

        
        
    }); //ready end

    var jsList = function(){
        location.href = "BD_index.do";
    };

    var jsBack = function(event){
        history.go(-1);
        event.preventDefault();
    };
    
    var jsUpdate = function(){
        document.dataForm2.action = "BD_updateForm.do?eventSn=${baseList.eventSn}";
        document.dataForm2.submit();
    };


    var jsAnswerList = function(el){

        var url = "eventSn=" + ${baseList.eventSn} ;
             url += "&eventTitle=" + "<c:out value="${baseList.eventTitle}" />" ;
             url += "&beginDate=" + "${baseList.beginDate}" ;
             url += "&endDate=" + "${baseList.endDate}" ;
        
        $(el).colorbox({
            title : "이벤트 댓글",
            href  : "PD_answerList.do?" + url,
            width : "800",
            height: "500",
            iframe: true
        });
    };
    /**
     * 목록 삭제
     */
    var jsDelete = function(){
        var url = "ND_deleteAction.do?";
        url += "eventSns=" + ${baseList.eventSn} + "&fileIds=" +  ${baseList.eventThumbFileSeq} ;

        if(confirm("이벤트를 정말 삭제하시겠습니까?")){
            $.post(url,
                    function(response){
                        try {
                            if(eval(response)) {
                                jsSuccessBox(Message.msg.deleteOk);
                                jsList();
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
                        } catch (e) {
                            jsSysErrorBox(response, e);
                            return;
                        }
                    });
        }
    };
    
</script>
</head>
<body>

     <form name="dataForm2" id="dataForm2" method="post">
     </form>

    <!-- 컨텐츠영역 -->
    <div id="contents">
        <form id="dataForm" enctype="multipart/form-data" method="post">
            <input type="hidden" id="eventSn" name="eventSn" value="${baseList.eventSn}" />
            <input type="hidden" id="eventThumbFileSeq" name="eventThumbFileSeq" value="${baseList.eventThumbFileSeq}" />
            
            
            <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
               <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                  <tr>
                    <th>제목</th>
                    <td>
                      <c:out value="${baseList.eventTitle}" />
                    </td>
                  </tr>
                  <tr>
                    <th>이벤트구분</th>
                    <td>${baseList.eventTyNm}</td>
                  </tr>
                  <tr>
                    <th>사이트</th>
                    <td>
                        <c:forEach items="${dataVo}" var="_bean" varStatus="status">
                          <c:if test="${not empty _bean.checkYn}">
                            ${_bean.domainDc}&nbsp; 
                          </c:if> 
                        </c:forEach>
                    </td>
                  </tr>
                  <tr>
                    <th>메뉴구분</th>
                    <td>
                          <c:forEach items="${dataVo1}" var="_bean" varStatus="status">
                             <c:if test="${not empty _bean.checkYn}"> 
                                ${_bean.eventLcSeNm}&nbsp;
                             </c:if>
                          </c:forEach>
                    </td>
                  </tr>
                  <tr>
                    <th>기간</th>
                    <td>
                        <c:if test="${not empty baseList.beginDate}">
                            ${fn:substring(baseList.beginDate,0,4)}-${fn:substring(baseList.beginDate,4,6)}-${fn:substring(baseList.beginDate,6,8)} ~&nbsp;
                        </c:if>
                        <c:if test="${not empty baseList.endDate}"> 
                            ${fn:substring(baseList.endDate,0,4)}-${fn:substring(baseList.endDate,4,6)}-${fn:substring(baseList.endDate,6,8)}
                        </c:if>
                    </td>
                  </tr>
                  <c:if test="${baseList.eventTyCd eq '1002'}">
                  <tr>
                    <th>발표일</th>
                    <td>
                        <c:if test="${not empty baseList.presnatnDate}"> 
                            ${fn:substring(baseList.presnatnDate,0,4)}-${fn:substring(baseList.presnatnDate,4,6)}-${fn:substring(baseList.presnatnDate,6,8)}
                        </c:if>
                        <c:if test="${not empty baseList.presnatnHm}">
                            ${fn:substring(baseList.presnatnHm,0,2)}:${fn:substring(baseList.presnatnHm,2,4)}
                        </c:if>
                    </td>
                  </tr>
                  </c:if>
                  <tr>
                    <th>내용</th>
                    <td>
                      <c:out value="${baseList.eventCn}" />
                    </td>
                  </tr>
                  <tr>
                    <th>진행상태</th>
                    <td>
                        ${baseList.eventStatus}
                    </td>
                  </tr>
                  <tr>
                    <th>링크URL</th>
                    <td>
                        ${baseList.linkUrl}
                    </td>
                  </tr>
                  <tr>
                    <th>담청자 확인 URL</th>
                    <td>
                        ${baseList.przwnerCnfirmUrl}
                    </td>
                  </tr>
                  <tr>
                    <th>조회수</th>
                    <td>
                        ${baseList.eventRdcnt}
                    </td>
                  </tr>
                  <tr>
                    <th>참여자수</th>
                    <td>
                    <c:if test="${baseList.partcptnCnt > 0}">
                        <a href="#" onclick="jsAnswerList(this);">${baseList.partcptnCnt}</a>
                    </c:if>
                    <c:if test="${baseList.partcptnCnt <= 0}">
                        0
                    </c:if>
                    </td>
                  </tr>
                </tbody>
            </table>
            
            <!-- 버튼 -->
            <div class="btn_r">
                <ul>
                    
                    <c:if test="${not empty baseList.eventSn}">
                        <c:if test="${(MenuAssignType eq 'A' && baseList.registId eq __msk.mgrId) or MenuAssignType eq 'G'}">
                            <li><a href="#" onclick="jsUpdate();"><button class="blue" type="button">수정</button></a></li>
                            <li><a href="#" onclick="jsDelete();"><button class="blue" type="button">삭제</button></a></li>
                        </c:if>
                    </c:if>
                    <li><a href="#"  onclick="jsBack(event);"><button class="blue" type="button">목록</button></a></li>
                </ul>
            </div>
            <!-- //버튼 -->
            
        </form>
    </div>
</body>
 상세

</html>