/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	수정자   	수정내용
 *--------------		--------  	-------------------------------
 * 2014. 10. 14.    		SON.H.S       	신규
 *</pre>
 * @see
 */
public interface CmManageService {
    
    
    /**
     *  커뮤니티 개설신청 목록
     * @param vo
     * @return pager  
     */
    Pager<CmManageVO> openCmManageList(CmManageVO vo);
    
    
    
    /**
     *  커뮤니티 개설신청 정보
     * @param vo
     * @return  
     */
    CmManageVO openCmManageView(CmManageVO vo);
    
    
    /**
     *  커뮤니티 이름 URL 중복체크
     * @param vo
     * @return 
     */    
    int getOpenCmManageCheck(CmManageVO vo);

    /**
     *  커뮤니티 닉네임 중복체크
     * @param vo
     * @return 
     */    
    int getCmNcnmCheck(CmManageVO vo);
    
    /**
     * 커뮤니티 개설 신청 
     * @param vo
     * @return  
     */
    String openCmManageUserInsert(HttpServletRequest request, CmManageVO vo); 
    /**
     *  커뮤니티 개설신청 개별 승인 
     * @param vo
     * @return  
     */
    String openCmManageApprovalUpdate(HttpServletRequest request , CmManageVO vo); 
    
    /**
     * 커뮤니티 개설 신청 거절
     * @param vo
     * @return  
     */
    String openCmManageRejectUpdate(CmManageVO vo);
    
    
    /**
     *  커뮤니티 개설신청 다중 승인 
     * @param vo
     * @return  
     */
    String openCmManageApprovalMultiUpdate(HttpServletRequest request , CmManageVO vo); 
    
    /**
     * 커뮤니티 개설 신청 다중 거절
     * @param vo
     * @return  
     */
    String openCmManageRejectMultiUpdate(CmManageVO vo);
    
    /**
     *  사용자 기본정보
     * @param vo
     * @return  
     */
    CmManageVO userInfoOptionSelect(CmManageVO vo);
        
    /**
     *  기업사용자 추가 정보
     * @param vo
     * @return  
     */
    CmManageVO userEntrprsOptionSelect(CmManageVO vo);
    
    /**
     *  일반사용자 추가 정보
     * @param vo
     * @return  
     */
    CmManageVO userOptionSelect(CmManageVO vo);
    
    /**
     *  다중 체크 리스트
     * @param vo
     * @return  
     */
    List<CmManageVO> openCmManageMutilView(CmManageVO vo);
    
    /**
     * 커뮤니티 사용자 최초 생성 메뉴 리스트
     * @param vo
     * @return  
     */
    List<CmManageVO> cmMenuManageSelect(CmManageVO vo);
    
    
    /**
     * 커뮤니티 사용자 최초 생성 메뉴 수정
     * @param vo
     * @return  
     */
    String cmMenuManageUpdate(CmManageVO vo);
    
    /**
     * 커뮤니티 사용자 최초 생성 메뉴 등록
     * @param vo
     * @return  
     */
    String cmMenuManageInsert(CmManageVO vo);
    
    /**
     * 커뮤니티 승인 정보 수정 적용
     * @param vo
     * @return  
     */
    String applyCmManageApprovalUpdate(HttpServletRequest request , CmManageVO vo);
    
    /**
     * 커뮤니티 폐쇄 처리
     * @param vo
     * @return  
     */
    String closeCmManageUpdate(HttpServletRequest request, CmManageVO vo) throws Exception;
    
    /**  
     * 커뮤니티 회원 목록
     * @param vo
     * @return pager  
    */
   Pager<CmManageVO> cmMberInfoList(CmManageVO vo);
    
   /**
    *  커뮤니티 회원 가입 
    * @param vo
    * @return  
    */
   String cmMemberShipJoinInsert(HttpServletRequest request, CmManageVO vo);
   
   /**
    *  커뮤니티 회원 재가입 수정 
    * @param vo
    * @return  
    */
   String cmMemberShipJoinUpdate(HttpServletRequest request, CmManageVO vo);
   
   /**
    *  커뮤니티 회원 신청 취소 
    * @param vo
    * @return  
    */
   String cmMemberShipCancelDelete(HttpServletRequest request, CmManageVO vo);
       
    /**
     *  커뮤니티 회원 정보 수정 : 가입 승인, 가입 거절 , 강제 탈퇴
     * @param vo
     * @return  
     */
    String cmMemberShipInfoUpdate(HttpServletRequest request, CmManageVO vo);
    
    /**
     *  커뮤니티 회원 정보
     * @param vo
     * @return  
     */
     CmManageVO cmMemberShipInfoView(CmManageVO vo);
     
     /**
      *  커뮤니티 폐쇄 관리자 메일 보내기 목록
      * @param vo
      * @return  
      */
     List<CmManageVO> cmMngrInfoSelet(CmManageVO vo);
     
     
     /* {{ 2016.05.04 BH.YANG 커뮤니티 개설자 아이디 정보 */
     /**
      *  커뮤니티 정보
      * @param vo
      * @return  
      */
     CmManageVO CmOptMainInfo(CmManageVO vo);
     /* }} */
    
}
