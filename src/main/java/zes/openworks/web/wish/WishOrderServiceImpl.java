package zes.openworks.web.wish;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2014. 11. 6.    이슬버미       신규
 * </pre>
 * @see
 */
@Service
public class WishOrderServiceImpl extends AbstractServiceImpl implements  WishOrderService {

    @Resource
    private WishOrderDAO dao;

    /* (non-Javadoc)
     * @see zes.openworks.web.whish.WhishOrderService#orderInsert(zes.openworks.web.whish.WhishOrderVO)
     */
    @Override
    public int orderInsert(WishOrderVO vo) {
        // TODO Auto-generated method stub
        return dao.orderInsert(vo);
    }
    
    @Override
    public int wishInforInsert(WishOrderVO vo) {
        // TODO Auto-generated method stub
        return dao.wishInforInsert(vo);
    }
    
}
