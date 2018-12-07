package zes.openworks.web.poll;

import java.util.List;
import java.util.Map;

import zes.base.pager.Pager;

/**
 * <pre>
 * 설문관리 서비스 객체
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 12.
 * @version $Id: WebPollService.java 2010. 3. 12. yesno $
 */
public interface WebPollService {

    /**
     * 도메인 명으로 도메인 코드 조회
     */
    WebPollDomainVO getDomain(String domainName);

    /**
     * 도메인 목록 조회
     */
    List<WebPollDomainVO> getDomainList();

    /**
     * 기본목록 조회
     */
    Pager<WebPollVO> pollList(WebPollVO pollVo);

    /**
     * 베너로 설정된 설문 목록 조회(최대 5건).
     */
    List<WebPollVO> pollBannerList(WebPollVO pollVo);

    /**
     * 기본정보조회
     */
    WebPollVO pollView(WebPollVO pollVo);

    /**
     * 그룹목록 조회
     */
    List<WebPollGroupVO> pollGroupList(WebPollVO pollVo);

    /**
     * 선택형 항목중 기타의견과 단답형 목록 조회
     */
    Pager<WebPollGroupVO> pollCommentList(WebPollGroupVO pollGroupVO);

    /**
     * 설문등록자 정보 조회(중복 등록 체크 시에도 사용)
     */
    List<WebPollResponseVO> pollResponseList(WebPollResponseVO pollResponseVo);

    /**
     * 설문 그룹 유효성 체크를 위한 목록
     */
    List<WebPollGroupVO> pollValidList(WebPollVO pollVo);

    /**
     * 설문 응답 등록
     */
    int pollResponse(Map<String, Object> itemMap);

}
