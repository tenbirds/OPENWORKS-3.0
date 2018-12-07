/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManage;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
@Repository
public class CmManageDAO extends EgovAbstractMapper {
    
    /**  
     * 커뮤니티 개설신청 목록
     * @param vo
     * @return pager  
    */
   @SuppressWarnings("unchecked")
    public Pager<CmManageVO> openCmManageList(CmManageVO vo){
       Map<String, Object> paraMap = vo.getDataMap();

       
       paraMap.put("cmmntySttusCdNotIn", vo.getCmmntySttusCdNotIn()); // 승인 거절 페이지 기본 조건 

       paraMap.put("cmmntySttusCd", vo.getCmmntySttusCd());
       
       List<CmManageVO> openCmManageList = list("_cmManage.openCmManageList", paraMap);
       vo.setTotalNum((Integer)selectByPk("_cmManage.openCmManageListCount",paraMap));
       return new Pager<CmManageVO>(openCmManageList, vo);  
   }
   
   /**
    *  커뮤니티 개설신청 정보
    * @param vo
    * @return  
    */
    public CmManageVO openCmManageView(CmManageVO vo){
        return (CmManageVO) selectByPk("_cmManage.openCmManageView", vo);
    }
   
   
   /**
      *  커뮤니티 이름 URL 중복체크
      * @param vo
      * @return 
      */    
    public int getOpenCmManageCheck(CmManageVO vo){
        
         return (Integer) selectByPk("_cmManage.getOpenCmManageCheck", vo);
    }
 
    /**
     *  커뮤니티 닉네임 중복체크
     * @param vo
     * @return 
     */    
   public int getCmNcnmCheck(CmManageVO vo){
       
        return (Integer) selectByPk("_cmManage.getCmNcnmCheck", vo);
   }
     /**
      * 커뮤니티 사용자 최초 생성 메뉴 리스트
      * @param vo
      * @return  
      */
     @SuppressWarnings("unchecked")
     public List<CmManageVO> cmMenuManageSelect(CmManageVO vo){
         return list("_cmManage.cmMenuManageSelect", vo);
     }
 
     /**
      * 커뮤니티 사용자 최초 생성 메뉴 수정
      * @param vo
      * @return  
      */
     public int cmMenuManageUpdate(CmManageVO vo){
         return (Integer) update("_cmManage.cmMenuManageUpdate",vo);
     }
     
     /**
      * 커뮤니티 사용자 최초 생성 메뉴 등록
      * @param vo
      * @return  
      */
     public int cmMenuManageInsert(CmManageVO vo){
         return (Integer) insert("_cmManage.cmMenuManageInsert",vo);
     }
     
     /**
      * 커뮤니티 개설 신청 
      * @param vo
      * @return  
      */
     public int openCmManageUserInsert(CmManageVO vo){
         return (Integer) insert("_cmManage.openCmManageUserInsert",vo);
     }
     
     
     /**
      * 커뮤니티 개설 신청 승인 /승인 적용
      * @param vo
      * @return  
      */
     public int openCmManageApprovalUpdate(CmManageVO vo){
         return (Integer) update("_cmManage.openCmManageApprovalUpdate",vo);
     }
     
     
     /**
      * 커뮤니티 폐쇄 적용
      * @param vo
      * @return  
      */
     public int closeCmManageUpdate(CmManageVO vo){
         return (Integer) update("_cmManage.closeCmManageUpdate",vo);
     }
     
     /**
      * 커뮤니티 개설 다중 신청 승인
      * @param vo
      * @return  
      */
     public int openCmManageApprovalMultiUpdate(CmManageVO vo){
         return (Integer) update("_cmManage.openCmManageApprovalMultiUpdate",vo);
     }
     
     
     /**
      * 커뮤니티 개설 신청 거절
      * @param vo
      * @return  
      */
     public int openCmManageRejectUpdate(CmManageVO vo){
         return (Integer) update("_cmManage.openCmManageRejectUpdate",vo);
     }
     
     /**
      * 커뮤니티 사용자 최초 생성 메뉴 저장
      * @param vo
      * @return  
      */ 
     
     public int cmMenuUserInsert(CmManageVO vo){
         return (Integer) insert("_cmManage.cmMenuUserInsert",vo);
     }
     /**
      * 커뮤니티 사용자 최초 생성 메뉴 삭제
      * @param vo
      * @return  
      */ 
     public int cmMenuUserDelete(CmManageVO vo){
         return (Integer) delete("_cmManage.cmMenuUserDelete",vo);
     }
     
