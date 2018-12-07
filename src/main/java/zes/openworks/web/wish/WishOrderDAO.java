
package zes.openworks.web.wish;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
*
* @Class Name : WikiDAO
* @version 1.0
* @since OpenMarketPlace 프로젝트. (After JDK 1.6)
* @author 오픈마켓플레이스
* @Description : 씨앗마켓 위키 공통 DAO
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일                 수정자                수정내용
*--------------    ----------    -------------------------------
* 2016. 01. 04.    (주)엔키소프트      신규
* @see
*/
@Repository
public class WishOrderDAO extends EgovAbstractMapper {


    /**
     * purchInsert �꽕紐�
     * @param vo
     * @return
     */
    public int orderInsert(WishOrderVO vo) {
        
        int ret = 0;        
       // ret = insert("_wishorder.inforInsert", vo);
        
        Map map = new HashMap();
        map.put("userId", vo.getUserId());
        map.put("grpSeq", vo.getGrpSeq());
       
        String sels = Arrays.toString(vo.getGoodsCodesSel());
        
        for(String data : vo.getGoodsCodes()) {
/*          {{ 삭제
            if(sels.indexOf(data) > 0 ) map.put("selChk", 'Y');
            else map.put("selChk", 'N');            
            }}
            System.out.println("*******************orderInsert**************************");
            {{ 체크한 항목만 희망목록에 담고 서비스코드가 등록되어 있지 않을때만 insert
*/          
            if(sels.indexOf(data) > 0 ) {
                map.put("selChk", 'Y');
                map.put("goodsCode", data);
                
             if( (Integer) selectByPk("_wishorder.wishOrderCount",map) == 0)  
                   insert("_wishorder.goodsListInsert",map);
            }
        }
        
        return ret;
    }
    
    
    /**
     * purchInsert 기본정보 
     * @param vo
     * @return
     */
    public int wishInforInsert(WishOrderVO vo) {
        
        int ret = 0;        
        ret = insert("_wishorder.inforInsert", vo);        
        
        return ret;
    }


    
    
}
