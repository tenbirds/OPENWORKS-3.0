package zes.openworks.common.transmit.sender.sendmail;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.core.spi.commons.configuration.Config;
import zes.openworks.common.transmit.Sender;

/**
 * <p>
 * 메일 전송 클래스.
 * </p>
 * 
 * @EXAMPLE
 *          SmtpServer smtpServer = new SmtpServer("127.0.0.1", "25");
 *          SendMail.setDefaultSmtpServer(smtpServer);
 *          Email email = new Email();
 *          email.setFrom("from@email.com");
 *          email.setTo("to@email.com");
 *          email.setSubject("A test subject");
 *          email.setMessage("A test message");
 *          // email.setHtmlMessage("A test <br>
 *          message");
 *          email.addAttachment(FILE_FULL_PATH_1);
 *          email.addAttachment(FILE_FULL_PATH_2);
 *          SendMail.send(email);
 * @author <a href="http://jodd.sourceforge.net">jOdd</a>
 * @version $Id: SendMail.java 23 2011-07-13 05:20:04Z oworks $
 */
public class SendMailSender implements Sender {

    /** 전송에 필요한 정보 설정 */
    private Properties props;
    /** SL4J 로깅 */
    private static Logger logger = LoggerFactory.getLogger(SendMailSender.class);

    /** 메일발송 서버 정보 */
    private static SmtpServer defaultSmtpServer = null;
    /** 발송자 이름 & 이메일 */
    private static String senderMail = Config.getString("sender.senderNm") + " <" + Config.getString("sender.senderEmail") + ">";

    @Override
    public Sender setProperties(Properties props) throws Exception {

        this.props = props;

        return this;
    }

    @Override
    public boolean send() {

        Boolean sendTf = Boolean.TRUE;

        // 기본값은 config/commons/global-config.xml 파일 내의 sender 속성 참조
        String senderEmail = props.getProperty("sender.email");
        if(senderEmail == null) {
            senderEmail = senderMail;
        }

        logger.debug("sender is {} ", senderEmail);

        String content = (String) this.props.get("content");

        // 실 구현시 for 문 내에서 개별전송 실패에 대한 처리 로직이 필요 할수 있음
        try {
            @SuppressWarnings("unchecked")
            List<Map<String, String>> receiptList = (List<Map<String, String>>) this.props.get("user.list");
            if(receiptList != null) {
                int cnt = receiptList.size();
                String[] to = new String[cnt];
                for(int i = 0 ; i < cnt ; i++) {

                    Map<String, String> receipt = receiptList.get(i);

                    String userName = receipt.get("USER_NAME");
                    String email = receipt.get("EMAIL");

                    to[i] = userName + "<" + email + ">";

                    logger.debug("email is {}, content id ", (userName + " : " + email), content);
                }

                Email email = new Email();
                email.setFrom(senderEmail);
                email.setTo(to);
                email.setSubject(this.props.get("title").toString());
                email.setHtmlMessage(this.props.get("content").toString());
                SendMailSender.send(email);
            }
        } catch (Exception e) {
            if(logger.isDebugEnabled()) {
                logger.info("{} 전송을 실패하였습니다.", "EMAIL", e);
            }
            return Boolean.FALSE;
        }

        return sendTf;
    }

    /**
     * 디폴트 SMTP 서버를 설정한다.
     * 
     * @param server
     *        디폴트 SmtpServer 객체
     */
    public static void setDefaultSmtpServer(SmtpServer server) {
        defaultSmtpServer = server;
    }

    /**
     * 디폴트 SMTP 서버를 얻는다.
     * 
     * @return SmtpServer 객체
     */
    public static SmtpServer getDefaultSmtpServer() {
        return defaultSmtpServer;
    }

    // ---------------------------------------------------------------- send
    /**
     * 기본 SMTP를 통해 메일을 전송한다.
     * 
     * @param email
     *        Email 객체
     * @exception MessagingException
     */
    public static void send(Email email) throws MessagingException, Exception {
        send(email, null);
    }

