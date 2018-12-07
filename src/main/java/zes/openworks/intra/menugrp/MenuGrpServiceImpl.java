package zes.openworks.intra.menugrp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("menuGrpService")
public class MenuGrpServiceImpl extends AbstractServiceImpl implements MenuGrpService {

    @Resource
    private MenuGrpDAO dao;

    @Override
    public List<MenuGrpVO> menuGrpList() {
        return dao.menuGrpList();
    }

    @Override
    public MenuGrpVO menuGrpView(MenuGrpVO vo) {
        return dao.menuGrpView(vo);
    }

    @Override
    public Object menuGrpInsertAction(MenuGrpVO vo) {
        return dao.menuGrpInsertAction(vo);
    }

    @Override
    public int menuGrpUpdateAction(MenuGrpVO vo) {
        return dao.menuGrpUpdateAction(vo);
    }

    @Override
    public int menuGrpDeleteAction(MenuGrpVO vo) {
        return dao.menuGrpDeleteAction(vo);
    }

    @Override
    public List<MenuItemVO> menuItemList(MenuGrpVO vo) {
        return dao.menuItemList(vo);
    }

    @Override
    public List<MenuItemVO> menuItemListWithMenuCd(MenuItemVO menuItemVo) {
        return dao.menuItemListWithMenuCd(menuItemVo);
    }

    @Override
    public int menuItemUpdateAction(MenuItemVO menuItemVo) {
        return dao.menuItemUpdateAction(menuItemVo);
    }

    @Override
    public List<MenuItemVO> menuGroupView(MenuGrpVO vo) {
        return dao.menuGroupView(vo);
    }

}
