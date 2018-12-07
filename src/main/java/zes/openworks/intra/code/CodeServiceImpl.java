/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.code;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import org.springframework.stereotype.Service;
import zes.base.pager.Pager;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.file.FileDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("codeService")
public class CodeServiceImpl extends AbstractServiceImpl implements CodeService {

    @Resource
    private CodeDAO dao;

    @Resource
    private FileDAO fileDao;

    @Override
    public List<CodeVO> codeList(CodeVO vo) {
        return dao.codeList(vo);
    }
    @Override
    public List<CodeVO> codeList2(CodeVO vo) {
        return dao.codeList2(vo);
    }

    @Override
    public List<CodeVO> grpList(CodeVO vo) {
        return dao.grpList(vo);
    }

    @Override
    public CodeVO codeView(CodeVO vo) {
        return dao.codeView(vo);
    }

    @Override
    public Integer insertAction(CodeVO vo) {
        return dao.insertAction(vo);
    }

    @Override
    public int updateAction(CodeVO vo) {
        return dao.updateAction(vo);
    }

    @Override
    public int deleteAction(CodeVO vo) {
        return dao.deleteAction(vo);
    }

    @Override
    public List<String> ctgCdList(CodeCtgVO CodeCtgVO2) {
        return dao.ctgCdList(CodeCtgVO2);
    }

    @Override
    public CodeCtgVO ctgView(CodeCtgVO CodeCtgVO2) {
        return dao.ctgView(CodeCtgVO2);
    }

    @Override
    public List<CodeVO> prvNmForCtgCd(CodeCtgVO CodeCtgVO2) {
        return dao.prvNmForCtgCd(CodeCtgVO2);
    }

    @Override
    public Object ctgInsertAction(CodeCtgVO CodeCtgVO2) {
        return dao.ctgInsertAction(CodeCtgVO2);
    }

    @Override
    public int ctgUpdateAction(CodeCtgVO CodeCtgVO2) {
        return dao.ctgUpdateAction(CodeCtgVO2);
    }

    @Override
    public int ctgDeleteAction(CodeCtgVO CodeCtgVO2) {
        return dao.ctgDeleteAction(CodeCtgVO2);
    }

    @Override
    public CodeVO codeSelect(CodeVO vo) {
        return dao.codeSelect(vo);
    }

    @Override
    public CodeVO checkCode(CodeVO vo) {
        return dao.checkCode(vo);
    }

    @Override
    public List<CodeVO> totalCodeList(CodeVO vo) {
        return dao.totalCodeList(vo);
    }

    @Override
    public List<CodeVO> ctgList(CodeCtgVO CodeCtgVO2) {
        return dao.ctgList(CodeCtgVO2);
    }

    @Override
    public List<CodeVO> prvNmUseYnList(CodeVO vo) {
        return dao.prvNmUseYnList(vo);
    }

    @Override
    public Pager<LoggingCodeVO> changeLogList(CodeVO vo) {
        return dao.changeLogList(vo);
    }

