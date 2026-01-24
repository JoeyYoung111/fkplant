package com.szrj.business.model.personel;

public class WenJointControlLevel {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;//人员主表id
	private String jointcontrollevel_old;//联控级别(原始)
	private String jointcontrollevel_new;//联控级别(调整)
	private String applicantreason;//
	private int applicantid;
	private String applicant;//
	private String applicanttime;//
	private int reviewerid;
	private String reviewer;//
	private String reviewertime;//
	private int examinestatus;
	private int examineresult;//
	private String memo;//
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String personname;
	private String cardnumber;
	private String starttime;
	private String endtime;
	private String homepolice;
	//显示权限 0-全部 1-派出所 2-民警 3-责任警种
	private int personFilter;//民警过滤
	private int unitFilter;//派出所字段 
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public String getJointcontrollevel_old() {
		return jointcontrollevel_old;
	}
	public void setJointcontrollevel_old(String jointcontrollevel_old) {
		this.jointcontrollevel_old = jointcontrollevel_old;
	}
	public String getJointcontrollevel_new() {
		return jointcontrollevel_new;
	}
	public void setJointcontrollevel_new(String jointcontrollevel_new) {
		this.jointcontrollevel_new = jointcontrollevel_new;
	}
	public String getApplicantreason() {
		return applicantreason;
	}
	public void setApplicantreason(String applicantreason) {
		this.applicantreason = applicantreason;
	}
	public int getApplicantid() {
		return applicantid;
	}
	public void setApplicantid(int applicantid) {
		this.applicantid = applicantid;
	}
	public String getApplicant() {
		return applicant;
	}
	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}
	public String getApplicanttime() {
		return applicanttime;
	}
	public void setApplicanttime(String applicanttime) {
		this.applicanttime = applicanttime;
	}
	public int getReviewerid() {
		return reviewerid;
	}
	public void setReviewerid(int reviewerid) {
		this.reviewerid = reviewerid;
	}
	public String getReviewer() {
		return reviewer;
	}
	public void setReviewer(String reviewer) {
		this.reviewer = reviewer;
	}
	public String getReviewertime() {
		return reviewertime;
	}
	public void setReviewertime(String reviewertime) {
		this.reviewertime = reviewertime;
	}
	public int getExaminestatus() {
		return examinestatus;
	}
	public void setExaminestatus(int examinestatus) {
		this.examinestatus = examinestatus;
	}
	
	public int getExamineresult() {
		return examineresult;
	}
	public void setExamineresult(int examineresult) {
		this.examineresult = examineresult;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getPersonname() {
		return personname;
	}
	public void setPersonname(String personname) {
		this.personname = personname;
	}
	public String getCardnumber() {
		return cardnumber;
	}
	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getHomepolice() {
		return homepolice;
	}
	public void setHomepolice(String homepolice) {
		this.homepolice = homepolice;
	}
	public int getPersonFilter() {
		return personFilter;
	}
	public void setPersonFilter(int personFilter) {
		this.personFilter = personFilter;
	}
	public int getUnitFilter() {
		return unitFilter;
	}
	public void setUnitFilter(int unitFilter) {
		this.unitFilter = unitFilter;
	}
	
}
