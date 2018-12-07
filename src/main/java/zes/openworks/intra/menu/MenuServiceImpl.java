package zes.openworks.intra.menu;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.vo.TreeVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("menuService")
public class MenuServiceImpl extends AbstractServiceImpl implements MenuService {

    @Resource
    private MenuDAO dao;

    @Override
    public List<TreeVO> menuList(MenuVO vo) {
        return dao.menuList(vo);
    }

    @Override
    public List<TreeVO> myMenuListAll(MenuVO vo) {
        return dao.myMenuListAll(vo);
    }

    /*
     * public List<MenuVO> myMenus(MenuVO vo) {
     * return dao.myMenus(vo);
     * }
     */

    @Override
    public MenuVO menuView(MenuVO vo) {
        return dao.menuView(vo);
    }

    @Override
    public Object insertAction(MenuVO vo) {
        return dao.insertAction(vo);
    }

    @Override
    public int updateAction(MenuVO vo) {
        return dao.updateAction(vo);
    }

    @Override
    public int deleteAction(MenuVO vo) {
        return dao.deleteAction(vo);
    }

}
