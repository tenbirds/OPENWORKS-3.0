/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.schedule.goods;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import zes.openworks.common.schedule.Processor;
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;
/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 12. 07.    최강식          신규
 *</pre>
 * @see 나라장터 서비스정보 배치
 */
public class GoodsMonitorBatchProcessor implements Processor{

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

            GoodsManageVO vo = new GoodsManageVO();
            Calendar cal = Calendar.getInstance();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat stf = new SimpleDateFormat("HH");

            String monitorDay = sdf.format(cal.getTime());
            String monitorTime = stf.format(cal.getTime());

            vo.setGoodsRegistSttus(1006);
            List<GoodsManageVO> goodsList = service.goodsMonitorList(vo);

            for(GoodsManageVO data : goodsList) {
                data.setGoodsServiceState(getResponseCode(data.getGoodsMonitorUrl()));
                data.setGoodsMonitorDay(monitorDay);
                data.setGoodsMonitorTime(monitorTime);
                service.goodsMonitorInsertAction(data);
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public static String getResponseCode(String urlString) {
        String rtnStr = "";
        try {
            URL u = new URL(urlString);
            HttpURLConnection huc =  (HttpURLConnection)  u.openConnection();
            huc.setRequestMethod("GET");
            huc.connect();
            rtnStr = Integer.toString(huc.getResponseCode());
        } catch (MalformedURLException e) {
            rtnStr = e.getMessage();
        } catch (IOException e) {
            rtnStr = e.getMessage();
        } catch (Exception e) {
            rtnStr = e.getMessage();
        }
        return rtnStr;
    }
}