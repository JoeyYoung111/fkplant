package com.szrj.business.model.information;

/**
 * 情报交办信息 i_information_assign_t
 * @author 李昊
 * Oct 14, 2021
 */
public class InfoAssign {

	private Integer id;				//自增ID
	private Integer informationid;	//来源信息id 新增存0
	private String assigntitle;		//标题
	private String assigncontent;	//内容
	private String signdepartment;	//签收单位name 多选，多个部门逗号隔开
	private String signdepartids;	//签收单位id
	private String instructions;	//领导批示
	private String judgeopinion;	//研判意见
	private String requirements;	//工作要求
	private String issuer;			//签发人 填写
	private String category;		//类别 核查性、指令性、指导性、督办性
	private String urgentflag;		//紧急程度 红色、橙色、蓝色
	private String signlimit;		//签收时限
	private String feedbacklimit;	//反馈时限
	private String attachments;		//附件
	private Integer validflag;		//状态标识
	private String addoperator;		//添加人/承办人
	private String departmentid;	//承办人部门
	private String contactnumber;	//联系电话
	private String addtime;			//添加时间
	private String memo;			//备注信息
	private String slimit;
	private String flimit;
	/*----------------------------*/
	private String receivename;
	private String departmentname;
	/*----------------------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getInformationid() {
		return informationid;
	}
	public void setInformationid(Integer informationid) {
		this.informationid = informationid;
	}
	public String getAssigntitle() {
		return assigntitle;
	}
	public void setAssigntitle(String assigntitle) {
		this.assigntitle = assigntitle;
	}
	public String getAssigncontent() {
		return assigncontent;
	}
	public void setAssigncontent(String assigncontent) {
		this.assigncontent = assigncontent;
	}
	public String getSigndepartment() {
		return signdepartment;
	}
	public void setSigndepartment(String signdepartment) {
		this.signdepartment = signdepartment;
	}
	public String getSigndepartids() {
		return signdepartids;
	}
	public void setSigndepartids(String signdepartids) {
		this.signdepartids = signdepartids;
	}
	public String getInstructions() {
		return instructions;
	}
	public void setInstructions(String instructions) {
		this.instructions = instructions;
	}
	public String getJudgeopinion() {
		return judgeopinion;
	}
	public void setJudgeopinion(String judgeopinion) {
		this.judgeopinion = judgeopinion;
	}
	public String getRequirements() {
		return requirements;
	}
	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}
	public String getIssuer() {
		return issuer;
	}
	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getUrgentflag() {
		return urgentflag;
	}
	public void setUrgentflag(String urgentflag) {
		this.urgentflag = urgentflag;
	}
	public String getSignlimit() {
		return signlimit;
	}
	public void setSignlimit(String signlimit) {
		this.signlimit = signlimit;
	}
	public String getFeedbacklimit() {
		return feedbacklimit;
	}
	public void setFeedbacklimit(String feedbacklimit) {
		this.feedbacklimit = feedbacklimit;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
	}
	public Integer getValidflag() {
		return validflag;
	}
	public void setValidflag(Integer validflag) {
		this.validflag = validflag;
	}
	public String getAddoperator() {
		return addoperator;
	}
	public void setAddoperator(String addoperator) {
		this.addoperator = addoperator;
	}
	public String getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(String departmentid) {
		this.departmentid = departmentid;
	}
	public String getContactnumber() {
		return contactnumber;
	}
	public void setContactnumber(String contactnumber) {
		this.contactnumber = contactnumber;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getReceivename() {
		return receivename;
	}
	public void setReceivename(String receivename) {
		this.receivename = receivename;
	}
	public String getDepartmentname() {
		return departmentname;
	}
	public void setDepartmentname(String departmentname) {
		this.departmentname = departmentname;
	}
	public String getSlimit() {
		return slimit;
	}
	public void setSlimit(String slimit) {
		this.slimit = slimit;
	}
	public String getFlimit() {
		return flimit;
	}
	public void setFlimit(String flimit) {
		this.flimit = flimit;
	}
	
}
