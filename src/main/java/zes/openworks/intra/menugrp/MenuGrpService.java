package zes.openworks.intra.menugrp;

import java.util.List;

public interface MenuGrpService {

    /**
     * 메뉴그룹 목록 조회
     */
    List<MenuGrpVO> menuGrpList();

    /**
     * 메뉴그룹 상세 조회
     */
    MenuGrpVO menuGrpView(MenuGrpVO vo);

    /**
     * 메뉴그룹 등록 액션
     */
    Object menuGrpInsertAction(MenuGrpVO vo);

    /**
     * 메뉴그룹 수정 액션
     */
    int menuGrpUpdateAction(MenuGrpVO vo);

    /**
     * 메뉴그룹 삭제 액션
     */
    int menuGrpDeleteAction(MenuGrpVO vo);

    /**
     * 메뉴그룹 아이템 목록 조회
     */
    List<MenuItemVO> menuItemList(MenuGrpVO vo);

    /**
     * 선택 메뉴에 대한 메뉴 그룹 아이템 전체 목록 조회
     */
    List<MenuItemVO> menuItemListWithMenuCd(MenuItemVO menuItemVo);

    /**
     * 메뉴그룹 아이템 수정 액션
     */
    int menuItemUpdateAction(MenuItemVO menuItemVo);

    /**
     * 메뉴그룹 조회(조회용)
     * 
     * @param vo
     * @return
     */
    List<MenuItemVO> menuGroupView(MenuGrpVO vo);
}
