
var pwdConfirm = function(el, title1, menuType, returnUrl, widthV, heightV, userId, userTyCd, paramVal, outputConts, modConts) {

            var menuNm = document.title.valueOf();

            if(paramVal == null ||  paramVal== "undefind"){
                paramVal = "";
            }

            if(modConts == null ||  modConts== "undefind"){
                modConts = "";
            }

            var width = widthV;
            if(!width) {
                width = "850";
            }

            var height = heightV;
            if(!height) {
                height = "700";
            }

            $(el).colorbox({
                title : title1,
                href : "/intra/user/PD_pwdConfirm.do?title1=" +title1      // 화면 제목(예: 회원정보 출력이력 목록 엑셀 출력)
                                                + "&logMenuNm=" +menuNm    // 메뉴 명
                                                + "&logMenuTy=" +menuType  // 메뉴타입(조회 : R, 변경: U, 출력 : O)
                                                + "&returnUrl=" +returnUrl // 비밀번호 확인 후 이동할 페이지 URL
                                                + "&widthV=" +widthV       // 비밀번호 확인 후 이동할 페이지 가로 길이
                                                + "&heightV=" +heightV     // 비밀번호 확인 후 이동할 페이지 세로 길이
                                                + "&userId=" +userId       // 사용자 ID
                                                + "&userTyCd=" + userTyCd  // 사용자 상태 코드
                                                + "&paramVal=" +paramVal   // paramVal ( & = ∬)
                                                + "&outptCn=" +outputConts // 출력내용 : 리스트 or [홍길동]접속이력
                                                + "&changeCn=" +modConts,  // 변경내용 : [주민번호등록번호항목],[이메일항목],[일반전화번호항목] 등등등
                width : width,
                height : height,
                iframe : true
            });
        };