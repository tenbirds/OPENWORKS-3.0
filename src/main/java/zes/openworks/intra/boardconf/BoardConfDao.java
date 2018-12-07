/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.base.support.CacheHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.boardtemp.BoardTempVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *  수정일        수정자                     수정내용
 * --------------  --------  ---------------------------------
 *  2012. 4. 25.     손재숙       JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 9. 20.    박꽃송이      DB 컬럼(사이트 구분 - SITE_DIV_CD) 추가로 인한 수정 및 추가
 * </pre>
 * @see
 */
@Repository
public class BoardConfDao extends EgovAbstractMapper {

    
    @Resource
    private FileDAO fileDao;
    
    
    /**
     * 게시판 목록 조회
     */
    @SuppressWarnings("unchecked")
    public Pager<BoardConfVO> boardConfList(BoardConfVO boardConfVO) {
        
        String q_domain_cd = boardConfVO.getQ_domain_cd() == null ? "" : boardConfVO.getQ_domain_cd().toString(); 
        if(!"".equals(q_domain_cd)) {
            boardConfVO.getDataMap().put("q_domain_cd",  boardConfVO.getQ_domain_cd().toString());
        }
        
        List<BoardConfVO> dataList = list("_boardconf.boardConfList", boardConfVO.getDataMap());
        boardConfVO.setTotalNum((Integer) selectByPk("_boardconf.boardConfListCount", boardConfVO.getDataMap()));
        
        return new Pager<BoardConfVO>(dataList, boardConfVO);
    }

    /**
     * 게시판 목록 조회
     */
    @SuppressWarnings("unchecked")
    public List<BoardConfVO> boardConfList() {
        List<BoardConfVO> dataList = list("_boardconf.boardConfSimpleList", new HashMap<String, String>());

        return dataList;
    }

    /**
     * 게시판 상세 조회
     */
    @SuppressWarnings("unchecked")
    public BoardConfVO boardConfView(BoardConfVO boardConfVO) {
        BoardConfVO dataVO = null;

        if(BoardConfConstant.GUBUN_CD_GLOBAL == boardConfVO.getGubunCd()) {
            
            dataVO = (BoardConfVO) selectByPk("_boardconf.boardConfView", boardConfVO);
            // 카테고리 사용안할경우에도 카테고리를 유지한다.
             if("Y".equals(dataVO.getCtgYn())){
                List<String> bbcCtgList = list("_boardconf.boardCtgNmList", boardConfVO);
                
                if(boardConfVO.getBbsCd() == 1002 || boardConfVO.getBbsCd() == 1031){
                    //ctgCd조회
                    List<Integer> bbcCtgCdList = list("_boardconf.boardCtgCdList", boardConfVO);
                    List<String> bbcAditCtgList  = new ArrayList<String>();
                    
                    int count =1;
                    for(int ctgCd : bbcCtgCdList){
                        boardConfVO.setCtgCd(ctgCd);
                        bbcAditCtgList.addAll(list("_boardconf.boardAditCtgNmList", boardConfVO));
                        
                        if(bbcCtgCdList.size() != count ){bbcAditCtgList.add("/");}
                        count++;
                    }
                    //2Depth
                    String[] aditCtgNms = bbcAditCtgList.toArray(new String[bbcAditCtgList.size()]);
                    dataVO.setAditCtgNms(aditCtgNms);
                }
                
                //1Depth
                String[] bbsCtgNms = bbcCtgList.toArray(new String[bbcCtgList.size()]);
                dataVO.setCtgNms(bbsCtgNms);
                
             }
        } else if(BoardConfConstant.GUBUN_CD_LIST == boardConfVO.getGubunCd()) {
            dataVO = (BoardConfVO) selectByPk("_boardconf.boardConfListView", boardConfVO);
        } else if(BoardConfConstant.GUBUN_CD_VIEW == boardConfVO.getGubunCd()) {
            dataVO = (BoardConfVO) selectByPk("_boardconf.boardConfViewView", boardConfVO);
        } else if(BoardConfConstant.GUBUN_CD_FORM == boardConfVO.getGubunCd()) {
            dataVO = (BoardConfVO) selectByPk("_boardconf.boardConfFormView", boardConfVO);
        } else if(BoardConfConstant.GUBUN_CD_AUTH == boardConfVO.getGubunCd()) {
            dataVO = (BoardConfVO) selectByPk("_boardconf.boardConfAuthView", boardConfVO);

            /*if(Validate.isNotEmpty(dataVO.getAuthIds())) {
                String[] authIds = StringUtil.split(dataVO.getAuthIds(), ",");
                if(Validate.isNotEmpty(authIds)) {
                    List<MgrVO> authList = new ArrayList<MgrVO>(authIds.length);

                    MgrVO mgrVo = new MgrVO();
                    for(String mngrId : authIds) {
                        mgrVo.setMgrId(mngrId);
                        authList.add((MgrVO) selectByPk("_mgr.view", mgrVo));
                    }
                    dataVO.setAuthList(authList);
                }
            }*/
        }

        return dataVO;
    }

