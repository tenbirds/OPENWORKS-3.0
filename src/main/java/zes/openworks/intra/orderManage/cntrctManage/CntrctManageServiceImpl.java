package zes.openworks.intra.orderManage.cntrctManage;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
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
@Service("CntrctManageService")
public class CntrctManageServiceImpl extends AbstractServiceImpl implements CntrctManageService {

    @Resource CntrctManageDAO dao;

    /* (계약관리목록)
     * @see zes.openworks.intra.orderManage.cntrctManage.CntrctManageService#cntrctManageList(zes.openworks.intra.orderManage.cntrctManage.CntrctManageVO)
     */
    @Override
    public Pager<CntrctManageVO> cntrctManageList(CntrctManageVO vo) {
        return dao.cntrctManageList(vo);
    }

    @Override
    public CntrctManageVO cntrctManageDetail(CntrctManageVO vo) {
        return dao.cntrctManageDetail(vo);
    }
    
    @Override
    public List<SuplerCntrctGoodsVO> cntrctManageDetailList(CntrctManageVO vo){
        return dao.cntrctManageDetailList(vo);
    }

    /* (조달청 나라장터 연계정보 - 계약실적목록)
     * @see zes.openworks.intra.orderManage.cntrctManage.CntrctManageService#cntrctManageList(zes.openworks.intra.orderManage.cntrctManage.CntrctManageVO)
     */
    @Override
    public Pager<CntrctManageVO> naraTotalCntrctInfoList(CntrctManageVO vo) {
        return dao.naraTotalCntrctInfoList(vo);
    }
    @Override
    public int cntrctManageInsertAction(CntrctManageVO vo) {
        return dao.cntrctManageInsertAction(vo);
    }

    @Override
    public CntrctManageVO cntrctManageView(CntrctManageVO vo) {
        return dao.cntrctManageView(vo);
    }

    @Override
    public int cntrctManageUpdateAction(CntrctManageVO vo) {
        return dao.cntrctManageUpdateAction(vo);
    }

    @Override
    public int fileDelete(FileVO fileVO) {
        return dao.fileDelete(fileVO);
    }

    @Override
    public int cntrctManageDeleteAction(CntrctManageVO vo) {
        return dao.cntrctManageDeleteAction(vo);
    }
    
    @Override
    public Map<String, Object> mainCntInfo(){
        return dao.mainCntInfo();
    }

    @Override
    public int cntrctManageUdpateUseAction(CntrctManageVO vo) {
        return dao.cntrctManageUpdateUseAction(vo);
    }
    @Override
    public int naraInfoInterface(CntrctManageVO vo) {
        return dao.naraInfoInterface(vo);
    }
    @Override
    public int tcnDvyfgInfoLInterface(CntrctManageVO vo) {
        return dao.tcnDvyfgInfoLInterface(vo);
    }

    @Override
    public int updateCntrctCmpl(SuplerCntrctVO vo){
        return dao.updateCntrctCmpl(vo);
    }    
    @Override
    public int updateCntrctCmpl2(SuplerCntrctVO vo){
        return dao.updateCntrctCmpl2(vo);
    }    

    @Override
    public int insertCntrctCmpl(SuplerCntrctVO vo){
        return dao.insertCntrctCmpl(vo);
    }    
    @Override
    public int InsertImmeServiceRegist(SuplerCntrctVO vo){
        return dao.InsertImmeServiceRegist(vo);
    }    

}
