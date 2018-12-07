package zes.core.spi.oscache;

import java.util.List;

import org.apache.commons.lang.time.StopWatch;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;

import org.apache.ibatis.session.SqlSession;
import com.opensymphony.module.sitemesh.util.ClassLoaderUtil;

/**
 * Cache implement class initializer bean
 * 
 * @author wisepms
 * @version 23 2011-07-13 05:20:04Z 
 */
public final class CacheClassInitializer implements InitializingBean {

    private final Log logger = LogFactory.getLog(this.getClass());

    private SqlSession sqlSession;

    public final void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    private List<String> cacheClassList;

    public void setCacheClassList(List<String> cacheClassList) {
        this.cacheClassList = cacheClassList;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        /* Called by after setting all properties */
    }

    public void initialize() {

        /* Called by after afterPropertiesSet() */

        logger.info("Wating for create cache ....");

        StopWatch stopWatch = new StopWatch();
        stopWatch.start();

        int listLength = cacheClassList.size();
        for(int i = 0 ; i < listLength ; i++) {
            String cacheClass = cacheClassList.get(i);
            ICache cache = createInstance(cacheClass);
            if(cache != null) {
                cache.createCache(sqlSession);
            }

            CacheFactory.register(cache.getClass(), cache);
        }

        stopWatch.stop();

        logger.info("Successfully create cache in " + cacheClassList.toString() + ". Elpased time "
            + stopWatch.getTime() + " msec");
    }

    public void destroy() {
        /* Called by destory bean from spring container */
    }

    private ICache createInstance(String cacheClass) {

        try {
            Class<?> clazz = ClassLoaderUtil.loadClass(cacheClass, this.getClass());
            Object object = clazz.newInstance();
            if(object instanceof ICache) {
                return (ICache) object;
            } else {
                logger.error(cacheClass + " is not implements ICache");
            }
        } catch (Exception e) {
            logger.error(e.toString());
        }
        return null;
    }

    @Override
    public String toString() {

        StringBuilder buff = new StringBuilder();
        buff.append("\n---- Cache List ----\n");
        int listLength = cacheClassList.size();
        for(int i = 0 ; i < listLength ; i++) {
            buff.append("[" + i + "] " + cacheClassList.get(i) + "\n");
        }
        if(listLength == 0) {
            buff.append("No exists cache class.");
        }

        return buff.toString();
    }
}
