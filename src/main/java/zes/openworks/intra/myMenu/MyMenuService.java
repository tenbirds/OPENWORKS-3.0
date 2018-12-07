/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.myMenu;

import java.util.List;

import zes.openworks.intra.menu.MenuVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 7. 25.    방기배       신규
 *</pre>
 * @see
 */
public interface MyMenuService {

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     * Explorer 내 메뉴 목록에서 사용함
     */
    public List<MenuVO> myAssignMenuListAll(MenuVO menuBean);

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     */
    public List<MenuVO> myMenuListAll(MenuVO menuBean);

    /**
     * 내 메뉴정보 목록 조회 (로그인 담당자가 설정한 메뉴 조회)
     */
    public List<MenuVO> myAssignMenuList(MenuVO menuBean);

    /**
     * 내 메뉴 수정 액션
     */
    public int updateAction(String mgrId, String[] menuCds);

}
