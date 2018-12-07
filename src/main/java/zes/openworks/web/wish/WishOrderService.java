package zes.openworks.web.wish;

/**
*
* @Class Name : WisOrderService
* @version 1.0
* @since OpenMarketPlace 프로젝트. (After JDK 1.6)
* @author 오픈마켓플레이스
* @Description : 씨앗마켓 위키 공통 Service
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일                 수정자                수정내용
*--------------    ----------    -------------------------------
* 2016. 01. 04.    (주)엔키소프트      신규
* @see
*/
public interface WishOrderService {


    /**
     * orderInsert 구매희망등록 담기
     * @param vo
     * @return
     */
    int orderInsert(WishOrderVO vo);
    
    
    int wishInforInsert(WishOrderVO vo);

}
