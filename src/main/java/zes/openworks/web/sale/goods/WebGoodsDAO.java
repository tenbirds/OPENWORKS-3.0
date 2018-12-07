package zes.openworks.web.sale.goods;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.intra.store.goods.GoodsSpecDescribeVO;
import zes.openworks.intra.store.goods.GoodsSpecVO;

@Repository
public class WebGoodsDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    private Object langCodes = null;  //언어
    private Object expsrCodes = null; //노출
    private Object crtfcCodes = null; //인증
    private Object statusCodes = null;//상태
    
    /**
     * getCodeNames 그룹코드에 해당하는 코드의 내용을 리스트로 구한다.
     * @param groupcd
     * @param indvdiz_cds
     * @return
     */
    private List<String> getCodeNames(int groupcd, Object indvdiz_cds) 
    {
        if (indvdiz_cds != null) 
        {
            String cds = String.valueOf(indvdiz_cds) ;
            if  (!"".equals(cds))
            {
                Map<String, Object> parameterMap = new HashMap<String, Object>();
                parameterMap.put("groupCd",    groupcd);                             
                parameterMap.put("indvdizCds", cds);           
                
                List<String> termLst = (List<String>)list("_myCeart.opCodeIndvdlzNames", parameterMap);
                
                return termLst;
            }
            else
            {
                return null;
            }
        }
        else
        {
            return null;
        }        
    }
    
    /**
     * getCommanString 리스트의 문자열을 콤머로 연결한다.
     * @param termLst
     * @return
     */
    private String getCommanString(List<String> termLst) 
    {
        if (!Validate.isEmpty(termLst)) 
        {
            StringBuilder commaSepValueBuilder = new StringBuilder();
            for ( int j = 0; j< termLst.size(); j++)
            {
                commaSepValueBuilder.append(termLst.get(j));
               
                if ( j != termLst.size()-1)
                {
                    commaSepValueBuilder.append(",");
                }
            }
    
            return commaSepValueBuilder.toString();
        }
        else
        {
            return null;
        }
    }
    

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<WebGoodsManageVO> goodsList(WebGoodsManageVO vo) {

        //공통 파라메타
        getDataMap(vo);

        vo.setTotalNum((Integer) selectByPk("_webGoods.goodsCount", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<WebGoodsManageVO> dataList = list("_webGoods.goodsList", vo.getDataMap());

        // Map<String, List<FileVO>> setmark = new HashMap<>();
        // List<FileVO>[] goodsMarkImage = new ArrayList<FileVO>();

        for(WebGoodsManageVO data : dataList) {
            // for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if(!Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }

        // 원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        vo.getDataMap().put("q_statusCodes", statusCodes);
        vo.getDataMap().put("q_expsrCodes", expsrCodes);
        vo.getDataMap().put("q_crtfcCodes", crtfcCodes);

        return new Pager<WebGoodsManageVO>(dataList, vo);
    }

    /**
     * 서비스검토대기목록
     * goodsExmntList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<WebGoodsManageVO> goodsExmntList(WebGoodsManageVO vo) {

        //공통 파라메타
        getDataMap(vo);

        vo.setTotalNum((Integer) selectByPk("_webGoods.goodsCount1", vo.getDataMap()));
        if(Validate.isNotEmpty(vo.getDataMap().get("q_excel"))) {
            vo.getDataMap().put("pagingEndNum", vo.getTotalNum());
        }
        List<WebGoodsManageVO> dataList = list("_webGoods.goodsList1", vo.getDataMap());

        for(WebGoodsManageVO data : dataList) {
            // for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if(!Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }

        // 원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        vo.getDataMap().put("q_statusCodes", statusCodes);
        vo.getDataMap().put("q_expsrCodes", expsrCodes);
        vo.getDataMap().put("q_crtfcCodes", crtfcCodes);

        return new Pager<WebGoodsManageVO>(dataList, vo);
    }

    /**
     * 서비스승인대기목록
     * goodsConfnList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<WebGoodsManageVO> goodsConfnList(WebGoodsManageVO vo) {

        //공통 파라메타
        getDataMap(vo);

        vo.getDataMap().put("q_goodsRegistSttus", 1002);

        List<WebGoodsManageVO> dataList = list("_webGoods.goodsList", vo.getDataMap());

        for(WebGoodsManageVO data : dataList) {
            // for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if(!Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }
        vo.setTotalNum((Integer) selectByPk("_webGoods.goodsCount", vo.getDataMap()));

        // 원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        vo.getDataMap().put("q_statusCodes", statusCodes);
        vo.getDataMap().put("q_expsrCodes", expsrCodes);
        vo.getDataMap().put("q_crtfcCodes", crtfcCodes);

        return new Pager<WebGoodsManageVO>(dataList, vo);
    }

    /**
     * 삭제서비스목록
     * goodsDeleteList 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings({ "unchecked" })
    public Pager<WebGoodsManageVO> goodsDeleteList(WebGoodsManageVO vo) {

        //공통 파라메타
        getDataMap(vo);

        List<WebGoodsManageVO> dataList = list("_webGoods.goodsDeleteList", vo.getDataMap());

        for(WebGoodsManageVO data : dataList) {
            // for(int fileSeq : data.getGoodsMarkList()){

            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {

                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));

            }

            if(!Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }

        }
        vo.setTotalNum((Integer) selectByPk("_webGoods.goodsDeleteCount", vo.getDataMap()));

        // 원상복구
        vo.getDataMap().put("q_langCodes", langCodes);
        vo.getDataMap().put("q_statusCodes", statusCodes);
        vo.getDataMap().put("q_expsrCodes", expsrCodes);
        vo.getDataMap().put("q_crtfcCodes", crtfcCodes);

        return new Pager<WebGoodsManageVO>(dataList, vo);
    }

    /**
     * 전시상태 Update 설명
     *
     * @param vo
     * @return int
     */
    @SuppressWarnings({ "unchecked" })
    public int dspyUpdate(WebGoodsManageVO vo) {
        int ret = 0;
        for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
            vo.setGoodsCode(vo.getGoodsCodes()[i]);
            vo.setGoodsStatus(vo.getGoodsStatuss()[i]);
            ret = (Integer) selectByPk("_goodsManage.goodsStatus", vo);
            if (ret == 0) {
                return -1;
            }
        }
        return update("_webGoods.dspyUpdate", vo);
    }
    
    @SuppressWarnings({ "unchecked" })
    public int goodsStatAction(WebGoodsManageVO vo) {
        int ret = 0;
        
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("goodscode",vo.getGoodsCode() );
        
        //goods코드와 goodsnum으로 해당 데이터가 있는 여부, 없으면 insert, 있으면 update판별 쿼리
        int cnt = (Integer)selectByPk("_webGoods.currentGoods", paramMap);                
        int cnt1 = (Integer)selectByPk("_webGoods.currentGoodsSn", paramMap);        
        
        if(cnt1 < 1){ //엑셀로 밀어넣은 자료 때문에 전시/비전시 처리시 해야함
            insert("_webGoods.tstExmnCnfmHInsert", vo);
        }
        
        if(cnt > 0){ //업데이트

                //서비스정보 : 전시에서 비전시 요청시 tmp에 데이터가 있는 경우 삭제하고 다시 insert            
                delete("_webGoods.tstGoodInfoiTmpDelete", paramMap);
                insert("_webGoods.tstGoodInfoiTmpInsert", vo);
        
                
                //규격서정보 : 전시에서 비전시 요청시 tmp에 데이터가 있는 경우 삭제하고 다시 insert            
                delete("_webGoods.toChgItemContentDelete", paramMap);
                insert("_webGoods.toChgItemContentInsert", vo);

              
                delete("_webGoods.tstGoodMarkIDelete", paramMap);
                insert("_webGoods.tstGoodMarkIInsert", vo);

                delete("_webGoods.tstGoodMetaIDelete", paramMap);
                insert("_webGoods.tstGoodMetaIInsert", vo);
                

                
                delete("_webGoods.tstCtfcAtchIDelete", paramMap);
                insert("_webGoods.tstCtfcAtchIInsert", vo);

                delete("_webGoods.tstGoodCateIDelete", paramMap);
                insert("_webGoods.tstGoodCateIInsert", vo);

                delete("_webGoods.tstGoodTagIDelete", paramMap);
                insert("_webGoods.tstGoodTagIInsert", vo);

        
        } else { //인서트
            
                //서비스정보 : 전시에서 비전시 요청시 tmp에 데이터가 있는 경우 삭제하고 다시 insert            
                insert("_webGoods.tstGoodInfoiTmpInsert", vo);
                
                //규격서 : 전시에서 비전시 요청시 관리자에서 승인 할 경우 아래 temp로 데이터 복사
                insert("_webGoods.toChgItemContentInsert", vo);
                
                insert("_webGoods.tstGoodMarkIInsert", vo);

                insert("_webGoods.tstGoodMetaIInsert", vo);

                insert("_webGoods.tstCtfcAtchIInsert", vo);

                insert("_webGoods.tstGoodCateIInsert", vo);

                insert("_webGoods.tstGoodTagIInsert", vo);
        
        }        
        
        
//        for(int i = 0 ; i < vo.getGoodsCodes().length ; i++) {
//            vo.setGoodsCode(vo.getGoodsCodes()[i]);
//            vo.setGoodsStatus(vo.getGoodsStatuss()[i]);
//            ret = (Integer) selectByPk("_goodsManage.goodsStatus", vo);
//            if (ret == 0) {
//                return -1;
//            }
//        }
        
        
        return update("_webGoods.tstGoodInfoiTmpInsertUpdate", paramMap);
    }

    /**
     * langList 서비스 언어 목록
     *
     * @param vo
     * @return
     */
    
    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> langList(WebGoodsManageVO vo) {
        return list("_webGoods.langList", vo);
    }

    /**
     * sttusList 상태 목록
     *
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> sttusList(WebGoodsManageVO vo) {
        return list("_webGoods.sttusList", vo);
    }

    /**
     * ctgryList (카테고리 항목)
     *
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> ctgryList(WebGoodsManageVO vo) {
        return list("_webGoods.ctgryList", vo);
    }

    public WebGoodsManageVO goodsView(WebGoodsManageVO vo) {
        String goodsCode = vo.getGoodsCode();

        WebGoodsManageVO gvo = (WebGoodsManageVO) selectByPk("_webGoods.goodsView", goodsCode);
        // for (Map<String, Object> goodsImage : gvo.getGoodsImage()) {
        //
        // gvo.setImageFile(fileDao.getFiles(Integer.parseInt(String.valueOf(goodsImage.get("GOODSIMAGEFILESEQ")))));
        // }

        if(Validate.isNotEmpty(gvo.getGoodsImageFileSeq())) {
            gvo.setImageFile(fileDao.getFiles(gvo.getGoodsImageFileSeq()));
        }
        if(Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsFileSeq()))) {
            gvo.setGoodsFile(fileDao.getFiles(gvo.getGoodsFileSeq()));
        }
        if(Validate.isNotEmpty(fileDao.getFiles(gvo.getGoodsMnlFileSeq()))) {
            gvo.setMnlFile(fileDao.getFiles(gvo.getGoodsMnlFileSeq()));
        }
        if(Validate.isNotEmpty(fileDao.getFiles(gvo.getMnlDnFileSeq()))) {
            gvo.setDnlFile(fileDao.getFiles(gvo.getMnlDnFileSeq()));
        }
        //기타 첨부파일
        if(Validate.isNotEmpty(fileDao.getFiles(gvo.getEtcFileSeq()))) {
            gvo.setEtcFile(fileDao.getFiles(gvo.getEtcFileSeq()));
        }
        //가격표 첨부파일 <!--{{ BH, 2016.01.13 가격표 파일 추가--!>
        if(Validate.isNotEmpty(fileDao.getFiles(gvo.getPriceDnFileSeq()))) {
            gvo.setPriceFile(fileDao.getFiles(gvo.getPriceDnFileSeq()));
        }
        
        // gvo.setCrtfcSeFileSeq(gvo.getGoodsMark().get(0).get("CRTFCSEFILESEQ"));

        List<List<FileVO>> markCrtfc = new ArrayList<List<FileVO>>();
        for(int i = 0 ; i < gvo.getGoodsMark().size() ; i++) {
            if(gvo.getGoodsMark().get(i).get("CRTFCSEFILESEQ") == null) {
                markCrtfc.add(null);
            } else {
                markCrtfc.add(fileDao.getFiles(Integer.parseInt(String.valueOf(gvo.getGoodsMark().get(i).get("CRTFCSEFILESEQ")))));
            }
        }
        gvo.setMarkCrtfcFile(markCrtfc);

        return gvo;
    }

    /**
     * 태그를 등록한다.
     */
    private int addTags(WebGoodsManageVO vo) {
        int ret = 1;
        /**
         * 메타태그 등록
         */
        int i = 0;
        
        String updateYn = vo.getUpdateYn();
        
        if(Validate.isNotEmpty(vo.getMetaTAGs())) {
            String[] metaTAGs = vo.getMetaTAGs().split(",");
            i = metaTAGs.length;
            vo.setMetaGroupCd(1023);
            vo.setMetaEtcCn("");
            
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);
            } else {
                ret = delete("_webGoods.metaDelete", vo);                
            }
                
            for(String metaCode : metaTAGs) {
                vo.setMetaCode(Integer.valueOf(metaCode));

                
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);                
                }
            }
        }

        if(Validate.isEmpty(vo.getGoodsTags()) || (vo.getGoodsTags().length() == 0)) {
            return ret;
        }

        String[] tags = vo.getGoodsTags().split(",");

        for(String tagNm : tags) {
            tagNm = tagNm.trim();
            if (Validate.isEmpty(tagNm)) {
                continue;
            }

            i++;
            if (i > 10) {
                return ret;
            }
            vo.setGoodsTagNm(tagNm);

            if("update".equals(updateYn)){
                ret = insert("_webGoods.tagInsertTmp", vo);
            } else {
                ret = insert("_webGoods.tagInsert", vo);                
            }
        }
        return ret;
    }

    private int addMetas(GoodsManageVO vo) {
        int ret = 1;

        /**
         * 지원언어 등록
         */
        Integer[] metaLangs = vo.getMetaLangs();
        String metaLangEtc = vo.getMetaLangEtc();
        
        String updateYn = vo.getUpdateYn();
        
        if(Validate.isNotEmpty(metaLangs)) {
            vo.setMetaGroupCd(1019);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            for(Integer metaCode : metaLangs) {
                vo.setMetaCode(metaCode);
                if (metaCode == 1006) {
                    vo.setMetaEtcCn(metaLangEtc);
                } else {
                    vo.setMetaEtcCn("");
                }

                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
            
            }
            vo.setMetaEtcCn("");
        }


//            
//        for(String metaCode : metaTAGs) {
//            vo.setMetaCode(Integer.valueOf(metaCode));
//
//            
//            if("update".equals(updateYn)){
//                ret = insert("_webGoods.metaInsertTmp", vo);
//            } else {
//                ret = insert("_webGoods.metaInsert", vo);                
//            }
//        }        
        
        /**
         * 지원OS 등록
         */
        if(Validate.isNotEmpty(vo.getMetaOSs())) {
            String[] metaOSs = vo.getMetaOSs().split(",");
            String metaOSetc = vo.getMetaOSetc();
            vo.setMetaGroupCd(1020);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);
            } else {
                ret = delete("_webGoods.metaDelete", vo);                
            }

            for(String metaCode : metaOSs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("9001")) {
                    vo.setMetaEtcCn(metaOSetc);
                } else {
                    vo.setMetaEtcCn("");
                }
                
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);                
                }                
            }
            vo.setMetaEtcCn("");
        }
       
        /**
         * 지역 등록
         */
        if(Validate.isNotEmpty(vo.getMetaAreas())) {
            String[] metaASs = vo.getMetaAreas().split(",");
            vo.setMetaGroupCd(2022);
//            ret = delete("_goodsManage.metaDelete", vo);

            if("update".equals(updateYn)){
                ret = delete("_goodsManage.metaDeleteTmp", vo);
            } else {
                ret = delete("_goodsManage.metaDelete", vo);                
            }            
            
            for(String metaCode : metaASs) {
                vo.setMetaCode(Integer.valueOf(metaCode));

                if("update".equals(updateYn)){
                    ret = delete("_goodsManage.metaInsertTmp", vo);
                } else {
                    ret = insert("_goodsManage.metaInsert", vo);                
                }            
            }
        }     
        
        /**
         * 가격등록 
         */
        if(Validate.isNotEmpty(vo.getMetaPrices())) {
            String[] metaASs = vo.getMetaPrices().split(",");
            vo.setMetaGroupCd(2024);
//          ret = delete("_goodsManage.metaDelete", vo);
            if("update".equals(updateYn)){
                ret = delete("_goodsManage.metaDeleteTmp", vo);
            } else {
                ret = delete("_goodsManage.metaDelete", vo);                
            }            
            
            for(String metaCode : metaASs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if("update".equals(updateYn)){
                    ret = delete("_goodsManage.metaInsertTmp", vo);
                } else {
                    ret = insert("_goodsManage.metaInsert", vo);                
                }            
                //ret = insert("_goodsManage.metaInsert", vo);
            }
        }
