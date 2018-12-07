package zes.openworks.web.apply;


import java.util.List;

import zes.base.pager.Pager;

public interface WebapplyService {
    
    Pager<ApplyManageVO> applyList(ApplyManageVO vo);
    /*  
     * bidMasterFrom
     * 입찰 공고 상세 조회
     */
    
    /* Master Request Info Data Join */
    ApplyManageVO bidRequestMasterInfo(ApplyManageVO vo);
    
    /* Master Supplier Info Data Join */
    ApplyManageVO bidSupplierMasterInfo(ApplyManageVO vo);

    /* IaaS Data One Join*/
    List<ApplyManageVO> bidIaaSInfoDB(ApplyManageVO vo);
    
    /* IaaS Data Two Join*/
    List<ApplyManageVO> bidIaaSInfoServer(ApplyManageVO vo);
   
    /* IaaS Data Join*/
    List<ApplyManageVO> bidIaaSInfo(ApplyManageVO vo);

    
    /* SaaS Data One Join 
     * type : List 
     * */
    List<ApplyManageVO> bidSaaSInfoOne(ApplyManageVO vo);
    
    /* SaaS Data Two Join
     * type : List
     * */
    List<ApplyManageVO> bidSaaSInfoTwo(ApplyManageVO vo);
    
    /* PaaS Data One Join*/
    ApplyManageVO  bidPaaSInfoOne(ApplyManageVO vo);
    
    /* PaaS Data Two Join*/
    ApplyManageVO  bidPaaSInfoTwo(ApplyManageVO vo);
    
    /* PaaS Data Insert*/
    int bidPaaSInsert(ApplyManageVO vo);
    int bidPaaSUpdate(ApplyManageVO vo);
    int bidIaaSInsertIaaSI(ApplyManageVO vo);
    int bidIaaSUpdateIaaSI(ApplyManageVO vo);
    int bidIaaSInsertIaaSDS(ApplyManageVO vo);
    int bidIaaSInsertIaaSDD(ApplyManageVO vo);
    int bidIaaSUpdateIaaSDS(ApplyManageVO vo);
    int bidIaaSUpdateIaaSDD(ApplyManageVO vo);
    
    ApplyManageVO applycomplete(ApplyManageVO vo);
    
    
    /*
     * SaaS Data One JoIn
     * SaaS Data Two JoIn
     * SaaS Data Three JoIn
     * SaaS Data Update 
     */
    int bidSaaSInsertSaaSD(ApplyManageVO vo);
    int bidSaaSInsertSaaSI(ApplyManageVO vo);
    int bidSaaSUpdateSaaSD(ApplyManageVO vo);
    int bidSaaSUpdateSaaSI(ApplyManageVO vo);
    int bidUpdate(ApplyManageVO vo);
    //Pager<ApplyManageVO> bidSaaSInfoTwo(ApplyManageVO vo);
    
    
    
    
    
    ApplyManageVO  applyPopUp(ApplyManageVO vo);
    int applyPopUpInsert(ApplyManageVO vo);
    int applyPopUpUpdate(ApplyManageVO vo);
}
