/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author
 * 
 *         <pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2016. 05. 21.    K.S     신규
 *         </pre>
 * 
 * @see
 */ 

public class UserNewAgreeTrans
{
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public UserNewAgreeTrans()
    {
    }

    public void open()
    {
        System.out.println("=====CROSS DB 호출 시작 : "+sdf.format(new Date(System.currentTimeMillis()))+"====="); 
    }

    public void close()
    {
        System.out.println("=====CROSS DB 호출 완료 : "+sdf.format(new Date(System.currentTimeMillis()))+"====="); 
    }

    public boolean newAgreeTrans(String _transUserId)
    {
        Connection        con   = null;
        PreparedStatement pstmt = null;

        try
        {
            // DB 접속
            con = getConnection();
            if (con == null)
            {
                System.out.println("DB의 커넥션을 얻지 못했습니다.!!!"); 
            }
            else
            {
                // 수정
                String sql = "UPDATE OP_USER                        "
                           + "   SET STPLAT_AGRE_AT = 'Y'           " // 신규약관동의여부 
                           + "      ,STPLAT_AGRE_DT = SYS_DATETIME  " // 신규약관동의일자 
                           + " WHERE USER_ID = ?                    " ;

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, _transUserId);
                int updateCnt = pstmt.executeUpdate(); // executeUpdate()는 int값 반환

                if (updateCnt <= 0)
                {
                    return false;
                }
            }
        }
        catch (Exception e)
        {
            return false;
        }
        finally
        {
            try
            {
                if (pstmt != null)
                    pstmt.close();
            }
            catch (Exception e)
            {
            }
            pstmt = null;
            
            try
            {
                if (con != null)
                    con.close();
            }
            catch (Exception e)
            {
            }
            con = null;
        }

        return true;
    }

    /* 소프트웨에 스토어 씨앗 DB접속 */  
    private Connection getConnection() throws Exception
    {
        Connection conn = null;

        String dbUrl    = null;
        String userName = null;
        String password = null;

        String driverName = "cubrid.jdbc.driver.CUBRIDDriver";

        // Test DB
        //dbUrl = "jdbc:CUBRID:202.30.77.190:30000:NOMPDEV:::?charSet=utf-8";
        // Real DB
        dbUrl = "jdbc:CUBRID:202.30.77.184:30000:n_omp_ceart:::?althosts=202.30.77.185:30000&charSet=utf-8";

        userName = "ompapp";
        password = "akzpt#vmffpdltm";

        try
        {
            Class.forName(driverName).newInstance();
            conn = DriverManager.getConnection(dbUrl, userName, password);
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
        return conn;
    }

    // 테스트 (특정아이디를 신규약관동의 처리한다.)
    public static void main(String[] args)
    {
        UserNewAgreeTrans st = new UserNewAgreeTrans();
        st.open();
        st.newAgreeTrans("kaimes98");
        st.close();
    }
}