//}}
        
/*KS : 클라우드 신규 공통코드 추가 {{*/
        /**
         * 무료/체험 구분(2027)
         */
        if(Validate.isNotEmpty(vo.getMetaExprns())) {
            String[] metaExprns = vo.getMetaExprns().split(",");
            vo.setMetaGroupCd(2027);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaExprns) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                //ret = insert("_webGoods.metaInsert", vo);
            }
        }
        /**
         * 계약단위(2028)
         */
        if(Validate.isNotEmpty(vo.getMetaCntrctUnits())) {
            String[] metaCntrctUnits = vo.getMetaCntrctUnits().split(",");
            String metaCntrctUnitetc = vo.getMetaCntrctUnitetc();
            vo.setMetaGroupCd(2028);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }

            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaCntrctUnits) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("1005")) {
                    vo.setMetaEtcCn(metaCntrctUnitetc);
                } else {
                    vo.setMetaEtcCn("");
                }
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                //ret = insert("_webGoods.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }
        /**
         * 무료/체험 구분(2030)
         */
        if(Validate.isNotEmpty(vo.getMetaSvcs())) {
            String[] metaSvcs = vo.getMetaSvcs().split(",");
            vo.setMetaGroupCd(2030);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            
            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaSvcs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                
                //ret = insert("_webGoods.metaInsert", vo);
            }
        }/**
         * 무료/체험 구분(2031)
         */
        if(Validate.isNotEmpty(vo.getMetaStds())) {
            String[] metaStds = vo.getMetaStds().split(",");
            vo.setMetaGroupCd(2031);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaStds) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                
                //ret = insert("_webGoods.metaInsert", vo);
            }
        }/**
         * 무료/체험 구분(2032)
         */
        if(Validate.isNotEmpty(vo.getMetaCnstcMthds())) {
            String[] metaCnstcMthds = vo.getMetaCnstcMthds().split(",");
            vo.setMetaGroupCd(2032);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaCnstcMthds) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                //ret = insert("_webGoods.metaInsert", vo);
            }
        }/**
         * 무료/체험 구분(2033)
         */
        if(Validate.isNotEmpty(vo.getMetaScqcLvs())) {
            String[] metaScqcLvs = vo.getMetaScqcLvs().split(",");
            vo.setMetaGroupCd(2033);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaScqcLvs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                //ret = insert("_webGoods.metaInsert", vo);
            }
        }
