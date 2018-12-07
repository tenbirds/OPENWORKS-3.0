package zes.core.spi.oscache;

import java.util.HashMap;
import java.util.Map;

/**
 * Cache factory
 * 
 * @author wisepms
 * @version23 2011-07-13 05:20:04Z 
 */
public class CacheFactory {

    private static Map<Class<?>, ICache> factories = new HashMap<Class<?>, ICache>();

    /**
     * 등록된 모든 캐쉬 구현체가 담긴 Map을 얻는다.
     */
    public static Map<Class<?>, ICache> getMap() {
        return factories;
    }

    /**
     * 캐쉬 구현체를 등록한다.
     */
    public static void register(Class<?> key, ICache cache) {

        factories.put(key, cache);
    }

    /**
     * 캐쉬 구현체를 얻는다.
     */
    public static ICache extract(Class<?> key) {

        return factories.get(key);
    }
}
