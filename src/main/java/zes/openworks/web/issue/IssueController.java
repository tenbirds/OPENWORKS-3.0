package zes.openworks.web.issue;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.InputSource;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 5. 21.    neteran   신규 생성
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = { "/web/inc" })
public class IssueController extends GeneralController {

    @Autowired
    private IssueService iservice;

    /**
     * 이슈게시물, 핫메뉴 목록
     */
    // 이슈콘텐츠 refresh 2013.05.14 김영상
    @RequestMapping(value = "/INC_issue.list.do", method = RequestMethod.POST)
    public String getIssuePolList(HttpServletRequest request, ModelMap model) {
        IssueVO vo = new IssueVO();
        OpHelper.bindSearchMap(vo, request);
        Map<String, Object> hiMap = new HashMap<String, Object>();
        hiMap.put("issue", iservice.getIssueList(vo));

        return responseJson(model, hiMap);
    }

    // 핫메뉴 refresh 2013.05.14 김영상
    @RequestMapping(value = "/INC_hot.list.do", method = RequestMethod.POST)
    public String getIssueHotList(HttpServletRequest request, ModelMap model) {
        IssueVO vo = new IssueVO();
        OpHelper.bindSearchMap(vo, request);
        Map<String, Object> hiMap = new HashMap<String, Object>();
        hiMap.put("hot", iservice.getHotmenuList(vo));

        return responseJson(model, hiMap);
    }

    // sns댓글 리스트
    @RequestMapping(value = "/INC_sns.list.do", method = RequestMethod.POST)
    public String getSnsList(HttpServletRequest request, ModelMap model) {

        String apiurl = "http://api.twitter.com/1/statuses/user_timeline.xml?screen_name=seoulmania";
        int max_count = 10;

        List<IssueVO> l_list = new ArrayList<IssueVO>();

        // String[][] info = null;

        HttpURLConnection conn = null;
        int max = 0;
        int k = 0;

        try {

            URL url = new URL(apiurl);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("accept-language", "ko");

            DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();

            byte[] bytes = new byte[4096];

            InputStream in = conn.getInputStream();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();

            while(true) {
                int red = in.read(bytes);

                if(red < 0) {
                    break;
                }

                baos.write(bytes, 0, red);
            }

            String xmlData = baos.toString("euc-kr");

            baos.close();
            in.close();
            conn.disconnect();

            Document doc = docBuilder.parse(new InputSource(new StringReader(xmlData)));
            Element el = (Element) doc.getElementsByTagName("statuses").item(0);

            max = el.getChildNodes().getLength();

            String reg = "(http:\\/\\/\\w+\\.\\w+(\\.\\w+)?(\\.\\w+)?/\\w+)";

            for(int i = 0 ; i < max ; i++) {

                Node node = el.getChildNodes().item(i);

                if(!node.getNodeName().equals("status")) {
                    continue;
                }

                if(k >= max_count) {
                    break;
                }

                IssueVO vo = new IssueVO();

                Element el2 = (Element) node;

                String content = el2.getElementsByTagName("text").item(0).getFirstChild().getNodeValue();
                String created_at = el2.getElementsByTagName("created_at").item(0).getFirstChild().getNodeValue();

                Element el3 = (Element) (el2.getElementsByTagName("user").item(0));

                String name = el3.getElementsByTagName("name").item(0).getFirstChild().getNodeValue();
                String screen_name = el3.getElementsByTagName("screen_name").item(0).getFirstChild().getNodeValue();

                @SuppressWarnings("deprecation")
                Date date = new Date(created_at);

                Pattern p = Pattern.compile(reg);

                Matcher m = p.matcher(content);

                if(m.find()) {
                    content = content
                        .replaceAll(reg, "<a href='" + m.group(1) + "' target='_blank'><font color='blue'>" + m.group(1) + "</font></a>");
                }

                long cha = (System.currentTimeMillis() - date.getTime()) / 1000;

                String ago = "";

                if(cha < 60) {
                    ago = "1분전";
                }
                else if(cha < 3600) {
                    ago = (cha / 60) + "분전";
                }
                else if(cha < 86400) {
                    ago = (cha / 60 / 60) + "시간전";
                }
                else {
                    ago = (cha / 60 / 60 / 24) + "일전";
                }

                vo.setSns_name(name);
                vo.setSns_screen_name(screen_name);
                vo.setSns_ago(ago);
                vo.setSns_content(content);

                l_list.add(vo);

                k++;
            }

        } catch (Exception e) {
            if(logger.isDebugEnabled()) {
                logger.debug("receive twitter content failed", e);
            }
        } finally {

            try {
                if(conn != null) {
                    conn.disconnect();
                }
            } catch (Exception e) {
                // do nothing
            }
        }

        return responseJson(model, l_list);
    }

}