/*}}*/
        
        
        /**
         * 지원AS 등록
         */
        if(Validate.isNotEmpty(vo.getMetaASs())) {
            String[] metaASs = vo.getMetaASs().split(",");
            String metaASetc = vo.getMetaASetc();
            vo.setMetaGroupCd(1021);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaASs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("1005") || metaCode.equals("2005")) {
                    vo.setMetaEtcCn(metaASetc);
                } else {
                    vo.setMetaEtcCn("");
                }

                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                //ret = insert("_webGoods.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }

        /**
         * 보유기술 및 자격증 등록
         */
        if(Validate.isNotEmpty(vo.getMetaTECHs())) {
            String[] metaTECHs = vo.getMetaTECHs().split(",");
            String metaTECHetc = vo.getMetaTECHetc();
            vo.setMetaGroupCd(1022);
            if("update".equals(updateYn)){
                ret = delete("_webGoods.metaDeleteTmp", vo);                
            } else {
                ret = delete("_webGoods.metaDelete", vo);
            }
            //ret = delete("_webGoods.metaDelete", vo);
            for(String metaCode : metaTECHs) {
                vo.setMetaCode(Integer.valueOf(metaCode));
                if (metaCode.equals("1002")) {
                    vo.setMetaEtcCn(metaTECHetc);
                } else {
                    vo.setMetaEtcCn("");
                }

                if("update".equals(updateYn)){
                    ret = insert("_webGoods.metaInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.metaInsert", vo);
                }
                
                //ret = insert("_webGoods.metaInsert", vo);
            }
            vo.setMetaEtcCn("");
        }
        
        return ret;
    }

    public int goodsUpdate(WebGoodsManageVO vo, HttpServletRequest request) {
        int ret = 0;

        String updateYn = vo.getUpdateYn();
        
        if("update".equals(updateYn)){
            ret = (Integer) selectByPk("_goodsManage.goodsStatusTmp", vo);
        } else {
            ret = (Integer) selectByPk("_goodsManage.goodsStatus", vo);            
        }
        
        if (ret == 0) {
            return -1;
        }
        
        //vo.getImageMainFile().
        
        String strGoodsCode = vo.getGoodsCode();
        
        int retCnt = (Integer) selectByPk("_webGoods.goodsSelectByPk", vo);
        

        
        if(vo.getImageMainFile().size() > 0) {  //서비스메인이미지 변경 추가
            
            if("imageFile1".equals(vo.getInputNm()) ){ //대표이미지 수정
                vo.setGoodsImageFileSeq(fileDao.saveFileToFirstUpdate(vo.getImageMainFile(), vo.getGoodsImageFileSeq(),vo.getGoodsCode()));
            } else {
                vo.setGoodsImageFileSeq(fileDao.saveFileToFirst(vo.getImageMainFile(), vo.getGoodsImageFileSeq()));                
            }
            
            
            fileDao.updateMainFile(vo.getImageMainFile(), vo.getGoodsImageFileSeq());
        }
        if(vo.getGoodsFile().size() > 0) {
            vo.setGoodsFileSeq(fileDao.saveFile(vo.getGoodsFile(), vo.getGoodsFileSeq()));
        }
        if(vo.getImageFile().size() > 0) {
            vo.setGoodsImageFileSeq(fileDao.saveFile(vo.getImageFile(), vo.getGoodsImageFileSeq()));
        }
        if(vo.getMnlFile().size() > 0) {
            vo.setGoodsMnlFileSeq(fileDao.saveFile(vo.getMnlFile(), vo.getGoodsMnlFileSeq()));
        }       

        if(vo.getDnlFile().size() > 0) {  //사용자 메뉴얼 추가
            
            if (vo.getMnlDnFileSeq() > 0)
            {
                fileDao.removeFile( vo.getMnlDnFileSeq() );
            }
            
            vo.setMnlDnFileSeq(fileDao.saveFile(vo.getDnlFile(), vo.getMnlDnFileSeq()));
        }

        int itemDnFileSeq = Integer.valueOf(vo.getItemDnFileSeq()) ; 
        
        for (int k = 1 ; k <= 4 ; k ++)
        {
            String etcfileInput  = request.getParameter("etcfileInput"+String.valueOf(k));
            String etcfileOrdrNo = request.getParameter("etcfileOrdrNo"+String.valueOf(k));
            
            // 선택된 기타파일을 삭제한경우 ('x'를 눌러서..)
            // 파일명은 없고 OrdrNo부분은 존재하는건은 삭제된 건으로 간주..
            if (Validate.isEmpty(etcfileInput) && !Validate.isEmpty(etcfileOrdrNo)) 
                fileDao.removeFile( itemDnFileSeq, Integer.valueOf(etcfileOrdrNo) );
        }

        if (vo.getEtcFile().size() > 0) //기타첨부파일 추가
        {
            vo.setEtcFileSeq(fileDao.saveFile(vo.getEtcFile(), itemDnFileSeq));
        }
        else
        {
            vo.setEtcFileSeq(itemDnFileSeq);
        }
        

        if(vo.getPriceFile().size() > 0) { //가격표 파일 추가
            
            if (vo.getPriceDnFileSeq() > 0)
            {
                fileDao.removeFile( vo.getPriceDnFileSeq() );
            }
            
            vo.setPriceDnFileSeq(fileDao.saveFile(vo.getPriceFile(), vo.getPriceDnFileSeq()));
        }

        
        ArrayList<Integer> CrtfcSeFileList;
        if(Validate.isNotEmpty(vo.getCrtfcSeFileSeqs())) {
            CrtfcSeFileList = new ArrayList<Integer>(Arrays.asList(vo.getCrtfcSeFileSeqs()));
        } else {
            CrtfcSeFileList = new ArrayList<Integer>();
        }

        int j = 0;
        String strInputNm = "";
        int intCrtfcSeCd = 0;
        int intCrtfcSeCdCount = 0;
        int intCrtfcSeCdGubun = 0;

        if("update".equals(updateYn)){
            intCrtfcSeCdCount = (Integer) selectByPk("_webGoods.markCrtfcFileSeqCountTmp", vo);
        } else {
            intCrtfcSeCdCount = (Integer) selectByPk("_webGoods.markCrtfcFileSeqCount", vo);                
        }
        
        if(intCrtfcSeCdCount  < 1){ //신규
            for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
                j = Integer.parseInt(vo.getMarkCrtfcFile().get(i).get(0).getInputNm().replace("markCrtfcFile", ""));
                
                int aaaa = Validate.isEmpty(CrtfcSeFileList.get(i)) ? -1 : CrtfcSeFileList.get(i);
                
                CrtfcSeFileList.set(i, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), Validate.isEmpty(CrtfcSeFileList.get(i)) ? -1 : CrtfcSeFileList.get(i)));
            }
            
        } else { //수정
            for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
                j = Integer.parseInt(vo.getMarkCrtfcFile().get(i).get(0).getInputNm().replace("markCrtfcFile", ""));
                
                strInputNm = vo.getMarkCrtfcFile().get(i).get(0).getInputNm(); 
                
                
                if("markCrtfcFile0".equals(strInputNm)){   //클라우드서비스보안인증(CSAP)  
                    vo.setCrtfcSeCd(1004);
                } else if("markCrtfcFile1".equals(strInputNm)){ // CC인증
                    vo.setCrtfcSeCd(1001);                
                } else if("markCrtfcFile3".equals(strInputNm)){ //클라우드서비스 품질성능 확인
                    vo.setCrtfcSeCd(1007);                
                }
                
                //수정임에도 불구하고 클라우드서비스보안인증(CSAP), CC인증, 클라우드서비스 품질성능 확인중에 넣지 않은 파일에 대해서 넣고자 한다면 
                //신규이며 수정안에서도 신규인지 아닌지 체크로지 추가
                if("update".equals(updateYn)){
                    intCrtfcSeCdGubun = (Integer) selectByPk("_webGoods.markCrtfcFileSeqGubunTmp", vo);
                } else {
                    intCrtfcSeCdGubun = (Integer) selectByPk("_webGoods.markCrtfcFileSeqGubun", vo);                    
                }
                
                if(intCrtfcSeCdGubun < 1){ //신규
                
//                    CrtfcSeFileList.set(i, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), Validate.isEmpty(CrtfcSeFileList.get(i)) ? -1 : CrtfcSeFileList.get(i)));
                    CrtfcSeFileList.set(i, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), 0));                    

                } else {
                    if("update".equals(updateYn)){
                        intCrtfcSeCd = (Integer) selectByPk("_webGoods.markCrtfcFileSeqTmp", vo);
                    } else {
                        intCrtfcSeCd = (Integer) selectByPk("_webGoods.markCrtfcFileSeq", vo);                
                    }
                
//                      CrtfcSeFileList.set(i, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), Validate.isEmpty(CrtfcSeFileList.get(i)) ? -1 : CrtfcSeFileList.get(i)));
                    CrtfcSeFileList.set(i, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), intCrtfcSeCd) );
                }
                
            }
            
        }
        
        Integer pChk = 0;
        
