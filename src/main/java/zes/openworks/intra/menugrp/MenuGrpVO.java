package zes.openworks.intra.menugrp;

import zes.base.vo.BaseVO;

/**
 * 메뉴그룹 VO
 * 
 * @author wisepms
 * @version $Id: MenuGrpVO.java 25 2011-07-13 05:32:06Z oworks $
 */
public class MenuGrpVO extends BaseVO {

    private static final long serialVersionUID = 6005492446460589740L;

    /** 메뉴그룹 코드 */
    private Integer menuGroupCd = 0;
    /** 메뉴그룹 이름 */
    private String menuGroupNm;
    /** 메뉴그룹 설명 */
    private String menuGroupDc;

    public String getMenuGrpDesc() {
        return menuGroupDc;
    }

    public void setMenuGrpDesc(String menuGroupDc) {
        this.menuGroupDc = menuGroupDc;
    }

    public Integer getMenuGroupCd() {
        return menuGroupCd;
    }

    public void setMenuGroupCd(Integer menuGroupCd) {
        this.menuGroupCd = menuGroupCd;
    }

    public String getMenuGroupNm() {
        return menuGroupNm;
    }

    public void setMenuGroupNm(String menuGroupNm) {
        this.menuGroupNm = menuGroupNm;
    }

}
