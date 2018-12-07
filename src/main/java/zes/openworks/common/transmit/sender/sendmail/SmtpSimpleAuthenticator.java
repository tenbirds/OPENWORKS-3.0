package zes.openworks.common.transmit.sender.sendmail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * <p>
 * Smtp 서버 접속에 필요한 인증을 취득하기 위한 클래스
 * </p>
 * 
 * @EXAMPLE
 *          Properties props = new Properties();
 *          props.put("mail.smtp.host", "127.0.0.1");
 *          Authenticator auth = new SmtpSimpleAuthenticator("user",
 *          "password");
 *          javax.mail.Session session = javax.mail.Session.getInstance(props,
 *          auth);
 *          .... 이하 생략
 * @author <a href="http://jodd.sourceforge.net">jOdd</a>
 * @version $Id: SmtpSimpleAuthenticator.java 23 2011-07-13 05:20:04Z oworks $
 */
public class SmtpSimpleAuthenticator extends Authenticator {

    private String username;

    private String password;

    /**
     * 지정한 계정으로 SMTP SmtpSimpleAuthenticator을 생성한다.
     * 
     * @param username
     *        사용자 아이디
     * @param password
     *        사용자 비밀번호
     */
    public SmtpSimpleAuthenticator(String username, String password) {
        super();
        this.username = username;
        this.password = password;
    }

    /**
     * 사용자 아이디, 비밀번호 레파지토리를 얻는다.
     * 
     * @return PasswordAuthentication 객체
     */
    @Override
    public PasswordAuthentication getPasswordAuthentication() {

        return new PasswordAuthentication(username, password);
    }
}
