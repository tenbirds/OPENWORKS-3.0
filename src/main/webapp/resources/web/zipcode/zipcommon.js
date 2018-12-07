/*******************************************************************************
    *최초작성일 : 2006.06.20
    *최초작성자 : mylee
    *주요처리내용 : 폼 체크용 공통 함수
    *수정일 :
    *수정자 :
    *수정내용 : 각자 필요한 내용을 수정,등록해 사용하시면 됩니다
 ******************************************************************************/
/*
 *  global variable 선언
 */
var KEY_ENTER = 13;
var HOST_URL = 'www.juso.go.kr';
var MAP_VERSION = '1,0,0,74';
var xmlHttp;
var CurrentPage = 1;

function isBizArea(code, mode) {
    
    if(code.length < 5){
        return true;
    }
    else if((code == '50110' || code == '50130' || code == '44810' || code == '44230' || code == '26710' || code == '47190' || code == '47150' || code == '47170' || code == '47750' || code == '47820' || code == '47770' || code == '47130' || code == '47930' || code == '47940' || code == '47830' || code == '41273' || code == '41271' || code == '42810' || code == '44150' || code == '44760' || code == '45210' || code == '45190' || code == '43730' || code == '46170' || code == '46900' || code == '46810' || code == '46730' || code == '48270' || code == '48890' || code == '48250' || code == '43740' || code == '42770' || code == '44200' || code == '41360' || code == '48870' || code == '46870') && mode == 'search')
    {
        //alert("이 지역은 새주소 정비사업중으로 안내정보와 현장의 건물번호가 다를 수 있으니 \n\n이용하실 때 참고 하시기 바랍니다. 불편을 드려 죄송합니다. (문의 : 해당 시군구) \n");
    }
    else if(code.length>5)
        code = code.substring(0,5);
        
        areaCode = new Array("42750","42780","42790","43710","44800","44825","44830","45740","45750","45770","47720","48720"); //2009년 사업지역
                                
        for(var i=0; i<areaCode.length; i++) {
            element = areaCode[i];
            if(element == code){            
                return true;
            }
        }

    return false;
}

function isExceptArea(code){
    //areaCode = new Array("41280", "41190", "41130", "41110", "41270", "41170", "41460", "47110", "45110", "43110", "43130");
    areaCode = new Array("고양시", "부천시", "성남시", "수원시", "안산시", "안양시", "용인시", "포항시", "전주시", "청주시","천안시");
    for(var i=0; i<areaCode.length; i++){
        element = areaCode[i];
        if(element == code){
            return true;
        }
    }
    return false;
}

function isEngExceptArea(code){
    //areaCode = new Array("41280", "41190", "41130", "41110", "41270", "41170", "41460", "47110", "45110", "43110", "43130");
    areaCode = new Array("Goyang-si", "Bucheon-si", "Seongnam-si", "Suwon-si", "Ansan-si", "Anyang-si", "Yongin-si", "Pohang-si", "Jeonju-si", "Cheongju-si", "Cheonan-si");
    for(var i=0; i<areaCode.length; i++){
        element = areaCode[i];
        if(element == code){
            return true;
        }
    }
    return false;
}

// 시도MAP 코드,레이어 매핑
function getLayerID(cd){    
    var retValue;

    if(cd.substring(0,2) == '42')   retValue = 1;   //강원도
    if(cd.substring(0,2) == '43')   retValue = 3;   //충청북도
    if(cd.substring(0,2) == '30')   retValue = 4;   //대전
    if(cd.substring(0,2) == '11')   retValue = 2;   //서울
    if(cd.substring(0,2) == '27')   retValue = 5;   //대구
    if(cd.substring(0,2) == '31')   retValue = 6;   //울산
    if(cd.substring(0,2) == '29')   retValue = 7;   //광주
    if(cd.substring(0,2) == '41')   retValue = 8;   //경기도
    if(cd.substring(0,2) == '44')   retValue = 9;   //충남
    if(cd.substring(0,2) == '50')   retValue = 10;  //제주
    if(cd.substring(0,2) == '45')   retValue = 11;  //전북
    if(cd.substring(0,2) == '46')   retValue = 12;  //전남
    if(cd.substring(0,2) == '28')   retValue = 13;  //인천
    if(cd.substring(0,2) == '26')   retValue = 14;  //부산
    if(cd.substring(0,2) == '47')   retValue = 15;  //경북
    if(cd.substring(0,2) == '48')   retValue = 16;  //경남
    
    retValue = ( 2 + ( (retValue - 1) * 4) ) + 1;
    
    return retValue;
        
    
}