//        if("update".equals(updateYn)){
//            ret = delete("_webGoods.markTempDelete", vo);
//        } else {
//            ret = delete("_webGoods.markDelete", vo);            
//        }
//        
//        if (Validate.isNotEmpty(vo.getGoodsMarkCds())) {
//            for ( Integer icode : vo.getGoodsMarkCds()) {
//                if (icode == 1001) {
//                    pChk = 1;
//                }
//                vo.setMarkCd(icode);
//
//                if("update".equals(updateYn)){
//                    ret = insert("_webGoods.markTempInsert", vo);
//                } else {
//                    ret = insert("_webGoods.markInsert", vo);            
//                }
//          }
//      }        

        if("Y".equals(vo.getCertMarkCdGubun())){ //ND_goodsActionStep2일때 아래 처리

            if(intCrtfcSeCdCount  < 1){ //신규
                for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
                    
                    strInputNm = vo.getMarkCrtfcFile().get(i).get(0).getInputNm(); 
                    
                    if("markCrtfcFile0".equals(strInputNm)){   //클라우드서비스보안인증(CSAP)  
                        vo.setCrtfcSeCd(1004);
                        vo.setMarkCd(1004);
                        if("update".equals(updateYn)){                        
                            ret = insert("_webGoods.markRegistInserttmp", vo);
                        } else {
                            ret = insert("_webGoods.markRegistInsert", vo);
                        }
                    } else if("markCrtfcFile1".equals(strInputNm)){ // CC인증
                        vo.setCrtfcSeCd(1001);                
                        vo.setMarkCd(1001);
                        if("update".equals(updateYn)){                        
                            ret = insert("_webGoods.markRegistInserttmp", vo);
                        } else {
                            ret = insert("_webGoods.markRegistInsert", vo);
                        }

                    } else if("markCrtfcFile3".equals(strInputNm)){ //클라우드서비스 품질성능 확인
                        vo.setCrtfcSeCd(1007);                
                        vo.setMarkCd(1007);
                        if("update".equals(updateYn)){                        
                            ret = insert("_webGoods.markRegistInserttmp", vo);
                        } else {
                            ret = insert("_webGoods.markRegistInsert", vo);
                        }

                    }
                    
                    vo.setMarkCd(vo.getCrtfcSeCd());
                    if(Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
                        vo.setCrtfcSeFileSeq(CrtfcSeFileList.get(i));
                        if("update".equals(updateYn)){
                            ret = update("_webGoods.crtfcUpdateTmp", vo);
                        } else {
                            ret = update("_webGoods.crtfcUpdate", vo);                        
                        }
                    }
                }
                
//                if("update".equals(updateYn)){
//                
//                    vo.setMarkCd(1004);
//                    ret = insert("_webGoods.markTempMerge", vo);
//                    //int intTstCtfcAtchICount1 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICountTmp", vo);
//                    vo.setMarkCd(1001);
//                    ret = insert("_webGoods.markTempMerge", vo);
//                    //int intTstCtfcAtchICount2 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICountTmp", vo);
//                    vo.setMarkCd(1001);
//                    ret = insert("_webGoods.markTempMerge", vo);
//                } else {
//                    vo.setMarkCd(1004);
//                    //int intTstCtfcAtchICount1 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
//                    ret = insert("_webGoods.markMerge", vo);
//                    vo.setMarkCd(1001);
//                    //int intTstCtfcAtchICount2 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
//                    ret = insert("_webGoods.markMerge", vo);
//                    vo.setMarkCd(1007);
//                    //int intTstCtfcAtchICount3 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
//                    ret = insert("_webGoods.markMerge", vo);            
//                    
//                }
                
    //            if(Validate.isNotEmpty(vo.getMarkCds())) {
    //                for(int i = 0 ; i < vo.getMarkCds().length ; i++) {
    //                    vo.setMarkCd(vo.getMarkCds()[i]);
    //                    if(Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
    //                        vo.setCrtfcSeFileSeq(CrtfcSeFileList.get(i));
    //                        
    //                        for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
    //                            
    //                            strInputNm = vo.getMarkCrtfcFile().get(i).get(0).getInputNm(); 
    //                            
    //                            
    //                            if("markCrtfcFile0".equals(strInputNm)){   //클라우드서비스보안인증(CSAP)  
    //                                vo.setCrtfcSeCd(1004);
    //                            } else if("markCrtfcFile1".equals(strInputNm)){ // CC인증
    //                                vo.setCrtfcSeCd(1001);                
    //                            } else if("markCrtfcFile3".equals(strInputNm)){ //클라우드서비스 품질성능 확인
    //                                vo.setCrtfcSeCd(1007);                
    //                            }
    //                            
    //                        }                        
    //                        
    //                        if("update".equals(updateYn)){
    //                            ret = update("_webGoods.crtfcUpdateTmp", vo);
    //                        } else {
    //                            ret = update("_webGoods.crtfcUpdate", vo);                        
    //                        }
    //                    }
    //                }
    //            }
    
            } else {
                for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
                    
                    strInputNm = vo.getMarkCrtfcFile().get(i).get(0).getInputNm(); 
                    
                    if("markCrtfcFile0".equals(strInputNm)){   //클라우드서비스보안인증(CSAP)  
                        vo.setCrtfcSeCd(1004);
                        vo.setMarkCd(1004);
                        if("update".equals(updateYn)){                        
                            ret = insert("_webGoods.markRegistInserttmp", vo);
                        } else {
                            ret = insert("_webGoods.markRegistInsert", vo);
                        }
                    } else if("markCrtfcFile1".equals(strInputNm)){ // CC인증
                        vo.setCrtfcSeCd(1001);                
                        vo.setMarkCd(1001);
                        if("update".equals(updateYn)){                        
                            ret = insert("_webGoods.markRegistInserttmp", vo);
                        } else {
                            ret = insert("_webGoods.markRegistInsert", vo);
                        }
                    } else if("markCrtfcFile3".equals(strInputNm)){ //클라우드서비스 품질성능 확인
                        vo.setCrtfcSeCd(1007);                
                        vo.setMarkCd(1007);
                        if("update".equals(updateYn)){                        
                            ret = insert("_webGoods.markRegistInserttmp", vo);
                        } else {
                            ret = insert("_webGoods.markRegistInsert", vo);
                        }
                    }
                    
                    //수정임에도 불구하고 클라우드서비스보안인증(CSAP), CC인증, 클라우드서비스 품질성능 확인중에 넣지 않은 파일에 대해서 넣고자 한다면 
                    //신규이며 수정안에서도 신규인지 아닌지 체크로지 추가
                    if("update".equals(updateYn)){
                        intCrtfcSeCdGubun = (Integer) selectByPk("_webGoods.markCrtfcFileSeqGubunTmp", vo);
                    } else {
                        intCrtfcSeCdGubun = (Integer) selectByPk("_webGoods.markCrtfcFileSeqGubun", vo);                    
                    }                
    
                    if(intCrtfcSeCdGubun < 1){ //신규
                        vo.setMarkCd(vo.getCrtfcSeCd());
                        if(Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
                            vo.setCrtfcSeFileSeq(CrtfcSeFileList.get(i));
                            if("update".equals(updateYn)){
                                ret = update("_webGoods.crtfcUpdateTmp", vo);
                            } else {
                                ret = update("_webGoods.crtfcUpdate", vo);                        
                            }
                        }    
                        
//                        if("update".equals(updateYn)){
//                            
//                            vo.setMarkCd(1004);
//                            ret = insert("_webGoods.markTempMerge", vo);
//                            //int intTstCtfcAtchICount1 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICountTmp", vo);
//                            vo.setMarkCd(1001);
//                            ret = insert("_webGoods.markTempMerge", vo);
//                            //int intTstCtfcAtchICount2 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICountTmp", vo);
//                            vo.setMarkCd(1001);
//                            ret = insert("_webGoods.markTempMerge", vo);
//                        } else {
//                            vo.setMarkCd(1004);
//                            //int intTstCtfcAtchICount1 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
//                            ret = insert("_webGoods.markMerge", vo);
//                            vo.setMarkCd(1001);
//                            //int intTstCtfcAtchICount2 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
//                            ret = insert("_webGoods.markMerge", vo);
//                            vo.setMarkCd(1007);
//                            //int intTstCtfcAtchICount3 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
//                            ret = insert("_webGoods.markMerge", vo);            
//                            
//                        }                       
                    } else {
                        vo.setMarkCd(vo.getMarkCds()[i]);
                        if(Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
                            vo.setCrtfcSeFileSeq(CrtfcSeFileList.get(i));
                            if("update".equals(updateYn)){
                                //ret = update("_webGoods.crtfcUpdateTmp", vo);
                            } else {
                                //ret = update("_webGoods.crtfcUpdate", vo);                        
                            }
                        }
                    }                
                }
                
             
                
                
    /*            if(Validate.isNotEmpty(vo.getMarkCds())) {
                    for(int i = 0 ; i < vo.getMarkCds().length ; i++) {
                        vo.setMarkCd(vo.getMarkCds()[i]);
                        if(Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
                            vo.setCrtfcSeFileSeq(CrtfcSeFileList.get(i));
                            if("update".equals(updateYn)){
                                //ret = update("_webGoods.crtfcUpdateTmp", vo);
                            } else {
                                //ret = update("_webGoods.crtfcUpdate", vo);                        
                            }
                        }
                    }
                }*/
                
            }
        }
        if("Y".equals(vo.getCertMarkCdGubun())){ //ND_goodsActionStep2일때 아래 처리        
        
            /*나라장터쇼핑몰 처리*/
            String strGsCrtfcNo = (vo.getGsCrtfcNo()).trim();
            int intGsCrtfcNoCount = 0;
            int ret1 = 0;
            if( !"".equals(strGsCrtfcNo) || strGsCrtfcNo.length() > 0 ) {
                
                if("update".equals(updateYn)){
                    vo.setMarkCd(1005);
                    ret = insert("_webGoods.markTempMerge", vo);
                    //ret = insert("_webGoods.markRegistInserttmp", vo);                
                } else {
                    vo.setMarkCd(1005);
                    ret = insert("_webGoods.markMerge", vo);
                    //ret = insert("_webGoods.markRegistInsert", vo);                
                }
                
            } else {
                if("update".equals(updateYn)){
                    vo.setMarkCd(1005);
                    ret1 = delete("_webGoods.markRegistDeletetmp", vo);                
                } else {
                    vo.setMarkCd(1005);
                    ret1 = delete("_webGoods.markRegistDelete", vo);                
                }
            }
        }
