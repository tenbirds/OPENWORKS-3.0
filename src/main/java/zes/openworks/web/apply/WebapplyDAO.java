package zes.openworks.web.apply;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class WebapplyDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    
    /*
     * 
     * apply 공통 부분
     * 
     * 
     * 
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<ApplyManageVO> applyList(ApplyManageVO vo) {

        vo.setTotalNum((Integer) selectByPk("_myapply.listCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<ApplyManageVO> dataList = list("_myapply.applyList", vo.getDataMap());

        return new Pager<ApplyManageVO>(dataList, vo);
    }

    public ApplyManageVO bidRequestMasterInfo(ApplyManageVO vo) {

        return (ApplyManageVO) selectByPk("_myapply.bidRequestMasterInfo", vo);
    }
    public ApplyManageVO bidSupplierMasterInfo(ApplyManageVO vo) {

        return (ApplyManageVO) selectByPk("_myapply.bidSupplierMasterInfo", vo);
    }
    
    public int bidUpdate(ApplyManageVO vo) {
        // 첨부파일
        if(vo.getDelyFileList() != null && vo.getDelyFileList().size() > 0) {
            vo.setDelyFile(fileDao.saveFile(vo.getDelyFileList(), vo.getDelyFile()));
        }
        
        return update("_myapply.bidUpdate", vo);
    }

    /*
     * 
     * 팝업 부분
     * 
     * 
     * 
     * 
     */
    public ApplyManageVO applycomplete(ApplyManageVO vo) {

        return (ApplyManageVO) selectByPk("_myapply.applycomplete", vo);
    }

    
    /*
     * 
     * SaaS 부분 시작
     * 
     * 
     * 
     */
    
    
    
    public List<ApplyManageVO> bidSaaSInfoOne(ApplyManageVO vo) {

        return list("_myapply.bidSaaSInfoOne", vo);
    }
    
    
    
    
    /*
     * 
     * Pass 부분 시작
     * 
     * 
     * 
     * 
     */
  public ApplyManageVO bidPaaSInfoOne(ApplyManageVO vo) {
        
        return  (ApplyManageVO) selectByPk("_myapply.bidPaaSInfoOne", vo);
    }
    
    public ApplyManageVO bidPaaSInfoTwo(ApplyManageVO vo) {

        return  (ApplyManageVO) selectByPk("_myapply.bidPaaSInfoTwo", vo);
    }
    
    public int bidPaaSInsert(ApplyManageVO vo) {
        return insert("_myapply.bidPaaSInsert", vo);
    }
    public int bidPaaSUpdate(ApplyManageVO vo) {
        return insert("_myapply.bidPaaSUpdate", vo);
    }
    public int bidIaaSInsertIaaSI(ApplyManageVO vo) {
        return insert("_myapply.bidIaaSInsertIaaSI", vo);
    }
    public int bidIaaSUpdateIaaSI(ApplyManageVO vo) {
        return insert("_myapply.bidIaaSUpdateIaaSI", vo);
    }
    public int bidIaaSInsertIaaSDS(ApplyManageVO vo) {
        return insert("_myapply.bidIaaSInsertIaaSDS", vo);
    }
    public int bidIaaSInsertIaaSDD(ApplyManageVO vo) {
        return insert("_myapply.bidIaaSInsertIaaSDD", vo);
    }
    public int bidIaaSUpdateIaaSDS(ApplyManageVO vo) {
        return insert("_myapply.bidIaaSUpdateIaaSDS", vo);
    }
    public int bidIaaSUpdateIaaSDD(ApplyManageVO vo) {
        return insert("_myapply.bidIaaSUpdateIaaSDD", vo);
    }
    /*
     * 
     * 
     * SaaS 부분
     * 
     * 
     * 
     * 
     */
   public List<ApplyManageVO> bidSaaSInfoTwo(ApplyManageVO vo) {
        return list("_myapply.bidSaaSInfoTwo", vo);
    }
   public int bidSaaSInsertSaaSD(ApplyManageVO vo) {
       return insert("_myapply.bidSaaSInsertSaaSD", vo);
   }
   public int bidSaaSInsertSaaSI(ApplyManageVO vo) {
       return insert("_myapply.bidSaaSInsertSaaSI", vo);
   }
   public int bidSaaSUpdateSaaSD(ApplyManageVO vo) {
       return update("_myapply.bidSaaSUpdateSaaSD", vo);
   }
   public int bidSaaSUpdateSaaSI(ApplyManageVO vo) {
       return update("_myapply.bidSaaSUpdateSaaSI", vo);
   }
 
        
   /*
    * 
    * IaaS 부분 시작 
    * 
    * 
    * 
    * 
    * 
    * 
    */
   
   public List<ApplyManageVO> bidIaaSInfoDB(ApplyManageVO vo) {

       return list("_myapply.bidIaaSInfoDB", vo);
   }
   
   
   public List<ApplyManageVO> bidIaaSInfoServer(ApplyManageVO vo) {
       return list("_myapply.bidIaaSInfoServer", vo);
   }
   
   public List<ApplyManageVO> bidIaaSInfo(ApplyManageVO vo) {
       
       return  list("_myapply.bidIaaSInfo", vo);
   }
   
   
   
   
   
   
   
   
   public ApplyManageVO applyPopUp(ApplyManageVO vo) {
       
       return  (ApplyManageVO) selectByPk("_myapply.applyPopUp", vo);
   }
   
   public int applyPopUpInsert(ApplyManageVO vo) {
       return insert("_myapply.applyPopUpInsert", vo);
   }
   public int applyPopUpUpdate(ApplyManageVO vo) {
       return insert("_myapply.applyPopUpUpdate", vo);
   }
}

