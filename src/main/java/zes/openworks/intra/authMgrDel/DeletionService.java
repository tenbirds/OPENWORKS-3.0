package zes.openworks.intra.authMgrDel;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.openworks.intra.authMgrAdd.AdditionalVO;

public interface DeletionService {

    List<AdditionalVO> delList(AdditionalVO vo, HttpServletRequest request);

    List<AdditionalVO> delList2(AdditionalVO vo, HttpServletRequest request);

    int delete(AdditionalVO vo, HttpServletRequest request);

}
