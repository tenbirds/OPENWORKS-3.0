package zes.openworks.intra.help;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.auth.AuthMenuVO;

public interface HelpService {

    Pager<HelpVO> getHelpList(HelpVO vo);

    int saveHelpItem(HelpVO vo);

    int deleteHelpItem(HelpVO vo);

    List<AuthMenuVO> getMenuList();
}
