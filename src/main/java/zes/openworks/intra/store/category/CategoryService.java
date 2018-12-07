package zes.openworks.intra.store.category;

import java.util.List;
import java.util.Map;

import zes.base.vo.TreeVO;

public interface CategoryService {
    String index(CategoryVO vo);
    
    List<CategoryVO> langList(CategoryVO vo);

    List<TreeVO> categoryList(CategoryVO vo);

    List<TreeVO> myMenuListAll(CategoryVO vo);

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     * List<MenuVO> myMenus(MenuVO vo);
     */

    CategoryVO categoryView(CategoryVO vo);

    Object insertAction(CategoryVO vo);

    int updateAction(CategoryVO vo);

    int deleteAction(CategoryVO vo);

    /**
     * goodsChk 설명
     * @param vo
     */
    List<Map<String, String>> goodsChk(CategoryVO vo);   
    
}