// 시도MAP 코드,레이어 매핑
function getLayerIDByEngName(engName){

    if(engName == 'busan')          return 14;
    if(engName == 'chungbuk')       return 3;
    if(engName == 'chungnam')       return 9;
    if(engName == 'daegu')          return 5;
    if(engName == 'dagjeon')        return 4;
    if(engName == 'gangwon')        return 1;
    if(engName == 'gyeonggi')       return 8;
    if(engName == 'gyeongnam')      return 16;
    if(engName == 'gyungbuk')       return 15;
    if(engName == 'incheon')        return 13;
    if(engName == 'jeju')           return 10;
    if(engName == 'jeonbuk')        return 11;
    if(engName == 'jeonnam')        return 12;
    if(engName == 'kwangju')        return 7;
    if(engName == 'seoul')          return 2;
    if(engName == 'ulsan')          return 6;
}

//맵안내 문구 쿠키이용
function setCookie(name, value) 
{ 
    var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + 365 ); 
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 

//맵안내 문구 쿠키이용
function setCookies(name, value, days) 
{ 
    var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + days ); 
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 

//쿠키 소멸 함수 
function clearCookie(name) { 
    var today = new Date() 
    //어제 날짜를 쿠키 소멸 날짜로 설정한다. 
    var expire_date = new Date(today.getTime() - 60*60*24*1000) 
    document.cookie = name + "= " + "; expires=" + expire_date.toGMTString() 
} 

function getCookieVal(name)
{
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
            var y = (x+nameOfCookie.length);
            if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                    if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                            endOfCookie = document.cookie.length;
                    return unescape( document.cookie.substring( y, endOfCookie ) );
            }
            x = document.cookie.indexOf( " ", x ) + 1;
            if ( x == 0 )
                    break;
    }
    return "";
}

function setCenterLayer(name){
    var xMax = document.body.clientWidth, yMax = document.body.clientHeight;

    var xOffset = (xMax-210)/2, yOffset = (yMax-150)/2+50; 
    //중심에서 오른쪽으로 20, 아래로 40픽셀에 항상 위치하는 레이어
    
    return xOffset+"^"+yOffset;

}

