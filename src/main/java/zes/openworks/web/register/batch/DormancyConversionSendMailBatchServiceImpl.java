package zes.openworks.web.register.batch;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 * 수정일        수정자      수정내용
 * ----------    --------    -------------------------------
 * 2015-11-10    이창환      신규
 *</pre>
 * @see
 */

@Service("dormancyConversionSendMailBatchService")
public class DormancyConversionSendMailBatchServiceImpl extends AbstractServiceImpl implements DormancyConversionSendMailBatchService {

    @Resource
    private DormancyConversionSendMailBatchDao dao;

    @Override
    public void dormancyConversionSendMail(){
        dao.dormancyConversionSendMail();
    }

    @Override
    public void dormancyConversion(){
        dao.dormancyConversion();
    }
}
