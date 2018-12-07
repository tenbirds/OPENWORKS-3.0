package zes.core.crypto;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.CipherOutputStream;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * DES 기반의 대칭키 암호화 복호화
 * 
 * @EXAMPLE
 *          <pre>
 * String encStr = DESCrypto.encrypt("홍길동", "/path/to/openworks.key.ser"); 
 * String decStr = DESCrypto.decrypt(encStr, "/path/to/openworks.key.ser"); 
 * 
 * ※ 비밀키 없이 작업하는 방법 
 * 별도의 비밀키를 지정하지 않을 경우에는 기본 라이브러리에 포함된
 * 기본키(/kr/openworks/core/spi/crypto/openworks.key.ser)를 사용함 
 * String encStr = DESCrypto.encrypt("홍길동"); 
 * String decStr = DESCrypto.decrypt(encStr);
 * </pre>
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 5.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@SuppressWarnings("restriction")
public class DESCrypto implements Crypto {

    /**
     * 파일 암호화에 쓰이는 버퍼 크기 지정
     */
    public static final int kBufferSize = 8192;

    private InputStream defaultInputStream = null;

    private String cryptoFile = "zes/core/crypto/openworks.key.ser";

    public DESCrypto() {

        defaultInputStream = getClass().getClassLoader().getResourceAsStream(cryptoFile);

        if(defaultInputStream == null) {
            defaultInputStream = getClass().getClassLoader().getResourceAsStream("/" + cryptoFile);
        }

        if(defaultInputStream == null) {
            defaultInputStream = getClass().getResourceAsStream(cryptoFile);
        }

        if(defaultInputStream == null) {
            defaultInputStream = getClass().getResourceAsStream("/" + cryptoFile);
        }
    }

    public DESCrypto(String desKey) {

        cryptoFile = desKey;

        defaultInputStream = getClass().getClassLoader().getResourceAsStream(cryptoFile);

        if(defaultInputStream == null) {
            defaultInputStream = getClass().getClassLoader().getResourceAsStream("/" + cryptoFile);
        }

        if(defaultInputStream == null) {
            defaultInputStream = getClass().getResourceAsStream(cryptoFile);
        }

        if(defaultInputStream == null) {
            defaultInputStream = getClass().getResourceAsStream("/" + cryptoFile);
        }
    }

    @Override
    public Crypto setKey(String cryptoKey) {
        this.cryptoFile = cryptoKey;
        return this;
    }

    /**
     * 지정된 비밀키를 가지고 오는 메서드
     * 
     * @return Key 비밀키 클래스
     * @exception Exception
     */
    private Key getKey(String keyFile) throws Exception {

        String fileURL = null;
        ObjectInputStream in = null;

        if(keyFile == null) {
            in = new ObjectInputStream(new DESCrypto().defaultInputStream);
        } else {
            fileURL = keyFile;
            in = new ObjectInputStream(new FileInputStream(fileURL));
        }

        Key key = (Key) in.readObject();
        in.close();

        return key;
    }

    /**
     * 문자열 대칭 암호화
     * 
     * @param ID 비밀키 암호화를 희망하는 문자열
     * @return String 암호화된 ID
     * @exception Exception
     */
    public String encrypt(String ID, String keyFile) {

        if(ID == null || ID.length() == 0) {
            return "";
        }

        try {
            Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, getKey(keyFile));
            String amalgam = ID;

            byte[] inputBytes1 = amalgam.getBytes("UTF8");
            byte[] outputBytes1 = cipher.doFinal(inputBytes1);
            BASE64Encoder encoder = new BASE64Encoder();

            return encoder.encode(outputBytes1);
        } catch (Exception e) {
            return "";
        }
    }

    @Override
    public String encrypt(String ID) {

        return encrypt(ID, null);
    }

    /**
     * 문자열 대칭 복호화
     * 
     * @param codedID 비밀키 복호화를 희망하는 문자열
     * @return String 복호화된 ID
     * @exception Exception
     */
    public String decrypt(String codedID, String keyFile) {

        if(codedID == null || codedID.length() == 0) {
            return "";
        }

        try {
            Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, getKey(keyFile));
            BASE64Decoder decoder = new BASE64Decoder();

            byte[] inputBytes1 = decoder.decodeBuffer(codedID);
            byte[] outputBytes2 = cipher.doFinal(inputBytes1);

            return new String(outputBytes2, "UTF8");
        } catch (Exception e) {
            return "";
        }
    }

    @Override
    public String decrypt(String codedID) {

        return decrypt(codedID, null);
    }

    /**
     * 파일 대칭 암호화
     * 
     * @param infile 암호화을 희망하는 파일명
     * @param outfile 암호화된 파일명
     * @exception Exception
     */
    public void encryptFile(String infile, String outfile, String keyFile) throws Exception {

        Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, getKey(keyFile));

        FileInputStream in = new FileInputStream(infile);
        FileOutputStream fileOut = new FileOutputStream(outfile);

        CipherOutputStream out = new CipherOutputStream(fileOut, cipher);
        byte[] buffer = new byte[kBufferSize];
        int length;
        while((length = in.read(buffer)) != -1) {
            out.write(buffer, 0, length);
        }
        in.close();
        out.close();
    }

    public void encryptFile(String infile, String outfile) throws Exception {

        encryptFile(infile, outfile, null);
    }

    /**
     * 파일 대칭 복호화
     * 
     * @param infile 복호화을 희망하는 파일명
     * @param outfile 복호화된 파일명
     * @exception Exception
     */
    public void decryptFile(String infile, String outfile, String keyFile) throws Exception {

        Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, getKey(keyFile));

        FileInputStream in = new FileInputStream(infile);
        FileOutputStream fileOut = new FileOutputStream(outfile);

        CipherOutputStream out = new CipherOutputStream(fileOut, cipher);
        byte[] buffer = new byte[kBufferSize];
        int length;
        while((length = in.read(buffer)) != -1) {
            out.write(buffer, 0, length);
        }
        in.close();
        out.close();
    }

    public void decryptFile(String infile, String outfile) throws Exception {

        decryptFile(infile, outfile, null);
    }
}
