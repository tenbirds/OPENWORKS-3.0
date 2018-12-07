/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.user.coLog.UserLogVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Service("userService")
public class UserServiceImpl extends AbstractServiceImpl implements UserService {

    @Resource
    private UserDAO dao;
    
    @Resource
    private FileDAO fileDao;

    @Override
    public Pager<UserVO> userList(UserVO vo) {
        return dao.userList(vo);
    }

    @Override
    public Map<String, Integer> deleteAction(UserVO vo) {
        return dao.deleteAction(vo);
    }
    
    @Override
    public int insertAction(UserVO vo) {
        return dao.insertAction(vo);
    }
    
    @Override
    public int updateAction(UserVO vo) {
        return dao.updateAction(vo);
    }

//    @Override
//    public int pInsertAction(UserVO vo) {
//        return dao.pInsertAction(vo);
//    }
    
    @Override
    public UserVO userForm(UserVO vo) {
        return dao.userForm(vo);
    }
    
    @Override
    public int fileDelete(FileVO fileVO) {
        return fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
    }

    @Override
    public UserVO pUpdateForm(UserVO vo) {
        return dao.pUpdateForm(vo);
    }

    @Override
    public int pUpdateAction(UserVO vo) {
        return dao.pUpdateAction(vo);
    }

    @Override
    public UserVO pOptionUpdateForm(UserVO vo) {
        return dao.pOptionUpdateForm(vo);
    }

    @Override
    public int pOptionUpdateAction(UserVO vo) {
        return dao.pOptionUpdateAction(vo);
    }

    @Override
    public Object selectUserPwd(UserLogVO lvo) {

        return dao.selectUserPwd(lvo);
    }
    
    @Override
    public int passwordUpdateAction(UserVO vo) {
        
        return dao.passwordUpdateAction(vo);
    }

    @Override
    public int checkDupleId(UserVO vo) {
        return dao.checkDupleId(vo);
    }

    @Override
    public Object userLogInsertAction(UserLogVO vo) {

        return dao.userLogInsertAction(vo);
    }

    @Override
    public List<UserVO> userListCExcel(UserVO vo) {

        return dao.userListCExcel(vo);
    }

    @Override
    public List<UserVO> userListSExcel(UserVO vo) {

        return dao.userListSExcel(vo);
    }

    @Override
    public Object userCount(UserVO vo) {

        return dao.userCount(vo);
    }

    @Override
    public Object pUserSetYn(UserVO vo) {

        return dao.pUserSetYn(vo);
    }

    @Override
    public Object cpUserSetYn(UserVO vo) {

        return dao.cpUserSetYn(vo);
    }
    
    @Override
    public Object pblUserSetYn(UserVO vo) {

        return dao.pblUserSetYn(vo);
    }
    
    @Override
    public Object storeSetYn(UserVO vo) {
        
        return dao.storeSetYn(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.user.UserService#userGradeList(zes.openworks.intra
     * .user.UserVO)
     */
    @Override
    public List<UserVO> userGradeList(UserVO vo) {

        return dao.userGradeList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.user.UserService#pOptionInsertAction(zes.openworks.intra.user.UserVO)
     */
    @Override
    public int pOptionInsertAction(UserVO vo) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public Integer checkDupleStoreNm(UserVO vo) {
        return dao.checkDupleStoreNm(vo);
    }

    @Override
    public Integer selectUserTyCd(UserVO vo) {
        return dao.selectUserTyCd(vo);
    }

    @Override
    public int emailDupleCheck(UserVO vo) {
        return dao.emailDupleCheck(vo);
    }

    @Override
    public List<Map<String, Object>> userNation(UserVO vo) {
        return dao.userNation(vo);
    }

    @Override
    public Integer checkDupleBizrno(UserVO vo) {
        return dao.checkDupleBizrno(vo);
    }

    @Override
    public List<Map<String, Object>> continentList() {
        return dao.continentList();
    }

    @Override
    public Integer checkStoreSales(UserVO vo) {
        return dao.checkStoreSales(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.user.UserService#userDrmncyList(zes.openworks.intra.user.UserVO)
     */
    @Override
    public Pager<UserVO> userDrmncyList(UserVO vo) {
        return dao.userDrmncyList(vo) ;
    }
}
