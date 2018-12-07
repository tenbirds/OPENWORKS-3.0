package zes.openworks.web.sale.bizMatching;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.board.BoardVO;


public interface WebBizMatchingService {

    /**
     * myBizBoardList 설명
     * @param bizMatchingVO
     * @return
     */
    Pager<BoardVO> myBizBoardList(BoardVO boardVO);

    /**
     * newBizBoardList 설명
     * @param boardVO
     * @return
     */
    List<BoardVO> newBizBoardList(BoardVO boardVO);

    /**
     * categoryList 설명
     * @param boardVO
     * @return
     */
    List<BoardVO> categoryList(BoardVO boardVO);

    /**
     * categoryInsert 설명
     * @param boardVO
     * @return
     */
    Boolean categoryInsert(BoardVO boardVO);
}
