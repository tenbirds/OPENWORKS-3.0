package zes.openworks.web.wish;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.Messages;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.login.UserLoginVO;
/**
 *
 * @Class Name : WikiController
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 * @Description : 씨앗마켓 위키 공통 Controller
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       	      수정자   	         수정내용
 *--------------    ----------    -------------------------------
 * 2016. 01. 04.    (주)엔키소프트      신규
 * @see
 */


@Controller
@RequestMapping(value = "/**/store")
public class WishOrderController extends GeneralController {

    @Autowired
    WishOrderService service;
 
    @RequestMapping(value = "/ND_WishOrder.do",  method = RequestMethod.POST)
    public String ND_WhishOrder(HttpServletRequest request, ModelMap model, WishOrderVO vo) {
       
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }       
        
        vo.setUserId(userLoginVo.getUserId());        
        if(service.orderInsert(vo) == StringUtil.ONE) {            
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "wishOk"));
        }
        
       return responseJson(model, Messages.FALSE, "wishFail");
    }
    
    
    @RequestMapping(value = "/ND_WishInfor.do",  method = RequestMethod.POST)
    public String ND_WishInfor(HttpServletRequest request, ModelMap model, WishOrderVO vo) {
       
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }       
        
        vo.setUserId(userLoginVo.getUserId());        
        if(service.wishInforInsert(vo) == StringUtil.ONE) {            
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "wishOk"));
        }
        
       return responseJson(model, Messages.FALSE, "wishFail");
    }
    
}
