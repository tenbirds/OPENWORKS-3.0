package zes.openworks.common.interceptor;

import javax.servlet.http.HttpServletRequest;

/**
 * Base Interceptor interface
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
 * 2012. 2. 26.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface IBaseInterceptor {

    /**
     * 대상 URL 패턴과 일치 하는지 여부를 확인
     * 
     * @param request
     * @return boolean 패턴과 일치시 true 이외 false
     */
    boolean validate(HttpServletRequest request);
}
