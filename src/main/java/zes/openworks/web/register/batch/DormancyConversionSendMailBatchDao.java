package zes.openworks.web.register.batch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.web.register.RegisterUserVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 * 수정일        수정자      수정내용
 * ----------    --------    -------------------------------
 * 2015-11-10    이창환      신규
 *</pre>
 * @see
 */

@Repository
public class DormancyConversionSendMailBatchDao extends EgovAbstractMapper{

    @Autowired
    private AutoMailService amservice;

    /**
     * 휴면 전환 안내 메일 발송
     * @return
     */
    public void dormancyConversionSendMail(){

        @SuppressWarnings("unchecked")
        List<RegisterUserVO> datalist = list("_register.dormancyConversionSendMailList", null);

        for(int i = 0 ; i < datalist.size() ; i++) {

            boolean result = false;
            Map<String, Object> autoMap = new HashMap<String, Object>();

            autoMap.put("automailId", AutoMailTemplate.KOR_DRMN_CNVR);

            autoMap.put("receiverName", datalist.get(i).getUserNm());                   // 수신자명
            autoMap.put("email", datalist.get(i).getEmail());                           // 수신이메일주소

            // 메일 템플릿에 적용될 치환값 : name, etc3, etc4
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("name", datalist.get(i).getUserNm());                   //성명
            oneToOneInfoMap.put("etc3", datalist.get(i).getValidLoginDt());             //로그인 유효 일자
            oneToOneInfoMap.put("etc4", datalist.get(i).getDormancyConversionDt());     //휴면 전환 일자

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "씨앗마켓");                                        // 생략시 기본 설정값 적용 : 씨앗마켓
            //autoMap.put("senderEmail", "발신자 이메일");                                 // 생략시 기본 설정값 적용 :
            //autoMap.put("mailTitle", "메일 제목");                                      // 생략시 기본 설정값 적용

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result){
               /* System.out.println("########################################################");
                System.out.println("#### 휴면 전환 안내 E-MAIL : " + datalist.get(i).getEmail() + "," + datalist.get(i).getUserNm() + "에게 발송 성공#########");
                System.out.println("########################################################");*/
            }else{
               /* System.out.println("########################################################");
                System.out.println("#### 휴면 전환 안내 E-MAIL : " + datalist.get(i).getEmail() + "," + datalist.get(i).getUserNm() + "에게 발송 실패#########");
                System.out.println("########################################################");*/
            }
        }

    }

    /**
     * 휴면 전환 처리
     * @return
     */
    public void dormancyConversion(){

        @SuppressWarnings("unchecked")
        List<RegisterUserVO> datalist = list("_register.dormancyConversionTrgetList", null);

        for(RegisterUserVO dataVO : datalist){

            // 휴면처리
            // select insert
            int rstIntc = insert("_register.userDrmncyInsert", dataVO); // 관심카테고리 추가

            if(rstIntc == 0){
                System.out.println("########################################################");
                System.out.println("#### 휴면 전환 처리 Step. 1 : " + dataVO.getUserId() + "," + dataVO.getUserNm() + "휴면 처리 실패 #########");
                System.out.println("########################################################");
            }else{
                // update op_user
                dataVO.setUserSttusCd(1004);// 회원 본인 휴면

                int rstUptc = update("_register.userDrmncyConfirm", dataVO);

                if(rstUptc == 0){
                    System.out.println("########################################################");
                    System.out.println("#### 휴면 전환 처리 Step. 2 : " + dataVO.getUserId() + "," + dataVO.getUserNm() + "휴면 처리 실패 #########");
                    System.out.println("########################################################");
                }else{

                    // 휴면 전환 처리 완료 메일 발송
                    boolean result = false;
                    Map<String, Object> autoMap = new HashMap<String, Object>();

                    autoMap.put("automailId", AutoMailTemplate.KOR_DRMN_COMP);

                    autoMap.put("receiverName", dataVO.getUserNm());                   // 수신자명
                    autoMap.put("email", dataVO.getEmail());                           // 수신이메일주소

                    // 메일 템플릿에 적용될 치환값 : name, etc3, etc4
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

                    // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
                    oneToOneInfoMap.put("id", dataVO.getUserId());
                    oneToOneInfoMap.put("name", dataVO.getUserNm());                   //성명
                    oneToOneInfoMap.put("etc4", dataVO.getDormancyConversionDt());     //휴면 전환 일자

                    // 치환정보 맵 입력
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);

                    // 선택 입력 항목
                    autoMap.put("senderName", "씨앗마켓");                                        // 생략시 기본 설정값 적용 : 씨앗마켓
                    //autoMap.put("senderEmail", "발신자 이메일");                                 // 생략시 기본 설정값 적용 :
                    //autoMap.put("mailTitle", "메일 제목");                                      // 생략시 기본 설정값 적용

                    // EMAIL 발송
                    result = amservice.sendAutoMail(autoMap);
                    if(result){
                        System.out.println("########################################################");
                        System.out.println("#### 휴면 전환 완료 E-MAIL : " + dataVO.getEmail() + "," + dataVO.getUserNm() + "에게 발송 성공#########");
                        System.out.println("########################################################");
                    }else{
                        System.out.println("########################################################");
                        System.out.println("#### 휴면 전환 완료 E-MAIL : " + dataVO.getEmail() + "," + dataVO.getUserNm() + "에게 발송 실패#########");
                        System.out.println("########################################################");
                    }
                }
            }
        }   // End for
    }

}
