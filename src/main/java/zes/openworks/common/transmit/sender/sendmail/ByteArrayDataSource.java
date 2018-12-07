package zes.openworks.common.transmit.sender.sendmail;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.activation.FileTypeMap;

/**
 * <p>
 * InputStream, 바이트배열, 문자열, 파일 등의 DataSource 구현체.
 * </p>
 * 이 클래스는 javamail API 데모를 참조해 만들었으나 성능은 더 우수하다.
 * 
 * @author <a href="http://jodd.sourceforge.net">jOdd</a>
 * @version $Id: ByteArrayDataSource.java 23 2011-07-13 05:20:04Z oworks $
 */
public class ByteArrayDataSource implements DataSource {

    /** 데이타 */
    private byte[] data;

    /** Content-Type */
    private String type;

    /**
     * 지정한 파일을 통해 데이타소스를 생성한다.<br>
     * Content-Type이 null이면 지정한 파일 확장자를 통해 타입이 지정된다.
     * 
     * @param f
     *        파일 객체
     * @param type
     *        Content-Type
     */
    public ByteArrayDataSource(File f, String type) throws IOException {
        this(new FileInputStream(f), type);
        if(this.type == null) {
            this.type = FileTypeMap.getDefaultFileTypeMap().getContentType(f);
        }
    }

    /**
     * 지정한 InputStream을 통해 데이타소스를 생성한다.
     * 
     * @param is
     *        InputStream
     * @param type
     *        Content-Type
     */
    public ByteArrayDataSource(InputStream is, String type) throws IOException {
        this.type = type;

        ByteArrayOutputStream os = new ByteArrayOutputStream(4096);

        byte buf[] = new byte[4096];
        int len;
        while(true) {
            len = is.read(buf);
            if(len < 0) {
                break;
            }
            os.write(buf, 0, len);
        }
        data = os.toByteArray();
    }

    /**
     * 지정한 바이트 배열을 통해 데이타소스를 생성한다.
     * 
     * @param data
     *        바이트 배열
     * @param type
     *        Content-Type
     */
    public ByteArrayDataSource(byte[] data, String type) {
        this.type = type;
        this.data = data;
    }

    /**
     * 지정한 문자열을 통해 데이타소스를 생성한다.<br>
     * 기본값으로 iso-8859-1 인코딩을 사용한다.<br>
     * 다른 유형의 인코딩을 사용할려면 Content-Type에 "charset"을 붙여서 지정하면 된다.
     * 
     * @param data
     *        byte array
     * @param type
     *        Content-Type
     */
    public ByteArrayDataSource(String data, String type) {
        this.type = type;
        try {
            this.data = data.getBytes("ISO-8859-1");
        } catch (UnsupportedEncodingException uex) {}
    }

    /**
     * 설정된 데이타에 대한 InputStream을 얻는다.
     * 
     * @return InputStream
     */
    @Override
    public InputStream getInputStream() throws IOException {
        if(data == null) {
            throw new IOException("No data.");
        }
        return new ByteArrayInputStream(data);
    }

    /**
     * 본 함수는 아직 구현되지 않았음.
     */
    @Override
    public OutputStream getOutputStream() throws IOException {
        throw new IOException("getOutputStream() not supported.");
    }

    /**
     * Content-Type을 얻는다.
     * 
     * @return Content-Type
     */
    @Override
    public String getContentType() {
        return type;
    }

    /**
     * Content-Type을 설정한다.
     * 
     * @param type
     *        Content-Type
     */
    public void setContentType(String type) {
        this.type = type;
    }

    /**
     * 아직 구현되지 않았음.
     */
    @Override
    public String getName() {
        return "";
    }

    /**
     * 지정한 OutputStream으로 데이타를 기록한다.
     * 
     * @param os
     *        데이타를 기록한 OutputStream.
     */
    public void writeTo(OutputStream os) throws IOException {
        os.write(data);
    }

    /**
     * 바이트 배열로 데이타를 얻는다.
     * 
     * @return 바이트 배열
     */
    public byte[] toByteArray() {
        return data;
    }

    /**
     * 데이타의 길이를 구한다.
     * 
     * @return 데이타의 길이, 아직 미설정되었다면 -1 반환.
     */
    public int getSize() {
        if(data == null) {
            return -1;
        } else {
            return data.length;
        }
    }

    /**
     * 데이타를 문자열로 얻는다.<br/>
     * 데이타 인코딩은 Content-Type에 설정된 "charset" 인자를 통해 결정된다.<br/>
     * 만약 설정되지 않았다면 디폴트로 ISO-8859-1로 인코딩한다.
     * 
     * @return 데이타 문자열
     */
    public String getText() {
        try {
            return new String(data, type);
        } catch (UnsupportedEncodingException uex) {
            try {
                return new String(data, "ISO-8859-1");
            } catch (UnsupportedEncodingException uex1) {
                return null;
            }
        }
    }
}
