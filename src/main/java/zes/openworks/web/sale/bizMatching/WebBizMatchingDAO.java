package zes.openworks.web.sale.bizMatching;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.bind.VoBinder;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.board.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class WebBizMatchingDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * myBizBoardList 설명
     * @param bizMatchingVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<BoardVO> myBizBoardList(BoardVO boardVO) {
        
        Map<String, Object> parameterMap = boardVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardVO);
        int listTotalCount = ((Integer) (selectByPk("_webBiz.boardListCount", parameterMap))).intValue();
        
        parameterMap.put(
            "pagingEndNum",
            Pager.getEndNum(Integer.parseInt(parameterMap.get("pagingStartNum").toString()),
                Integer.parseInt(parameterMap.get("q_rowPerPage").toString())));
        
        List<BoardVO> dataList = list("_webBiz.boardList", parameterMap);
        
        boardVO.setTotalNum(listTotalCount);

        return new Pager<BoardVO>(dataList, boardVO);
    }

    /**
     * newBizBoardList 설명
     * @param boardVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> newBizBoardList(BoardVO boardVO) {
        
        Map<String, Object> parameterMap = boardVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardVO);
        
        parameterMap.put("rowNum", 4);
        
        List<BoardVO> dataList = list("_webBiz.boardRecentList", parameterMap);
        
        
        return dataList;
    }

    /**
     * 비즈매칭 알림설정 목록 조회 
     * @param boardVO
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardVO> categoryList(BoardVO boardVO) {
        
        Map<String, Object> parameterMap = boardVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardVO);
        
        List<BoardVO> dataList = list("_webBiz.categoryList", parameterMap);
        
        return dataList;
    }

    /**
     * categoryInsert 설명
     * @param boardVO
     * @return
     */
    public Boolean categoryInsert(BoardVO boardVO) {
        boolean result = true;

        delete("_webBiz.userCategoryDelete", boardVO);
        
        if(Validate.isNotEmpty(boardVO.getCtgryCodes())){
            for(String ctgryCode : boardVO.getCtgryCodes()){
                boardVO.setCtgryCode(ctgryCode);
                insert("_webBiz.userCategoryInsert", boardVO); // 관심카테고리 추가
                
            }
        }else{
            result = false; 
        }
        
        return result;
    }

}
