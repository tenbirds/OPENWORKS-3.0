package zes.openworks.web.poll;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * <pre>
 * 설문관리 서비스 객체
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 12.
 * @version $Id: WebPollServiceImpl.java 2010. 3. 12. yesno $
 */
@Service("webPollService")
public class WebPollServiceImpl extends AbstractServiceImpl implements WebPollService {

    @Resource
    private WebPollDAO webPollDao;

    /**
     * 도메인 명으로 도메인 코드 조회
     */
    @Override
    public WebPollDomainVO getDomain(String domainName) {
        return webPollDao.getDomain(domainName);
    }

    /**
     * 도메인 목록 조회
     */
    @Override
    public List<WebPollDomainVO> getDomainList() {
        return webPollDao.getDomainList();
    }

    /**
     * 기본목록 조회
     */
    @Override
    public Pager<WebPollVO> pollList(WebPollVO pollVo) {
        return webPollDao.pollList(pollVo);
    }

    /**
     * 베너로 설정된 설문 목록 조회(최대 5건).
     */
    @Override
    public List<WebPollVO> pollBannerList(WebPollVO pollVo) {
        return webPollDao.pollBannerList(pollVo);
    }

    /**
     * 기본정보조회
     */
    @Override
    public WebPollVO pollView(WebPollVO pollVo) {
        return webPollDao.pollView(pollVo);
    }

    /**
     * 그룹목록 조회
     */
    @Override
    public List<WebPollGroupVO> pollGroupList(WebPollVO pollVo) {
        return webPollDao.pollGroupList(pollVo);
    }

    /**
     * 선택형 항목중 기타의견과 단답형 목록 조회
     */
    @Override
    public Pager<WebPollGroupVO> pollCommentList(WebPollGroupVO pollGroupVO) {
        return webPollDao.pollCommentList(pollGroupVO);
    }

    /**
     * 설문등록자 정보 조회(중복 등록 체크 시에도 사용)
     */
    @Override
    public List<WebPollResponseVO> pollResponseList(WebPollResponseVO pollResponseVo) {
        return webPollDao.pollResponseList(pollResponseVo);
    }

    /**
     * 설문 그룹 유효성 체크를 위한 목록
     */
    @Override
    public List<WebPollGroupVO> pollValidList(WebPollVO pollVo) {
        return webPollDao.pollValidList(pollVo);
    }

    /**
     * 설문 응답 등록
     */
    @Override
    public int pollResponse(Map<String, Object> itemMap) {
        return webPollDao.pollResponse(itemMap);
    }

}
