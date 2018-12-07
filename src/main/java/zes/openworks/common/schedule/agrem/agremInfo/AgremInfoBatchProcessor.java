package zes.openworks.common.schedule.agrem.agremInfo;

import java.net.InetAddress;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import zes.openworks.common.schedule.Processor;
import zes.openworks.intra.bassAgremManage.BassAgremManageService;
import zes.openworks.intra.bassAgremManage.BassAgremManageVO;
/**
 *
 *
 * @version 2.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 11. 29.    guest1          신규
 *</pre>
 * @see 협약 만료일 도래시 사용자 정보 전환 배치
 *      1.사용자 전환(공급자->수요자)
 *      2.해당 사용자의 상품을 비전시로 전환
 *      3.해당 사용자의 협약정보의 협약상태 변경
 *      ※ WAS시간과 DB시간이 상이할 경우 DB시간이 빠를 경우 무방하나 DB시간이 느릴 경우 WAS의 시간을 쿼리 파라미터로 전달하여 선정대상자를 수집하여야 함.
 */
public class AgremInfoBatchProcessor implements Processor{
    
    @Autowired
    BassAgremManageService bassAgremManageService;

    @Override
    public void process() {

        try{
            InetAddress inet = InetAddress.getLocalHost();
            String svrIP = inet.getHostAddress();

            //운영용
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/
            if(!svrIP.equals("202.30.77.182")){
                return;
            }
            
            /****************************************************/
            // DB시간과 WAS시간이 상이할 경우 배치 수행하는 WAS의 날짜를 조회 파라미터로 전달하기 위해
            /****************************************************/
            Calendar cal = Calendar.getInstance();
            String yStr = ""+cal.get(Calendar.YEAR);            // 올해년도 얻기
            String mStr = ""+(cal.get(Calendar.MONTH) + 1);     // 현재 월 얻기 (월은 + 1 해줘야함)
            if(Integer.parseInt(mStr) < 10){
                mStr = "0" + mStr;
            }
            String dStr = ""+(cal.get(Calendar.DATE));          // 현재 일 얻기
            if(Integer.parseInt(dStr) < 10){
                dStr = "0" + dStr;
            }
            String nowDate = yStr + mStr + dStr;
            /****************************************************/
            // DB시간과 WAS시간이 상이할 경우 배치 수행하는 WAS의 날짜를 조회 파라미터로 전달하기 위해
            /****************************************************/
            
            // 여기서 부터 배치 로직 시작
            /*logger.info("======================================================");
            logger.info("협약 만료일 도래시 사용자 정보 전환 배치 시작");
            logger.info("INFO1) 배치 수행일자 : " + nowDate);
            logger.info("  ==> 배치 수행일 1일전 협약 마감 대상자를 전환합니다.");*/

            // CASE1) 협약 종료 대상 목록 찾기 - WAS 시간(날짜) 기준으로 조회 하도록 수정(2017.04.27)
//            BassAgremManageVO param = new BassAgremManageVO();
//            List<BassAgremManageVO> userList = bassAgremManageService.bassAgremClosUserList(param);
            Map paramMap = new HashMap();
            paramMap.put("paramDate", nowDate);
            List<BassAgremManageVO> userList = bassAgremManageService.bassAgremClosUserList(paramMap);
            
           /* logger.info("INFO2) 전체 전환 대상자 수 : " + userList.size());*/
            
            // CASE2) 조회된 협약 종료 대상자별 처리 [1.사용자 전환(공급자->수요자) / 2.해당 사용자의 상품을 비전시로 전환 / 3.해당 사용자의 협약정보의 협약상태 변경]
            String userId     = "";  // 사용자 ID
            String agremEndDe = "";  // 협약 종료일

            for(int i=0; i<userList.size(); i++){
                
                userId     = userList.get(i).getUserId();     // 사용자 ID
                agremEndDe = userList.get(i).getAgremEndDe(); // 협약 종료일

                /*logger.info("[" + i + "] 사용자ID : " + userId);*/

                // 파라미터 셋팅
                BassAgremManageVO closParam = new BassAgremManageVO();
                closParam.setUserId(userId);         // 사용자 ID

                // CASE2-1-1) 사용자 전환(공급자->수요자)(OP_USER 테이블 Update)
                bassAgremManageService.opUserBassAgremClosAction(closParam);

                // CASE2-1-2) 사용자 전환(공급자->수요자)(TUM_SVC_STOR_I 테이블 Update)
                bassAgremManageService.tumSvcStorBassAgremClosAction(closParam);

                // CASE2-2) 해당 사용자의 상품을 비전시로 전환
                bassAgremManageService.tstGoodInfoBassAgremClosAction(closParam);

                // CASE2-3) 해당 사용자의 협약정보의 협약상태 변경[승인(1004) -> 협약종료(1005)]
                closParam.setAgremEndDe(agremEndDe); // 협약 종료일
                bassAgremManageService.bassAgremManageClosAction(closParam);
            }
            
           /* logger.info("협약 만료일 도래시 사용자 정보 전환 배치 끝");
            logger.info("======================================================");*/

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
