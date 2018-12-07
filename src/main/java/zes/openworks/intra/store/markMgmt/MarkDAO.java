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

import org.springframework.stereotype.Repository;

import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.code.CodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2014. 11. 24.    김영상       신규
 * </pre>
 * @see
 */
@Repository
public class MarkDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * markList 설명
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<CodeVO> markList() {

        return list("_markmgmt.markList", null);
    }

    /**
     * cntcImgList 설명
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<CodeVO> cntcImgList() {

        return list("_markmgmt.cntcImgList", null);
    }

    /**
     * chkCnt 설명
     * 
     * @param vo
     * @return
     */
    public int chkCnt(MarkVO vo) {

        return (Integer) selectByPk("_markmgmt.chkCnt", vo);
    }

    /**
     * getMarkInfo 설명
     * 
     * @param vo
     * @return
     */
    public MarkVO getMarkInfo(MarkVO vo) {
        MarkVO markVo = (MarkVO) selectByPk("_markmgmt.markInfo", vo);
        if(Validate.isNotEmpty(markVo)) {
            markVo.setFileList(fileDao.getFiles(markVo.getMarkImageFileSeq()));
            return markVo;
        }
        // 공통코드에만 값이 존재 즉, 마크이미지 신규 등록시 코드값에 있는 값 세팅
        return vo;
    }

    /**
     * getCntcImgInfo 설명
     * 
     * @param vo
     * @return
     */
    public MarkVO getCntcImgInfo(MarkVO vo) {
        MarkVO markVo = (MarkVO) selectByPk("_markmgmt.cntcImgInfo", vo);
        if(Validate.isNotEmpty(markVo)) {
            markVo.setFileList(fileDao.getFiles(markVo.getCntcGoodsImageSeq()));
            return markVo;
        }
        // 공통코드에만 값이 존재 즉, 마크이미지 신규 등록시 코드값에 있는 값 세팅
        return vo;
    }

    /**
     * saveMarkInfo 설명
     * 
     * @param vo
     * @return
     */
    public int saveMarkInfo(MarkVO vo) {
        if("I".equals(vo.getSepp())) {
            int fileSeq = fileDao.saveFile(vo.getFileList());
            vo.setMarkImageFileSeq(fileSeq);
            return insert("_markmgmt.markInsert", vo);
        } else {
            if(Validate.isNotEmpty(vo.getFileList())){
                fileDao.removeFile(vo.getMarkImageFileSeq());
                int fileSeq = fileDao.saveFile(vo.getFileList(), vo.getMarkImageFileSeq());
                vo.setMarkImageFileSeq(fileSeq);
            }
            return update("_markmgmt.markUpdate", vo);
        }
    }

    /**
     * saveCntcImgInfo 설명
     * 
     * @param vo
     * @return
     */
    public int saveCntcImgInfo(MarkVO vo) {
        if("I".equals(vo.getSepp())) {
            int fileSeq = fileDao.saveFile(vo.getFileList());
            vo.setCntcGoodsImageSeq(fileSeq);
            return insert("_markmgmt.cntcImgInsert", vo);
        } else {
            if(Validate.isNotEmpty(vo.getFileList())){
                fileDao.removeFile(vo.getCntcGoodsImageSeq());
                int fileSeq = fileDao.saveFile(vo.getFileList(), vo.getCntcGoodsImageSeq());
                vo.setCntcGoodsImageSeq(fileSeq);
            }
            return insert("_markmgmt.cntcImgUpdate", vo);
        }
    }

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    public boolean fileDelete(List<FileVO> fileList) {
        int deleteCnt = 0;
        if(Validate.isNotEmpty(fileList)) {
            // 물리적인 첨부파일 삭제
            for(FileVO fileVO : fileList) {
                if(FileUtil.delete(GlobalConfig.UPLOAD_ROOT + fileVO.getFileUrl())) {
                    deleteCnt++;
                }
            }
        }
        return (deleteCnt == fileList.size()) ? true : false;
    }

    /**
     * 파일삭제 후 seq 초기화
     */
    public int fileDelete(FileVO fileVO, MarkVO vo) {
        if(Validate.isNotEmpty(vo.getMarkImageFileSeq())) {
            vo.setMarkImageFileSeq(-1);
            update("_markmgmt.markUpdate", vo);
        } else if(Validate.isNotEmpty(vo.getCntcGoodsImageSeq())) {
            vo.setCntcGoodsImageSeq(-1);
            update("_markmgmt.cntcImgUpdate", vo);
        }
        return fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
    }
}
