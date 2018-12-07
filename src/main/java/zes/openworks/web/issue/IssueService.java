package zes.openworks.web.issue;

import java.util.List;

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
public interface IssueService {

    // 이슈목록
    List<IssueVO> getIssueList(IssueVO vo);

    // 핫메뉴 목록
    List<IssueVO> getHotmenuList(IssueVO vo);

}
