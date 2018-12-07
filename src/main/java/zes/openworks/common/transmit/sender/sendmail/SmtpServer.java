package zes.openworks.common.transmit.sender.sendmail;

/**
 * <p>
 * SMTP 서버를 표현하는 클래스.
 * </p>
 * 
 * @EXAMPLE
 *          SmtpServer smtpServer = new SmtpServer("127.0.0.1");
 *          SmtpServer smtpServer =
 *          new SmtpServer("127.0.0.1", "user", "password");
 * @author <a href="http://jodd.sourceforge.net">jOdd</a>
 * @version $Id: SmtpServer.java 23 2011-07-13 05:20:04Z oworks $
 */
public class SmtpServer {

    // ----------------------------------------------------------------
    // construct
    public SmtpServer() {
        this.host = MailProperty.MAIL_HOST;
        this.port = MailProperty.MAIL_PORT;
        this.isSSL = MailProperty.IS_SSL;
        this.isDebug = MailProperty.IS_DEBUG;
        this.username = MailProperty.MAIL_ID;
        this.password = MailProperty.MAIL_PASSWORD;
    }

    private String host;
    private String port;
    private String username;
    private String password;
    private boolean isSSL;
    private boolean isDebug;

    /**
     * 지정한 호스트로 SMTP 서버를 생성한다.
     * 
     * @param host
     *        SMTP 서버 주소
     */
    public SmtpServer(String host) {
        this.host = host;
        this.port = MailProperty.MAIL_PORT;
    }

    /**
     * 지정한 호스트와 포트로 SMTP 서버를 생성한다.
     * 
     * @param host SMTP 서버 주소
     * @param port SMTP 포트
     */
    public SmtpServer(String host, String port) {
        this.host = host;
        this.port = port;
    }

    /**
     * 지정한 호스트, 계정으로 SMTP 서버를 생성한다.
     * 
     * @param host
     *        SMTP 서버 주소
     * @param username
     *        사용자 아이디
     * @param password
     *        사용자 비밀번호
     * @param port
     *        SMTP 포트
     */
    public SmtpServer(String host, String port, String username, String password) {
        this.host = host;
        this.port = port;
        this.username = username;
        this.password = password;
    }

    // ---------------------------------------------------------------- data

    /**
     * SMTP 주소를 설정한다.
     * 
     * @param host
     *        SMTP 주소
     */
    public void setHost(String host) {
        this.host = host;
    }

    /**
     * SMTP 주소를 얻는다.
     * 
     * @return SMTP 주소
     */
    public String getHost() {
        return host;
    }

    /**
     * SMTP 주소 인증을 위한 사용자 아이디를 설정한다.
     * 
     * @param username
     *        SMTP 사용자 아이디
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * SMTP 사용자 아이디를 얻는다.
     * 
     * @return SMTP 사용자 아이디
     */
    public String getUsername() {
        return username;
    }

    /**
     * SMTP 사용자 비밀번호를 설정한다.
     * 
     * @param password
     *        SMTP 사용자 비밀번호
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * SMTP 사용자 비밀번호를 얻는다.
     * 
     * @return SMTP 사용자 비밀번호
     */
    public String getPassword() {
        return password;
    }

    /**
     * SMTP 포트를 얻는다.
     * 
     * @return
     */
    public String getPort() {
        return port;
    }

    /**
     * SMTP 포트를 설정한다.
     * 
     * @param port
     */
    public void setPort(String port) {
        this.port = port;
    }

    public boolean isSSL() {
        return isSSL;
    }

    public void setSSL(boolean isSSL) {
        this.isSSL = isSSL;
    }

    public boolean isDebug() {
        return isDebug;
    }

    public void setDebug(boolean isDebug) {
        this.isDebug = isDebug;
    }

}
