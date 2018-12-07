package zes.core.spi.oscache;

import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.event.EventListenerList;

import com.opensymphony.oscache.base.AbstractCacheAdministrator;
import com.opensymphony.oscache.base.NeedsRefreshException;
import com.opensymphony.oscache.general.GeneralCacheAdministrator;

/**
 * Opensymphony oscache wrapper 클래스
 * 
 * @author wisepms
 * @version 23 2011-07-13 05:20:04Z 
 */
public class Cache {

    // private static final Log logger = LogFactory.getLog(Cache.class);

    private GeneralCacheAdministrator osCache;

    public Cache() {

        Properties property = new Properties();

        property.setProperty(AbstractCacheAdministrator.CACHE_MEMORY_KEY, "true");

        /*--
        property.setProperty(AbstractCacheAdministrator.CACHE_ENTRY_EVENT_LISTENERS_KEY, 
                "com.wisepms.core.spi.oscache.listener.CacheEntryEventListenerImpl");
        property.setProperty(AbstractCacheAdministrator.CACHE_ALGORITHM_KEY,  
                "com.opensymphony.oscache.base.algorithm.LRUCache");
        property.setProperty(AbstractCacheAdministrator.CACHE_CAPACITY_KEY, "5");
        property.setProperty(AbstractCacheAdministrator.CACHE_BLOCKING_KEY, "true");
        property.setProperty(AbstractCacheAdministrator.CACHE_PERSISTENCE_OVERFLOW_KEY, "true");
        property.setProperty(AbstractCacheAdministrator.PERSISTENCE_CLASS_KEY,
                "com.wisepms.core.spi.oscache.SalmonPersistenceListener");
        --*/

        osCache = new GeneralCacheAdministrator(property);
    }

    private static class SingletonHolder {

        private static Cache instance = new Cache();
    }

    private static Cache getInstance() {
        return SingletonHolder.instance;
    }

    public static Object get(String key) {
        return realGet(key);
    }

    public static Object get(String key, HttpServletRequest request) {
        return get(key, request.getSession());
    }

    public static Object get(String key, HttpSession session) {
        return realGet(key);
    }

    private static Object realGet(String key) {

        try {
            return getInstance().osCache.getFromCache(key);
        } catch (NeedsRefreshException nre) {

            /*--
            try {
                // 새로운 캐시값을 등록
                String newValue = "새로운 캐시값 FROM DB";
                getInstance().osCache.putInCache(key, StringUtil.EMPTY);
            }
            catch (Exception ex) {
                // 에러 발생 시 현재 캐쉬값을 가져옴
                Object myValue = nre.getCacheContent();
                logger.info("** ERROR ** myValue : " + myValue + "____" + ex);
                // It is essential that cancelUpdate is called if the
                // cached content is not rebuilt
                getInstance().osCache.cancelUpdate(key);
            }
            --*/

            getInstance().osCache.cancelUpdate(key);
        }
        return null;
    }

    public static void put(String key, Object value) {

        getInstance().osCache.putInCache(key, value);
    }

    public static void remove(String key) {

        Object value = null;

        try {
            value = getInstance().osCache.getFromCache(key);
        } catch (NeedsRefreshException e) {
            getInstance().osCache.cancelUpdate(key);
        }

        if(value != null) {
            /*--
            getInstance().osCache.flushEntry(key);
            --*/
            getInstance().osCache.removeEntry(key);
        }
    }

    public static EventListenerList getCacheEventListenerList() {

        return getInstance().osCache.getCache().getCacheEventListenerList();

        /*--
         * @TODO : 추후 캐쉬 통계조회용 JSP 에서 구현할 것
         * 
        Object[] listeners = listenerList.getListenerList();
        for (int i = 0 ; i < listeners.length ; i++) {
            
            CacheEventListener listener = (CacheEventListener)listeners[i];
            String toPrintout = listener.toString();
        }
        --*/
    }

    public static GeneralCacheAdministrator getCache() {

        return getInstance().osCache;
    }
}
