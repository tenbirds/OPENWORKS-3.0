package zes.openworks.common.schedule.goods;

import java.io.InputStream;
import java.net.InetAddress;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;

import zes.core.spi.commons.configuration.Config;
import zes.openworks.common.schedule.Processor;
import zes.openworks.intra.store.goods.GoodsManageService;

public class OverseasProductsMonitorBatchProcessor implements Processor{

    @Autowired
    GoodsManageService service;

    @Override
    public void process() {

        try{
            InetAddress inet = InetAddress.getLocalHost();
            String svrIP = inet.getHostAddress();
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/
            if(!svrIP.equals("202.30.77.182")){
                return;
            }

            String requestProtocol = Config.getString("overseasProducts.digitalMarketplace.protocol");
            String requestDomain = Config.getString("overseasProducts.digitalMarketplace.domain");
            String requestUrl = Config.getString("overseasProducts.digitalMarketplace.url");
            String requestQuerystring =  Config.getString("overseasProducts.digitalMarketplace.queryString");
            String requestCharset =  Config.getString("overseasProducts.digitalMarketplace.charset");
                
            Document doc = Jsoup.connect(requestProtocol +"://"+ requestDomain + requestUrl +"?"+ requestQuerystring).get();
            Elements es = doc.select("div.search-result");
            
            for(Element e: es) {
                String searchResultTitle = e.select("h2.search-result-title a").text();
                String searchResultSupplier = e.select("p.search-result-supplier").text();
                String searchResultExcerpt = e.select("p.search-result-excerpt").text();
                String searchResultMetadataItem1 = e.select("li.search-result-metadata-item").get(0).text();
                String searchResultMetadataItem2 = e.select("li.search-result-metadata-item").get(1).text();
                String searchResultLink = requestProtocol +"://"+ requestDomain + e.select("h2.search-result-title a").attr("href");
                String searchResultSeq = searchResultLink.replaceAll(".*/([0-9]+)$", "$1");
                
                Map<String, String> paramMap = new HashMap<String, String>();
                paramMap.put("searchResultTitle", searchResultTitle);
                paramMap.put("searchResultSupplier", searchResultSupplier);
                paramMap.put("searchResultExcerpt", searchResultExcerpt);
                paramMap.put("searchResultMetadataItem1", searchResultMetadataItem1);
                paramMap.put("searchResultMetadataItem2", searchResultMetadataItem2);
                paramMap.put("searchResultLink", searchResultLink);
                paramMap.put("searchResultSeq", searchResultSeq);

                // insert or update
                service.overseasProductsInsertUpdate(paramMap);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}