package zes.core.utils;

import zes.core.crypto.Crypto;
import zes.core.crypto.CryptoFactory;

/**
 * 관리자, 회원(사용자) 비밀번호 생성기
 * 
 * @author wisepms
 * @version $Id: PasswordGenerator.java 23 2011-07-13 05:20:04Z oworks $
 */
public class PasswordGenerateUtil {

    private final static int MIN_SIZE = 10;
    private final static int MAX_SIZE = 15;

    /**
     * 비밀번호 초기화
     */
    public static String initPwd() {

        int pwdSize = nextInt(getSize());
        int alphaSize = (int) (Math.random() * pwdSize);
        int numSize = pwdSize - alphaSize;
        StringBuilder initPwd = new StringBuilder();

        for(int i = 0 ; i < alphaSize ; i++) {
            char ch = (char) ((Math.random() * 26) + 97);
            initPwd.append(ch);
        }
        for(int i = 0 ; i < numSize ; i++) {
            initPwd.append((int) (Math.random() * 10));
        }

        Crypto crypto = CryptoFactory.getInstance();

        return crypto.encrypt(initPwd.toString());
    }

    private static int getSize() {
        return (int) (Math.random() * MAX_SIZE + 1);
    }

    private static int nextInt(int num) {

        while(MIN_SIZE > num) {
            num = getSize();
        }
        return num;
    }
}
