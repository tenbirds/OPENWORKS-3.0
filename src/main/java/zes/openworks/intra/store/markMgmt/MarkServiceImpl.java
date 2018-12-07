/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.markMgmt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.code.CodeVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 24.    김영상       신규
 *</pre>
 * @see
 */
@Service("markService")
public class MarkServiceImpl extends AbstractServiceImpl implements MarkService {
    
    @Resource
    private MarkDAO dao;

    @Resource
    private FileDAO fileDao;

    @Override
    public List<CodeVO> markList() {

        return dao.markList();
    }

    @Override
    public List<CodeVO> cntcImgList() {

        return dao.cntcImgList();
    }

    @Override
    public int chkCnt(MarkVO vo) {
       
        return dao.chkCnt(vo);
    }
    
    @Override
    public int saveMarkInfo(MarkVO vo) {

        return dao.saveMarkInfo(vo);
    }
    
    @Override
    public int saveCntcImgInfo(MarkVO vo) {

        return dao.saveCntcImgInfo(vo);
    }
    
    @Override
    public int fileDelete(FileVO fileVO, MarkVO vo) {
        return dao.fileDelete(fileVO, vo);
    }
    
    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    @Override
    public boolean fileDelete(List<FileVO> fileList) {
        return dao.fileDelete(fileList);
    }

    @Override
    public MarkVO getMarkInfo(MarkVO vo) {

        return dao.getMarkInfo(vo);
    }

    @Override
    public MarkVO getCntcImgInfo(MarkVO vo) {

        return dao.getCntcImgInfo(vo);
    }
}
