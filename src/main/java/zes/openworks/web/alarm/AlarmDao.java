package zes.openworks.web.alarm;

import java.util.List;

import org.springframework.stereotype.Repository;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.7)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 12. 28.    sa   신규 생성
 * </pre>
 * @see
 */


@Repository
public class AlarmDao extends EgovAbstractMapper {

    @SuppressWarnings("unchecked")
    public List<AlarmVO> alarmList(AlarmVO vo) {
        return list("_alarm.alarmList", vo);
    }

    
    public int alarmInsert(AlarmVO vo) {
        return insert("_alarm.alarmInsert", vo);
    }
    
    public int alarmUpdate(AlarmVO vo) {
        return update("_alarm.alarmUpdate", vo);
    }
    
}
