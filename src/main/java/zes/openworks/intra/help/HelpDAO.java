package zes.openworks.intra.help;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.openworks.intra.auth.AuthMenuVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class HelpDAO extends EgovAbstractMapper {

    @SuppressWarnings("unchecked")
    public Pager<HelpVO> getHelpList(HelpVO vo) {
        Map<String, Object> parameterMap = vo.getDataMap();

        List<HelpVO> dataList = list("_help.helpList", parameterMap);
        vo.setTotalNum((Integer) selectByPk("_help.helpListCount", parameterMap));

        return new Pager<HelpVO>(dataList, vo);
    }

    @SuppressWarnings("unchecked")
    public List<AuthMenuVO> getMenuList() {

        List<AuthMenuVO> dataList = list("_auth.menuAllList", null);

        return dataList;
    }

    public int saveHelp(HelpVO vo) {

        return insert("_help.saveHelp", vo);
    }

    public int deleteHelp(HelpVO vo) {

        return update("_help.deleteHelp", vo);
    }
}
