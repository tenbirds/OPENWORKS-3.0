/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.support;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Cms 메뉴 관리 컨트롤에 기능으로서의 컨텐츠를 메뉴에 매핑 하는 경우
 * 해당 정보를 Cms 메뉴 관리 컨트롤에 전달할 서비스에 사용한다.<br />
 * 예) 게시판, 설문, 기타 어플리케이션
 * <p />
 * <strong>예문</strong>
 * 
 * <pre>
 * 주석 등
 * ....
 * <strong>@</strong>CmsReference(name="게시판목록", method="getCmsRefrence")
 * public class BbsController {
 *     ...
 * 
 *     주석.. Cms 메뉴관리 컨트롤에서 호출되는 메소드...
 *     <strong>@</strong>CmsReference(name="게시판목록")
 *     public List<CmsReferenceBean> getCmsRefrence() {
 *         ...
 *         return referenceList;
 *     }
 * }
 * </pre>
 * 
 * @author xanadu
 * @version 0.1, JDK 1.5 later, 2011. 2. 17.
 * @since OP 1.0
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ java.lang.annotation.ElementType.TYPE, java.lang.annotation.ElementType.METHOD })
@Documented
public @interface CmsReference {

    /**
     * Cms 컨트롤 에서 호출 되는 한글 명칭<br />
     * 예) 게시판목록, 설문조사목록.. 등 서비스 명칭
     */
    public abstract String name();

    /**
     * Cms 컨트롤에게 넘겨줄 정보를 제공하는 <code>Method</code> 명을 입력
     * 지시자, 반환형식, 파라미터등은 제외하고 순수 명칭만 사용<br />
     * 예) getCmsReference
     */
    public abstract String method();
}
