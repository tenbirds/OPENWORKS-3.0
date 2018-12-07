/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms;

import java.util.List;

import zes.base.vo.TreeVO;
import zes.openworks.intra.user.grade.UserGradeVO;

/**
 * 사용자메뉴관리 인터페이스
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OP 1.0
 */
public interface CmsService {

    /**
     * 메뉴별 회원권한 설정용 회원유형 목록 데이터
     * 
     * @param userGradeVo1
     * @return
     * @throws Exception
     */
    List<UserGradeVO> getUserGradeList(CmsVO cmsVo) throws Exception;

    /**
     * 메뉴정보 목록 조회 (계층별 JSON Tree 조회)
     * xanadu : 2011. 3. 3.
     * 
     * @param CmsVO cmsVo
     * @return
     */
    List<TreeVO> getMenuList(CmsVO cmsVo) throws Exception;

    /**
     * 컨텐츠 담당자의 메뉴정보 목록 조회 (계층별 JSON Tree 조회)
     * 
     * @param CmsVO cmsVo
     * @return
     * @throws Exception
     */
    List<TreeVO> getChargeMenuList(CmsVO cmsVo) throws Exception;

    /**
     * 사용자메뉴 상세
     * xanadu : 2011. 3. 3.
     * 
     * @param CmsVO cmsVo
     * @return
     */
    CmsVO getMenu(CmsVO cmsVo) throws Exception;

    /**
     * 사이트 생성시 기본 루트 값 생성
     * 
     * @param cmsVo
     * @return
     * @throws Exception
     */
    Object createMenu(CmsVO cmsVo) throws Exception;

    /**
     * 사이트 삭제로 인한 메뉴 삭제 요청이 들어오는 경우 VO 객체 커플링을 제거하기 위한 Adapter
     * 
     * @param domainCd
     * @param topMenuCode
     * @param parentMenuCode
     * @return
     * @throws Exception
     */
    int deleteMenuAdapter(Integer domainCd, String paramParentMenuCode) throws Exception;

    /**
     * 사용자메뉴 등록
     * xanadu : 2011. 3. 3.
     * 
     * @param CmsVO cmsVo
     * @return
     */
    Object insertMenu(CmsVO cmsVo) throws Exception;

    /**
     * 사용자메뉴 수정
     * xanadu : 2011. 3. 3.
     * 
     * @param CmsVO cmsVo
     * @return
     */
    int updateMenu(CmsVO cmsVo) throws Exception;

    /**
     * 컨텐츠 담당자 메뉴정보 수정 수정
     * xanadu : 2011. 11. 21.
     * 
     * @param CmsVO cmsVo
     * @return
     */
    int chargerUpdateMenu(CmsVO cmsVo) throws Exception;

    /**
     * 사용자메뉴 이동
     * xanadu : 2011. 3. 13.
     * 
     * @param CmsVO cmsVo
     * @return
     */
    int updateMoveMenu(CmsVO cmsVo) throws Exception;

    /**
     * 사용자메뉴 삭제
     * xanadu : 2011. 3. 3.
     * 
     * @param CmsVO cmsVo
     * @return
     */
    int deleteMenu(CmsVO cmsVo) throws Exception;

    /**
     * 메뉴 변경에 따른 메뉴 케시 정보 동기화
     * 
     * @param cmsVo
     * @return
     * @throws Exception
     */
    String synchronize(CmsVO cmsVo) throws Exception;
}