     /**
      *  사용자 기본정보
      * @param vo
      * @return  
      */
     public CmManageVO userInfoOptionSelect(CmManageVO vo){
         return (CmManageVO) selectByPk("_cmManage.userInfoOptionSelect", vo);
     }
     
     
     /**
      *  기업사용자 추가 정보
      * @param vo
      * @return  
      */
     public CmManageVO userEntrprsOptionSelect(CmManageVO vo){
         return (CmManageVO) selectByPk("_cmManage.userEntrprsOptionSelect", vo);
     }
     
     /**
      *  일반사용자 추가 정보
      * @param vo
      * @return  
      */
     public CmManageVO userOptionSelect(CmManageVO vo){
         return (CmManageVO) selectByPk("_cmManage.userOptionSelect", vo);
     }
     
     /**
      *   다중 체크 개인정보 가져오기
      * @param vo
      * @return  
      */
     public CmManageVO openCmInfoSelect(CmManageVO vo){
         return (CmManageVO) selectByPk("_cmManage.openCmInfoSelect", vo);
     }
     
     /**  
      * 커뮤니티 회원 목록
      * @param vo
      * @return pager  
     */
     @SuppressWarnings("unchecked")
     public Pager<CmManageVO> cmMberInfoList(CmManageVO vo){
        Map<String, Object> paraMap = vo.getDataMap();
        
        paraMap.put("cmmntyId", vo.getCmmntyId());
        paraMap.put("langCode", vo.getLangCode());
//        logger.info("q_mberStateTab::::::::::::::손해석:::::::::::::::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+paraMap.get("q_mberStateTab") );
        if( paraMap.get("q_mberStateTab") == null){
            paraMap.put("q_mberStateTab", "1001");  // 가입신청회원으로 기본 세팅 한다.
        }else  if( "".equals(paraMap.get("q_mberStateTab").toString())){
            paraMap.put("q_mberStateTab", "1001");  // 가입신청회원으로 기본 세팅 한다.
        }
        //q_mberStateTab
        List<CmManageVO> cmMberInfoList = list("_cmManage.cmMberInfoList", paraMap);
        vo.setTotalNum((Integer)selectByPk("_cmManage.cmMberInfoListCount",paraMap));
        return new Pager<CmManageVO>(cmMberInfoList, vo);  
     }
     
     /**
      *  커뮤니티 회원 가입 
      * @param vo
      * @return  
      */
     public int cmMemberShipJoinInsert(CmManageVO vo){
         return (Integer) insert("_cmManage.cmMemberShipJoinInsert",vo);
     }
     /**
      *  커뮤니티 회원 재가입 수정 
      * @param vo
      * @return  
      */
     public int cmMemberShipJoinUpdate(CmManageVO vo){
         return (Integer) update("_cmManage.cmMemberShipJoinUpdate",vo);
     }
     
     /**
      *  커뮤니티 회원 신청 취소 
      * @param vo
      * @return  
      */
     public int cmMemberShipCancelDelete(CmManageVO vo){
         return (Integer) update("_cmManage.cmMemberShipCancelDelete",vo);
     }
     
     /**
      *  커뮤니티 회원 정보 수정 : 가입 승인, 가입 거절 , 강제 탈퇴
      * @param vo
      * @return  
      */
     public int cmMemberShipInfoUpdate(CmManageVO vo){
         return (Integer) update("_cmManage.cmMemberShipInfoUpdate",vo);
     }
     
     /**
      *  커뮤니티 회원 정보
      * @param vo
      * @return  
      */
      public CmManageVO cmMemberShipInfoView(CmManageVO vo){
          return (CmManageVO) selectByPk("_cmManage.cmMemberShipInfoView", vo);
      }
     
      /**
       *  커뮤니티 폐쇄 관리자 메일 보내기 목록
       * @param vo
       * @return  
       */
      @SuppressWarnings("unchecked")
      public List<CmManageVO> cmMngrInfoSelet(CmManageVO vo){
          return list("_cmManage.cmMngrInfoSelet", vo);
      }
      
      /* {{ 2016.05.04 BH.YANG 커뮤티니 개설자 정보 */
      /**
       * CmOptMainInfo 설명
       * @param vo
       * @return
       */
      public CmManageVO CmOptMainInfo(CmManageVO vo) {
          return (CmManageVO)selectByPk("_cmManage.cmOptMainAdminId", vo);
      }
      /* }} */
}
