package zes.core.spi.commons.configuration;

import java.io.File;
import java.io.FileNotFoundException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.DefaultConfigurationBuilder;
import org.springframework.util.ResourceUtils;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.util.WebUtils;

/**
 * 서블릿 표준 ServletContextListener를 구현하여 속성 값을 로드 한다.
 * 현재 미사용 : 필요에 따라서 사용시 web.xml 파일에 아래 내용을 추가해야 한다.
 * 
 * <pre>
 *  &lt;context-param&gt;
 *      &lt;param-name&gt;commonsConfigLocation&lt;/param-name&gt;
 *      &lt;param-value&gt;classpath:/config/commons/config.xml&lt;/param-value&gt;
 * &lt;/context-param&gt;
 * 
 * <pre>
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 * 2012. 2. 26.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * 
 * @see Config
 */
public class CommonsConfigurationListener implements ServletContextListener {

    public static final String CONFIG_LOCATION_PARAM = "commonsConfigLocation";

    @Override
    public void contextInitialized(ServletContextEvent event) {

        ServletContext servletContext = event.getServletContext();

        String location = servletContext.getInitParameter(CONFIG_LOCATION_PARAM);
        File file = null;

        if(location != null) {

            try {
                // Return a URL (e.g. "classpath:" or "file:") as-is;
                // consider a plain file path as relative to the web application
                // root directory.
                if(!ResourceUtils.isUrl(location)) {
                    // Resolve system property placeholders before resolving
                    // real path.
                    location = SystemPropertyUtils.resolvePlaceholders(location);
                    location = WebUtils.getRealPath(servletContext, location);
                    file = new File(location);
                } else {
                    location = SystemPropertyUtils.resolvePlaceholders(location);
                    file = ResourceUtils.getFile(location);
                }

                servletContext.log("Initializing commons-config from [" + location + "]");

                DefaultConfigurationBuilder builder = new DefaultConfigurationBuilder(file.getAbsolutePath());

                Config.setConfiguration(builder.getConfiguration(true));
            } catch (FileNotFoundException ex) {
                throw new IllegalArgumentException("Invalid 'commonsConfigLocation' parameter: " + ex.getMessage());
            } catch (ConfigurationException ex) {
                throw new IllegalArgumentException("Invalid commons configuration parameter: " + ex.getMessage());
            }

            /*--
            if (location.charAt(0) != '/') {
                location = "/" + location;
            }
            location = servletContext.getRealPath(location);

            servletContext.log("Initializing commons configuration from [" + location + "]");

            try {
                DefaultConfigurationBuilder builder = new DefaultConfigurationBuilder(location);
                
                Config.setConfiguration( builder.getConfiguration(true) );
            }
            catch (ConfigurationException ex) {
                throw new IllegalArgumentException(
                        "Invalid commons configuration parameter: "
                                + ex.getMessage());
            }
            --*/

            servletContext.log("Successfully loaded commons-config");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        /* Do nothing */
    }
}
