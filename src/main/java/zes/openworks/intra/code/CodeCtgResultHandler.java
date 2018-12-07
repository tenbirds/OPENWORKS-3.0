package zes.openworks.intra.code;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

/**
 * 코드 카테고리 맵핑 목록 RowHandler
 * 
 * @author wisepms
 * @version $Id: CodeCtgRowHandler.java 50 2011-07-17 04:15:3Z oworks $
 */
public class CodeCtgResultHandler implements ResultHandler {

    private List<String> list;

    public CodeCtgResultHandler() {
        list = new ArrayList<String>();
    }

    public List<String> getList() {

        return list;
    }

    @Override
    public void handleResult(ResultContext context) {

        CodeCtgVO dataVo = (CodeCtgVO) context.getResultObject();

        String ctgCd = dataVo.getCtgCd();
        String[] prvNms = dataVo.getPrvCds();

        String result = "<tr><th>" + ctgCd + "</th><td>";
        for(int i = 0 ; i < prvNms.length ; i++) {
            String prvNm = prvNms[i];
            result += prvNm;
            if(i < prvNms.length - 1) {
                result += ", ";
            }
        }
        result += "</td></tr>";

        list.add(result);
    }
}
