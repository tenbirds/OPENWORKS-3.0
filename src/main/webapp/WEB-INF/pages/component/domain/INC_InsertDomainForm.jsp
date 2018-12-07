<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<script type="text/javascript">
//<CDATA[[

    // 패밀리 사이트 추가
    var addDomainGroup = function() {
        $("#domainGroupDiv").append($("#domainGroupDummy").html());
    };

    // 패밀리 사이트 삭제
    var delDomainGroup = function(obj) {
        $(obj).parent().remove();
        if ($.trim($("#domainGroupDiv").html()) == "") {
            addDomainGroup();
        }
    };

    $().ready(function() {

        $("#domainNm").focus();

        $("#dataForm").validate({
            <valid:script type="jquery" />,
            submitHandler: function(form) {
                $(form).ajaxSubmit({
                    url      : "ND_InsertAction.do",
                    type     : "POST",
                    dataType : "json",
                    success  : function(response) {
                        if (response.result) {
                            jsSuccessBox(response.message);
                        } else { 
                            jsErrorBox(response.message);
                        }
                    },
                    error :  function(response) {
                        jsSysErrorBox(response.responseText);
                        return;
                    }
                });
            }
        });

        /** 사이트담당자 설정 Autocomplete */
        $("input[name=chargerNm]").autocomplete({
            minLength: ($.browser.mozilla ? 1: 2),
            delay: ($.browser.mozilla ? 800: 10),
            source: function(request, response) {
                $.ajax({
                    url: "<c:url value="/intra/mgr/ND_mgrSearchList.do" />",
                    type: "POST",
                    dataType: "json",
                    data: {
                        q_rowPerPage: 20,
                        useYn: "Y",
                        mgrNm: request.term
                    },
                    success: function( data ) {
                        response(data);
                    }
                });
            },
            select: function( event, ui ) {
                $("#chargeDeptNm").val(ui.item.deptNm);
                $("#chargerNm").val(ui.item.mgrNm);

                $("#chargerId").val(ui.item.mgrId);
                $("#chargeDeptCode").val(ui.item.deptCd);
            }
        });
    });

//]]>
</script>

<form id="dataForm">

    <h4 class="tx_13">신규 등록</h4>

    <table class="boardWrite" summary="사이트 등록" >
        <caption class="title">신규 등록</caption>
        <colgroup>
            <col width="20%" />
            <col width="80%" />
        </colgroup>
        <tbody>
        <tr>
            <th>사이트 주소<span class="tx_red tx_b">*</span></th>
            <td>
                <input type="text" id="domainNm" name="domainNm" value="" maxlength="50" style="width:200px;"/> 
                포트 : <input type="text" id="portNo" name="portNo" value="80" maxlength="5" style="width:40px;"/> 
                컨텍스트 : <input type="text" id="contextPath" name="contextPath" value="" maxlength="25" style="width:120px;"/>

            </td>
        </tr>

        <tr>
            <th>IP 주소</th>
            <td>
                <span class="tx_blue_s">컨텐츠를 동기화하기 위한 패밀리 서버를 등록합니다.</span>
                <div id="domainGroupDummy" style="display:none">
                    <div style="margin-bottom:5px;">
                        <input type="text" id="groupIpAddr" name="groupIpAddr" value="" maxlength="50" style="width:200px;"/> 
                        포트 : <input type="text" id="groupPortNo" name="groupPortNo" value="80"maxlength="5" style="width:40px;"/>

                        <button type="button" class="s_blue" onclick="addDomainGroup();">추가</button>
                        <button type="button" class="s_blue" onclick="delDomainGroup(this);">삭제</button>

                    </div>
                </div>
                <div id="domainGroupDiv">
                    <div style="margin-bottom:5px;">
                        <input type="text" id="groupIpAddr" name="groupIpAddr" value="" maxlength="50" style="width:200px;"/> 
                        포트 : <input type="text" id="groupPortNo" name="groupPortNo" value="80"maxlength="5" style="width:40px;"/>

                        <button type="button" class="s_blue" onclick="addDomainGroup();">추가</button>

                    </div>
                </div>
            </td>
        </tr>

        <tr>
            <th>사이트 명</th>
            <td>
                <input type="text" id="domainDesc" name="domainDesc" value="" maxlength="50" style="width:200px;"/>
            </td>
        </tr>

        <tr>
            <th>사이트 담당자</th>
            <td>
                [담당자명] <input type="text" name="chargerNm" id="chargerNm" value="" class="text-input w-100"/>&nbsp;&nbsp;&nbsp;
                [담당부서] <input type="text" name="chargeDeptNm" id="chargeDeptNm" value="" readonly="readonly"/>
                           <button type="button" class="s_blue" onclick="jsClearChargeInfo();">삭제</button>

                <input type="hidden" name="chargerId" id="chargerId" value=""/>
                <input type="hidden" name="chargeDeptCode" id="chargeDeptCode" value=""/>
                <p class="gray">사이트 담당자 이름을 입력한 후 선택하세요. &nbsp;(바로 Enter키 누르지 마세요)</p>
            </td>
        </tr>

        <tr>
            <th>사용 여부<span class="tx_red tx_b">*</span></th>
            <td>
                <input type="radio" id="useYn_Y" name="useYn" value="Y" class="radio" checked="checked" />
                <label for="useYn_Y">사용</label>
                
                <input type="radio" id="useYn_N" name="useYn" value="N" class="radio" />
                <label for="useYn_N">미사용</label>

                <div class="gray">미사용 선택 시 해당 사이트 접근이 차단됩니다.</div>
            </td>
        </tr>

        </tbody>
    </table>


    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button class="w_blue mar_l5 mar_b5">저장</button></li>
        </ul>
    </div>

</form>
