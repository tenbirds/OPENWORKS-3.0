package zes.openworks.intra.poll;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * <pre>
 * 설문관리 서비스 객체
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 12.
 * @version $Id: PollServiceImpl.java 2010. 3. 12. yesno $
 */
@Service("pollService")
public class PollServiceImpl extends AbstractServiceImpl implements PollService {

    @Resource
    private PollDAO pollDAO;

    /**
     * 도메인 코드 조회
     */
    @Override
    public PollDomainVO getDomain(String domainCd) {
        return pollDAO.getDomain(domainCd);
    }

    /**
     * 도메인 목록 조회
     */
    @Override
    public List<PollDomainVO> getDomainList(PollDomainVO pollDomainVo) {

        return pollDAO.getDomainList(pollDomainVo);
    }

    /**
     * 기본목록 조회
     */
    @Override
    public Pager<PollVO> pollList(PollVO pollVo) {
        return pollDAO.pollList(pollVo);
    }

    /**
     * 기본정보조회
     */
    @Override
    public PollVO pollView(PollVO pollVo) {
        return pollDAO.pollView(pollVo);
    }

    /**
     * 기본정보등록
     */
    @Override
    public Integer pollInsertAction(PollVO pollVo) {
        return pollDAO.pollInsertAction(pollVo);
    }

    /**
     * 기본정보 수정
     */
    @Override
    public int pollUpdateAction(PollVO pollVo) {
        return pollDAO.pollUpdateAction(pollVo);
    }

    /**
     * 설문삭제(자식정보 모두 삭제)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int pollDeleteAction(PollVO pollVo) {
        return pollDAO.pollDeleteAction(pollVo);
    }

    /**
     * 그룹목록 조회
     */
    @Override
    public List<PollGroupVO> pollGroupList(PollVO pollVo) {
        return pollDAO.pollGroupList(pollVo);
    }

    /**
     * 그룹정보 등록
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Integer pollGroupInsertAction(PollGroupVO pollGroupVo) {
        return pollDAO.pollGroupInsertAction(pollGroupVo);
    }

    /**
     * 그룹정보 수정(설문항목 포함)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int pollGroupUpdateAction(PollGroupVO pollGroupVo) {
        return pollDAO.pollGroupUpdateAction(pollGroupVo);
    }

    /**
     * 그룹정보 삭제(하위 항목 포함)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int pollGroupDeleteAction(PollGroupVO pollGroupVo) {
        return pollDAO.pollGroupDeleteAction(pollGroupVo);
    }

    /**
     * 선택형 항목중 기타의견과 단답형 목록 조회
     */
    @Override
    public Pager<PollGroupVO> pollCommentList(PollGroupVO pollGroupVo) {
        return pollDAO.pollCommentList(pollGroupVo);
    }

    /**
     * 설문등록자 정보 조회(중복 등록 체크 시에도 사용)
     */
    @Override
    public List<PollResponseVO> pollResponseList(PollResponseVO pollResponseVo) {
        return pollDAO.pollResponseList(pollResponseVo);
    }

}
