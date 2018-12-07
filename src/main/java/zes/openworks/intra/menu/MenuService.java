package zes.openworks.intra.menu;

import java.util.List;

import zes.base.vo.TreeVO;

public interface MenuService {

    List<TreeVO> menuList(MenuVO vo);

    List<TreeVO> myMenuListAll(MenuVO vo);

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     * List<MenuVO> myMenus(MenuVO vo);
     */

    MenuVO menuView(MenuVO vo);

    Object insertAction(MenuVO vo);

    int updateAction(MenuVO vo);

    int deleteAction(MenuVO vo);
}
