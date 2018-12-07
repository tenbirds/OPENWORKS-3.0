package zes.openworks.intra.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.auth.AuthMenuVO;

@Service("helpService")
public class HelpServiceImpl implements HelpService {

    @Autowired
    HelpDAO dao;

    @Override
    public Pager<HelpVO> getHelpList(HelpVO vo) {
        return dao.getHelpList(vo);
    }

    @Override
    public List<AuthMenuVO> getMenuList() {
        return dao.getMenuList();
    }

    @Override
    public int saveHelpItem(HelpVO vo) {

        return dao.saveHelp(vo);
    }

    @Override
    public int deleteHelpItem(HelpVO vo) {

        return dao.deleteHelp(vo);
    }
}
