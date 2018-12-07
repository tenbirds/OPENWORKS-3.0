package zes.openworks.web.dmandExamin;

import java.util.List;

import zes.base.vo.FileVO;

/**
 * 수요조사 VO 클래스
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)엔키소프트 양교훈
 *
 *		 <pre>
 * << 개정이력(Modification Information) >>
 *
 *	 수정일			   수정자						 수정내용
 * --------------  --------  -------------------------------
 *  2016. 10. 5.	 양교훈	 신규
 * </pre>
 * @see
 */
@SuppressWarnings("serial")
public class DmandExaminVO extends FileVO {

	/*수요조사순번*/
	private int dmandExaminSn = 0;
	/*수요조사순번 배열*/
	private String[] dmandExaminSns;
	/*회원아이디*/
	private String userId;
	/*파일번호*/
	//private int fileSeq = 0;
	/*삭제여부*/
	private String dmandExaminDt;
	/*순번*/
	private int dmandSurveyNo = 0;
	/*기관유형*/
	private String dmandSurveyInsttTy;
    /*상위기관명*/
	private String dmandSurveyHighorgname;
	/*기관명*/
	private String dmandSurveyOrgname;
	/*시스템명*/
	private String dmandSurveySysname;
	/*시스템목적*/
	private String dmandSurveySysobj;
	/*시스템구분(기존/신규)*/
	private String dmandSurveyDivision;
	/*담당자*/
	private String dmandSurveyManager;
	/*이메일*/
	private String dmandSurveyMail;
	/*연락처*/
	private String dmandSurveyPhone;
	/*구축년도(YYYY)*/
	private String dmandSurveyBuildy;
	/*최근업그레이드년도(YYYY)*/
	private String dmandSurveyUpy;
	/*구축비*/
	private String dmandSurveyBuildcost;
	/*당해년도유지보수비*/
	private String dmandSurveyMaint;
	/*당해년도운영비*/
	private String dmandSurveyExpenses;
	/*클라우드이용여부*/
	private String dmandSurveyClouduse;
	/*클라우드구분(민간/자체/G-Cloud)*/
	private String dmandSurveySeparation;
	/*클라우드도입년도(YYYY)*/
	private String dmandSurveyIntroy;
	/*시스템(Y/N)*/
	private String dmandSurveyFirstsyst;
	/*구현성(Y/N)*/
	private String dmandSurveyFirstreal;
	/*경제성(Y/N)*/
	private String dmandSurveyFirstecon;
	/*제외대상(Y/N)*/
	private String dmandSurveyExem;
	/*서비스(3/2/1)*/
	private String dmandSurveySecoundserv;
	/*데이터(3/2/1)*/
	private String dmandSurveySecounddata;
	/*연계(3/2/1)*/
	private String dmandSurveySecoundconn;
	/*업무대체율(3/2/1)*/
	private String dmandSurveySecoundsubs;
	/*업무대체비용(3/2/1)*/
	private String dmandSurveySecoundsubscost;
	/*업무대체수준(㉕+㉖)/2*/
	private String dmandSurveySecoundsubslevel;
	/*사고시파급효과(3/2/1)*/
	private String dmandSurveySecoundripp;
	/*총점*/
	private String dmandSurveyTotalscore;
	/*평균*/
	private String dmandSurveyAverage;
	/*클라우드자체평가등급*/
	private String dmandSurveySelflevel;
	/*클라우드전환 또는 도입예정(전환/도입예정/N)*/
	private String dmandSurveyChangep;
	/*클라우드구분(민간/자체/G-Cloud)*/
	private String dmandSurveySeparation2;
	/*2017년 1/4분기(단위:천원)*/
	private String dmandSurveyFiquater;
	/*2017년 2/4분기(단위:천원)*/
	private String dmandSurveySequater;
	/*2017년 3/4분기(단위:천원)*/
	private String dmandSurveyThquater;
	/*2017년 4/4분기(단위:천원)*/
	private String dmandSurveyFoquater;
	/*2017년 이후(단위:천원)*/
	private String dmandSurveyAfquater;
	/*2017년(Y/N)*/
	private String dmandSurveyChangeth;
	/*2017년 이후 전환연도(YYYY)*/
	private String dmandSurveyChangene;
	/*공공기관코드*/
	private String pblinsttCd;
	/*기관유형*/
	private String pblinsttType;
	/*상위기관명*/
	private String upperPblinsttNm;
	/*공공기관명*/
	private String pblinsttNm;
	/*클라우드 전환 또는 도입예정*/
	private String dmandSurveyCnvrsPlan;
	/*클라우드 도입예정시(클라우드 구분)*/
	private String dmandSurveyPlanCloudSeparation;
	/*클라우드 도입예정시(서비스구분)*/
	private String dmandSurveyPlanServSeparation;
	/*클라우드 예산 (단위:천원)*/
	private String dmandSurveyBudget;
	/*비밀여부*/
	private String dmandSurveyVldtySecretAt;
	/*경제성*/
	private String dmandSurveyVldtyFirstecon;
	/*클라우드 도입 만족도 부문*/
	private String dmandSurveyStsfdg;
	/*기타사유 및 의견(서술형)*/
	private String dmandSurveyOpinion;
	/*수요조사 실시 년도*/
	private String dmandExaminOprtnYear;
	/*임시 저장 날짜*/
	private String tmprSaveDate;
	/*제출일*/
	private String presentnDate;
	/*부서코드*/
	private String buseoCode;
	/*기관구분*/
	private String statsTyCode;


    
    /**
     * String statsTyCode을 반환
     * @return String statsTyCode
     */
    public String getStatsTyCode() {
        return statsTyCode;
    }

    
    /**
     * statsTyCode을 설정
     * @param statsTyCode 을(를) String statsTyCode로 설정
     */
    public void setStatsTyCode(String statsTyCode) {
        this.statsTyCode = statsTyCode;
    }


