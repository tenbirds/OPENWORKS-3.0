package zes.openworks.intra.store.category;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.vo.TreeVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("categoryService")
public class CategoryServiceImpl extends AbstractServiceImpl implements CategoryService {

    @Resource
    private CategoryDAO dao;
    
    @Override
    public String index(CategoryVO vo) {
        return dao.index(vo);
    }
    
    @Override
    public List<CategoryVO> langList(CategoryVO vo) {
        return dao.langList(vo);
    }
    
    @Override
    public List<TreeVO> categoryList(CategoryVO vo) {
        return dao.categoryList(vo);
    }

    @Override
    public List<TreeVO> myMenuListAll(CategoryVO vo) {
        return dao.myMenuListAll(vo);
    }

    /*
     * public List<MenuVO> myMenus(MenuVO vo) {
     * return dao.myMenus(vo);
     * }
     */

    @Override
    public CategoryVO categoryView(CategoryVO vo) {
        return dao.categoryView(vo);
    }

    @Override
    public Object insertAction(CategoryVO vo) {
        return dao.insertAction(vo);
    }

    @Override
    public int updateAction(CategoryVO vo) {
        return dao.updateAction(vo);
    }

    @Override
    public int deleteAction(CategoryVO vo) {
        return dao.deleteAction(vo);
    }
    
    @Override
    public List<Map<String, String>> goodsChk(CategoryVO vo) {
        return dao.goodsChk(vo);
    }
}
