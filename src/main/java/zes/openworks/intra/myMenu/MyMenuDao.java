package zes.openworks.intra.myMenu;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.menu.MenuVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내 메뉴관리 (내부) DAO
 * 
 * @author wisepms
 * @version $Id: MyMenuDao.java 382 2010-02-16 11:10:05Z wisepms $
 */
@Repository
public class MyMenuDao extends EgovAbstractMapper {

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     * Explorer 내 메뉴 목록에서 사용함
     */
    @SuppressWarnings("unchecked")
    public List<MenuVO> myAssignMenuListAll(MenuVO menuBean) {

        if(menuBean.getUpperMenuCd() == StringUtil.ZERO) {
            menuBean.setUpperMenuCd(GlobalConfig.HIGH_MENU_CD);
        }

        return list("_mymenu.myAssignMenuList", menuBean);
    }

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     */
    @SuppressWarnings("unchecked")
    public List<MenuVO> myMenuListAll(MenuVO menuBean) {

        if(menuBean.getUpperMenuCd() == StringUtil.ZERO) {
            menuBean.setUpperMenuCd(GlobalConfig.HIGH_MENU_CD);
        }

        return list("_mymenu.myMenuListAll", menuBean);
    }

    /**
     * 내 메뉴정보 목록 조회 (로그인 담당자가 설정한 메뉴 조회)
     */
    @SuppressWarnings("unchecked")
    public List<MenuVO> myAssignMenuList(MenuVO menuBean) {

        return list("_mymenu.myMenuList", menuBean);
    }

    /**
     * 내 메뉴 수정 액션
     */
    public int updateAction(final String mgrId, final String[] menuCds) {

        if(Validate.isEmpty(menuCds)) {
            return StringUtil.ZERO;
        }

        delete("_mymenu.myMenuDeleteAll", mgrId);

        int affected = 0;

        MenuVO menuBean = new MenuVO();
        menuBean.setMngrId(mgrId);

        for(String menuCd : menuCds) {
            menuBean.setMenuCd(Integer.valueOf(menuCd));
            menuBean.setMenuOrdrNo(affected + 1);
            delete("_mymenu.myMenuInsert", menuBean);
            affected++;
        }

        return affected;

    }
}