    private List<FileVO> dmandExaminFile;

	//private List<DmandExaminVO> dmandExaminDetailList = new ArrayList<DmandExaminVO>();

	public int getDmandExaminSn() {
		return dmandExaminSn;
	}

	public void setDmandExaminSn(int dmandExaminSn) {
		this.dmandExaminSn = dmandExaminSn;
	}

	public String[] getDmandExaminSns() {
		return dmandExaminSns;
	}

	public void setDmandExaminSns(String[] dmandExaminSns) {
		this.dmandExaminSns = dmandExaminSns;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDmandExaminDt() {
		return dmandExaminDt;
	}

	public void setDmandExaminDt(String dmandExaminDt) {
		this.dmandExaminDt = dmandExaminDt;
	}

	public int getDmandSurveyNo() {
		return dmandSurveyNo;
	}

	public void setDmandSurveyNo(int dmandSurveyNo) {
		this.dmandSurveyNo = dmandSurveyNo;
	}

	public String getDmandSurveyHighorgname() {
		return dmandSurveyHighorgname;
	}

	public void setDmandSurveyHighorgname(String dmandSurveyHighorgname) {
		this.dmandSurveyHighorgname = dmandSurveyHighorgname;
	}

	public String getDmandSurveyOrgname() {
		return dmandSurveyOrgname;
	}

	public void setDmandSurveyOrgname(String dmandSurveyOrgname) {
		this.dmandSurveyOrgname = dmandSurveyOrgname;
	}

	public String getDmandSurveySysname() {
		return dmandSurveySysname;
	}

	public void setDmandSurveySysname(String dmandSurveySysname) {
		this.dmandSurveySysname = dmandSurveySysname;
	}

	public String getDmandSurveySysobj() {
		return dmandSurveySysobj;
	}

	public void setDmandSurveySysobj(String dmandSurveySysobj) {
		this.dmandSurveySysobj = dmandSurveySysobj;
	}

	public String getDmandSurveyDivision() {
		return dmandSurveyDivision;
	}

	public void setDmandSurveyDivision(String dmandSurveyDivision) {
		this.dmandSurveyDivision = dmandSurveyDivision;
	}

	public String getDmandSurveyManager() {
		return dmandSurveyManager;
	}

	public void setDmandSurveyManager(String dmandSurveyManager) {
		this.dmandSurveyManager = dmandSurveyManager;
	}

	public String getDmandSurveyMail() {
		return dmandSurveyMail;
	}

	public void setDmandSurveyMail(String dmandSurveyMail) {
		this.dmandSurveyMail = dmandSurveyMail;
	}

	public String getDmandSurveyPhone() {
		return dmandSurveyPhone;
	}

	public void setDmandSurveyPhone(String dmandSurveyPhone) {
		this.dmandSurveyPhone = dmandSurveyPhone;
	}

	public String getDmandSurveyBuildy() {
		return dmandSurveyBuildy;
	}

	public void setDmandSurveyBuildy(String dmandSurveyBuildy) {
		this.dmandSurveyBuildy = dmandSurveyBuildy;
	}

	public String getDmandSurveyUpy() {
		return dmandSurveyUpy;
	}

	public void setDmandSurveyUpy(String dmandSurveyUpy) {
		this.dmandSurveyUpy = dmandSurveyUpy;
	}

	public String getDmandSurveyBuildcost() {
		return dmandSurveyBuildcost;
	}

	public void setDmandSurveyBuildcost(String dmandSurveyBuildcost) {
		this.dmandSurveyBuildcost = dmandSurveyBuildcost;
	}

	public String getDmandSurveyMaint() {
		return dmandSurveyMaint;
	}

	public void setDmandSurveyMaint(String dmandSurveyMaint) {
		this.dmandSurveyMaint = dmandSurveyMaint;
	}

	public String getDmandSurveyExpenses() {
		return dmandSurveyExpenses;
	}

	public void setDmandSurveyExpenses(String dmandSurveyExpenses) {
		this.dmandSurveyExpenses = dmandSurveyExpenses;
	}

	public String getDmandSurveyClouduse() {
		return dmandSurveyClouduse;
	}

	public void setDmandSurveyClouduse(String dmandSurveyClouduse) {
		this.dmandSurveyClouduse = dmandSurveyClouduse;
	}

	public String getDmandSurveySeparation() {
		return dmandSurveySeparation;
	}

	public void setDmandSurveySeparation(String dmandSurveySeparation) {
		this.dmandSurveySeparation = dmandSurveySeparation;
	}

	public String getDmandSurveyIntroy() {
		return dmandSurveyIntroy;
	}

	public void setDmandSurveyIntroy(String dmandSurveyIntroy) {
		this.dmandSurveyIntroy = dmandSurveyIntroy;
	}

	public String getDmandSurveyFirstsyst() {
		return dmandSurveyFirstsyst;
	}

	public void setDmandSurveyFirstsyst(String dmandSurveyFirstsyst) {
		this.dmandSurveyFirstsyst = dmandSurveyFirstsyst;
	}

	public String getDmandSurveyFirstreal() {
		return dmandSurveyFirstreal;
	}

	public void setDmandSurveyFirstreal(String dmandSurveyFirstreal) {
		this.dmandSurveyFirstreal = dmandSurveyFirstreal;
	}

	public String getDmandSurveyFirstecon() {
		return dmandSurveyFirstecon;
	}

	public void setDmandSurveyFirstecon(String dmandSurveyFirstecon) {
		this.dmandSurveyFirstecon = dmandSurveyFirstecon;
	}

	public String getDmandSurveyExem() {
		return dmandSurveyExem;
	}

	public void setDmandSurveyExem(String dmandSurveyExem) {
		this.dmandSurveyExem = dmandSurveyExem;
	}

	public String getDmandSurveySecoundserv() {
		return dmandSurveySecoundserv;
	}

	public void setDmandSurveySecoundserv(String dmandSurveySecoundserv) {
		this.dmandSurveySecoundserv = dmandSurveySecoundserv;
	}

	public String getDmandSurveySecounddata() {
		return dmandSurveySecounddata;
	}

	public void setDmandSurveySecounddata(String dmandSurveySecounddata) {
		this.dmandSurveySecounddata = dmandSurveySecounddata;
	}

	public String getDmandSurveySecoundconn() {
		return dmandSurveySecoundconn;
	}

	public void setDmandSurveySecoundconn(String dmandSurveySecoundconn) {
		this.dmandSurveySecoundconn = dmandSurveySecoundconn;
	}

	public String getDmandSurveySecoundsubs() {
		return dmandSurveySecoundsubs;
	}

	public void setDmandSurveySecoundsubs(String dmandSurveySecoundsubs) {
		this.dmandSurveySecoundsubs = dmandSurveySecoundsubs;
	}

	public String getDmandSurveySecoundsubscost() {
		return dmandSurveySecoundsubscost;
	}

	public void setDmandSurveySecoundsubscost(String dmandSurveySecoundsubscost) {
		this.dmandSurveySecoundsubscost = dmandSurveySecoundsubscost;
	}

	public String getDmandSurveySecoundsubslevel() {
		return dmandSurveySecoundsubslevel;
	}

	public void setDmandSurveySecoundsubslevel(String dmandSurveySecoundsubslevel) {
		this.dmandSurveySecoundsubslevel = dmandSurveySecoundsubslevel;
	}

	public String getDmandSurveySecoundripp() {
		return dmandSurveySecoundripp;
	}

	public void setDmandSurveySecoundripp(String dmandSurveySecoundripp) {
		this.dmandSurveySecoundripp = dmandSurveySecoundripp;
	}

	public String getDmandSurveyTotalscore() {
		return dmandSurveyTotalscore;
	}

	public void setDmandSurveyTotalscore(String dmandSurveyTotalscore) {
		this.dmandSurveyTotalscore = dmandSurveyTotalscore;
	}

	public String getDmandSurveyAverage() {
		return dmandSurveyAverage;
	}

	public void setDmandSurveyAverage(String dmandSurveyAverage) {
		this.dmandSurveyAverage = dmandSurveyAverage;
	}

	public String getDmandSurveySelflevel() {
		return dmandSurveySelflevel;
	}

	public void setDmandSurveySelflevel(String dmandSurveySelflevel) {
		this.dmandSurveySelflevel = dmandSurveySelflevel;
	}

	public String getDmandSurveyChangep() {
		return dmandSurveyChangep;
	}

	public void setDmandSurveyChangep(String dmandSurveyChangep) {
		this.dmandSurveyChangep = dmandSurveyChangep;
	}

	public String getDmandSurveySeparation2() {
		return dmandSurveySeparation2;
	}

	public void setDmandSurveySeparation2(String dmandSurveySeparation2) {
		this.dmandSurveySeparation2 = dmandSurveySeparation2;
	}

	public String getDmandSurveyFiquater() {
		return dmandSurveyFiquater;
	}

	public void setDmandSurveyFiquater(String dmandSurveyFiquater) {
		this.dmandSurveyFiquater = dmandSurveyFiquater;
	}

	public String getDmandSurveySequater() {
		return dmandSurveySequater;
	}

	public void setDmandSurveySequater(String dmandSurveySequater) {
		this.dmandSurveySequater = dmandSurveySequater;
	}

	public String getDmandSurveyThquater() {
		return dmandSurveyThquater;
	}

	public void setDmandSurveyThquater(String dmandSurveyThquater) {
		this.dmandSurveyThquater = dmandSurveyThquater;
	}

	public String getDmandSurveyFoquater() {
		return dmandSurveyFoquater;
	}

	public void setDmandSurveyFoquater(String dmandSurveyFoquater) {
		this.dmandSurveyFoquater = dmandSurveyFoquater;
	}

	public String getDmandSurveyAfquater() {
		return dmandSurveyAfquater;
	}

	public void setDmandSurveyAfquater(String dmandSurveyAfquater) {
		this.dmandSurveyAfquater = dmandSurveyAfquater;
	}

	public String getDmandSurveyChangeth() {
		return dmandSurveyChangeth;
	}

	public void setDmandSurveyChangeth(String dmandSurveyChangeth) {
		this.dmandSurveyChangeth = dmandSurveyChangeth;
	}

	public String getDmandSurveyChangene() {
		return dmandSurveyChangene;
	}

	public void setDmandSurveyChangene(String dmandSurveyChangene) {
		this.dmandSurveyChangene = dmandSurveyChangene;
	}

	public String getPblinsttCd() {
		return pblinsttCd;
	}

	public void setPblinsttCd(String pblinsttCd) {
		this.pblinsttCd = pblinsttCd;
	}

	public String getPblinsttType() {
		return pblinsttType;
	}

	public void setPblinsttType(String pblinsttType) {
		this.pblinsttType = pblinsttType;
	}

	public String getUpperPblinsttNm() {
		return upperPblinsttNm;
	}

	public void setUpperPblinsttNm(String upperPblinsttNm) {
		this.upperPblinsttNm = upperPblinsttNm;
	}

	public String getPblinsttNm() {
		return pblinsttNm;
	}

	public void setPblinsttNm(String pblinsttNm) {
		this.pblinsttNm = pblinsttNm;
	}

	
    
    /**
     * String buseoCode을 반환
     * @return String buseoCode
     */
    public String getBuseoCode() {
        return buseoCode;
    }

    
    /**
     * buseoCode을 설정
     * @param buseoCode 을(를) String buseoCode로 설정
     */
    public void setBuseoCode(String buseoCode) {
        this.buseoCode = buseoCode;
    }

    /**
     * String dmandExaminOprtnYear을 반환
     * @return String dmandExaminOprtnYear
     */
    public String getDmandExaminOprtnYear() {
        return dmandExaminOprtnYear;
    }

    
    /**
     * dmandExaminOprtnYear을 설정
     * @param dmandExaminOprtnYear 을(를) String dmandExaminOprtnYear로 설정
     */
    public void setDmandExaminOprtnYear(String dmandExaminOprtnYear) {
        this.dmandExaminOprtnYear = dmandExaminOprtnYear;
    }

    
    /**
     * String tmprSaveDate을 반환
     * @return String tmprSaveDate
     */
    public String getTmprSaveDate() {
        return tmprSaveDate;
    }

    
    /**
     * tmprSaveDate을 설정
     * @param tmprSaveDate 을(를) String tmprSaveDate로 설정
     */
    public void setTmprSaveDate(String tmprSaveDate) {
        this.tmprSaveDate = tmprSaveDate;
    }

    
    /**
     * String presentnDate을 반환
     * @return String presentnDate
     */
    public String getPresentnDate() {
        return presentnDate;
    }

    
    /**
     * presentnDate을 설정
     * @param presentnDate 을(를) String presentnDate로 설정
     */
    public void setPresentnDate(String presentnDate) {
        this.presentnDate = presentnDate;
    }

    public List<FileVO> getDmandExaminFile() {
		return dmandExaminFile;
	}

	public void setDmandExaminFile(List<FileVO> dmandExaminFile) {
		this.dmandExaminFile = dmandExaminFile;
	}
	
	/**
     * String dmandSurveyInsttTy을 반환
     * @return String dmandSurveyInsttTy
     */
    public String getDmandSurveyInsttTy() {
        return dmandSurveyInsttTy;
    }

    
    /**
     * dmandSurveyInsttTy을 설정
     * @param dmandSurveyInsttTy 을(를) String dmandSurveyInsttTy로 설정
     */
    public void setDmandSurveyInsttTy(String dmandSurveyInsttTy) {
        this.dmandSurveyInsttTy = dmandSurveyInsttTy;
    }
    
    /**
     * String dmandSurveyCnvrsPlan을 반환
     * @return String dmandSurveyCnvrsPlan
     */
    public String getDmandSurveyCnvrsPlan() {
        return dmandSurveyCnvrsPlan;
    }

    
    /**
     * dmandSurveyCnvrsPlan을 설정
     * @param dmandSurveyCnvrsPlan 을(를) String dmandSurveyCnvrsPlan로 설정
     */
    public void setDmandSurveyCnvrsPlan(String dmandSurveyCnvrsPlan) {
        this.dmandSurveyCnvrsPlan = dmandSurveyCnvrsPlan;
    }
    
    /**
     * String dmandSurveyPlanCloudSeparation을 반환
     * @return String dmandSurveyPlanCloudSeparation
     */
    public String getDmandSurveyPlanCloudSeparation() {
        return dmandSurveyPlanCloudSeparation;
    }

    
    /**
     * dmandSurveyPlanCloudSeparation을 설정
     * @param dmandSurveyPlanCloudSeparation 을(를) String dmandSurveyPlanCloudSeparation로 설정
     */
    public void setDmandSurveyPlanCloudSeparation(String dmandSurveyPlanCloudSeparation) {
        this.dmandSurveyPlanCloudSeparation = dmandSurveyPlanCloudSeparation;
    }

    
    /**
     * String dmandSurveyPlanServSeparation을 반환
     * @return String dmandSurveyPlanServSeparation
     */
    public String getDmandSurveyPlanServSeparation() {
        return dmandSurveyPlanServSeparation;
    }

    
    /**
     * dmandSurveyPlanServSeparation을 설정
     * @param dmandSurveyPlanServSeparation 을(를) String dmandSurveyPlanServSeparation로 설정
     */
    public void setDmandSurveyPlanServSeparation(String dmandSurveyPlanServSeparation) {
        this.dmandSurveyPlanServSeparation = dmandSurveyPlanServSeparation;
    }

    
    /**
     * String dmandSurveyBudget을 반환
     * @return String dmandSurveyBudget
     */
    public String getDmandSurveyBudget() {
        return dmandSurveyBudget;
    }

    
    /**
     * dmandSurveyBudget을 설정
     * @param dmandSurveyBudget 을(를) String dmandSurveyBudget로 설정
     */
    public void setDmandSurveyBudget(String dmandSurveyBudget) {
        this.dmandSurveyBudget = dmandSurveyBudget;
    }

    
    /**
     * String dmandSurveyVldtySecretAt을 반환
     * @return String dmandSurveyVldtySecretAt
     */
    public String getDmandSurveyVldtySecretAt() {
        return dmandSurveyVldtySecretAt;
    }

    
    /**
     * dmandSurveyVldtySecretAt을 설정
     * @param dmandSurveyVldtySecretAt 을(를) String dmandSurveyVldtySecretAt로 설정
     */
    public void setDmandSurveyVldtySecretAt(String dmandSurveyVldtySecretAt) {
        this.dmandSurveyVldtySecretAt = dmandSurveyVldtySecretAt;
    }

    
    /**
     * String dmandSurveyVldtyFirstecon을 반환
     * @return String dmandSurveyVldtyFirstecon
     */
    public String getDmandSurveyVldtyFirstecon() {
        return dmandSurveyVldtyFirstecon;
    }

    
    /**
     * dmandSurveyVldtyFirstecon을 설정
     * @param dmandSurveyVldtyFirstecon 을(를) String dmandSurveyVldtyFirstecon로 설정
     */
    public void setDmandSurveyVldtyFirstecon(String dmandSurveyVldtyFirstecon) {
        this.dmandSurveyVldtyFirstecon = dmandSurveyVldtyFirstecon;
    }

    
    /**
     * String dmandSurveyStsfdg을 반환
     * @return String dmandSurveyStsfdg
     */
    public String getDmandSurveyStsfdg() {
        return dmandSurveyStsfdg;
    }

    
    /**
     * dmandSurveyStsfdg을 설정
     * @param dmandSurveyStsfdg 을(를) String dmandSurveyStsfdg로 설정
     */
    public void setDmandSurveyStsfdg(String dmandSurveyStsfdg) {
        this.dmandSurveyStsfdg = dmandSurveyStsfdg;
    }

    
    /**
     * String dmandSurveyOpinion을 반환
     * @return String dmandSurveyOpinion
     */
    public String getDmandSurveyOpinion() {
        return dmandSurveyOpinion;
    }

    
    /**
     * dmandSurveyOpinion을 설정
     * @param dmandSurveyOpinion 을(를) String dmandSurveyOpinion로 설정
     */
    public void setDmandSurveyOpinion(String dmandSurveyOpinion) {
        this.dmandSurveyOpinion = dmandSurveyOpinion;
    }

}
