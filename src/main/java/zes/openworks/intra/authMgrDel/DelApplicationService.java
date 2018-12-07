package zes.openworks.intra.authMgrDel;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.openworks.intra.authMgrAdd.AddApplicationVO;

public interface DelApplicationService {

    AddApplicationVO applicant(AddApplicationVO vo);

    List<AddApplicationVO> currentlyList(AddApplicationVO vo);

    List<AddApplicationVO> currentlyList2(AddApplicationVO vo);

    int insert(AddApplicationVO vo, HttpServletRequest request);

}
