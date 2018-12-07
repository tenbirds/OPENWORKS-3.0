package zes.base.log;

import java.lang.reflect.Proxy;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.AbstractUrlBasedView;
import org.springframework.web.servlet.view.AbstractView;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.util.UrlPathHelper;

import zes.core.lang.Validate;
import zes.core.utils.ExceptionUtil;

public class OpenworksLogger {

    protected final Logger logger = LoggerFactory.getLogger(getClass());

    private static int requestCount = 0;

    private HttpServletRequest request = null;
    private Object handler = null;
    private ModelAndView mv = null;
    private Exception exception = null;

    public OpenworksLogger() {
    }

    /**
     * HttpServletRequest 설정 후 <code>this</code> 반환(Chain Method Type)
     * 
     * @param request
     * @return
     */
    public OpenworksLogger setRequest(HttpServletRequest request) {
        this.request = request;
        return this;
    }

    /**
     * Handler 설정 후 <code>this</code> 반환(Chain Method Type)
     * 
     * @param handler
     * @return
     */
    public OpenworksLogger setHandler(Object handler) {
        this.handler = handler;
        return this;
    }

    /**
     * ModelAndView 설정 후 <code>this</code> 반환(Chain Method Type)
     * 
     * @param mv
     * @return
     */
    public OpenworksLogger setModelAndView(ModelAndView mv) {
        this.mv = mv;
        return this;
    }

    /**
     * Exception 설정 후 <code>this</code> 반환(Chain Method Type)
     * 
     * @param exception
     * @return
     */
    public OpenworksLogger setException(Exception exception) {
        this.exception = exception;
        return this;
    }

    /**
     * 출력 결과 반환
     * 
     * @return
     */
    public String getResult() {

        StringBuilder logText = new StringBuilder();

        if(logger.isInfoEnabled()) {

            String requestUri = new UrlPathHelper().getRequestUri(request);

            boolean isMultipart = ServletFileUpload.isMultipartContent(request);

            if(isMultipart) {
                //request = request;
            }

            logText.append("\n------------------------------------------");
            logText.append("\nREQUEST    : ");
            logText.append(request.getRemoteAddr() + ", ");
            logText.append((isMultipart ? "MULTIPART" : request.getMethod().toUpperCase()) + " ("
                + (requestCount++) + " called) ");
            logText.append("\n           : " + request.toString());
            logText.append("\nURI        : " + requestUri);

            int parameterLength = 0;
            StringBuilder paramText = new StringBuilder();

            Enumeration<?> _enum = request.getParameterNames();
            while(_enum.hasMoreElements()) {
                String key = _enum.nextElement().toString();
                String[] value = request.getParameterValues(key);
                if(value.length == 1) {
                    paramText.append("\t{" + key + " = " + prettyText(value[0]) + "}\n");
                } else {
                    paramText.append("\t{" + key + "[] = ");
                    for(int i = 0 ; i < value.length ; i++) {
                        paramText.append("[" + value[i] + "]");
                        if((i + 1) == value.length) {
                            paramText.append(",");
                        }
                    }
                    paramText.append("}\n");
                }
                parameterLength++;
            }

            if(parameterLength > 0) {
                logText.append("\nPARAM      : " + parameterLength + " 건\n");
                logText.append(paramText.substring(0, paramText.length() - 1));
            } else {
                logText.append("\nPARAM      : N/A");
            }

            if(handler == null) {
                logText.append("\nCONTROLLER : [WARN : No handler found]");
            } else {
                logText.append("\nCONTROLLER : " + handler.getClass().getSimpleName());
            }

            if(mv != null) {

                View view = mv.getView();

                if(view != null) {
                    if(Proxy.isProxyClass(view.getClass())) {
                        logText.append("\nVIEW       : " + view.toString());
                    } else {
                        logText.append("\nVIEW       : " + view.getClass().getSimpleName());
                        if(view instanceof AbstractUrlBasedView) {
                            logText.append(" -> " + ((AbstractUrlBasedView) view).getUrl());
                        } else if(view instanceof JstlView) {
                            logText.append(" -> " + ((JstlView) view).getUrl());
                        } else {
                            logText.append(" -> : " + ((AbstractView) view).getContentType());
                        }
                    }
                }
            }

            if(exception != null) {
                if(exception instanceof HttpRequestMethodNotSupportedException) {
                    logText.append("\nEXCEPTION  : " + exception.getMessage());
                } else {
                    logText.append("\nEXCEPTION  :\n" + ExceptionUtil.getFullStackTrace(exception));
                }
            }

        }
        return logText.toString();
    }

    private String prettyText(String val) {

        if(Validate.isEmpty(val)) {
            return val;
        }

        if(val.length() > 50) {
            val = val.substring(0, 50) + "....";
        }

        return val;
    }
}
