package zes.openworks.common.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import zes.core.spi.oscache.Cache;
import zes.core.spi.oscache.ICache;
import zes.core.utils.StringUtil;
import zes.openworks.intra.boardconf.BoardArrangeVO;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.intra.boardconf.BoardCtgVO;
import zes.openworks.intra.boardconf.BoardExtensionVO;

public class BoardConfCache implements ICache {

    public static final String CACHE_KEY = "__bbsList";
    public static final String BBS_CD_KEY = "__bbsCd";

    @Override
    public void createCache(SqlSession sqlSession) {

    	Map<String, Object> paramMap = new HashMap<String, Object>();

        List<BoardConfVO> boardConfList = sqlSession.selectList("_cache.board.boardConfList");

        Cache.put(CACHE_KEY, boardConfList);

        for(BoardConfVO boardConfVO : boardConfList) {
            BoardConfVO _boardConfVO = (BoardConfVO) sqlSession.selectOne("_cache.board.boardConfView", boardConfVO);

            if(_boardConfVO == null) {
                continue;
            }

            if("Y".equals(_boardConfVO.getCtgYn())) {
                List<BoardCtgVO> ctgList = sqlSession.selectList("_cache.board.boardCtgList", boardConfVO);
                _boardConfVO.setCtgList(ctgList);
            }
            List<BoardArrangeVO> listArrange = sqlSession.selectList("_cache.board.boardListArrange", boardConfVO);
            _boardConfVO.setListArrange(listArrange);

            List<BoardArrangeVO> viewArrange = sqlSession.selectList("_cache.board.boardViewArrange", boardConfVO);
            _boardConfVO.setViewArrange(viewArrange);

            List<BoardExtensionVO> extVoList;
            paramMap.put("bbsCd", _boardConfVO.getBbsCd());
            paramMap.put("domainCd", _boardConfVO.getDomainCd());

            // 검색 시 확장 항목
            paramMap.put("searchCndYn", "Y");
            extVoList = sqlSession.selectList("_cache.board.boardExtensionList", paramMap);
            for(BoardExtensionVO extVO : extVoList) {
                extVO.setBeanName(StringUtil.camelCase(extVO.getColumnId()));
            }
            _boardConfVO.setSearchColunms(extVoList);

            // 등록 시 확장 항목
            paramMap.put("searchCndYn", "");
            extVoList = sqlSession.selectList("_cache.board.boardExtensionList", paramMap);
            for(BoardExtensionVO extVO : extVoList) {
                extVO.setBeanName(StringUtil.camelCase(extVO.getColumnId()));
            }
            _boardConfVO.setFormColunms(extVoList);

            // 검색시 서비스 항목

            if(_boardConfVO.getDomainCd() == 2){
                paramMap.put("langCode", "00");
            }else if(_boardConfVO.getDomainCd() == 3){
                paramMap.put("langCode", "01");
            }else if(_boardConfVO.getDomainCd() == 4){
                paramMap.put("langCode", "06");
            }

            //서비스목록 조회(검색사용)
            List<BoardConfVO> productList = sqlSession.selectList("_cache.board.productList", paramMap);
            _boardConfVO.setProductList(productList);

            Cache.put(BBS_CD_KEY + "_" + _boardConfVO.getDomainCd() + "_" + _boardConfVO.getBbsCd(), _boardConfVO);
        }
    }

    @Override
    public void reloadCache(SqlSession sqlSession) {
        createCache(sqlSession);
    }

    @Override
    public void reloadCache(SqlSession sqlSession, Integer domainCd) {
        reloadCache(sqlSession);
    }

    @Override
    public String getName() {
        return "게시판 정보";
    }
}
