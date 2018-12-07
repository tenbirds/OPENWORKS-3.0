/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.util.random;

import java.util.Random;
import java.util.Date;
/**
 * 
 *
 * @version 1.0
 * @since kwea_new 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 11. 11.    김영상       신규
 *</pre>
 * @see
 */
public final class RandomNumber {

    public static int getInt() {
        return _rnd.nextInt();
    }
    public static int getInt(int n) {
        return _rnd.nextInt(n);
    }
    private static Random _rnd = null;
    static {
        _rnd = new Random(new Date().getTime());
    }
}