package zes.openworks.web.issue;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
 *  2013. 5. 8.    neteran   신규 생성
 * </pre>
 * @see
 */
@Repository
public class IssueDAO extends EgovAbstractMapper {

    @SuppressWarnings("unchecked")
    public List<IssueVO> getIssueList(IssueVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("rowNum", IssueConstant.RECENT_ARTICLE_COUNT); // 목록
                                                                        // 가져올
                                                                        // 갯수

        List<IssueVO> dataList = list("_issue.issueList", parameterMap);

        return dataList;
    }

    @SuppressWarnings("unchecked")
    public List<IssueVO> getgetHotmenuList(IssueVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("rowNum", IssueConstant.RECENT_ARTICLE_COUNT); // 목록
                                                                        // 가져올
                                                                        // 갯수

        List<IssueVO> dataList = list("_issue.hotMenuList", parameterMap);

        return dataList;
    }

}
