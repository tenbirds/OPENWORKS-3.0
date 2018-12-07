<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<c:set var="requestMap" value="${noteVO.dataMap}"/>
<c:set var="flag" value="${empty param.flag ? '1' : param.flag}" />
<c:set var="title" value="${flag == 1 ? '쪽지 관리' : '쪽지 관리'}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>${title}</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />

    <op:jsTag type="spi" items="extjs, form, autocomplete, ui, extjs-ux, highlight" />
    <op:jsTag type="openworks" items="form, ui" />

    <script type="text/javascript">
    //<![CDATA[
        $(document).ready(function() {
            jsSearchKey();

        });

        // 상세
        var flag = '${flag}';
        var jsView = function(seq) {

            if ( $("#msg" + seq).is(":hidden") ) {

                if ( flag == '1' && $("#_readDt" + seq).val() == "" ) {
                    $.post(
                        "INC_noteView.do", {
                            seq : seq,
                            flag: '${flag}'
                            }, function (data) {
                                    $("#_readDt" + seq).val(data.readDt);
                                    //$("#_h" + seq).fadeIn('slow');
                                    $("#_h" + seq).show();
                                    $("#msg" + seq).show(500, function(){});
                                    //$("#msg" + seq).slideDown(500, function(){});



                                    $("#noteImg" + seq).html('<img alt="읽음" src="<c:url value="/resources/intra/note/images/read_note.gif"/>" style="vertical-align:middle"/>');
                                    $("#_a" + seq).addClass("read-note");
                            }, 'json');
                } else {
                    $("#_h" + seq).show(500, function(){});
                    $("#msg" + seq).show();
                }
            } else {
                $("#_h" + seq).hide();
                $("#msg" + seq).hide();


            }
        };

        var jsDeleteAction = function(seq) {
            var message = "";
            if (flag == "1") {
                message = "받은 쪽지를 삭제 하시겠습니까?";
            }
            if (flag == "2") {
                message = "보낸 쪽지를 삭제 하시겠습니까?\n\n수신자의 쪽지는 삭제되지 않습니다.";
            }
            if (confirm(message)) {
                $.ajax({
    				type: "POST",
    				url: "INC_deleteAction.do",
    				data: {
				    	seq : seq,
				    	flag : '${flag}'
					},
    				success: function(response){
    				    try {
    				        if(eval(response)) {
    				            jsSuccessBox(Message.msg.deleteOk);
                                $('#dataForm').submit();
    				        } else {
    				            jsErrorBox(Message.msg.processFail);
    				        }
    				    } catch (e) {
    				        jsSysErrorBox(response, e);
    				        return;
    				    }
    				}
    			});
            }
        };

        var jsCheckedArray = function() {
            var selectedNotes = new Array();

            $(".checkbox:checked").each(function(i) {
                selectedNotes[i] = $(this).val();
            });
            return selectedNotes;
        };

        var jsDeleteAllAction = function() {

            var selectedNotes = jsCheckedArray();
            if (selectedNotes.length == 0) {
                jsWarningBox("삭제 대상 쪽지를 1개 이상 선택하세요.");
                return false;
            } else {
                if (confirm("선택한 " + selectedNotes.length + "개의 쪽지를 삭제 하시겠습니까?")) {
                    $.ajax({
        				type: "POST",
        				url: "INC_deleteAction.do",
        				data: {
    				    	arraySeq : selectedNotes,
    				    	flag     : '${flag}'
    					},
        				success: function(response){
                            if(response) {
                                jsSuccessBox(selectedNotes.length + "개의 쪽지가 삭제 되었습니다.");
                                $('#dataForm').submit();
                            } else {
                                jsErrorBox(Message.msg.processFail);
                            }
        				}
        			});
                }
            }
        };

        // 페이지이동
        var jsMenuClick = function(flag) {
            document.dataForm.action = "BD_index.do";
            document.dataForm.elements["flag"].value = flag;
            document.dataForm.elements["q_currPage"].value = "0";
            document.dataForm.elements["q_searchKey"].value = "";
            document.dataForm.elements["q_searchVal"].value = "";
            document.dataForm.submit();
        };

        // 검색
        var jsSearch = function() {

                if ( $("#q_searchKey").val() != "" && $("#q_searchVal").val() == "" ) {
                    jsWarningBox("검색어를 입력하세요.");
                    $("#q_searchVal").focus();
                    return false;
                }
                document.dataForm.action = "BD_index.do";
                document.dataForm.elements["q_currPage"].value = "1";
                document.dataForm.submit();
        };

        // 검색조건 선택시.
        var jsSearchKey = function(){
            if($("#q_searchKey").val() == ""){
                $("#q_searchVal").attr('disabled',true);
                $("#q_searchVal").val("");
            }else if($("#q_searchKey").val() != ""){
                $("#q_searchVal").attr('disabled',false);

            }
        };

        var jsMovePage = function (page) {
	    	var p = 1;
	    	if (page == 'page') {
	    	    p = $('input[name=page]').val();
	    	} else {
	    		p = page;
	    	}
	        $('#dataForm input[name=q_currPage]').val(p);
	        $('#dataForm').submit();
	    };
    //]]>
    </script>
