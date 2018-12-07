    /**
    *  - 개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지
    *  - 간단한 문자나 숫자의 연속사용(4자리이상) 금지
    *  @param    pwd:비밀번호, userId:사용자 아이디, brthdy:생년월일, email:이메일, mbtlnum:핸드폰번호
    *  @return   String
    **/
    function validPwd(pwd, userId, brthdy, email, mbtlnum) {
        var rtn = '';
        var chars = "01234567890123456789";
        var tmp = pwd.toUpperCase();
        var icnt = 0;
        var tmpNum = '';
        var tmppwd  = "";

        //개인정보 포함 제외시킴
        if( pwd.indexOf(userId) != -1 && userId != '') {
            rtn = Message.msg.passwordCheck1;
            return rtn;
        }
        if( pwd.indexOf(brthdy) != -1 && brthdy != '') {
            rtn = Message.msg.passwordCheck1;
            return rtn;
        }
        if( pwd.indexOf(email) != -1 && email != '') {
            rtn = Message.msg.passwordCheck1;
            return rtn;
        }
        if( pwd.indexOf(mbtlnum) != -1 && mbtlnum != '') {
            rtn = Message.msg.passwordCheck1;
            return rtn;
        }

        //연속된 숫자 카운터(간단한 문자나 숫자의 연속사용(4자리이상) 금지)
        for (var inx = 0; inx < pwd.length; inx++) {
            if(chars.indexOf(pwd.charAt(inx)) != -1) {
                icnt++;
                tmpNum = tmpNum+pwd.charAt(inx);
                if( icnt >= 4) {
                    break;
                }
            } else {
                icnt = 0;
                tmpNum = "";
            }
        }
        if( icnt >= 4 ) {
            if( chars.indexOf(tmpNum) >= 0 ) {
                rtn = Message.msg.passwordCheck1;
                return rtn;
            }
        }
         //step1:연속된 동일문자 4회 반복시 검출.
        tmppwd = pwd;
        tmppwd = tmppwd.replace(/\\/g, "★");
        tmppwd = tmppwd.replace(/\^/g, "☆"); 
        for (var inx = 0; inx < tmppwd.length; inx++) {
            stCh   = tmppwd.substr(inx,1);
            stChar = "["+stCh+"]{4,}";
            chk    = new RegExp(stChar);
            if( chk.test(tmppwd) ) {
                stCh = stCh.replace("★", "\\");
                stCh = stCh.replace("☆", "^");
                rtn = Message.msg.passwordCheck1;
                return rtn;
                break;
            }
        }
        return rtn;
    }//END_FUNCTION

    //특수문자 포함여부
    function isSpecial(info)  {
        var chars = "~`@#$%^&*()|\\+=-_;:\"<>!?/";
        return containsCharsOnly(info,chars);
    }
    
    //숫자 포함여부
    function isInNumber(info) {
        var chars = "0123456789";
        return containsCharsOnly(info,chars);
    }

    //특정값이 있는지 체크
    function containsCharsOnly(info,chars) {
        for (var inx = 0; inx < info.length; inx++) {
            if (chars.indexOf(info.charAt(inx)) != -1) {
                return true;
            }
         }
        return false;
    }

    //숫자, 특수문자 외 값 여부
    function isInteger(varCk) {
        var chk=true;
        var ch= "";
        var charSet = "~`@#$%^&*()|\\+=-_;:\"<>!?/";
        for (var i=0; i<=varCk.length-1; i++) {
            ch = varCk.substring(i,i+1);
            if (ch>="0" && ch<="9") {
                chk = true;
            } else {
                chk=false;
                for (var j=0; j<=charSet.length-1; j++) {
                    comp = charSet.substring(j,j+1);
                    if (ch==comp) {
                        chk = true;
                        break;
                    }
                }
                if (!chk) break;    // 숫자+특수문자외의 문자가 있는 경우만 error 종료
            }
        }
        return chk;
    }

    //문자열 length 반환
    function fnLengthCheck(value) {
        var nStrLength = 0;

        for (var i = 0; i < value.length; i++) {
            if (parseInt(value.charCodeAt(i)) > 127) {
                nStrLength = nStrLength + 2;
            } else {
                nStrLength++;
            }
        }
        return nStrLength;
    }