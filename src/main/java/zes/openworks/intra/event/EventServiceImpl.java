/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.event;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 16.    이슬버미       신규
 *</pre>
 * @see
 */
@Service("eventService")
public class EventServiceImpl  extends AbstractServiceImpl  implements EventService {

    @Resource
    private EventDAO dao;
    
    @Resource
    private FileDAO fileDao;

    @Override
    public Pager<EventVO> eventList(EventVO vo) {
        return dao.eventList(vo);
    }
    
    @Override
    public Pager<EventVO> answerList(EventVO vo) {
        return dao.answerList(vo);
    }

    @Override
    public List<EventVO> eventTypeList(EventVO vo) {
        return dao.eventTypeList(vo);
    }

    @Override
    public int eventInsertAction(EventVO vo, HttpServletRequest request) {

        //파일 저장
        int fileSeq = fileDao.saveFile(vo.getFileList());
        vo.setEventThumbFileSeq(fileSeq);
        
        int cnt = dao.eventInsertAction(vo);
        
        dao.eventInsertDomainCd(vo);

        //메뉴구분
        String[] eventLcSeCds = request.getParameter("eventLcSeCds1").split(",");
        for(String eventLsCeCd : eventLcSeCds){
            vo.setEventLcSeCd(Integer.parseInt(eventLsCeCd));
            dao.eventInsertLsSeCd(vo);
        }

        return cnt;
    }

    @Override
    public EventVO eventUpdateForm(EventVO vo) {
        /* FileUtil.delete(GlobalConfig.WEBAPP_ROOT + baseFileVo.getFileUrl()); */
        return dao.eventUpdateForm(vo);
    }

    @Override
    public int eventUpdate(EventVO vo, HttpServletRequest request) {
        
        if(Validate.isNotEmpty(vo.getFlag()) || Validate.isNotEmpty(vo.getEventFilePath())) {
            fileDao.removeFile(vo.getEventThumbFileSeq());            
        }
        
        for(int i = 0 ; i < vo.getFileList() .size() ; i++) {
          //파일 수정
            fileDao.removeFile(vo.getEventThumbFileSeq());
            int fileSeq = fileDao.saveFile(vo.getFileList());
            vo.setEventThumbFileSeq(fileSeq);
        }
        
        dao.eventUpdate(vo);
        dao.eventDomainDel(vo);
        dao.eventLcInfoDel(vo);
        
        //사이트
        dao.eventInsertDomainCd(vo);
        
        //메뉴구분
        String[] eventLcSeCds = request.getParameter("eventLcSeCds1").split(",");
        for(String eventLsCeCd : eventLcSeCds){
            vo.setEventLcSeCd(Integer.parseInt(eventLsCeCd));
            dao.eventInsertLsSeCd(vo);
        }
        
        return 0;
    }

    @Override
    public int fileDel(EventVO vo) {
        String filePath = dao.filePath(vo);
        FileUtil.delete(GlobalConfig.RESOURCE_ROOT + filePath);
        return dao.fileDel(vo);
    }

    @Override
    public List<EventVO> domainList(EventVO vo) {
        return dao.domainList(vo);
    }

    @Override
    public List<EventVO> eventLcSeList(EventVO vo) {
        return dao.eventLcSeList(vo);
    }
    
    @Override
    public List<EventVO> eventDomainList(EventVO vo) {
        return dao.eventDomainList(vo);
    }

    @Override
    public List<EventVO> orderList(EventVO vo) {
        return dao.orderList(vo);
    }

    @Override
    public int orderUpdate(EventVO vo, HttpServletRequest request) {
        String[] seqs = request.getParameter("seqs").split(",");
        vo.setDomainCd(Integer.parseInt(request.getParameter("domainCds")));
        for(String seq : seqs) {
            vo.setEventSn(Integer.parseInt(seq));
            dao.orderDelete(vo);
            dao.orderUpdate(vo);
        }
        return 0;
    }

    @Override
    public int eventInsertAction(EventVO vo) {
        dao.eventInsertAction(vo);
        return 0;
    }

    @Override
    public int enfrcClosAtUpdateAction(EventVO vo) {

        return dao.enfrcClosAtUpdateAction(vo);
    }

    @Override
    public int eventDeleteAction(EventVO vo) {

        //유형 삭제 (Y/N)
        return dao.eventAtDeleteAction(vo);
        
//완전 삭제
//        if(Validate.isNotEmpty(vo.getFileIds())){
//            for(String fielSeqs : vo.getFileIds()) {
//                fileDao.removeFile(Integer.valueOf(fielSeqs));
//            }
//        }
//        return dao.eventDeleteAction(vo);
    }

    
    /**
     * answerListExcel (댓글 엑셀 출력)
     * @param vo
     * @return
     */
    @Override
    public List<EventVO> answerListExcel(EventVO vo) {
        return dao.answerListExcel(vo);
    }
    
}
