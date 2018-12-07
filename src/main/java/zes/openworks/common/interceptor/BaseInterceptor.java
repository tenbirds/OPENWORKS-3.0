package zes.openworks.common.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import zes.core.lang.Validate;
import zes.core.utils.PathMapper;
import zes.core.utils.StringUtil;

/**
 * Base Interceptor
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
 *  2012. 2. 26.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BaseInterceptor extends HandlerInterceptorAdapter implements IBaseInterceptor {

    private final PathMapper includeMapper = new PathMapper();
    private final PathMapper excludeMapper = new PathMapper();

    /**
     * 대상 URL 패턴 설정
     * 
     * @param urls
     */
    public void setInclude(String[] urls) {
        if(Validate.isNotEmpty(urls)) {
            for(String url : urls) {
                includeMapper.put(StringUtil.EMPTY, url);
            }
        }
    }

    /**
     * 제외 URL 패턴 설정
     * 
     * @param urls
     */
    public void setExclude(String[] urls) {
        if(Validate.isNotEmpty(urls)) {
            for(String url : urls) {
                excludeMapper.put(StringUtil.EMPTY, url);
            }
        }
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.core.spring.interceptor.IBaseInterceptor#validate(javax.servlet.http
     * .HttpServletRequest)
     */
    @Override
    public boolean validate(HttpServletRequest request) {

        String path = extractRequestPath(request);

        if(excludeMapper.get(path) != null) {
            return false;
        }
        if(includeMapper.get(path) != null) {
            return true;
        }

        return false;
    }

    /**
     * 요청 URL(ServletPath 포함)과 QueryString 결합한 결과
     * 
     * @param request
     * @return 전체 URL
     */
    private String extractRequestPath(HttpServletRequest request) {

        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        String query = request.getQueryString();

        return (servletPath == null ? "" : servletPath) + (pathInfo == null ? "" : pathInfo)
            + (query == null ? "" : ("?" + query));
    }
}
