package zes.openworks.intra.bassAgremManage;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.user.UserVO;


/**
*
*<pre>
*<< 개정이력(Modification Information) >>
*
*  기본협약관리>기본협약관리
*
* 수정일          수정자    수정내용
*--------------  --------  -------------------------------
* 2016. 10. 26.   엔키      신규
*</pre>
* @see
*/

@Service("BassAgremManageService")
public class BassAgremManageServiceImpl extends AbstractServiceImpl implements BassAgremManageService {

    @Resource BassAgremManageDAO dao;

    @Override
    public Pager<BassAgremManageVO> bassAgremManageList(BassAgremManageVO vo) {
        return dao.bassAgremManageList(vo);
    }

    @Override
    public  List<BassAgremManageVO> bassAgremManageListExcel(BassAgremManageVO vo){
        return dao.bassAgremManageListExcel(vo);
    }

    @Override
    public int bassAgremManageInsertAction(BassAgremManageVO vo) {
        return dao.bassAgremManageInsertAction(vo);
    }

    @Override
    public BassAgremManageVO bassAgremManageView(BassAgremManageVO vo) {
        return dao.bassAgremManageView(vo);
    }

    @Override
    public int bassAgremManageUpdateAction(BassAgremManageVO vo) {
        return dao.bassAgremManageUpdateAction(vo);
    }
    
    @Override
    public int opUserUpdateAction(BassAgremManageVO vo) {
        return dao.opUserUpdateAction(vo);
    }
    
    @Override
    public int tumSvcStorIUpdateAction(BassAgremManageVO vo) {
        return dao.tumSvcStorIUpdateAction(vo);
    }

    @Override
    public int fileDelete(FileVO fileVO) {
        return dao.fileDelete(fileVO);
    }

    @Override
    public int bassAgremManageDeleteAction(BassAgremManageVO vo) {
        return dao.bassAgremManageDeleteAction(vo);
    }

    @Override
    public Pager<UserVO> sellerListPop(BassAgremManageVO vo) {
        return dao.sellerListPop(vo);
    }
    
    /**
     * bassAgremClosUserList (협약 종료 사용자 목록 조회) - WAS 시간(날짜) 기준으로 조회 하도록 수정(2017.04.27)
     * @param paramMap
     * @return
     */
    @Override
//    public  List<BassAgremManageVO> bassAgremClosUserList(BassAgremManageVO vo){
//        return dao.bassAgremClosUserList(vo);
//    }
    public  List<BassAgremManageVO> bassAgremClosUserList(Map paramMap){
        return dao.bassAgremClosUserList(paramMap);
    }

    /**
     * opUserBassAgremClosAction (협약 종료에 따른 사용자 전환(공급자->수요자)(OP_USER 테이블 Update))
     * @param vo
     * @return
     */
    @Override
    public int opUserBassAgremClosAction(BassAgremManageVO vo) {
        return dao.opUserBassAgremClosAction(vo);
    }

    /**
     * tumSvcStorBassAgremClosAction (협약 종료에 따른 사용자 전환(공급자->수요자)(TUM_SVC_STOR_I 테이블 Update))
     * @param vo
     * @return
     */
    @Override
    public int tumSvcStorBassAgremClosAction(BassAgremManageVO vo) {
        return dao.tumSvcStorBassAgremClosAction(vo);
    }
    
    /**
     * tstGoodInfoBassAgremClosAction (협약 종료에 따른 해당 사용자의 상품을 비전시로 전환)
     * @param vo
     * @return
     */
    @Override
    public int tstGoodInfoBassAgremClosAction(BassAgremManageVO vo) {
        return dao.tstGoodInfoBassAgremClosAction(vo);
    }
    
    /**
     * bassAgremManageClosAction (해당 사용자의 협약정보의 협약상태 변경[승인(1004) -> 협약종료(1005)])
     * @param vo
     * @return
     */
    @Override
    public int bassAgremManageClosAction(BassAgremManageVO vo) {
        return dao.bassAgremManageClosAction(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.bassAgremManage.BassAgremManageService#summaryBassAgrem(zes.openworks.intra.bassAgremManage.BassAgremManageVO)
     */
    @Override
    public BassAgremSummaryVO summaryBassAgrem(BassAgremManageVO vo) {
        return dao.summaryBassAgrem(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.bassAgremManage.BassAgremManageService#updateUser(javax.servlet.http.HttpServletRequest)
     */
    @Override
    public int updateUser(BassAgremManageVO vo) {
        return dao.updateUser(vo);
    }
}
