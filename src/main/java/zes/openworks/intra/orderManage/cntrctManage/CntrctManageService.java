package zes.openworks.intra.orderManage.cntrctManage;

import java.util.List;
import java.util.Map;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctGoodsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 * 수정일          수정자    수정내용
 *--------------  --------  -------------------------------
 * 2016. 02. 15.   엔키      신규
 *</pre>
 * @see
 */

public interface CntrctManageService {

    /**
     * cntrctManageList (계약관리목록)
     * @param vo
     * @return
     */
    Pager<CntrctManageVO> cntrctManageList(CntrctManageVO vo);

    CntrctManageVO cntrctManageDetail(CntrctManageVO vo);
    List<SuplerCntrctGoodsVO> cntrctManageDetailList(CntrctManageVO vo);
    
    /**
     * 조달청 나라장터 연계정보 - 계약실적목록
     * naraTotalCntrctInfoList 설명
     * @param vo
     * @return
     */
    Pager<CntrctManageVO> naraTotalCntrctInfoList(CntrctManageVO vo);


    /**
     * cntrctManageInsertAction (계약관리 등록)
     * @param vo
     * @return
     */
    int cntrctManageInsertAction(CntrctManageVO vo);

    /**
     * cntrctManageView (계약관리상세)
     * @param vo
     * @return
     */
    CntrctManageVO cntrctManageView(CntrctManageVO vo);

    /**
     * cntrctManageUpdateAction (계약관리 수정)
     * @param vo
     * @return
     */
    int cntrctManageUpdateAction(CntrctManageVO vo);

    /**
     * fileDelete (계약서 파일 삭제)
     * @param fileVO
     * @return
     */
    int fileDelete(FileVO fileVO);

    /**
     * cntrctManageDeleteAction (계약관리 삭제)
     * @param vo
     * @return
     */
    int cntrctManageDeleteAction(CntrctManageVO vo);

    int cntrctManageUdpateUseAction(CntrctManageVO vo);
    int naraInfoInterface(CntrctManageVO vo);
    int tcnDvyfgInfoLInterface(CntrctManageVO vo);    

    
    Map<String, Object> mainCntInfo();
    
    int updateCntrctCmpl(SuplerCntrctVO vo);
    int updateCntrctCmpl2(SuplerCntrctVO vo);    

    int insertCntrctCmpl(SuplerCntrctVO vo);
    int InsertImmeServiceRegist(SuplerCntrctVO vo);    

    
    
}