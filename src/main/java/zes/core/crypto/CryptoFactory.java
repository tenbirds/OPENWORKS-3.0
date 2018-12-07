/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.crypto;

import zes.openworks.common.GlobalConfig;

/**
 * 암호화 모듈을 반환한다.
 * 지원되는 암호화 방식은 DES/SEED 두개의 타입이다. <br />
 * 암호화 모듈 별칭으로 지정하지 않는 경우 프레임워크 기본 설정에 따라
 * 암호화 모듈이 반환된다.
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
 *  2012. 3. 5.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see GlobalConfig
 */
public class CryptoFactory {

    /**
     * 각각의 명칭에 해당하는 암복호화 지칭
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
    public enum EncryptType {
        DES, SEED, ARIA, SHA256
    }

    /**
     * 프레임 워크 기본 암호화 모듈 반환
     * 
     * @return
     * @see GlobalConfig
     */
    public static Crypto getInstance() {

        return getInstance(GlobalConfig.DEFAULT_CRYPTO);
    }

    /**
     * 별칭으로 암호화 모듈 반환
     * 
     * <pre>
     * DES : DESCrypto
     * SEED : SEEDCrypto
     * </pre>
     * 
     * @param cryptoName
     * @return
     */
    public static Crypto getInstance(String cryptoName) {

        return getInstance(EncryptType.valueOf(cryptoName));
    }

    /**
     * 별칭으로 암호화 모듈 반환
     * 
     * <pre>
     * DES : DESCrypto
     * SEED : SEEDCrypto
     * </pre>
     * 
     * @param cryptoName
     * @return
     */
    public static Crypto getInstance(EncryptType cryptoType) {
        if(EncryptType.DES.equals(cryptoType)) {
            return new DESCrypto();
        } else if(EncryptType.SEED.equals(cryptoType)) {
            return new SEEDCrypto();
        } else if(EncryptType.ARIA.equals(cryptoType)) {
            return new ARIACrypto();
        } else if(EncryptType.SHA256.equals(cryptoType)) {
            return new SHA256Crypto();
        } else {
            new Throwable("지원하지 않는 암호화 방식입니다.");
        }
        return null;
    }

}