    /**
     * 지정한 SMTP를 통해 메일을 전송한다.
     * 
     * @param email
     *        Email 객체
     * @param smtpServer
     *        SmtpServer 객체, null일 경우 기본 서버를 사용함.
     * @exception MessagingException
     */
    public static void send(Email email, SmtpServer smtpServer) throws MessagingException, Exception {

        if(smtpServer == null) {
            smtpServer = defaultSmtpServer;
        }
        if(smtpServer == null) {
            smtpServer = new SmtpServer();
        }

        Properties props = new Properties();

        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", smtpServer.getHost());
        props.put("mail.smtp.port", smtpServer.getPort());

        Authenticator auth = null;
        if(smtpServer.getUsername() != null) {
            props.put("mail.smtp.auth", "true");

            auth = new SmtpSimpleAuthenticator(smtpServer.getUsername(), smtpServer.getPassword());
        }
        if(smtpServer.isDebug()) {
            props.put("mail.smtp.debug", "true");
        }
        if(smtpServer.isSSL()) {
            props.put("mail.smtp.socketFactory.port", smtpServer.getPort());
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");
        }

        Session session = Session.getInstance(props, auth);

        Message msg = new MimeMessage(session);

        InternetAddress inetFrom = new InternetAddress(email.getFrom());
        inetFrom.setPersonal(inetFrom.getPersonal(), MailProperty.CHAR_SET);
        msg.setFrom(inetFrom);

        int totalTo = email.getTo().length;
        InternetAddress[] address = new InternetAddress[totalTo];
        for(int i = 0 ; i < totalTo ; i++) {
            address[i] = new InternetAddress(email.getTo()[i]);
            address[i].setPersonal(address[i].getPersonal(), MailProperty.CHAR_SET);
        }
        msg.setRecipients(Message.RecipientType.TO, address);

        if(email.getCc() != null) {
            int totalCc = email.getCc().length;
            address = new InternetAddress[totalCc];
            for(int i = 0 ; i < totalCc ; i++) {
                address[i] = new InternetAddress(email.getCc()[i]);
                address[i].setPersonal(address[i].getPersonal(), MailProperty.CHAR_SET);
            }
            msg.setRecipients(Message.RecipientType.CC, address);
        }
        if(email.getBcc() != null) {
            int totalBcc = email.getBcc().length;
            address = new InternetAddress[totalBcc];
            for(int i = 0 ; i < totalBcc ; i++) {
                address[i] = new InternetAddress(email.getBcc()[i]);
                address[i].setPersonal(address[i].getPersonal(), MailProperty.CHAR_SET);
            }
            msg.setRecipients(Message.RecipientType.BCC, address);
        }

        msg.setSubject(email.getSubject());
        Date date = email.getSentDate();
        if(date == null) {
            date = new Date();
        }
        msg.setSentDate(date);

        HashMap<String, String> headers = email.getHeaders();
        Iterator<String> it = headers.keySet().iterator();
        while(it.hasNext()) {
            String name = it.next();
            String value = headers.get(name);
            msg.setHeader(name, value);
        }

        MimeBodyPart messageData = new MimeBodyPart();

        if(email.isHtmlMessage()) {
            messageData.setContent(email.getMessage(), "text/html; charset=" + MailProperty.CHAR_SET);
        } else {
            /*--
            messageBodyPart.setContent(
                 email.getMessage(), "text/plain; charset=\"Windows-1250\";");
            messageBodyPart.setText(email.getMessage(), "Windows-1250");
            --*/
            messageData.setText(email.getMessage());
        }

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageData);

        int totalAttachments = email.getTotalAttachments();
        for(int i = 0 ; i < totalAttachments ; i++) {
            multipart.addBodyPart(email.getAttachmentBodyPart(i));
        }

        msg.setContent(multipart);

        /*--
        Transport.send(msg);
        --*/
        new MailThread(msg).start();
    }

    static class MailThread extends Thread {

        Message msg;

        public MailThread(Message msg) {
            super("");
            this.msg = msg;
        }

        @Override
        public void run() {

            try {
                Transport.send(msg);
            } catch (Exception e) {
                logger.error("메일전송 실패", e);
            }
        }
    }

}
