package zes.openworks.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import zes.base.vo.BaseVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;

/**
 * 사용자단 로그인 체크 Interceptor
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
 *  2012. 2. 26.    방기배   신규 생성
 * </pre>
 * @see
 */
public class UserLoginCheckInterceptor extends BaseInterceptor {

    protected final Log logger = LogFactory.getLog(getClass());

    /**
     * 사용자단 회원로그인 여부 및 권한 체크
     * 
     * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle
     *      (javax.servlet.http.HttpServletRequest,
     *      javax.servlet.http.HttpServletResponse, java.lang.Object)
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if(validate(request)) {
            BaseVO baseVo = (BaseVO) (request.getSession().getAttribute(GlobalConfig.USER_SESSION_KEY));

            if(Validate.isNull(baseVo)) {
                response.sendRedirect(GlobalConfig.USER_LOGIN);
                return false;
            }
        }
        return super.preHandle(request, response, handler);
    }

}
