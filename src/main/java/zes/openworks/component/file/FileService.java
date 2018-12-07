package zes.openworks.component.file;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;

/**
 * 파일관리 Table에서 해당 키 값에 해당하는 파일(들) 정보를 반환하거나, 저장, 삭제를 수행한다.
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
 *  2012. 4. 20.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface FileService {

    /**
     * 대상 일련번호에 해당하는 모든 저장 파일 목록 반환
     * 
     * @param fileSeq 파일일련 번호
     * @return
     */
    List<FileVO> getFiles(Integer fileSeq);

    /**
     * 대상 파일 반환. 하나의 파일만 반환한다.
     * 
     * @param fileId 첨부파일의 고유 id
     * @return
     */
    FileVO getFile(String fileId);

    /**
     * 파일 목록 저장
     * 
     * @param fileList 추가할 파일 목록
     * @return
     */
    int saveFile(List<FileVO> fileList);

    /**
     * 이미 저장되어 있는 일련번호 그룹에 추가 저장
     * 
     * @param fileList 추가할 파일 목록
     * @param fileSeq 저장할 파일들의 일련번호
     * @return
     */
    int saveFile(List<FileVO> fileList, Integer fileSeq);

    /**
     * 이미 저장되어 있는 일련번호 그룹에 추가 저장하며, 화면 UI의 input 태그의 name 속성을 함께 저장한다.
     * 
     * @param fileList 추가할 파일 목록
     * @param fileSeq 저장할 파일들의 일련번호
     * @param inputNm 화면 UI의 input 태그의 name 속성
     * @return
     */
    int saveFile(List<FileVO> fileList, Integer fileSeq, String inputNm);

    /**
     * 저장되어 있는 파일정보를 수정한다.
     * 수정 내용은 파일명, 정렬순서, 파일설명(이미지의 경우 접근성 내용)만 가능하다.
     * 
     * @param request
     * @return
     */
    int updateFile(HttpServletRequest request);

    /**
     * 파일 일련번호에 해당하는 모든 파일을 삭제한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @return
     */
    int removeFile(Integer fileSeq);

    /**
     * 파일 고유 ID를 통하여 하나의 파일을 삭제 한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @param fileId 삭제할 파일의 고유 id
     * @return
     */
    int removeFile(Integer fileSeq, String fileId);

    /**
     * 일련번호에 해당하는 파일중 지정된 고유 ID에 해당하는 파일들을 삭제한다.
     * DB와 물리적 파일 모두 삭제한다.
     * 
     * @param fileSeq 삭제할 파일들의 일련번호
     * @param fileIds 삭제할 파일의 고유 id 목록
     * @return
     */
    int removeFile(Integer fileSeq, String[] fileIds);

    /**
     * 파일 교체(기존 파일 삭제후 신규 등록)
     * 
     * @param fileList 저장할 파일 목록
     * @param fileSeq 삭제 저장할 파일 일련번호
     * @param inputNm 화면 UI의 input 태그의 name 속성
     * @return
     */
    int replaceFile(List<FileVO> fileList, Integer fileSeq, String inputNm);

    /**
     * 파일 다운로드 이력을 남기고 다운로드
     * 
     * @param request 웹 요청 객체
     * @param fileId 첨부파일 고유 ID
     * @return
     */
    int updateFileDown(HttpServletRequest request, String fileId);

    /**
     * 파일별 파일 다운로드 이력 목록
     * 
     * @param vo 이력을 확인 할 파일 정보
     * @return
     */
    Pager<?> getFileLogs(FileLogVO vo);
}