/*
        if("update".equals(updateYn)){
            vo.setMarkCd(1004);
            ret = insert("_webGoods.markTempMerge", vo);
            //int intTstCtfcAtchICount1 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICountTmp", vo);
            vo.setMarkCd(1001);
            ret = insert("_webGoods.markTempMerge", vo);
            //int intTstCtfcAtchICount2 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICountTmp", vo);
            vo.setMarkCd(1001);
            ret = insert("_webGoods.markTempMerge", vo);
            //int intTstCtfcAtchICount3 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICountTmp", vo);
            
//            if(intTstCtfcAtchICount1 > 0){
//                vo.setMarkCd(1004);
//                ret = insert("_webGoods.markTempMerge", vo);
//            }
//            if(intTstCtfcAtchICount2 > 0){
//                vo.setMarkCd(1001);
//                ret = insert("_webGoods.markTempMerge", vo);
//            }
//            
//            if(intTstCtfcAtchICount3 > 0){
//                vo.setMarkCd(1007);
//                ret = insert("_webGoods.markTempMerge", vo);
//            }
        } else {
            vo.setMarkCd(1004);
            //int intTstCtfcAtchICount1 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
            ret = insert("_webGoods.markMerge", vo);
            vo.setMarkCd(1001);
            //int intTstCtfcAtchICount2 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
            ret = insert("_webGoods.markMerge", vo);
            vo.setMarkCd(1007);
            //int intTstCtfcAtchICount3 = (Integer) selectByPk("_webGoods.intTstCtfcAtchICount", vo);
            ret = insert("_webGoods.markMerge", vo);            

//            if(intTstCtfcAtchICount1 > 0){
//                vo.setMarkCd(1004);
//                ret = insert("_webGoods.markMerge", vo);
//            }
//            
//            if(intTstCtfcAtchICount2 > 0){
//                vo.setMarkCd(1001);
//                ret = insert("_webGoods.markMerge", vo);
//            }
//            
//            if(intTstCtfcAtchICount3 > 0){
//                vo.setMarkCd(1007);
//                ret = insert("_webGoods.markMerge", vo);
//            }
        }
        */
        if("update".equals(updateYn)){
            ret = insert("_webGoods.ctgryDeleteTmp", vo);
        } else {
            ret = insert("_webGoods.ctgryDelete", vo);            
        }
        
        if(Validate.isNotEmpty(vo.getCtgryCds())) {
            for(String scode : vo.getCtgryCds()) {
                vo.setpChk(pChk);
                vo.setCtgryCd(scode);
                
                if("update".equals(updateYn)){
                    ret = insert("_webGoods.ctgryInsertTmp", vo);
                } else {
                    ret = insert("_webGoods.ctgryInsert", vo);            
                }                
            }
        }

        if("update".equals(updateYn)){
            ret = delete("_webGoods.tagDeleteTmp", vo);
        } else {
            ret = delete("_webGoods.tagDelete", vo);            
        }                
        
        ret = addTags(vo);
        ret = addMetas(vo);
 
        
        if("update".equals(updateYn)){
            ret = update("_webGoods.goodsUpdateTmp", vo);
        } else {
            ret = update("_webGoods.goodsUpdate", vo);
        }
        
        insert("_goodsManage.chngHistInsert", vo);
        return ret;
    }
    
    
    
    
    public int goodsUpdateConfirm(WebGoodsManageVO vo) {
        int ret = 0;
        ret = (Integer) selectByPk("_goodsManage.goodsStatus", vo);
        if (ret == 0) {
            return -1;
        }
        ret = update("_webGoods.goodsUpdateConfirm", vo);
        return ret;
    }

    public int goodsInsert(WebGoodsManageVO vo) {
        int ret = 0;

        
        if(vo.getImageMainFile().size() > 0) {  //서비스메인이미지 변경 추가
            vo.setGoodsImageFileSeq(fileDao.saveFile(vo.getImageMainFile(), vo.getGoodsImageFileSeq()));
        }
        if(vo.getGoodsFile().size() > 0) {
            vo.setGoodsFileSeq(fileDao.saveFile(vo.getGoodsFile(), vo.getGoodsFileSeq()));
        }
        if(vo.getImageFile().size() > 0) {
            vo.setGoodsImageFileSeq(fileDao.saveFile(vo.getImageFile(), vo.getGoodsImageFileSeq()));
        }
        if(vo.getMnlFile().size() > 0) {
            vo.setGoodsMnlFileSeq(fileDao.saveFile(vo.getMnlFile(), vo.getGoodsMnlFileSeq()));
        }
        //{{SKYOU 2015.12.21 사용자 메뉴얼 추가
        if(vo.getDnlFile().size() > 0) {
            vo.setMnlDnFileSeq(fileDao.saveFile(vo.getDnlFile(), vo.getMnlDnFileSeq()));
        }
        // }}
        
        //{{KS 2015.12.23 기타첨부파일 추가
        if(vo.getEtcFile().size() > 0) {
            vo.setEtcFileSeq(fileDao.saveFile(vo.getEtcFile(), vo.getEtcFileSeq()));
        }
        // }}
        
        //{{BH, 2016.01.13 가격표 첨부파일 추가  
        if(vo.getPriceFile().size() > 0) {
            vo.setPriceDnFileSeq(fileDao.saveFile(vo.getPriceFile(), vo.getPriceDnFileSeq()));
        }
        // }}
        
        
        ArrayList<Integer> CrtfcSeFileList;
        if(Validate.isNotEmpty(vo.getCrtfcSeFileSeqs())) {
            CrtfcSeFileList = new ArrayList<Integer>(Arrays.asList(vo.getCrtfcSeFileSeqs()));
        } else {
            CrtfcSeFileList = new ArrayList<Integer>();
        }

        for(int i = 0 ; i < vo.getMarkCrtfcFile().size() ; i++) {
            int j = Integer.parseInt(vo.getMarkCrtfcFile().get(i).get(0).getInputNm().replace("markCrtfcFile", ""));
            
            CrtfcSeFileList.set(j, fileDao.saveFile(vo.getMarkCrtfcFile().get(i), Validate.isEmpty(CrtfcSeFileList.get(j)) ? -1 : CrtfcSeFileList.get(j)));
        }

        vo.setSleMthdCd(1002); // 판매자가 서비스를 등록할때는 기본 판매방식은 신청하기

        ret = insert("_webGoods.goodsInsert", vo);

        Integer pChk = 0;

//        ret = delete("_webGoods.markDelete", vo);
//        if(Validate.isNotEmpty(vo.getGoodsMarkCds())) {
//            for(Integer icode : vo.getGoodsMarkCds()) {
//                if (icode == 1001) {
//                    pChk = 1;
//                }
//                vo.setMarkCd(icode);
//                ret = insert("_webGoods.markInsert", vo);
//            }
//        }
//
//        if(Validate.isNotEmpty(vo.getMarkCds())) {
//            for(int i = 0 ; i < vo.getMarkCds().length ; i++) {
//                if(Validate.isNotEmpty(vo.getMarkCds()[i])){
//                    vo.setMarkCd(vo.getMarkCds()[i]);
//                    if(Validate.isNotEmpty(CrtfcSeFileList.get(i))) {
//                        vo.setCrtfcSeFileSeq(CrtfcSeFileList.get(i));
//                        ret = update("_webGoods.crtfcUpdate", vo);
//                    }
//                }
//            }
//        }
        ret = delete("_webGoods.ctgryDelete", vo);
        if(Validate.isNotEmpty( vo.getCtgryCds())){
            for(String scode : vo.getCtgryCds()) {
                vo.setpChk(pChk);
                vo.setCtgryCd(scode);
                ret = insert("_webGoods.ctgryInsert", vo);
            }
        }
        
        ret = delete("_webGoods.tagDelete", vo);
        ret = addTags(vo);
        ret = addMetas(vo);
        
        update("_goodsManage.updtUpdate", vo);
        return ret;
    }

    /**
     * 삭제
     *
     * @param vo
     * @return
     */
    public int goodsDelete(WebGoodsManageVO vo) {

        return update("_webGoods.goodsDelete", vo);
    }

    /**
     * 
     * markingInfoDelete 설명
     * @param vo
     * @return
     */
    public int markingInfoDelete(WebGoodsManageVO vo) {
        int ret = 0;

        String strIsMark = vo.getIsMark();
        String strUpdateYn = vo.getUpdateYn();

        if("update".equals(strUpdateYn)){
            update("_webGoods.updateTstGoodInfoIModifyTmp", vo);

            if("Y".equals(strIsMark)){
                delete("_webGoods.tstGoodMarkIDeleteInfoTmp", vo);
                ret = delete("_webGoods.tstCtfcAtchIDeleteInfoTmp", vo);
                
                if(ret == 0 ){
                    ret = 1;
                }
            } else {

            }            
            
            
        } else {
            update("_webGoods.updateTstGoodInfoIModify", vo);
            
            if("Y".equals(strIsMark)){
                delete("_webGoods.tstGoodMarkIDeleteInfo", vo);
                ret = delete("_webGoods.tstCtfcAtchIDeleteInfo", vo);
                
                if(ret == 0 ){
                    ret = 1;
                }
            } else {

            }                
        }
        
        
        return ret;
    }
    public int deleteTstGoodMarkIInt(WebGoodsManageVO vo) {
        int ret = 0;

        if("update".equals(vo.getUpdateYn())){
            ret = delete("_webGoods.markDeleteMarkCdTmp", vo);
        } else {
            ret = delete("_webGoods.markDeleteMarkCd", vo);            
        }

        return ret;        
    }
    
    /**
     * 등록상태 Update
     *
     * @param vo
     * @return int
     */
    public int registUpdate(WebGoodsManageVO vo) {
        return update("_webGoods.registUpdate", vo);
    }

    /**
     * fileCount 설명
     *
     * @param fileSeq
     * @return
     */
    public int fileCount(Integer fileSeq) {
        return (Integer) selectByPk("_webGoods.fileCount", fileSeq);
    }

    /**
     * ctgrySelect 설명
     *
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> ctgrySelect(WebGoodsManageVO vo) {

        return list("_webGoods.ctgrySelect", vo);
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> goodsMarkCodeList(WebGoodsManageVO vo) {

        return list("_webGoods.goodsMarkList", vo);
    }
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> goodsMarkCodeListTmp(WebGoodsManageVO vo) {

        return list("_webGoods.goodsMarkListTmp", vo);
    }


    private void getDataMap(WebGoodsManageVO vo) {

        //언어
        Object langCodes = vo.getDataMap().get("q_langCodes");
        if(Validate.isNotEmpty(langCodes)) {
            String[] langCode = langCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_langCodes", langCode);
        }

        //상태
        Object statusCodes = vo.getDataMap().get("q_statusCodes");
        if(Validate.isNotEmpty(statusCodes)) {
            String[] statusCode = statusCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_statusCodes", statusCode);
        }

        //노출
        Object expsrCodes = vo.getDataMap().get("q_expsrCodes");
        if(Validate.isNotEmpty(expsrCodes)) {
            String[] expsrCode = expsrCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_expsrCodes", expsrCode);
        }

        //인증마크
        Object crtfcCodes = vo.getDataMap().get("q_crtfcCodes");
        if(Validate.isNotEmpty(crtfcCodes)) {
            String[] crtfcCode = crtfcCodes.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_crtfcCodes", crtfcCode);
        }

        // 날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);

// 2017.04.27 수정 - 최초 로딩시 날짜 설정이 없을경우 날짜 비움
//            vo.getDataMap().put("q_beginDate", sdf.format(c2.getTime()));
//            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
            vo.getDataMap().put("q_beginDate", "");
            vo.getDataMap().put("q_endDate", "");
        }

        this.langCodes = langCodes;
        this.statusCodes = statusCodes;
        this.expsrCodes = expsrCodes;
        this.crtfcCodes = crtfcCodes;


    }

    /**
     * returnReason 설명
     * @param vo
     * @return
     */
    public GoodsManageVO returnReason(GoodsManageVO vo) {

        GoodsManageVO dataVO = (GoodsManageVO) selectByPk("_webGoods.returnReason", vo);
        return dataVO;
    }

    /**
     * goodsStoreList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> goodsStoreList(WebGoodsManageVO vo) {
        Map<String, Object> store = (Map<String, Object>)selectByPk("_premium.goodsStoreList", vo);
        return store;
    }


    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> storeLangList(WebGoodsManageVO vo) {
        return list("_webGoods.storeLangList", vo);
    }

    /**
     * goodsCode 설명
     * @param vo
     * @return
     */
    public String goodsCode(WebGoodsManageVO vo) {
        String goodsCode = (String)selectByPk("_webGoods.goodsCodekey", null);
        return goodsCode;
    }
    

    /**
     * eManagerInfo 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> eManagerAuthInfo(WebGoodsManageVO vo) {
        return  list("_webGoods.eManagerAuthInfo", vo);
    }

    /**
     * goodsMetaLang 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> goodsMetaLang(WebGoodsManageVO vo) {
        return list("_webGoods.goodsMetaLangCode", vo);
    }
    
    
    /**
     * goodsMetaLang 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<WebGoodsManageVO> goodsMetaPrice(WebGoodsManageVO vo) {
        return list("_webGoods.goodsMetaPriceCode", vo);
    }

    /**
     * orderCnt 설명
     * @param vo
     * @return
     */
    public Integer orderCnt(WebGoodsManageVO vo) {
        return (Integer) selectByPk("_webGoods.orderCnt", vo);
    }

    /**
     * storeLangNm 설명
     * @param langCode
     * @return
     */
    public WebGoodsManageVO storeLangNm(String langCode) {
        return (WebGoodsManageVO) selectByPk("_webGoods.storeLangNm", langCode);
    }
    
    // {{ 서비스 SPEC 
    
    public int goodsSpecNum(GoodsSpecVO vo) {
        
        return  (Integer)selectByPk("_webGoods.goodsSpecNum", vo);
    }

    /**
     * goodsSpecDescribeNum 설명
     * @param vo
     * @return
     */
    public int goodsSpecDescribeNum(GoodsSpecDescribeVO vo) {
        
        return  (Integer)selectByPk("_webGoods.goodsSpecDescribeNum", vo);
    }
    
    
    public  int inserGoodsSpecExcel(Map vo) {
        
        return  insert("_webGoods.inserGoodsSpecExcel", vo);
    }    
    
    /**
     * inserGoodsSpecDescribe 설명
     * @param vo
     * @return
     */
    public int insertGoodsSpecDescribe(GoodsSpecDescribeVO vo) {

        return  insert("_webGoods.inserGoodsSpecDescribe", vo);
    }


    public  GoodsSpecVO GoodsSpecInfo(GoodsSpecVO vo) {
        
        GoodsSpecVO gvo = (GoodsSpecVO)  selectByPk("_webGoods.GoodsSpecInfo", vo);
       if(gvo != null){
            if(Validate.isNotEmpty(fileDao.getFiles(gvo.getFileSeq()))) {
                gvo.setSpecExcelFile(fileDao.getFiles(gvo.getFileSeq()));
            }
        }
        return  gvo;
    }

    public  GoodsSpecDescribeVO GoodsSpecDescribeInfo(GoodsSpecDescribeVO vo) 
    {        
        List<String> termLst = null ;
        
        GoodsSpecDescribeVO specInfo = (GoodsSpecDescribeVO)selectByPk("_webGoods.GoodsSpecDescribeInfo", vo);
                
        if ( specInfo != null )
        {
            // 컨설팅 가능 인프라 (2080) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2080, specInfo.getcInfrstrctr());    
            specInfo.setcInfrstrctrNm(getCommanString(termLst));
            
            // 컨설팅 가능 플랫폼 (2081) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.        
            termLst = getCodeNames(2081, specInfo.getcPltfom());    
            specInfo.setcPltfomNm(getCommanString(termLst));            
            
            // 컨설팅 영역 (2082) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.        
            termLst = getCodeNames(2082, specInfo.getcCnslRelm());    
            specInfo.setcCnslRelmNm(getCommanString(termLst));
            
            // 컨설팅 범위 (2083) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.        
            termLst = getCodeNames(2083, specInfo.getcCnslScope());    
            specInfo.setcCnslScopeNm(getCommanString(termLst));
            
            
            // 컨설팅 수행기간 (2084) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2084, specInfo.getcExcPd());    
            specInfo.setcExcPdNm(getCommanString(termLst));
            
            // 컨설팅 수행 가능 지역 (2022) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2022, specInfo.getcExcArea());    
            specInfo.setcExcAreaNm(getCommanString(termLst));
        }
            
        return specInfo;
        
    }
    
    /**
     * getGoodsKindCode 설명
     * @param goodsCode
     * @return
     */
    public int getGoodsKindCode(String goodsCode) {
        
        return (Integer) selectByPk("_webGoods.GoodsKindCode", goodsCode);
    }
    public int getPassYn(Map<String, Object> parameterMap) {
        
        return (Integer) selectByPk("_webGoods.getPassYn", parameterMap);
    }
    public int getPassYnUpdate(Map<String, Object> parameterMap) {
        
        return (Integer) selectByPk("_webGoods.getPassYnUpdate", parameterMap);
    }

    /**
     * goodsSpecDescribeInfo 설명
     * @param vo
     * @return
     */
    public GoodsSpecDescribeVO goodsSpecDescribeInfo(GoodsSpecDescribeVO vo) {
                                                           
        return (GoodsSpecDescribeVO) selectByPk("_webGoods.GoodsSpecDescribeInfo", vo);
    }

    public  int excelFileSaveAction(GoodsSpecVO vo) {
        
        if (vo.getSpecExcelFile().size() > 0) {                
            vo.setFileSeq(fileDao.saveFile(vo.getSpecExcelFile()));
        }
        return update("_webGoods.updateExcelSeq", vo) ;
    }
      
    // }}
    
    /**
     * goodsChngHist 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked") //TST_EXMN_CNFM_H
    public List<Map<String, Object>> goodsChngHist(GoodsManageVO vo) {
        
        List<Map<String, Object>> dataList = list("_webGoods.goodsChngHist", vo);
        
        for(Map<String, Object> data : dataList) {
            data.put("GOODS_CHNG_FILE_ID", fileDao.getFiles(Integer.parseInt(String.valueOf(data.get("GOODS_CHNG_FILE")))));
        }
        
        return dataList;
    }
    
    
    /**
     * 변경사유 등록
     * @param vo
     * @return
     */
    public Integer changeAction(GoodsManageVO vo) {
       
       Integer result =-1;
       
       GoodsManageVO gmVo = (GoodsManageVO) selectByPk("_webGoods.returnReason", vo);
       
       if (vo.getGcFile().size() > 0) 
           vo.setGoodsChngSeq(fileDao.saveFile(vo.getGcFile(), vo.getGoodsChngSeq()));
       
       if(gmVo != null)          
          result = update("_webGoods.updateChangeAction", vo);
       else {
           result = insert("_webGoods.insertChangeAction", vo);
       }
      
       return result;
    }
    
    /**
     * 서비스변경요청 등록
     * @param vo
     * @return
     */
    public int insertSvcChangeRequstAction(GoodsManageVO vo) {
       return insert("_webGoods.insertSvcChangeRequstAction", vo);
    }

    /**
     * goodsInfoSpecInfo 설명
     * @param parameterMap
     * @return
     */
    public Map<String, Object> goodsInfo(Map<String, Object> parameterMap) {
        return (Map<String, Object>)selectByPk("_webGoods.goodsInfo", parameterMap);
    }
    public Map<String, Object> goodsInfoTmp(Map<String, Object> parameterMap) {
        return (Map<String, Object>)selectByPk("_webGoods.goodsInfoTmp", parameterMap);
    }

    public Map<String, Object> goodsInfo_2(Map<String, Object> parameterMap) {
        return (Map<String, Object>)selectByPk("_webGoods.goodsInfo_2", parameterMap);
    }
    public Map<String, Object> goodsInfoTmp_2(Map<String, Object> parameterMap) {
        return (Map<String, Object>)selectByPk("_webGoods.goodsInfoTmp_2", parameterMap);
    }

    /**
     * goodsInfoSpecInfo 설명
     * @param parameterMap
     * @return
     */
    public GoodsSpecDescribeVO specInfo(Map<String, Object> parameterMap) 
    {
        List<String> termLst = null ;
        
        GoodsSpecDescribeVO specInfo = (GoodsSpecDescribeVO)selectByPk("_webGoods.specInfo", parameterMap);
                
        if ( specInfo != null )
        {
            // 컨설팅 가능 인프라 (2080) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2080, specInfo.getcInfrstrctr());    
            specInfo.setcInfrstrctrNm(getCommanString(termLst));
            
            // 컨설팅 가능 플랫폼 (2081) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.        
            termLst = getCodeNames(2081, specInfo.getcPltfom());    
            specInfo.setcPltfomNm(getCommanString(termLst));
            
            // 컨설팅 수행기간 (2084) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2084, specInfo.getcExcPd());    
            specInfo.setcExcPdNm(getCommanString(termLst));
            
            // 컨설팅 수행 가능 지역 (2022) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2022, specInfo.getcExcArea());    
            specInfo.setcExcAreaNm(getCommanString(termLst));
        }
            
        return specInfo;
    }
    public GoodsSpecDescribeVO specInfoUpdate(Map<String, Object> parameterMap) 
    {
        List<String> termLst = null ;
        
        GoodsSpecDescribeVO specInfo = (GoodsSpecDescribeVO)selectByPk("_webGoods.specInfoUpdate", parameterMap);
                
        if ( specInfo != null )
        {
            // 컨설팅 가능 인프라 (2080) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2080, specInfo.getcInfrstrctr());    
            specInfo.setcInfrstrctrNm(getCommanString(termLst));
            
            // 컨설팅 가능 플랫폼 (2081) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.        
            termLst = getCodeNames(2081, specInfo.getcPltfom());    
            specInfo.setcPltfomNm(getCommanString(termLst));
            
            // 컨설팅 수행기간 (2084) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2084, specInfo.getcExcPd());    
            specInfo.setcExcPdNm(getCommanString(termLst));
            
            // 컨설팅 수행 가능 지역 (2022) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2022, specInfo.getcExcArea());    
            specInfo.setcExcAreaNm(getCommanString(termLst));
        }
            
        return specInfo;
    }
    public GoodsSpecDescribeVO specInfo_2(Map<String, Object> parameterMap) 
    {
        List<String> termLst = null ;
        
        GoodsSpecDescribeVO specInfo = (GoodsSpecDescribeVO)selectByPk("_webGoods.specInfo_2", parameterMap);
                
        if ( specInfo != null )
        {
            // 컨설팅 가능 인프라 (2080) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2080, specInfo.getcInfrstrctr());    
            specInfo.setcInfrstrctrNm(getCommanString(termLst));
            
            // 컨설팅 가능 플랫폼 (2081) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.        
            termLst = getCodeNames(2081, specInfo.getcPltfom());    
            specInfo.setcPltfomNm(getCommanString(termLst));
            
            // 컨설팅 수행기간 (2084) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2084, specInfo.getcExcPd());    
            specInfo.setcExcPdNm(getCommanString(termLst));
            
            // 컨설팅 수행 가능 지역 (2022) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2022, specInfo.getcExcArea());    
            specInfo.setcExcAreaNm(getCommanString(termLst));
        }
            
        return specInfo;
    }
    public GoodsSpecDescribeVO specInfoUpdate_2(Map<String, Object> parameterMap) 
    {
        List<String> termLst = null ;
        
        GoodsSpecDescribeVO specInfo = (GoodsSpecDescribeVO)selectByPk("_webGoods.specInfoUpdate_2", parameterMap);
                
        if ( specInfo != null )
        {
            // 컨설팅 가능 인프라 (2080) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2080, specInfo.getcInfrstrctr());    
            specInfo.setcInfrstrctrNm(getCommanString(termLst));
            
            // 컨설팅 가능 플랫폼 (2081) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.        
            termLst = getCodeNames(2081, specInfo.getcPltfom());    
            specInfo.setcPltfomNm(getCommanString(termLst));
            
            // 컨설팅 수행기간 (2084) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2084, specInfo.getcExcPd());    
            specInfo.setcExcPdNm(getCommanString(termLst));
            
            // 컨설팅 수행 가능 지역 (2022) : 코드(들)을 풀어헤쳐 코드명(들)을 구한다.
            termLst = getCodeNames(2022, specInfo.getcExcArea());    
            specInfo.setcExcAreaNm(getCommanString(termLst));
        }
            
        return specInfo;
    }

    /**
     * 서비스 및 규격서 신규등록시
     * mergeGoodsInfoSpecInfo 설명
     * @param curStep
     * @param goodsVo
     * @param specVo
     * @return
     */
    public int mergeGoodsInfoSpecInfo(String curStep, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo) 
    {   
        int retCnt = 0;
        if  ("1".equals(curStep)){
            
            update("_webGoods.mergeGoodsManage1", goodsVo);
            update("_webGoods.mergeGoodsSpecDescribe1", specVo);
        }        
        
        if  ("2".equals(curStep)){
            update("_webGoods.mergeGoodsManage2", goodsVo);
            update("_webGoods.mergeGoodsSpecDescribe2", specVo);
        }        
        
        if  ("3".equals(curStep)){
            
            //규격서정보 유무 체크 
            retCnt = (Integer) selectByPk("_webGoods.selectGoodsSpecDescribeCount3", specVo);
            
            if(retCnt < 1){
                insert("_webGoods.insertGoodsSpecDescribe3", specVo);
            }
            //update("_webGoods.mergeGoodsManage3", goodsVo);
            update("_webGoods.mergeGoodsSpecDescribe3", specVo);
        }
        
        if  ("4".equals(curStep)){

            /**
             2018-08-29 4단계는 규격서내용으로 tst_good_info_i 테이블저장을 안함
             */
            
//            update("_webGoods.mergeGoodsManage4", goodsVo);
            update("_webGoods.mergeGoodsSpecDescribe4", specVo);
        }        
        
        if  ("5".equals(curStep)){
            update("_webGoods.mergeGoodsManage5", goodsVo);
        }        
        
        return 1;
    }
    
    /**
     * 서비스 및 규격서 수정시 
     * mergeGoodsInfoSpecInfoUpdate 설명
     * @param curStep
     * @param goodsVo
     * @param specVo
     * @return
     */
    public int mergeGoodsInfoSpecInfoUpdate(String curStep, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo) 
    {   
        
        specVo.setUpdtId(goodsVo.getUpdtId()); 
        int retCnt = 0;
        if  ("1".equals(curStep))
        {
            update("_webGoods.mergeGoodsManageTmp1", goodsVo);
            update("_webGoods.mergeGoodsSpecDescribeTmp1", specVo);
        }        
        if  ("2".equals(curStep))
        {
            update("_webGoods.mergeGoodsManageTmp2", goodsVo);
            update("_webGoods.mergeGoodsSpecDescribeTmp2", specVo);
        }        
        if  ("3".equals(curStep))
        {
            
            //규격서정보 유무 체크 
            retCnt = (Integer) selectByPk("_webGoods.selectGoodsSpecDescribeCountTmp3", specVo);
            
            if(retCnt < 1){
                insert("_webGoods.insertGoodsSpecDescribeTmp3", specVo);
            }

            update("_webGoods.mergeGoodsSpecDescribeTmp3", specVo);
        }        
        if  ("4".equals(curStep))
        {
//            update("_webGoods.mergeGoodsManageTmp4", goodsVo);
            update("_webGoods.mergeGoodsSpecDescribeTmp4", specVo);
        }        
        if  ("5".equals(curStep))
        {
            
            update("_webGoods.mergeGoodsManage5_1", goodsVo);            
            update("_webGoods.mergeGoodsManage5_2", goodsVo);            
            update("_webGoods.mergeGoodsManageTmp5", goodsVo);
        }        
        
        return 1;
    }

    /**
     * updateGoodsSpecDescribe 설명
     * @param specVo
     * @return
     */
    public int updateGoodsSpecDescribe(GoodsSpecDescribeVO specVo) {
        
        return 0;
    }

    /**
     * goodsCateList 설명
     * @param parameterMap
     * @return
     */
    public List<Map<String, Object>> goodsCateList(Map<String, Object> parameterMap) {

        return list("_webGoods.goodsCateList", parameterMap);
    }
    public List<Map<String, Object>> goodsCateListTmp(Map<String, Object> parameterMap) {

        return list("_webGoods.goodsCateListTmp", parameterMap);
    }

    /**
     * goodsMarkList 설명
     * @param parameterMap
     * @return
     */
    public List goodsMarkList(Map<String, Object> parameterMap) {
        return list("_webGoods.goodsMarkList", parameterMap);
    }

    /**
     * goodsMetaList 설명
     * @param goodsVo
     * @return
     */
    public List goodsMetaList(WebGoodsManageVO goodsVo) {
        return list ("_webGoods.goodsMetaList", goodsVo);
    }
    public List goodsMetaListTmp(WebGoodsManageVO goodsVo) {
        return list ("_webGoods.goodsMetaListTmp", goodsVo);
    }

    /**
     * tstCateMgmt 설명
     * @param cDetailSvc
     * @return
     */
    public Map<String, Object> tstCateMgmt(Map<String, Object> cDetailSvc) {
        return (Map<String, Object>) selectByPk("_webGoods.tstCateMgmtInfo", cDetailSvc);
    }
    
}