    /**
     * regExcelEnBloLoad 개별코드 엑셀 일괄등록 로드
     * 
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public List<CodeVO> regExcelEnBloLoad(HttpServletRequest request) throws Exception {
        List<FileVO> fileList = fileDao.getFiles(fileDao.saveFile(UploadHelper.upload(request, "prvExcelEnBloc")));
        Workbook workbook = null;
        Sheet sheet = null;

        List<CodeVO> grpList = new ArrayList<CodeVO>();

        for(FileVO file : fileList) {

            workbook = Workbook.getWorkbook(new File(GlobalConfig.UPLOAD_ROOT + file.getFileUrl()));
            sheet = workbook.getSheet(0);

            int rowCount = sheet.getRows();
            int colCount = sheet.getColumns();

            if(rowCount <= 1) {
                return null;
            }
            String content = null;

            // 엑셀데이터를 배열에 저장
            for(int i = 1 ; i < rowCount ; i++) {
                CodeVO CodeVo = new CodeVO();
                for(int k = 0 ; k < colCount ; k++) {

                    Cell cell = sheet.getCell(k, i); // 해당 위치의 셀을 가져옴
                    content = (cell != null) ? cell.getContents() : "";

                    switch(k) {
                        case 0:
                            try {
                                CodeVo.setLangCode(content);
                            } catch (Exception e) {
                                CodeVo.setLangCode("");;
                            }
                            break;
                        case 1:
                            try {
                                CodeVo.setGrpCd(Integer.valueOf(content));
                            } catch (Exception e) {
                                CodeVo.setGrpCd(-1);
                            }
                            break;
                        case 2:
                            try {
                                CodeVo.setPrvCd(Integer.valueOf(content));
                            } catch (Exception e) {
                                CodeVo.setPrvCd(-1);
                            }
                            break;
                        case 3:
                            CodeVo.setPrvNm(content);
                            break;
                    }
                }
                if(CodeVo.getLangCode() != "" && CodeVo.getGrpCd() >= 0 && CodeVo.getPrvCd() >= 0 && CodeVo.getPrvNm() != "") {
                    grpList.add(CodeVo);
                }
            }

            try {
                if(workbook != null) {
                    workbook.close();
                }
            } catch (Exception e) {

            }

            fileDao.removeFile(file.getFileSeq());
        }

        return grpList;
    }

    /**
     * insertPrvExcelEnBloc 개별코드 엑셀 일괄등록
     * 
     * @param vo
     *        중복체크 포함하여 등록되도록 추가 2013년 4월 김영상
     */
    @Override
    public String[] insertPrvExcelEnBloc(CodeVO vo) {
        int returnVal = 0;
        String[] strReturn = new String[2];
        String returnMsg = "";
        String[] langCode = vo.getLangCodes().split(",");
        String[] grpCd = vo.getGrpCds().split(",");
        String[] prvCd = vo.getPrvCds().split(",");
        String[] prvNm = vo.getPrvNm().split(",");

        CodeVO nVo = new CodeVO();

        for(int i = 0 ; i < prvCd.length ; i++) {
            HashMap<String, Object> vMap = new HashMap<String, Object>();
            vMap.put("langCode", langCode[i]);
            vMap.put("grpCd", Integer.valueOf(grpCd[i]));
            vMap.put("prvCd", Integer.valueOf(prvCd[i]));
            
            // 언어코드 존재여부
            int iLangCdExt = dao.extChkLangAction(langCode[i]);
            if(iLangCdExt == 0) {
                returnMsg = "서비스되지 않는 언어코드가 존재하는 요소가 있습니다.";
                returnVal++;
            }else{
                // 그룹코드 존재여부
                int iGrpCdExt = dao.extChkGrpAction(vMap);
                // 개별코드 존재여부
                int iPrvCdExt = dao.dupChkPrvAction(vMap);
                if(iGrpCdExt == 0) {
                    int j = i + 1;
                    returnMsg += "그룹코드" + Integer.valueOf(grpCd[i]) + "(이)가 존재하지 않아 " + j + "번째 요소는 등록에서 제외되었습니다." + "<br />";
                } else {
                    nVo.setLangCode(langCode[i]);
                    nVo.setGrpCd(Integer.valueOf(grpCd[i]));
                    if(iPrvCdExt > 0) {
                        returnMsg += "개별코드" + Integer.valueOf(prvCd[i]) + "(이)가 중복되어 등록에서 제외되었습니다." + "<br />";
                    } else {
                        nVo.setPrvCd(Integer.valueOf(prvCd[i]));
                        nVo.setPrvNm(prvNm[i]);
                    }
                }
    
                // 그룹코드가 존재하고 개별코드가 존재하지 않아야 됨
                if(iGrpCdExt > 0 && iPrvCdExt == 0) {
                    dao.insertAction(nVo);
                    returnVal++;
                }
            }
        }
        strReturn[0] = (Integer.valueOf(returnVal)).toString();
        strReturn[1] = returnMsg;
        return strReturn;
    }

    @Override
    public List<CodeVO> getLangCodeList(CodeVO vo) {
        return dao.getLangCodeList(vo);
    }

    @Override
    public List<CodeVO> langList(CodeVO vo) {
        return dao.langList(vo);
    }
    
    /** 20150901 소트 수정 추가 시작  */
    @Override
    public int selectCodeSelectMaxOrder(CodeVO vo) {
        return dao.selectCodeSelectMaxOrder(vo);
    }
    
    @Override
    public int updateCodeUpdateOrderNoUp(CodeVO vo) {
        return dao.updateCodeUpdateOrderNoUp(vo);
    }
    
    @Override
    public int updateCodeUpdateOrderNoDown(CodeVO vo) {
        return dao.updateCodeUpdateOrderNoDown(vo);
    }
    
    @Override
    public int updateCodeUpdateOrderNo(CodeVO vo) {
        return dao.updateCodeUpdateOrderNo(vo);
    }
    /** 20150901 소트 수정 추가 끝  */
}
