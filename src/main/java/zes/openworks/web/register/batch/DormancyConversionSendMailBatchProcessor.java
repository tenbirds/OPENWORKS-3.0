package zes.openworks.web.register.batch;

import java.net.InetAddress;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.openworks.common.schedule.Processor;

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
public class DormancyConversionSendMailBatchProcessor implements Processor{
    Logger logger = LoggerFactory.getLogger(DormancyConversionSendMailBatchProcessor.class);

    @Resource
    private DormancyConversionSendMailBatchService dormancyConversionSendMailBatchService;

    @Override
    public void process(){
        try {
            InetAddress inet = InetAddress.getLocalHost();
            String svrIP = inet.getHostAddress();
            /**************************************************/
            /* 운영서버가 아닐경우 스케줄이 동작하지 않게 함. */
            /**************************************************/
            if(!svrIP.equals("202.30.77.182")){
                return;
            }

            // TODO Auto-generated method stub
            logger.info("======================================================");
            logger.info("휴면 전환 안내 메일 발송 시작");

            dormancyConversionSendMailBatchService.dormancyConversionSendMail();

            logger.info("휴면 전환 안내 메일 발송 끝");
            logger.info("======================================================");

            logger.info("======================================================");
            logger.info("휴면 전환 시작");

            dormancyConversionSendMailBatchService.dormancyConversion();

            logger.info("휴면 전환 끝");
            logger.info("======================================================");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
