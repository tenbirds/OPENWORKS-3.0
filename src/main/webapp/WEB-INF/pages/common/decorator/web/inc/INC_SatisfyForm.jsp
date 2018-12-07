<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${cmsVo.satisfyShowYn eq 'Y'}">
            <div class="pollbox">
                <form id="frmSatisfy" name="frmSatisfy" method="post" action="/web/satisfy/ND_InsertAction.do" onsubmit="return jsSubmit();">
                    <fieldset>
                    <legend class="hide">현재 컨텐츠에 대한 만족도 조사</legend>
                    <input type="hidden" name="menuCode" value="${cmsVo.menuCode}"/>
                    <input type="hidden" name="domainCd" value="${cmsVo.domainCd}"/>
                    <ul class="pol">
                        <li>
                            <span>이 페이지 내용에 만족하셨습니까?</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input name="itemNo" type="radio" value="5" title="매우만족" alt="매우만족" id="itemNo_5"/>
                            <label for="r1">매우만족</label>&nbsp;&nbsp;
                            <input name="itemNo" type="radio" value="4" title="만족" alt="만족"  id="itemNo_4" />
                            <label for="r2">만족</label>&nbsp;&nbsp;
                            <input name="itemNo" type="radio" value="3" title="보통" alt="보통"  id="itemNo_3" />
                            <label for="r3">보통</label>&nbsp;&nbsp;
                            <input name="itemNo" type="radio" value="2" title="불만족" alt="불만족"  id="itemNo_2" />
                            <label for="r4">불만족</label>&nbsp;&nbsp;
                            <input name="itemNo" type="radio" value="1" title="매우불만족" alt="매우불만족" id="itemNo_1" />
                            <label for="r5">매우불만족</label>
                        </li>
                        <li>
                            <input type="text" name="comments" style="border:1px solid #333333;" title="컨텐츠에 대한 내용을 입력해주세요" value=""/>&nbsp;
                            <label for="r6"><input type="submit" value="만족도 등록" title="컨텐츠 만족도 등록"/></label>
                        </li>
                    </ul>
                    </fieldset>
                </form>
            </div>
            <script type="text/javascript">
                var jsSubmit = function() {
                    $("#frmSatisfy").ajaxSubmit({
                        url   : $(this).attr("action"),
                        type     : "POST",
                        dataType : "json",
                        beforeSubmit : function(){
                            var itemNoVal = $("input[name='itemNo']:checked").val();
                            if(!itemNoVal) {
                                alert("만족도 항목을 선택하세요.");
                                return false;
                            }
                            /*
                            if(itemNoVal == "2" || itemNoVal == "1") {
                                var comments = $.trim($("#comments").val());
                                if(comments == "" || comments.length <= 10) {
                                    alert("불만족 사유를 10자 이상으로 등록하여 주세요.");
                                    return false;
                                }
                            }
                            */
                            return true;
                        },
                        success  : function(response){
                            if(response.result) {
                                alert("만족도 평가를 등록하였습니다.");
                            } else {
                                alert(response.message);
                            }
                        }
                    });
                    return false;
                }
            </script>
</c:if>
