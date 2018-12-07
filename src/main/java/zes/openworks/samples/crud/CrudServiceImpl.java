/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.samples.crud;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
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
 *  2012. 3. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("crudService")
public class CrudServiceImpl extends AbstractServiceImpl implements CrudService {

    @Resource
    private CrudDAO crudDao;
    @Resource
    private FileDAO fileDao;

    @Override
    public CrudVO crudView(CrudVO crudVo) {

        CrudVO dataVo = crudDao.crudView(crudVo);
        if(dataVo.getFileSeq() > -1) {
            dataVo.setFileList(fileDao.getFiles(dataVo.getFileSeq()));
        }

        return dataVo;
    }

    @Override
    public CrudVO crudData(CrudVO crudVo) {

        CrudVO dataVo = crudDao.crudData(crudVo);
        if(dataVo.getFileSeq() > -1) {
            dataVo.setFileList(fileDao.getFiles(dataVo.getFileSeq()));
        }

        return dataVo;
    }

    @Override
    public Pager<CrudVO> crudList(CrudVO crudVo) {

        return crudDao.crudList(crudVo);
    }

    @Override
    public Object crudInsert(CrudVO crudVo) {

        crudVo.setFileSeq(fileDao.saveFile(crudVo.getFileList()));

        return crudDao.crudInsert(crudVo);
    }

    @Override
    public Integer crudUpdate(CrudVO crudVo) {

        if(Validate.isNotEmpty(crudVo.getFileIds())) {
            fileDao.removeFile(crudVo.getFileSeq(), crudVo.getFileIds());
        }

        crudVo.setFileSeq(fileDao.saveFile(crudVo.getFileList(), crudVo.getFileSeq()));

        return crudDao.crudUpdate(crudVo);
    }

    @Override
    public Integer crudDelete(CrudVO crudVo) {

        // 원글 삭제
        CrudVO delCrudVo = crudData(crudVo);
        delCrudVo.setDataMap(crudVo.getDataMap());

        Integer delCnt = crudDao.crudDelete(delCrudVo);

        if(delCrudVo.getFileSeq() > -1) {
            fileDao.removeFile(delCrudVo.getFileSeq());
        }

        // 답변 삭제
        CrudReplyVO crudReplyVo = new CrudReplyVO();
        crudReplyVo.setDataMap(crudVo.getDataMap());

        List<CrudReplyVO> dataList = crudDao.crudReplyList(crudReplyVo);
        for(CrudReplyVO replyVo : dataList) {
            if(replyVo.getFileSeq() > -1) {
                fileDao.removeFile(replyVo.getFileSeq());
            }
        }

        crudDao.crudReplyListDelete(crudReplyVo);

        return delCnt;
    }

    @Override
    public Integer crudListDelete(CrudVO crudVo) {

        Integer delCnt = 0;
        CrudVO delCrudVo;
        Map<String, Object> dataMap = new HashMap<String, Object>();

        Integer[] seqs = crudVo.getSeqs();

        for(Integer seq : seqs) {
            dataMap.put("q_seq", seq);
            crudVo.setDataMap(dataMap);

            // 원글 삭제
            delCrudVo = crudData(crudVo);
            delCnt += crudDao.crudDelete(delCrudVo);

            if(delCrudVo.getFileSeq() > -1) {
                fileDao.removeFile(delCrudVo.getFileSeq());
            }

            // 답변 삭제
            CrudReplyVO crudReplyVo = new CrudReplyVO();
            crudReplyVo.setDataMap(dataMap);

            List<CrudReplyVO> dataList = crudDao.crudReplyList(crudReplyVo);
            for(CrudReplyVO replyVo : dataList) {
                if(replyVo.getFileSeq() > -1) {
                    fileDao.removeFile(replyVo.getFileSeq());
                }
            }

            crudDao.crudReplyListDelete(crudReplyVo);
        }

        return delCnt;
    }

    @Override
    public CrudReplyVO crudReplyView(CrudReplyVO crudReplyVo) {

        CrudReplyVO replyVo = crudDao.crudReplyView(crudReplyVo);
        if(replyVo.getFileSeq() > -1) {
            replyVo.setFileList(fileDao.getFiles(replyVo.getFileSeq()));
        }

        return replyVo;
    }

    @Override
    public List<CrudReplyVO> crudReplyList(CrudReplyVO crudReplyVo) {

        List<CrudReplyVO> dataList = crudDao.crudReplyList(crudReplyVo);
        for(CrudReplyVO replyVo : dataList) {
            if(replyVo.getFileSeq() > -1) {
                replyVo.setFileList(fileDao.getFiles(replyVo.getFileSeq()));
            }
        }

        return dataList;
    }

    @Override
    public Object crudReplyInsert(CrudReplyVO crudReplyVo) {

        crudReplyVo.setFileSeq(fileDao.saveFile(crudReplyVo.getFileList()));

        return crudDao.crudReplyInsert(crudReplyVo);
    }

    @Override
    public Integer crudReplyUpdate(CrudReplyVO crudReplyVo) {

        if(Validate.isNotEmpty(crudReplyVo.getFileIds())) {
            fileDao.removeFile(crudReplyVo.getFileSeq(), crudReplyVo.getFileIds());
        }

        crudReplyVo.setFileSeq(
            fileDao.saveFile(crudReplyVo.getFileList(), crudReplyVo.getFileSeq()));

        Integer updateCnt = crudDao.crudReplyUpdate(crudReplyVo);

        return updateCnt;
    }

    @Override
    public Integer crudReplyDelete(CrudReplyVO crudReplyVo) {

        CrudReplyVO replyVo = crudReplyView(crudReplyVo);
        replyVo.setDataMap(crudReplyVo.getDataMap());
        Integer deleteCnt = crudDao.crudReplyDelete(replyVo);

        if(replyVo.getFileSeq() > -1) {
            fileDao.removeFile(replyVo.getFileSeq());
        }

        return deleteCnt;
    }

}
