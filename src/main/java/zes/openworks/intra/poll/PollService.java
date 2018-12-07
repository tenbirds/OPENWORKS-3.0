package zes.openworks.intra.poll;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import zes.base.pager.Pager;

/**
 * <pre>
 * 설문관리 서비스 객체
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 12.
 * @version $Id: PollService.java 2010. 3. 12. yesno $
 */
public interface PollService {

    /**
     * 도메인 코드 조회
     */
    PollDomainVO getDomain(String domainCd);

    /**
     * 도메인 목록 조회
     */
    List<PollDomainVO> getDomainList(PollDomainVO pollDomainVo);

    /**
     * 기본목록 조회
     */
    Pager<PollVO> pollList(PollVO pollVo);

    /**
     * 기본정보조회
     */
    PollVO pollView(PollVO pollVo);

    /**
     * 기본정보등록
     */
    Integer pollInsertAction(PollVO pollVo);

    /**
     * 기본정보 수정
     */
    int pollUpdateAction(PollVO pollVo);

    /**
     * 설문삭제(자식정보 모두 삭제)
     */
    @Transactional(rollbackFor = Exception.class)
    int pollDeleteAction(PollVO pollVo);

    /**
     * 그룹목록 조회
     */
    List<PollGroupVO> pollGroupList(PollVO pollVo);

    /**
     * 그룹정보 등록
     */
    @Transactional(rollbackFor = Exception.class)
    Integer pollGroupInsertAction(PollGroupVO pollGroupVo);

    /**
     * 그룹정보 수정(설문항목 포함)
     */
    @Transactional(rollbackFor = Exception.class)
    int pollGroupUpdateAction(PollGroupVO pollGroupVo);

    /**
     * 그룹정보 삭제(하위 항목 포함)
     */
    @Transactional(rollbackFor = Exception.class)
    int pollGroupDeleteAction(PollGroupVO pollGroupVo);

    /**
     * 선택형 항목중 기타의견과 단답형 목록 조회
     */
    Pager<PollGroupVO> pollCommentList(PollGroupVO pollGroupVo);

    /**
     * 설문등록자 정보 조회(중복 등록 체크 시에도 사용)
     */
    List<PollResponseVO> pollResponseList(PollResponseVO pollResponseVo);

}
