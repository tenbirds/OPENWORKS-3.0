package zes.openworks.intra.menugrp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class MenuGrpDAO extends EgovAbstractMapper {

    /**
     * 메뉴그룹 목록 조회
     */
    public List<MenuGrpVO> menuGrpList() {

        return list("_menuGrp.list", null);
    }

    /**
     * 메뉴그룹 상세 조회
     */
    public MenuGrpVO menuGrpView(MenuGrpVO vo) {

        return (MenuGrpVO) selectByPk("_menuGrp.view", vo);
    }

    /**
     * 메뉴그룹 등록 액션
     */
    public Object menuGrpInsertAction(MenuGrpVO vo) {

        Object primaryKey = insert("_menuGrp.insert", vo);

        if(primaryKey != null) {
            // CacheFactory.get(MenuGrpCache.class).reloadCache(getSqlSession());
        }

        return primaryKey;
    }

    /**
     * 메뉴그룹 수정 액션
     */
    public int menuGrpUpdateAction(MenuGrpVO vo) {

        int affected = update("_menuGrp.update", vo);

        if(affected == StringUtil.ONE) {
            // CacheFactory.get(MenuGrpCache.class).reloadCache(getSqlSession());
        }

        return affected;
    }

    /**
     * 메뉴그룹 삭제 액션
     */
    public int menuGrpDeleteAction(MenuGrpVO vo) {

        int affected = delete("_menuGrp.delete", vo);

        if(affected == StringUtil.ONE) {
            // CacheFactory.get(MenuGrpCache.class).reloadCache(getSqlSession());
        }

        return affected;
    }

    /**
     * 메뉴그룹 아이템 목록 조회
     */
    public List<MenuItemVO> menuItemList(MenuGrpVO vo) {

        @SuppressWarnings("rawtypes")
        Map parameterMap = new HashMap();
        parameterMap.put("menuGrpCd", String.valueOf(vo.getMenuGroupCd()));
        parameterMap.put("highMenuCd", String.valueOf(GlobalConfig.HIGH_MENU_CD));

        return list("_menu.menuItemList", parameterMap);
    }

    /**
     * 선택 메뉴에 대한 메뉴 그룹 전체 목록 조회
     */
    public List<MenuItemVO> menuItemListWithMenuCd(MenuItemVO menuItemVo) {

        return list("_menuGrp.menuItemListWithMenuCd", menuItemVo);
    }

    /**
     * 메뉴그룹 아이템 수정 액션
     */
    public int menuItemUpdateAction(MenuItemVO menuItemVo) {

        String data = (String) selectByPk("_menuGrp.menuItemView",
            menuItemVo);

        if("Y".equals(menuItemVo.getChecked())) {
            if(data == null) {
                return update("_menuGrp.menuItemInsert", menuItemVo);
            } else {
                return update("_menuGrp.menuItemUpdate", menuItemVo);
            }
        } else {
            if(data != null) {
                return delete("_menuGrp.menuItemDelete", menuItemVo);
            } else {
                return StringUtil.ONE;
            }
        }
    }

    /**
     * 메뉴그룹 조회(조회용)
     */
    public List<MenuItemVO> menuGroupView(MenuGrpVO vo) {

        return list("_menuGrp.menuGroupView", vo);
    }
}
