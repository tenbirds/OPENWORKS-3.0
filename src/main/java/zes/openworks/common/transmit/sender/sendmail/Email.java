package zes.openworks.common.transmit.sender.sendmail;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeBodyPart;

/**
 * <p>
 * 메일 전송에 필요한 정보를 가지고 있는 저장소
 * </p>
 * 
 * @author <a href="http://jodd.sourceforge.net">jOdd</a>
 * @version $Id: Email.java 23 2011-07-13 05:20:04Z oworks $
 */
public class Email {

    // ---------------------------------------------------------------- address

    private String from = MailProperty.MAIL_SENDER;

    /**
     * 발송자 메일주소 설정.
     * 
     * @param from
     *        발송자 메일주소
     */
    public void setFrom(String from) {
        this.from = from;
    }

    /**
     * 발송자 메일주소 얻기.
     * 
     * @return 발송자 메일주소
     */
    public String getFrom() {
        return from;
    }

    private String[] to;

    /**
     * 수신자 메일주소 설정.
     * 
     * @param to
     *        수신자 메일주소
     */
    public void setTo(String to) {
        this.to = new String[1];
        this.to[0] = to;
    }

    /**
     * 수신자 메일주소 목록 설정.
     * 
     * @param to
     *        수신자 메일주소 배열
     */
    public void setTo(String[] to) {
        this.to = to;
    }

    /**
     * 수신자 메일주소목록 얻기.
     * 
     * @return 수신자 메일주소 배열
     */
    public String[] getTo() {
        return to;
    }

    private String[] cc;

    /**
     * 참조자 메일주소 설정.
     * 
     * @param cc
     *        참조자 메일주소
     */
    public void setCc(String cc) {
        this.cc = new String[1];
        this.cc[0] = cc;
    }

    /**
     * 참조자 메일주소 목록 설정.
     * 
     * @param cc
     *        참조자 메일주소 배열.
     */
    public void setCc(String[] cc) {
        this.cc = cc;
    }

    /**
     * 참조자 메일주소 목록 얻기.
     * 
     * @return 참조자 메일주소 배열
     */
    public String[] getCc() {
        return cc;
    }

    private String[] bcc;

    /**
     * 숨은 참조자 메일주소 설정.
     * 
     * @param bcc
     *        숨은 참조자 메일주소
     */
    public void setBcc(String bcc) {
        this.bcc = new String[1];
        this.bcc[0] = bcc;
    }

    /**
     * 숨은 참조자 메일주소 목록 설정.
     * 
     * @param bcc
     *        숨은 참조자 메일주소 배열.
     */
    public void setBcc(String[] bcc) {
        this.bcc = bcc;
    }

    /**
     * 숨은 참조자 메일주소 목록 얻기.
     * 
     * @return 숨은 참조자 메일주소 배열.
     */
    public String[] getBcc() {
        return bcc;
    }

    // ---------------------------------------------------------------- content
    private String subject;

    /**
     * 메일 제목 설정.
     * 
     * @param subject
     *        메일 제목
     */
    public void setSubject(String subject) {
        this.subject = subject;
    }

    /**
     * 메일 제목 얻기.
     * 
     * @return 메일 제목
     */
    public String getSubject() {
        return this.subject;
    }

    private boolean htmlMessage = false;

    private String message;

    /**
     * 텍스트 메일 메시지 설정.
     * 
     * @param message
     *        텍스트 메일 메시지
     */
    public void setMessage(String message) {
        this.htmlMessage = false;
        this.message = message;
    }

    /**
     * 메일 메시지 얻기. (텍스트 or HTML)
     * 
     * @return 메일 메시지
     */
    public String getMessage() {
        return this.message;
    }

    /**
     * HTML 메일 메시지 설정.
     * 
     * @param htmlMessage
     *        HTML 메일 메시지
     */
    public void setHtmlMessage(String htmlMessage) {
        this.htmlMessage = true;
        this.message = htmlMessage;
    }

    /**
     * HTML 메일 메시지 여부 확인.
     * 
     * @return true HTML 메시지면 true.
     */
    public boolean isHtmlMessage() {
        return this.htmlMessage;
    }

    // ----------------------------------------------------------------
    // attachments

    private ArrayList<MimeBodyPart> attachments = new ArrayList<MimeBodyPart>();

    /**
     * 전체 첨부파일 갯수 얻기.
     * 
     * @return 전체 첨부파일 갯수
     */
    public int getTotalAttachments() {
        return attachments.size();
    }

    /**
     * javamail API 사용을 위해 지정 인덱스에 위치한 첨부파일 BodyPart 얻기.
     * 
     * @param i
     *        첨부파일 인덱스
     * @return 첨부파일 MimeBodyPart
     */
    public MimeBodyPart getAttachmentBodyPart(int i) {
        return attachments.get(i);
    }

    /**
     * 바이너리 첨부파일 추가하기.
     * 
     * @param fileName
     *        파일명(전체경로)
     * @param dh
     *        DataHandler
     * @exception MessagingException
     */
    public void addAttachment(String fileName, DataHandler dh) throws MessagingException {
        MimeBodyPart attBodyPart = new MimeBodyPart();
        attBodyPart.setFileName(fileName);
        attBodyPart.setDataHandler(dh);
        attachments.add(attBodyPart);
    }

    /**
     * HTML 첨부파일 추가하기.
     * 
     * @param fileName
     *        파일명(전체경로)
     * @param data
     *        HTML 데이타
     * @exception MessagingException
     */
    public void addAttachment(String fileName, String data) throws MessagingException {
        DataHandler dh = new DataHandler(new ByteArrayDataSource(data, "text/html; charset=" + MailProperty.CHAR_SET));
        addAttachment(fileName, dh);
    }

    /**
     * 첨부파일 추가하기.
     * 
     * @param fileName
     *        파일명(전체경로)
     * @exception MessagingException
     */
    public void addAttachment(String fileName) throws MessagingException {
        FileDataSource fds = new FileDataSource(fileName);
        addAttachment(fds.getName(), new DataHandler(fds));
    }

    // ---------------------------------------------------------------- headers
    private HashMap<String, String> headers = new HashMap<String, String>();

    /**
     * 전체 헤더정보를 맵으로 얻는다.
     * 
     * @return 헤더정보 맵
     */
    HashMap<String, String> getHeaders() {
        return headers;
    }

    /**
     * 단일 헤더를 추가한다.
     * 
     * @param name
     *        헤더 키
     * @param value
     *        헤더 값
     */
    public void addHeader(String name, String value) {
        headers.put(name, value);
    }

    /**
     * 복합 헤더를 추가한다.
     * 
     * @param map
     *        헤더 맵
     */
    public void addHeaders(Map<String, String> map) {
        headers.putAll(map);
    }

    // ---------------------------------------------------------------- date

    private Date sentDate = null;

    /**
     * 발신일자를 설정한다. <code>null</code>일 경우 물리적으로 송신된 날짜가 기록된다.
     * 
     * @param date
     *        발신일자
     */
    public void setSentDate(Date date) {
        sentDate = date;
    }

    /**
     * 발신일자를 현재시간으로 설정한다.
     */
    public void setSentDate() {
        sentDate = new Date();
    }

    /**
     * 발신일자를 얻는다. 반환값이 <code>null</code>이면 메일이 송신중일 수도 있다.
     * 
     * @return 발신일자
     */
    public Date getSentDate() {
        return sentDate;
    }
}
