package zes.openworks.component.cache;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainVO;

/**
 * 케시 새로 읽기
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 18.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/component/cache")
public class CacheReloadController extends IntraController {

    @Autowired
    CacheReloadService cacheReloadService;

    /**
     * Cache 리로드 폼
     * 
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_Index.do", method = RequestMethod.GET)
    public void index(HttpServletRequest request, ModelMap model) throws Exception {

        DomainVO domainVo = new DomainVO();
        List<DomainVO> domainList = cacheReloadService.getDomainList(domainVo);

        model.addAttribute(GlobalConfig.KEY_BASE_LIST, domainList);
    }

    /**
     * Cache 리로드
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_ReloadAction.do", method = RequestMethod.POST)
    public String reloadCache(HttpServletRequest request, ModelMap model, CacheReloadVO cacheReloadVO) throws Exception {

        cacheReloadService.synchronize(cacheReloadVO);

        return responseJson(model, Boolean.TRUE, Messages.COMMON_PROCESS_OK);
    }

}
