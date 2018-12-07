/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.sms;

import java.sql.*;
import java.text.SimpleDateFormat;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.StringUtil;

/**
 *
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 21.    김영상       신규
 *</pre>
 * @see
 */
public class NiaSmsTrans {
    /** 발송자 전화번호 */
    private static String senderTel = Config.getString("sender.senderTel");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public NiaSmsTrans() {
    }

    public void open() {
       // System.out.println("=====SMS 호출 시작 : "+sdf.format(new Date(System.currentTimeMillis()))+"=====");
    }

    public void close() {
       // System.out.println("=====SMS 호출 완료 : "+sdf.format(new Date(System.currentTimeMillis()))+"=====");
    }

    public boolean smsTextTrans(String _transtext, String _transcelno) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String transcelno = _transcelno;
        String transtext = _transtext;

        try {
            /* SMS 메시지 80 Byte 초과 : 길이 수정함 */
            if ( transtext.getBytes("EUC-KR").length > 80 ) {                
                transtext = transtext.substring(0, 40);
            }
            if (transcelno.indexOf("-") != -1) {
                transcelno = StringUtil.replace(transcelno, "-", "");
            }
            //MS-SQL접속            
            con = getConnection();
            
            if (con == null) {
                //System.out.println("!!!SMS DB의 커넥션을 얻지 못했습니다.!!!");
            } else {
                con.setAutoCommit(true);
                //OMP SP를 호출
                pstmt = con.prepareCall("{CALL SMS.dbo.up_sendsms_openmarkerplace(?,?,?)}");
                pstmt.setString(1, transcelno);
                pstmt.setString(2, senderTel);
                pstmt.setString(3, transtext);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {            
            return false;
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch(Exception e){ }
            pstmt = null;
            try { if (con != null) con.close(); } catch(Exception e){ }
            con = null;
        }

        return true;
    }

    /* NIA(등촌청사) SMS서버 MS-SQL DB 접속 */
    private Connection getConnection() throws Exception {
        Connection conn = null;
        String msDbUrl    = null;
        String msUserName = null;
        String msPassword = null;
        String msDriverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
//        msDbUrl = "jdbc:sqlserver://202.30.74.140:1433";
        msDbUrl = "jdbc:sqlserver://202.30.88.124:1433"; // 2015.06.27 09:00 변경
        msUserName = "sms";
        msPassword = "admin";

        try {
            Class.forName(msDriverName).newInstance();
            conn = DriverManager.getConnection(msDbUrl, msUserName, msPassword);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return conn;
    }

    //테스트
    public static void main(String[] args) {
        NiaSmsTrans st = new NiaSmsTrans();
        st.open();
        st.smsTextTrans("[씨앗마켓 안내]\n씨앗마켓~씨앗마켓~씨앗마켓\n씨앗마켓~!", "01052834032");
        st = new NiaSmsTrans();
        st.smsTextTrans("[씨앗마켓]SMS발송 테스트\n씨앗마켓 SMS발송 테스트", "01052834032");
        st = new NiaSmsTrans();
        st.smsTextTrans("[CeartMarket]SMS Transmit... from CeartMarket Thanks.NIA", "01052834032");
        st.close();
    }
}