    /**
     * 게시판 전체항목 목록
     * 
     * @param bbsCd
     * @return
     */
    public List<BoardArrangeVO> boardColumnList(BoardArrangeVO boardArrangeVO) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("domainCd", boardArrangeVO.getDomainCd());
        map.put("bbsCd", boardArrangeVO.getBbsCd());
        @SuppressWarnings("unchecked")
        List<BoardArrangeVO> list = list("_boardconf.boardColumnList", map);

        return list;
    }

    /**
     * 게시판 표시항목 목록
     * 
     * @param bbsCd
     * @return
     */
    public List<BoardArrangeVO> boardDisplayColumnList(BoardArrangeVO boardArrangeVO) {
        @SuppressWarnings("unchecked")
        List<BoardArrangeVO> list = list("_boardconf.boardDisplayColumnList", boardArrangeVO);

        return list;
    }

    /**
     * 게시판 확장 관리 목록
     * 
     * @param bbsCd
     * @return
     */
    public List<BoardExtensionVO> boardConfExtList(BoardConfVO boardConfVO) {
        @SuppressWarnings("unchecked")
        List<BoardExtensionVO> extList = list("_boardconf.boardConfExtensionList", boardConfVO);

        return extList;
    }

    /**
     * 게시판 템플릿 목록
     */
    public List<BoardTempVO> boardTemplateList(String type) {
        @SuppressWarnings("unchecked")
        List<BoardTempVO> tempList = list("_boardconf.boardTemplateList", type);

        return tempList;
    }

    /**
     * 게시판 등록 액션
     */
    public Object insertAction(BoardConfVO boardConfVO) {
        insert("_boardconf.boardConfInsert", boardConfVO);

        Integer domainCd = boardConfVO.getDomainCd();
        Integer primaryKey = boardConfVO.getBbsCd();

        if(primaryKey != null) {
            boardConfVO.setBbsCd(primaryKey);

            update("_boardconf.boardConfGlobalInsert", boardConfVO);
            update("_boardconf.boardConfListInsert", boardConfVO);
            update("_boardconf.boardConfViewInsert", boardConfVO);
            update("_boardconf.boardConfFormInsert", boardConfVO);
            // update("_boardconf.boardConfAuthInsert", boardConfVO);

            Iterator<?> it = Config.getKeys("board.defaultColumn");

            String key = "";
            BoardExtensionVO bExtVO;

            while(it.hasNext()) {
                bExtVO = new BoardExtensionVO();

                key = String.valueOf(it.next());
                key = key.replaceAll("board.defaultColumn", "board.defaultConfig");

                bExtVO.setBbsCd(primaryKey);
                bExtVO.setDomainCd(domainCd);
                bExtVO.setColumnId(Config.getString(key + "[@columnId]"));
                bExtVO.setColumnNm(Config.getString(key + "[@columnNm]"));
                bExtVO.setColumnTy(Config.getString(key + "[@columnTy]"));
                bExtVO.setColumnCm(Config.getString(key + "[@columnComment]"));
                bExtVO.setSearchCndYn(Config.getString(key + "[@searchCndYn]"));
                bExtVO.setSearchTy(Config.getString(key + "[@searchTy]"));
                bExtVO.setEssntlYn(Config.getString(key + "[@essntlYn]"));
                bExtVO.setUseYn(Config.getString(key + "[@useYn]"));

                insert("_boardconf.boardConfExtensionInsert", bExtVO);
            }

            if("Y".equals(boardConfVO.getCtgYn())) {
                insertBbsCtgAction(boardConfVO);
            }

            // 기본 배치 항목 등록
            String[][] lists = BoardConfConstant.LIST_ARRANGE_LIST;
            int orderNo = 0;
            for(int i = 0 ; i < lists.length ; i++) {
                BoardArrangeVO vo = new BoardArrangeVO();
                vo.setBbsCd(primaryKey);
                vo.setDomainCd(domainCd);
                vo.setListViewSe("list");
                vo.setColumnId(lists[i][0]);
                vo.setColumnNm(lists[i][1]);
                vo.setArrangeOrdrNo(++orderNo);
                vo.setBeanNm(StringUtil.camelCase(lists[i][0]));
                insert("_boardconf.boardConfArrangeInsert", vo);
            }
            String[][] views = BoardConfConstant.VIEW_ARRANGE_LIST;
            orderNo = 0;
            for(int i = 0 ; i < views.length ; i++) {
                BoardArrangeVO vo = new BoardArrangeVO();
                vo.setBbsCd(primaryKey);
                vo.setDomainCd(domainCd);
                vo.setListViewSe("view");
                vo.setColumnId(views[i][0]);
                vo.setColumnNm(views[i][1]);
                vo.setArrangeOrdrNo(++orderNo);
                vo.setBeanNm(StringUtil.camelCase(views[i][0]));
                insert("_boardconf.boardConfArrangeInsert", vo);
            }

            // 게시판 캐쉬를 리로드 합니다.
            reloadBbsCache();
        }

        return primaryKey;
    }

    /**
     * 게시판 수정 액션
     */
    public int updateAction(BoardConfVO boardConfVO) {
        
        boardConfVO.setUpdtDt(DateFormatUtil.getToday());
        
        int affected = update("_boardconf.boardConfUpdate", boardConfVO);
        
        insertBbsCtgAction(boardConfVO);

        if(affected == StringUtil.ONE) {
            if(BoardConfConstant.GUBUN_CD_GLOBAL == boardConfVO.getGubunCd()) {
                affected = update("_boardconf.boardConfGlobalUpdate", boardConfVO);
                if(affected == StringUtil.ONE) {
                    insertBbsCtgAction(boardConfVO);
                }
            } else if(BoardConfConstant.GUBUN_CD_LIST == boardConfVO.getGubunCd()) {
                affected = update("_boardconf.boardConfListUpdate", boardConfVO);
            } else if(BoardConfConstant.GUBUN_CD_VIEW == boardConfVO.getGubunCd()) {
                affected = update("_boardconf.boardConfViewUpdate", boardConfVO);
            } else if(BoardConfConstant.GUBUN_CD_FORM == boardConfVO.getGubunCd()) {
                affected = update("_boardconf.boardConfFormUpdate", boardConfVO);
            } else if(BoardConfConstant.GUBUN_CD_AUTH == boardConfVO.getGubunCd()) {
                affected = update("_boardconf.boardConfAuthUpdate", boardConfVO);
            }

            // 게시판 캐쉬를 리로드 합니다.
            reloadBbsCache();
        }

        return affected;
    }

    /**
     * 게시판 확장 관리 수정 액션(추가컬럼 및 목록 표시 항목)
     */
    public int updateExtAction(List<BoardExtensionVO> extList) {
        int affexted = 0;
        
        for(BoardExtensionVO extenstion : extList) {
            affexted += update("_boardconf.boardConfExtensionUpdate", extenstion);
        }

        // 게시판 캐쉬를 리로드 합니다.
        reloadBbsCache();

        return affexted;
    }

    /**
     * 게시판 카테고리 등록
     */
    private void insertBbsCtgAction(BoardConfVO boardConfVO) {

    	if(boardConfVO.getCtgNms() != null ){
    	     String[] ctgNms = boardConfVO.getCtgNms();
            
             if(Validate.isNotEmpty(ctgNms) && (ctgNms.length != 0)) {
                BoardCtgVO boardCtgVO = new BoardCtgVO();
                boardCtgVO.setBbsCd(boardConfVO.getBbsCd());
                boardCtgVO.setDomainCd(boardConfVO.getDomainCd());
                
                if("Y".equals(boardConfVO.getCtgYn())) {
                    
                    //FAQ게시판(2Depth 사용)
                    if(boardConfVO.getBbsCd() == 1002 ){
                        delete("_boardconf.boardAditCtgDeleteAll", boardCtgVO);
                    }
                    
                    delete("_boardconf.boardCtgDeleteAll", boardCtgVO);
    
                    int ctgOrderNo = 1;
                    int count = 0;
                    
                    for(int i = 0 ; i < ctgNms.length ; i++) {
                        if(Validate.isNotEmpty(ctgNms[i].trim())) {
                        boardCtgVO.setCtgNm(StringUtil.trim(ctgNms[i].trim()));
                        boardCtgVO.setCtgOrdrNo(ctgOrderNo++);
                        update("_boardconf.boardCtgInsert", boardCtgVO);
                        
                        //FAQ게시판(2Depth 사용)
                        if(boardConfVO.getBbsCd() == 1002 ){
                        	int ctgCd= (Integer) selectByPk("_boardconf.ctgCdSelect", boardConfVO);
                            boardCtgVO.setCtgCd(ctgCd);
                                                                
                            String adit = "";
                            for(int j = 0 ; j < boardConfVO.getAditCtgNms().length ; j++) {
                                adit += boardConfVO.getAditCtgNms()[j];
                                adit += ",";
                            }
                            
                            String[] aditCtgNms = adit.split("/");
                            String[] aditCtgNm = aditCtgNms[count].split(",");
                            
                            int aditCtgOrderNo = 1;
                            for(String aditCtg : aditCtgNm){
                                if(Validate.isNotEmpty(aditCtg.trim())) {
                                boardCtgVO.setCtgNm(StringUtil.trim(aditCtg));
                                boardCtgVO.setCtgOrdrNo(aditCtgOrderNo++);
                                update("_boardconf.boardAditCtgInsert", boardCtgVO);
                                }
                            }
                            
                            count++;
                            }
                         }
                    }
                }
            }
        }
    }

    /**
     * 게시판 칼럼별 사용여부 수정 액션
     */
    public int updateAction(BoardConfYnVO boardConfYnVO) {
        int affected = 0;
        
        if(StringUtil.ZERO == boardConfYnVO.getGubunCd()) {
            boardConfYnVO.setUpdtDt(DateFormatUtil.getToday());
            affected = update("_boardconf.boardConfYnUpdate", boardConfYnVO);
        } else if(BoardConfConstant.GUBUN_CD_GLOBAL == boardConfYnVO.getGubunCd()) {
            affected = update("_boardconf.boardConfGlobalYnUpdate", boardConfYnVO);
        } else if(BoardConfConstant.GUBUN_CD_LIST == boardConfYnVO.getGubunCd()) {
            affected = update("_boardconf.boardConfListYnUpdate", boardConfYnVO);
        } else if(BoardConfConstant.GUBUN_CD_VIEW == boardConfYnVO.getGubunCd()) {
            affected = update("_boardconf.boardConfViewYnUpdate", boardConfYnVO);
        } else if(BoardConfConstant.GUBUN_CD_FORM == boardConfYnVO.getGubunCd()) {
            affected = update("_boardconf.boardConfFormYnUpdate", boardConfYnVO);
        }

        // 게시판 캐쉬를 리로드 합니다.
        if(affected > 0) {
            reloadBbsCache();
        }

        return affected;
    }

    /**
     * 게시판 목록/상세 배치 수정 액션
     */
    public int arrangeUpdateAction(BoardArrangeVO boardArrangeVO ,HttpServletRequest request) throws  Exception {
        
        int affexted = 0, orderNo = 0;

        Integer domainCd = boardArrangeVO.getDomainCd();

        // 기존 표시항목 목록 삭제
        delete("_boardconf.boardConfArrangeDelete", boardArrangeVO);

        List<FileVO> fileList = fileDao.getFiles(fileDao.saveFile(UploadHelper.upload(request, "boardConfArrange")));
        Workbook workbook = null;
        Sheet sheet = null;

        // 표시항목 등록
        String[] columns = boardArrangeVO.getDisplayColumns();
        for(String column : columns) {
            
            for(FileVO file : fileList) {
                
            WorkbookSettings ws = new WorkbookSettings(); 
            ws.setEncoding("Cp1252"); 
                
            workbook = Workbook.getWorkbook(new File(GlobalConfig.UPLOAD_ROOT + file.getFileUrl()),ws);
            sheet = workbook.getSheet(0);
            
            int rowCount = sheet.getRows();
            int colCount = sheet.getColumns();
            
            
            if(rowCount <= 1) return 0;
            
            String content = null;
            
            // 엑셀데이터를 배열에 저장
            for(int i = 1 ; i < rowCount ; i++) {
                BoardArrangeVO arrangeVO = new BoardArrangeVO();
                for(int k = 0 ; k < colCount ; k++) {
                
                    Cell cell = sheet.getCell(k, i); // 해당 위치의 셀을 가져옴 
                    content = (cell != null) ? cell.getContents() : "";
                    
                    switch(k) {
                        case 0:
                            if(domainCd == Integer.parseInt(content.trim())) arrangeVO.setDomainCd(Integer.valueOf(content.trim()));
                            break;
                        case 1:
                            if(domainCd == arrangeVO.getDomainCd()) arrangeVO.setColumnId(content.trim());
                            break;
                        case 2:
                            if(domainCd == arrangeVO.getDomainCd()){
                                if(arrangeVO.getColumnId().equals(column.trim())){
                                    
                                    arrangeVO.setLangColumnNm(content.trim());
                                    arrangeVO.setBbsCd(boardArrangeVO.getBbsCd());
                                    arrangeVO.setListViewSe(boardArrangeVO.getListViewSe());
                                    arrangeVO.setArrangeOrdrNo(++orderNo);
                                    arrangeVO.setBeanNm(StringUtil.camelCase(column));
                                }
                            }
                            break;
                    }
                    
                    if(Validate.isNotEmpty(arrangeVO.getBbsCd())  && Validate.isNotEmpty(arrangeVO.getDomainCd()) && Validate.isNotEmpty(arrangeVO.getLangColumnNm())) {
                        affexted += update("_boardconf.boardConfArrangeInsert", arrangeVO);
                    }
                }
            }
            
            try { if(workbook != null) workbook.close();
            } catch (Exception e) {e.printStackTrace();}
            
            }
        }

        // 게시판 캐쉬를 리로드 합니다.
        reloadBbsCache();
        
        return affexted;
    }

    /**
     * 게시판 삭제 액션
     */
    public int deleteAction(Integer domainCd, String[] bbsCds) {
        int affected = 0;
        int bbsLength = bbsCds.length;

        //for(String bbsCd : bbsCds) {
        for(int i=0; i < bbsLength; i++) {
            BoardConfVO boardConfVo = new BoardConfVO();
            boardConfVo.setDomainCd(domainCd);
            boardConfVo.setBbsCd(Integer.parseInt(bbsCds[i]));

            delete("_boardconf.boardArrangeDelete", boardConfVo);
            delete("_boardconf.boardAuthDelete", boardConfVo);
            delete("_boardconf.boardExtensionDelete", boardConfVo);
            delete("_boardconf.boardFormDelete", boardConfVo);
            delete("_boardconf.boardGlobalDelete", boardConfVo);
            delete("_boardconf.boardListDelete", boardConfVo);
            delete("_boardconf.boardViewDelete", boardConfVo);
            delete("_boardconf.boardCtgsDelete", boardConfVo);
            delete("_boardconf.boardTagDelete", boardConfVo);
            delete("_boardconf.boardCmtDelete", boardConfVo);
            delete("_boardconf.boardDelete", boardConfVo);

            affected += delete("_boardconf.boardConfDelete", boardConfVo);
        }

        // 게시판 캐쉬를 리로드 합니다.
        if(affected > 0) {
            reloadBbsCache();
        }

        return affected;
    }

    /**
     * 삭제
     */
    public Integer boardConfDelete(BoardConfVO boardConfVO) {

        int affected = 0;

        delete("_boardconf.boardArrangeDelete", boardConfVO);
//        delete("_boardconf.boardAuthDelete", boardConfVO);
        delete("_boardconf.boardExtensionDelete", boardConfVO);
        delete("_boardconf.boardFormDelete", boardConfVO);
        delete("_boardconf.boardGlobalDelete", boardConfVO);
        delete("_boardconf.boardListDelete", boardConfVO);
        delete("_boardconf.boardViewDelete", boardConfVO);
        delete("_boardconf.boardCtgsDelete", boardConfVO);
        delete("_boardconf.boardTagDelete", boardConfVO);
        delete("_boardconf.boardCmtDelete", boardConfVO);
        delete("_boardconf.boardDelete", boardConfVO);

        affected += delete("_boardconf.boardConfDelete", boardConfVO);

        // 게시판 캐쉬를 리로드 합니다.
        if(affected > 0) {
            reloadBbsCache();
        }

        return affected;
    }

    /**
     * 게시판 복사 액션
     */
    public Object copyAction(String domainCd, String oldBbsCd, String newBbsNm, String newBbsDesc) {
        Map<String, String> parameterMap = new HashMap<String, String>(2);
        
        parameterMap.put("domainCd", domainCd);
        parameterMap.put("oldBbsCd", oldBbsCd);
        parameterMap.put("newBbsNm", newBbsNm);
        parameterMap.put("newBbsDesc", newBbsDesc);

        insert("_boardconf.boardCopyInsert", parameterMap);

        Object newBbsCd = parameterMap.get("bbsCd");

        if(newBbsCd != null) {
            parameterMap.put("newBbsCd", newBbsCd.toString());
            insert("_boardconf.boardCopyFormInsert", parameterMap);
            insert("_boardconf.boardCopyGlobalInsert", parameterMap);
            insert("_boardconf.boardCopyListInsert", parameterMap);
            insert("_boardconf.boardCopyViewInsert", parameterMap);
            insert("_boardconf.boardCopyCtgInsert", parameterMap);
            insert("_boardconf.boardCopyArrangeInsert", parameterMap);
            insert("_boardconf.boardCopyExtensionInsert", parameterMap);
        }

        // 게시판 캐쉬를 리로드 합니다.
        reloadBbsCache();

        return newBbsCd;
    }

    /**
     * 게시판 복사 액션
     */
    public int extCopyAction(Integer oldBbsCd) {
        int copyCnt = 0;
        Map<String, Integer> parameterMap = new HashMap<String, Integer>(2);

        List<BoardConfVO> confList = boardConfList();

        for(BoardConfVO boardConf : confList) {
            try {
                parameterMap.put("oldBbsCd", oldBbsCd);
                parameterMap.put("newBbsCd", boardConf.getBbsCd());

                insert("_boardconf.boardCopyExtensionInsert", parameterMap);

                copyCnt++;
            } catch (Exception e) {
                if(logger.isDebugEnabled()) {
                    logger.debug("board copy failed", e);
                }
            }
        }

        return copyCnt;
    }

    /**
     * 게시판 설정 정보를 리로드 합니다.
     */
    public void reloadBbsCache() {
        CacheHelper.cacheReload("BoardConfCache", getSqlSession());
    }

    /* ------------------------------ 2014. 9. 20 추가 ------------------------------*/
    
    /**
     * 도메인별 게시판 유형 목록 불러오기
     * @param boardConfVO
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List boardTypeList(BoardConfVO boardConfVO) {
        
        Map<String, Object> map = boardConfVO.getDataMap();
        
        List dataList = list("_boardconf.getBoardTypeList", map);
        
        return dataList;
    }

}