</head>

<body>
   <!-- 탭 영역 시작 -->
<ul class="tab">
    <li>
    	<a href="javaScript:jsMenuClick(1);" <c:if test="${flag == 1}"> class="on" </c:if>><span>받은 쪽지함</span> </a>
    </li>
    <li>
    	<a href="javaScript:jsMenuClick(2);" <c:if test="${flag == 2}"> class="on" </c:if>> <span>보낸 쪽지함</span> </a>
    </li>
    <li>
    	<a href="BD_insertForm.do?flag=${flag}"><span>쪽지 보내기</span> </a>
    </li>
</ul>
   <!-- 탭 영역 끝 -->

   <form name="dataForm" id="dataForm" method="post" action="BD_index.do">
       <input type="hidden" name="flag" value="${flag}" />
       <input type="hidden" name="" value="" />

       <!-- 캡션 영역 끝 -->

       <!-- 검색 영역 시작 -->
       <div class="search">
           <select id="q_searchKey" name="q_searchKey" onchange="jsSearchKey();">
               <option value="">- 전체 -</option>
               <option value="1001" <c:if test="${param.q_searchKey eq '1001'}">selected="selected"</c:if>>쪽지함 내용</option>
               <c:if test="${flag == 1}">
                   <option value="1002" <c:if test="${param.q_searchKey eq '1002'}">selected="selected"</c:if>>보낸이</option>
               </c:if>
               <c:if test="${flag == 2}">
                   <option value="1003" <c:if test="${param.q_searchKey eq '1003'}">selected="selected"</c:if>>받는이</option>
               </c:if>
           </select>
           <input type="text" id="q_searchVal" name="q_searchVal" value="${param.q_searchVal}" class="text-input-search w-200" />
           <button type="button" onclick="jsSearch();" class="gray mar_l5 mar_b5">검색</button>
       </div>
       <!-- 검색 영역 끝 -->

       <op:pagerParam title="쪽지 목록" />
   </form>

   <!-- 게시판 목록 시작 -->
   <div class="list-table">
       <table class="boardList" summary="쪽지함 목록">
           <caption>쪽지함 목록</caption>
           <colgroup>
               <col width="3%" />
               <col width="" />
               <c:if test="${flag == 1}">
                   <col width="100px" />
                   <col width="150px" />
               </c:if>
               <c:if test="${flag == 2}">
                   <col width="100px" />
                   <col width="150px" />
                   <col width="150px" />
               </c:if>
           </colgroup>
           <thead>
               <tr>
                   <th><input type="checkbox" name="chk-all" id="chk-all" class="checkbox" /></th>
                   <th>쪽지함 내용</th>
                   <c:if test="${flag == 1}">
                       <th>보낸이</th>
                       <th class="no-bg">받은날짜</th>
                   </c:if>
                   <c:if test="${flag == 2}">
                       <th>받는이</th>
                       <th>읽은날짜</th>
                       <th class="no-bg">보낸날짜</th>
                   </c:if>
               </tr>
           </thead>
           <tbody>
           	   <c:set var="index" value="${pager.indexNo}" />
               <c:forEach items="${pager.list}" var="noteVo" varStatus="status">
                   <c:set var="isRead" value="${empty noteVo.readDt ? 'N' : 'Y'}" />
                   <tr <c:if test="${(index-status.index)%2==0}">class="bg_yellow"</c:if>>
                       <td><input type="checkbox" name="seqs" id="seqs" class="checkbox" value="${noteVo.seq}" /></td>
                       <td id="_a${noteVo.seq}"  class="tx_l<c:if test="${isRead eq 'Y'}"> read-note</c:if>"><a href="javascript:jsView('${noteVo.seq}')" id="_summary${noteVo.seq}">
                       		<c:choose>
                            	<c:when test="${isRead eq 'Y'}">
                                	<img alt="읽음" src="<c:url value="/resources/intra/note/images/read_note.gif"/>" style="vertical-align: middle" />
                               	</c:when>
                                <c:otherwise>
                                	<span id="noteImg${noteVo.seq}"> <img alt="새 쪽지" src="<c:url value="/resources/intra/note/images/new_note.gif"/>" style="vertical-align: middle;" /> </span>
                              	</c:otherwise>
                          	</c:choose> ${noteVo.summary} </a>
							<c:if test="${noteVo.fileCnt > 0}">
								<a href="/component/file/zipdownload.do?fileSeq=${noteVo.fileSeq}" class="t_file" title="첨부파일이 ${noteVo.fileCnt}개 존재합니다.">(${noteVo.fileCnt})</a>
							</c:if>
                       </td>
                       <c:if test="${flag == 1}">
                           <td>${noteVo.senderNm} <input type="hidden" id="_readDt${noteVo.seq}" value="${noteVo.readDt}" />
                           </td>
                       </c:if>
                       <c:if test="${flag == 2}">
                           <td>${noteVo.mgrNm}</td>
                           <c:set var="readDt" value="${empty noteVo.readDt ? '읽지 않음' : noteVo.readDt}" />
                           <td>${readDt}</td>
                       </c:if>
                       <td class="lr_none">${noteVo.regDt}</td>
                   </tr>
                   <tr id="_h${noteVo.seq}" style="display: none">
                       <td id="_v${noteVo.seq}" colspan="<c:if test="${flag == 1}">4</c:if><c:if test="${flag == 2}">5</c:if>"
                           class="tx_l lr_none" style="padding-left : 80px;">
                           <div class="msg-view" id="msg${noteVo.seq}">
                               ${noteVo.contents}

                               <c:if test="${!empty noteVo.fileList}">
                                    <c:forEach items="${noteVo.fileList}" var="fileBean" varStatus="status">
                                        <p style="text-align: right;margin:2px;">
                                            <img src="/resources/openworks/theme/default/images/icon/icon_file.gif" alt="첨부파일" />
                                            <a href="<c:url value="/component/file/ND_fileDownload.do?id=${fileBean.fileId}"/>" title="${fileBean.localNm} 다운로드">${fileBean.localNm}</a>
                                            (${fileBean.fileSize}, ${fileBean.fileType}, 다운 ${fileBean.downCnt} 회)
                                        </p>
                                    </c:forEach>
                               </c:if>

                               <button type="button" class="float_r s_blue" onclick="jsDeleteAction('${noteVo.seq}');">삭제</button>
                           </div>
                       </td>
                   </tr>
               </c:forEach>

               <c:if test="${flag == 1}">
                   <op:no-data obj="${pager}" colspan="4" />
               </c:if>
               <c:if test="${flag == 2}">
                   <op:no-data obj="${pager}" colspan="5" />
               </c:if>

           </tbody>
       </table>
   </div>
   <!-- 게시판 목록 끝 -->

   <br/>
   <br/>
   <!-- 게시판 하단 영역 시작 -->

   <!-- 페이징 영역 시작 -->
   <op:pager pager="${pager}" />
   <div>
       <div class="float_r">
           <button type="button" class="w_blue" onclick="jsDeleteAllAction();">선택쪽지 삭제</button>
       </div>
   </div>

</body>
</html>
