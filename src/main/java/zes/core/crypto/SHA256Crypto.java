/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.crypto;

import java.security.MessageDigest;

import sun.misc.BASE64Encoder;

/**
 * SHA256 복호화 불가능한 암호화
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 23.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@SuppressWarnings("restriction")
public class SHA256Crypto implements Crypto {

    @Override
    public String encrypt(String encStr) {
        String result = "";
        try {
            byte[] bytes = encStr.getBytes("UTF-16");

            MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
            byte[] hash = sha256.digest(bytes);

            BASE64Encoder encoder = new BASE64Encoder();
            result = encoder.encode(hash);

        } catch (Exception e) {}

        return result;
    }

    @Override
    public String decrypt(String decStr) {

        return null;
    }

    @Override
    public Crypto setKey(String cryptoKey) {

        return null;
    }

}
