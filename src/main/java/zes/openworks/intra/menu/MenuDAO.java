package zes.openworks.intra.menu;

import java.util.List;

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
public class MenuDAO extends EgovAbstractMapper {

    public List<TreeVO> menuList(MenuVO vo) {
        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(GlobalConfig.HIGH_MENU_CD);
        }

        return list("_menu.treeList", vo);
    }

    public List<TreeVO> myMenuListAll(MenuVO vo) {

        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(GlobalConfig.HIGH_MENU_CD);
        }

        return list("_menu.myListAll", vo);
    }

    public MenuVO menuView(MenuVO vo) {

        MenuVO dataVo = (MenuVO) selectByPk("_menu.view", vo);

        if(dataVo != null) {
            List<String> menuAsnList = list("_menu.assignMenuAuthNm", String.valueOf(vo.getMenuCd()));

            String[] authNms = menuAsnList.toArray(new String[menuAsnList.size()]);

            dataVo.setAuthNms(authNms);
        }

        return dataVo;
    }

    public Object insertAction(MenuVO vo) {

        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(GlobalConfig.HIGH_MENU_CD);
        }

        if(!Validate.isEmpty(vo.getMenuUrl())) {
            vo.setMenuFolder(PathUtil.lastFolderName(vo.getMenuUrl(), "/"));
        }

        insert("_menu.insert", vo);
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

    public int updateAction(MenuVO vo) {

        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(GlobalConfig.HIGH_MENU_CD);
        }

        // 기본 정보 수정
        if(vo.getMenuOrdrNo() == StringUtil.ZERO) {

            vo.setModiDt(DateFormatUtil.getTodayFull());

            if(!Validate.isEmpty(vo.getMenuUrl())) {
                vo.setMenuFolder(PathUtil.lastFolderName(vo.getMenuUrl(), "/"));
            }

            return update("_menu.infoUpdate", vo);
        }
        // 정렬 정보 수정
        else {
            List<MenuVO> sameLevelList = list("_menu.sameLevelList", vo);
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
                MenuVO sameLevelVo = sameLevelList.get(i);

                sameLevelVo.setMenuOrdrNo(i + 1);
                affected += update("_menu.orderUpdate", sameLevelVo);
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
    public int deleteAction(MenuVO vo) {

        //메뉴에 할당된 권한이 있을 경우 삭제 할 수 없음
        int assMenuCnt = ((Integer)selectByPk("_menu.assignMenuCnt", vo)).intValue();

        if(assMenuCnt > 0){
            return 0;
        }else{
            return delete("_menu.delete", vo);
        }
    }

}
