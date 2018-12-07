<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>포스트잇 관리</title>
    <op:jsTag type="spi" items="jquery, ui"/>
    <op:jsTag type="openworks" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/openworks/spi/jquery/stickyNote/jquery.stickynotes.css"/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/openworks/spi/jquery/stickyNote/jquery.contextMenu.css"/>" />


    <script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
    <script type="text/javascript" src="<c:url value="/resources/openworks/spi/jquery/stickyNote/jquery.contextMenu.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/openworks/spi/jquery/stickyNote/jquery.stickynotes.js" />"></script>
    <script type="text/javascript">
        $().ready(function() {

            // Remove ajax event
            jQuery().unbind('ajaxStart').unbind('ajaxStop').unbind('ajaxError');

            var myNoteArray = new Array();
            //<c:forEach items="${dataList}" var="snBean">
            myNoteArray.push({
                "id"         : '${snBean.seq}',
                "text"       : "${snBean.contents}",
                "pos_x"      : '${snBean.posXis}',
                "pos_y"      : '${snBean.posYis}',
                "width"      : '${snBean.width}',
                "height"     : '${snBean.height}',
                "zindex"     : '${snBean.zindex}',
                "background" : '${snBean.background}'
            });
            //</c:forEach>

            var options = {
                notes          : myNoteArray,
                resizable      : true,
                controls       : true,
                editCallback   : jsUpdate,
                deleteCallback : jsDelete,
                moveCallback   : jsMoved,
                resizeCallback : jsMoved
            };

            $("#notes").stickyNotes(options);

            // 큰 아이콘으로 변경
            $(".ui-resizable-se").each(function() {
                $(this).removeClass("ui-icon-gripsmall-diagonal-se").addClass("ui-icon-grip-diagonal-se");
            });
            $(".ui-resizable-s").each(function() {
                $(this).css("bottom", "0px");
                $(this).css("line-height", "1px");
            });
            $(".ui-resizable-e").each(function() {
                $(this).css("right", "0px");
            });
            $(".stretch").each(function() {
                $(this).css("margin-top", "0px");
            });
        });

        var jsCreated = function() {
            $.post("INC_insertAction.do", {
                seq: 0,
                contents : "메모 내용을 입력하세요.",
                width: 0,
                height: 0,
                posXis: 0,
                posYis: 0,
                zindex: 0
            },
            function(response) {
                try {
                    if(eval(response)) {
                        jQuery.fn.stickyNotes.createNote(response);
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }
            }, 'text');
        };

        var jsUpdate = function(note) {

            // 메모 추가 후 내용 입력 없이 종료 시
            if (note.text == "" && isCreate) {
                $.post("INC_deleteAction.do", {
                    seq: note.id
                },
                function(result) {
                    jQuery("#note-" + note.id).remove();
                }, 'json');
            }
            // 메모 내용 저장
            else {
                $.post("INC_updateAction.do", {
                    seq: note.id,
                    contents : note.text,
                    width: note.width,
                    height: note.height,
                    posXis: note.pos_x,
                    posYis : note.pos_y,
                    zindex : note.zindex,
                    background: note.background
                },
                function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.updateOk);
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                }, 'text');
            }
        };

        var jsDelete = function(note) {
            if (note.text == "" && isCreate) {
                $.post("INC_deleteAction.do", {
                    seq: note.id
                },
                function(result) {
                    jQuery("#note-" + note.id).remove();

                    isCreate = false;
                    jQuery("#add_note").attr("disabled", false);

                }, 'text');
                return true;
            }

            if (confirm("정말 삭제 하시겠습니까?")) {
                $.post("INC_deleteAction.do", {
                    seq: note.id
                },
                function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                }, 'text');
                return true;
            }
            else
                return false;
        };

        var jsMoved = function(note) {

            if (note.text != "") {
                $.post("INC_updateAction.do", {
                    seq: note.id,
                    contents : note.text,
                    width: note.width,
                    height: note.height,
                    posXis: note.pos_x,
                    posYis : note.pos_y,
                    zindex : note.zindex, type:'move'
                },
                function(result) {
                }, 'text');
            }
        };

        var jsChangeBg = function(bg_img, el) {

            var bg = $(el).parent().find(".background");

            if (jQuery.browser.msie && jQuery.browser.version <= 6)  {
                bg.html('<img src="<c:url value="/resources/openworks/spi/jquery/stickyNote/images/spacer.gif" />" class="stretch" style="margin-top:5px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\'<c:url value="/resources/openworks/spi/jquery/stickyNote/images/"/>' + bg_img + '\', sizingMethod=\'scale\'");" alt="" />');
            } else {
                bg.html('<img src="<c:url value="/resources/openworks/spi/jquery/stickyNote/images/" />' + bg_img + '" class="stretch" style="margin-top:5px;" alt="" />');
            }

            var note_id = $(el).attr("seq");

            $.post("INC_updateAction.do", {
                seq: note_id,
                background : bg_img
            },
            function(result) {
            }, 'text');
        };
    </script>
</head>

<body style="margin:0; padding:0; overflow: auto;">

<div id="notes" style="width:100%; height:100%;"></div>

<ul id="myMenu" class="contextMenu">
    <li class="default"><a href="#background_default.png">기본 배경</a></li>
    <li class="skyblue"><a href="#bg_skyblue.png">하늘색</a></li>
    <li class="leafgreen"><a href="#bg_leafgreen.png">연두색</a></li>
    <li class="pink"><a href="#bg_pink.png">분홍색</a></li>
    <li class="violet"><a href="#bg_violet.png">연보라색</a></li>
</ul>

</body>
</html>