function createXMLHttpRequest() {
    
    if(xmlHttp != null) {
      xmlHttp.abort();
      delete xmlHttp;
      xmlHttp = null;
    }
      
    if (window.ActiveXObject) {
         xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else if (window.XMLHttpRequest) {
         xmlHttp = new XMLHttpRequest();
    }
}

function handleStateChange() {
   
 if(xmlHttp.readyState == 4) {
      if(xmlHttp.status == 200) 
           updateAreaList();
           delete xmlHttp;
           xmlHttp = null;
      }
 }

function handleStateChangeSearch() {
    var j = 1;
    if(xmlHttp.readyState == 2||xmlHttp.readyState == 3){
        $("#ziptable tbody").empty();
        $("#ziptable tbody:last").append("<tr><td colspan=3 style='text-align:center;'>--처리중입니다.--</td></tr>");
    }
    if(xmlHttp.readyState == 4) {
         if(xmlHttp.status == 200)
             var siNm         = xmlHttp.responseXML.getElementsByTagName('siNm');
             var sggNm        = xmlHttp.responseXML.getElementsByTagName('sggNm');
             var emdNm        = xmlHttp.responseXML.getElementsByTagName('emdNm');
             var liNm         = xmlHttp.responseXML.getElementsByTagName('liNm');
             var rn           = xmlHttp.responseXML.getElementsByTagName('rn');
             var rnCd         = xmlHttp.responseXML.getElementsByTagName('rnCd');
             var buldMnnm     = xmlHttp.responseXML.getElementsByTagName('buldMnnm');
             var buldSlno     = xmlHttp.responseXML.getElementsByTagName('buldSlno');
             var lnbrMnnm     = xmlHttp.responseXML.getElementsByTagName('lnbrMnnm');
             var lnbrSlno     = xmlHttp.responseXML.getElementsByTagName('lnbrSlno');
             var udrtYn       = xmlHttp.responseXML.getElementsByTagName('udrtYn');
             var mtYn         = xmlHttp.responseXML.getElementsByTagName('mtYn');
             var bdNm         = xmlHttp.responseXML.getElementsByTagName('bdNm');
             var bdKd         = xmlHttp.responseXML.getElementsByTagName('bdkd');
             var zipCl        = xmlHttp.responseXML.getElementsByTagName('zipCl');
             var intCurrentPage       = xmlHttp.responseXML.getElementsByTagName('intCurrentPage');
             var intCountPerPage      = xmlHttp.responseXML.getElementsByTagName('intCountPerPage');
             var totalCount       = xmlHttp.responseXML.getElementsByTagName('totalCount');

             var setDetailJuso = '';

             $("#ziptable tbody").empty();
              
              for(var i = 0; i < sggNm.length; i++) {
                  var tempLnbr="";
                  var tempBuld="";
                  var jibun="";
                  var newaddr="";
                  var zip="";
                  var htmlBuff="";
                  
                  if(lnbrSlno[i].firstChild.nodeValue!="0"){
                      tempLnbr=lnbrMnnm[i].firstChild.nodeValue+'-'+lnbrSlno[i].firstChild.nodeValue;
                  }else{
                      tempLnbr=lnbrMnnm[i].firstChild.nodeValue;
                  }
                  if(buldSlno[i].firstChild.nodeValue!="0"){
                      tempBuld=buldMnnm[i].firstChild.nodeValue+'-'+buldSlno[i].firstChild.nodeValue;
                  }else{
                      tempBuld=buldMnnm[i].firstChild.nodeValue;
                  }

                  if(siNm[i].firstChild.nodeValue=="세종특별자치시"){
                      var temp=bdKd[i].firstChild.nodeValue;
                      if(temp.substring(0,2)=='02'&&bdNm[i].childNodes.length!='0')
                          setDetailJuso = "("+bdNm[i].firstChild.nodeValue+")";
                      
                      if(liNm[i].childNodes.length == '0') {
                          newaddr = siNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+' '+tempBuld;
                          jibun = siNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+tempLnbr;
                      }else{
                          newaddr = siNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+' '+tempBuld;
                          jibun = siNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+liNm[i].firstChild.nodeValue+' '+tempLnbr;
                      }
                      
                  }else{
                      if(liNm[i].childNodes.length == '0') {
                          var temp=bdKd[i].firstChild.nodeValue;
                          if(temp.substring(0,2)=='02'&&bdNm[i].childNodes.length!='0')
                              setDetailJuso = "("+emdNm[i].firstChild.nodeValue+"，"+bdNm[i].firstChild.nodeValue+")";
                          else
                              setDetailJuso = "("+emdNm[i].firstChild.nodeValue+")";
                          newaddr = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+' '+tempBuld;
                          jibun = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+tempLnbr;
                      }else{
                          var temp=bdKd[i].firstChild.nodeValue;
                          if(temp.substring(0,2)=='02'&&bdNm[i].childNodes.length!='0')
                              setDetailJuso = "("+bdNm[i].firstChild.nodeValue+")";
                          newaddr = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' ' +rn[i].firstChild.nodeValue+' '+tempBuld;
                          jibun = siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+liNm[i].firstChild.nodeValue+' '+tempLnbr;
                      }
                  }
                  
                  
                      

                  if(bdNm[i].childNodes.length!='0')
                      jibun += ' '+bdNm[i].firstChild.nodeValue;

                  if(zipCl[i].childNodes.length=='0'){
                      zip = "-";
                  }else{
                      zip = zipCl[i].firstChild.nodeValue;
                  }
                  
                  htmlBuff += "<tr onclick=\"javascript:returnValue('"+zip+"','"+($("#q_searchKey option:selected").val() == 'dong' ? jibun : newaddr)+"','', '"+($("#q_searchKey option:selected").val() == 'doro' ? jibun : newaddr )+"' ,'', '')\" style='cursor:pointer;'>";
                  htmlBuff += "<td style='text-align:center;'>"+zip+"</td>";
                  htmlBuff += "<td>"+jibun+"</td>";
                  htmlBuff += "<td  class='lr_none'>"+newaddr+"</td>";
                  htmlBuff += "</tr>";
                 
                  
                  $("#ziptable tbody:last").append(htmlBuff);
             }

              if(typeof(siNm) == "undefined"){
                  $("#ziptable tbody").empty();
                  $("#ziptable tbody:last").append("<tr><td colspan=3 style='text-align:center;'>다시 검색해 주세요.</td></tr>");
                  $("#pagenate").html("");
              }else{
                  
                  if(siNm.length=="0"){
                      $("#ziptable tbody").empty();
                      $("#ziptable tbody:last").append("<tr><td colspan=3 style='text-align:center;'>검색된 결과가 없습니다.</td></tr>");
                  }
                  
                  if(siNm.length>0){
                      htmlBuff=getPaging(intCountPerPage[0].firstChild.nodeValue,'10',totalCount[0].firstChild.nodeValue,"");
                      $("#pagenate").html(htmlBuff);
                  }else{
                      $("#pagenate").html("");
                  }
              }
              delete xmlHttp;
              xmlHttp = null;
         }
    }

/* 
fListScale : 한페이지 출력할 게시물수 
fPageScale : 페이지수를 표시할 갯수 
fTotal : 전체 게시물수 
fStart : 리스트를 뿌릴 시작점(최근게시물로 order by 해서 뽑아 내는 자료라면 가장 최근 자료가 0번이 됨 
fPagingUrl : 클릭시 넘어갈 페이지 
*/ 

function getPaging(fListScale,fPageScale,fTotal,fPagingUrl) {
    /*if(window.location.pathname.indexOf("intra", 0) > -1){*/
        return getPaging1(fListScale,fPageScale,fTotal,fPagingUrl);
    /*}else{
        return getPaging2(fListScale,fPageScale,fTotal,fPagingUrl);
    }*/
        
}

function getPaging1(fListScale,fPageScale,fTotal,fPagingUrl) { 
    
    var fStart = CurrentPage;
    
    var fReturn = ""; 
    
    
    if(fTotal > fListScale) {
        var tPage = (fTotal % fListScale == 0 ? parseInt(fTotal/fListScale) : parseInt(fTotal/fListScale)+1);
        

        fReturn = fReturn + "<div class='paging' > ";
        // 처음으로 이동 
        if(fStart > fPageScale) { 
            fReturn = fReturn + "<a href='javascript:normalSearch(1)' class='p_gray' title='처음페이지로 가기' >First</a> "; 
            fPreStart = fStart % fPageScale == 0 ? parseInt(fStart / fPageScale)*fPageScale - fPageScale : parseInt(fStart / fPageScale)*fPageScale ;
            fReturn  = fReturn + "<a href='javascript:normalSearch(" +fPreStart+ ")' class='p_gray' title='이전페이지로 가기' >Prev</a> ";
             
        }
        // sPageScale 만큼 출력 
        for(var i=0; i < fPageScale ; i++) { 
            fLn = fStart % fPageScale == 0 ? parseInt(fStart / fPageScale)*fPageScale - fPageScale + 1 +i : parseInt(fStart / fPageScale)*fPageScale + 1 +i ;
            if(fLn<=tPage) { 
                   if(fLn!=fStart) {
                       fReturn  = fReturn + " <a href='javascript:normalSearch(" + fLn + ")'>" + fLn + "</a> "; }
                   else {
                       fReturn  = fReturn + " <a href='#none' class='on'>" + fLn + "</a> ";}  
             }  
        } 

        // sPageScale 만큼 뒤로 이동 
        if(parseInt(fStart / fPageScale)*fPageScale + parseInt(fPageScale) + 1 < tPage) { 
            fNstart=fStart % fPageScale == 0 ? parseInt(fStart / fPageScale)*fPageScale + 1 : parseInt(fStart / fPageScale)*fPageScale + parseInt(fPageScale) + 1;
            fReturn  = fReturn + " <a href='javascript:normalSearch(" + fNstart+ ")' class='p_gray' title='다음페이지로 가기'>next</a> "; 
        
            
            fReturn  = fReturn + "<a href='javascript:normalSearch(" + tPage+ ")' class='p_gray' title='마지막페이지로 가기' >last</a> "; 
        }
        fReturn = fReturn + "</div> ";
        
    } 
    return fReturn; 
}

function getPaging2(fListScale,fPageScale,fTotal,fPagingUrl) { 
    
    var fStart = CurrentPage;
    
    var fReturn = ""; 
    
    
    
    if(fTotal > fListScale) {
        var tPage = (fTotal % fListScale == 0 ? parseInt(fTotal/fListScale) : parseInt(fTotal/fListScale)+1);
        

        
        // 처음으로 이동 
        if(fStart > fPageScale) { 
            fReturn = fReturn + " <a href='javascript:normalSearch(1)' class='first' title='처음페이지로 가기' ></a> "; 
            fPreStart = fStart % fPageScale == 0 ? parseInt(fStart / fPageScale)*fPageScale - fPageScale : parseInt(fStart / fPageScale)*fPageScale ;
            fReturn  = fReturn + "<a href='javascript:normalSearch(" +fPreStart+ ")' class='prev' title='이전페이지로 가기' ></a> ";
             
        }
        // sPageScale 만큼 출력 
        for(var i=0; i < fPageScale ; i++) { 
            fLn = fStart % fPageScale == 0 ? parseInt(fStart / fPageScale)*fPageScale - fPageScale + 1 +i : parseInt(fStart / fPageScale)*fPageScale + 1 +i ;
            if(fLn<=tPage) { 
                   if(fLn!=fStart) {
                       fReturn  = fReturn + " <a href='javascript:normalSearch(" + fLn + ")'>" + fLn + "</a> "; }
                   else {
                       fReturn  = fReturn + " <a href='#none' class='on'>" + fLn + "</a> ";}  
             }  
        } 

        // sPageScale 만큼 뒤로 이동 
        if(parseInt(fStart / fPageScale)*fPageScale + parseInt(fPageScale) + 1 < tPage) { 
            fNstart=fStart % fPageScale == 0 ? parseInt(fStart / fPageScale)*fPageScale + 1 : parseInt(fStart / fPageScale)*fPageScale + parseInt(fPageScale) + 1;
            fReturn  = fReturn + " <a href='javascript:normalSearch(" + fNstart+ ")' class='next' title='다음페이지로 가기'></a> "; 
        
            
            fReturn  = fReturn + "<a href='javascript:normalSearch(" + tPage+ ")' class='last' title='마지막페이지로 가기' ></a> "; 
        } 
        
    } 
    return fReturn; 
} 

function normalSearch(currentPage){
    
    var url;
    
    
    var townText = $("#q_searchVal").val();
    var townBun1= $("#q_searchBun1").val();
    var townBun2 = $("#q_searchBun2").val();
    var searchKey =  $("#q_searchKey option:selected").val();
    
    var sidoText = $("#q_sidoCd option:selected").text();
    
    sidoText = sidoText == '::선택::' ? '' : sidoText;

    if(searchKey == "dong"){
        url = "AjaxRequestXML.do?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=false&mode=jibun_search&searchType=location_jibun&topTab=1&engineCtpNm="+ encodeURI(sidoText) +"&engineEmdNm="+encodeURI(townText)+"&engineBdMaSn="+encodeURI(townBun1)+"&engineBdSbSn="+encodeURI(townBun2)+"&currentPage="+currentPage);
    }else if(searchKey == "doro"){
        url = "AjaxRequestXML.do?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=true&mode=road_search&searchType=location_newaddr&topTab=1&engineCtpNm="+ encodeURI(sidoText) +"&engineRdNm="+encodeURI(townText)+"&engineBdMaSn="+encodeURI(townBun1)+"&engineBdSbSn="+encodeURI(townBun2)+"&currentPage="+currentPage);
    }else if(searchKey == "bd"){
        url = "AjaxRequestXML.do?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=true&mode=road_search&searchType=location_buld&topTab=1&engineCtpNm="+ encodeURI(sidoText) +"&engineBdNm="+encodeURI(townText)+"&currentPage="+currentPage);
    }

    CurrentPage = currentPage;
    createXMLHttpRequest();
    
    xmlHttp.onreadystatechange = handleStateChangeSearch;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);

} 
