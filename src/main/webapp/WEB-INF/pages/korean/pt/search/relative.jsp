<%@ page import="java.io.*,java.lang.*,java.net.*,java.util.*"%><%@ page contentType="text/xml; charset=UTF-8" language="java" session="false" %><%request.setCharacterEncoding("utf-8");%><%
    /**
    *  subject: 인기검색어 가져오는 페이지
    **/

	int timeout=500;	// 1000분의 500초 : 0.5초이내에 응답이 없는 경우 연결 종료
	String query = request.getParameter("query"); //Normal:EUC-KR
	String target = request.getParameter("target");
	String charset = request.getParameter("charset");
	String label = request.getParameter("label");
	//String range = request.getParameter("range");
	String collection = request.getParameter("collection");

	if (query != null) { 
		query = URLEncoder.encode(query, "UTF-8");
	}
	// 운영
	String url = "http://" + "202.30.77.186" + ":" + "7800" + "/manager/WNRun.do?";
	// 개발
	//String url = "http://" + "202.30.77.210" + ":" + "7800" + "/manager/WNRun.do?";

	if(query != null){
		url += "query=" + query + "&";
	}
	
	if(target != null){
		url += "target=" + target + "&";	
	}
	
	if(charset != null){
		url += "charset=" + charset + "&";	
	}
	
	if(label != null){
		url += "label=" + label + "&";	
	}
	
	
	System.out.println("URL:"+url);

	out.println(getHtmls(url, timeout)); //send url value
%>
<%!
	 public String getHtmls(String receiverURL, int timeout){
        StringBuffer receiveMsg = new StringBuffer();
        try{
            int errorCode   = 0;
            // -- receive servlet connect
            URL servletUrl = new URL(receiverURL);
            HttpURLConnection uc = (HttpURLConnection)servletUrl.openConnection();
			uc.setReadTimeout(timeout);
            uc.setRequestMethod("POST");
            uc.setDoOutput(true);
            uc.setDoInput(true);
            uc.setUseCaches(false);
            uc.connect();
            // init
            errorCode = 0;
            // -- Network error check
            if(uc.getResponseCode() == HttpURLConnection.HTTP_OK){
				String currLine = new String();
				//UTF-8인 경우
				BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "UTF-8"));
				//BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
				while ((currLine = in.readLine()) != null){
					receiveMsg.append(currLine).append("\r\n");
				}
            }else{
                errorCode = uc.getResponseCode();
				return receiveMsg.toString();
            }
            uc.disconnect();
        }catch(Exception ex){
            /* System.out.println( ex ); */
        }
        return receiveMsg.toString(); 
	}
%>