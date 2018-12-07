package zes.openworks.intra.store.category;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.PathUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
@SuppressWarnings("unchecked")
public class CategoryDAO extends EgovAbstractMapper {

    private final String HIGH_TREE_CD = String.valueOf(GlobalConfig.HIGH_TREE_CD);

    public List<TreeVO> categoryList(CategoryVO vo) {
        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(HIGH_TREE_CD);
        }

        return list("_category.treeList", vo);
    }

    public List<TreeVO> myMenuListAll(CategoryVO vo) {

        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(HIGH_TREE_CD);
        }

        return list("_category.myListAll", vo);
    }

    public CategoryVO categoryView(CategoryVO vo) {


/*
        if(dataVo != null) {
            List<String> menuAsnList = list("_category.assignMenuAuthNm", String.valueOf(vo.getMenuCd()));

            String[] authNms = menuAsnList.toArray(new String[menuAsnList.size()]);

            dataVo.setAuthNms(authNms);
        }
*/
        return (CategoryVO) selectByPk("_category.view", vo);
    }

    public Object insertAction(CategoryVO vo) {

        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(HIGH_TREE_CD);
        }

        insert("_category.insert", vo);
        Object primaryKey = vo.getMenuCd();
        /*
         * if(primaryKey != null) {
         * MenuItemVO menuItemVo = new MenuItemVO();
         * menuItemVo.setMenuGrpCd(GlobalConfig.HIGH_MENU_CD);
         * menuItemVo.setMenuCd(vo.getMenuCd());
         * menuItemVo.setMenuItemDesc("CRUD");
         * update("_menuGrp.menuItemInsert", menuItemVo);
         * }
         */
        return primaryKey;
    }

    public int updateAction(CategoryVO vo) {

        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(HIGH_TREE_CD);
        }

        // 기본 정보 수정
        if(vo.getMenuOrdrNo() == StringUtil.ZERO) {

            vo.setModiDt(DateFormatUtil.getTodayFull());

            if(!Validate.isEmpty(vo.getMenuUrl())) {
                vo.setMenuFolder(PathUtil.lastFolderName(vo.getMenuUrl(), "/"));
            }

            return update("_category.infoUpdate", vo);
        }
        // 정렬 정보 수정
        else {
            List<CategoryVO> sameLevelList = list("_category.sameLevelList", vo);
            int sameLevelLength = sameLevelList.size();

            int newOrderNo = vo.getMenuOrdrNo();

            if(newOrderNo <= StringUtil.ZERO) {
                newOrderNo = 1;
            }
            if(newOrderNo > sameLevelLength) {
                newOrderNo = sameLevelLength + 1;
            }

            sameLevelList.add(newOrderNo - 1, vo);
            sameLevelLength++;

            int affected = StringUtil.ZERO;

            for(int i = 0 ; i < sameLevelLength ; i++) {
                CategoryVO sameLevelVo = sameLevelList.get(i);

                sameLevelVo.setMenuOrdrNo(i + 1);
                affected += update("_category.orderUpdate", sameLevelVo);
            }

            if(affected == sameLevelLength) {
                return StringUtil.ONE;
            } else {
                return StringUtil.ZERO;
            }
        }
    }

    /**
     * 메뉴 삭제 액션
     */
    public int deleteAction(CategoryVO vo) {
        String leafChk = (String) selectByPk("_category.leafChk", vo);
        Integer goodsChkCount = (Integer) selectByPk("_category.goodsChkCount", vo);

        if (goodsChkCount == 0) {
            if (leafChk.equals("1")) {
                return update("_category.delete", vo);
            } else {
                // 하위 카테고리 존재
                return -1;
            }
        } else {
            // 남은 카테고리가 하나 남아있는 서비스가 있을때.
            return goodsChkCount + 1;
        }
    }


    /**
     * index 설명
     * @param vo
     * @return
     */
    public String index(CategoryVO vo) {
        return (String) selectByPk("_category.clNm", vo);
    }

    public List<CategoryVO> langList(CategoryVO vo) {
        return list("_category.langList", vo);
    }

    /**
     * goodsChk 설명
     * @param vo
     * @return
     */
    public List<Map<String, String>> goodsChk(CategoryVO vo) {

        return list("_category.goodsChk", vo);
    }

}
