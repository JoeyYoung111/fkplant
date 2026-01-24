package com.szrj.business.model.information;

/**
 * 发布接收表
 * i_information_send_t
 */
public class InformationSend {
	private int id;
	private int informationid;	//情报信息id
	private int receiveid;		//接收单位id
	private int topflag;		//置顶标志 0-否 1-是
	private int hideflag;		//隐藏标志 0-否 1-是
	private int followflag;		//关注标志 0-否 1-是
	private int validflag;		//状态标识 0-作废 1-正常 2-退回 3-签收 4-已反馈
	private String tuihuireason;//退回原因
	private String tuihuitime;	//退回时间
	private String addoperator;	//添加人
	private String addtime;		//添加时间
	private String memo;		//备注信息
	private String signoper;	//退回签收人
	private Integer signoperid;	//退回签收人id
	private String signtime;	//退回签收时间
	private String feedbackoper;//退回签收反馈人
	private Integer feedbackoperid;//退回签收反馈人id
	private String feedbacktime;//退回签收反馈时间
	private int specialid;		//专项标签 未专项存0
	private Integer pizhuid;	//添加工作批注时修改该id
	private Integer ytpizhuid;	//源头批注id
	private String feedbackcontent;//反馈内容
	/*------------非数据库字段--------------------*/
	private int infoid;	//来源信息id 新增存0
	private int infooperate;	//情报来源 1-新增 2-转阅
	private String infotitle;	//标题
	private String infocontent;	//内容
	private String submitunit;	//主报送单位name(接收方)
	private int submitunitid;	//主报送单位id(接收方)
	private String otherunitids;//其他报送单位id(接收方)
	private String otherunit;	//其他报送单位name 1,2(接收方)
	private String infosource;	//情报来源 数据字典存汉字
	private String infotype;	//情报类型
	private String infostate;	//情报状态 已发生、正发生、未发生
	private String urgentflag;	//紧急程度 一般、紧急、重要
	private String isclear;		//是否明确 是/否
	private String pointaddress1;//指向地址
	private String pointaddress2;
	private String pointaddress3;
	private String reviewer;	//核稿人
	private String issuer;		//签发人
	private String attachments;	//照片附件
	private int gatherid;		//采编标签 未采编存0
	private int annotationid;	//最新批注id 批注id
	private int departmentid;	//上报人单位(发送方)
	private String starttime;
	private String endtime;
	private String tuihuistarttime;
	private String tuihuiendtime;
	private String departname;
	private String receivename;
	private String gongzuopizhu;
	private String yuantoupizhu;
	private int validflag2;
	private String specialName;
	/*-------------get/set-----------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getInformationid() {
		return informationid;
	}
	public void setInformationid(int informationid) {
		this.informationid = informationid;
	}
	public int getReceiveid() {
		return receiveid;
	}
	public void setReceiveid(int receiveid) {
		this.receiveid = receiveid;
	}
	public int getTopflag() {
		return topflag;
	}
	public void setTopflag(int topflag) {
		this.topflag = topflag;
	}
	public int getHideflag() {
		return hideflag;
	}
	public void setHideflag(int hideflag) {
		this.hideflag = hideflag;
	}
	public int getFollowflag() {
		return followflag;
	}
	public void setFollowflag(int followflag) {
		this.followflag = followflag;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public String getAddoperator() {
		return addoperator;
	}
	public void setAddoperator(String addoperator) {
		this.addoperator = addoperator;
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
	public int getInfoid() {
		return infoid;
	}
	public void setInfoid(int infoid) {
		this.infoid = infoid;
	}
	public int getInfooperate() {
		return infooperate;
	}
	public void setInfooperate(int infooperate) {
		this.infooperate = infooperate;
	}
	public String getInfotitle() {
		return infotitle;
	}
	public void setInfotitle(String infotitle) {
		this.infotitle = infotitle;
	}
	public String getInfocontent() {
		return infocontent;
	}
	public void setInfocontent(String infocontent) {
		this.infocontent = infocontent;
	}
	public String getSubmitunit() {
		return submitunit;
	}
	public void setSubmitunit(String submitunit) {
		this.submitunit = submitunit;
	}
	public int getSubmitunitid() {
		return submitunitid;
	}
	public void setSubmitunitid(int submitunitid) {
		this.submitunitid = submitunitid;
	}
	public String getOtherunitids() {
		return otherunitids;
	}
	public void setOtherunitids(String otherunitids) {
		this.otherunitids = otherunitids;
	}
	public String getOtherunit() {
		return otherunit;
	}
	public void setOtherunit(String otherunit) {
		this.otherunit = otherunit;
	}
	public String getInfosource() {
		return infosource;
	}
	public void setInfosource(String infosource) {
		this.infosource = infosource;
	}
	public String getInfotype() {
		return infotype;
	}
	public void setInfotype(String infotype) {
		this.infotype = infotype;
	}
	public String getInfostate() {
		return infostate;
	}
	public void setInfostate(String infostate) {
		this.infostate = infostate;
	}
	public String getUrgentflag() {
		return urgentflag;
	}
	public void setUrgentflag(String urgentflag) {
		this.urgentflag = urgentflag;
	}
	public String getIsclear() {
		return isclear;
	}
	public void setIsclear(String isclear) {
		this.isclear = isclear;
	}
	public String getReviewer() {
		return reviewer;
	}
	public void setReviewer(String reviewer) {
		this.reviewer = reviewer;
	}
	public String getIssuer() {
		return issuer;
	}
	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
	}
	public int getGatherid() {
		return gatherid;
	}
	public void setGatherid(int gatherid) {
		this.gatherid = gatherid;
	}
	public int getSpecialid() {
		return specialid;
	}
	public void setSpecialid(int specialid) {
		this.specialid = specialid;
	}
	public int getAnnotationid() {
		return annotationid;
	}
	public void setAnnotationid(int annotationid) {
		this.annotationid = annotationid;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
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
	public String getDepartname() {
		return departname;
	}
	public void setDepartname(String departname) {
		this.departname = departname;
	}
	public String getReceivename() {
		return receivename;
	}
	public void setReceivename(String receivename) {
		this.receivename = receivename;
	}
	public String getTuihuireason() {
		return tuihuireason;
	}
	public void setTuihuireason(String tuihuireason) {
		this.tuihuireason = tuihuireason;
	}
	public String getSignoper() {
		return signoper;
	}
	public void setSignoper(String signoper) {
		this.signoper = signoper;
	}
	public Integer getSignoperid() {
		return signoperid;
	}
	public void setSignoperid(Integer signoperid) {
		this.signoperid = signoperid;
	}
	public String getSigntime() {
		return signtime;
	}
	public void setSigntime(String signtime) {
		this.signtime = signtime;
	}
	public String getFeedbackoper() {
		return feedbackoper;
	}
	public void setFeedbackoper(String feedbackoper) {
		this.feedbackoper = feedbackoper;
	}
	public Integer getFeedbackoperid() {
		return feedbackoperid;
	}
	public void setFeedbackoperid(Integer feedbackoperid) {
		this.feedbackoperid = feedbackoperid;
	}
	public String getFeedbacktime() {
		return feedbacktime;
	}
	public void setFeedbacktime(String feedbacktime) {
		this.feedbacktime = feedbacktime;
	}
	public String getTuihuitime() {
		return tuihuitime;
	}
	public void setTuihuitime(String tuihuitime) {
		this.tuihuitime = tuihuitime;
	}
	public String getPointaddress1() {
		return pointaddress1;
	}
	public void setPointaddress1(String pointaddress1) {
		this.pointaddress1 = pointaddress1;
	}
	public String getPointaddress2() {
		return pointaddress2;
	}
	public void setPointaddress2(String pointaddress2) {
		this.pointaddress2 = pointaddress2;
	}
	public Integer getPizhuid() {
		return pizhuid;
	}
	public void setPizhuid(Integer pizhuid) {
		this.pizhuid = pizhuid;
	}
	public String getGongzuopizhu() {
		return gongzuopizhu;
	}
	public void setGongzuopizhu(String gongzuopizhu) {
		this.gongzuopizhu = gongzuopizhu;
	}
	public Integer getYtpizhuid() {
		return ytpizhuid;
	}
	public void setYtpizhuid(Integer ytpizhuid) {
		this.ytpizhuid = ytpizhuid;
	}
	public String getYuantoupizhu() {
		return yuantoupizhu;
	}
	public void setYuantoupizhu(String yuantoupizhu) {
		this.yuantoupizhu = yuantoupizhu;
	}
	public String getTuihuistarttime() {
		return tuihuistarttime;
	}
	public void setTuihuistarttime(String tuihuistarttime) {
		this.tuihuistarttime = tuihuistarttime;
	}
	public String getTuihuiendtime() {
		return tuihuiendtime;
	}
	public void setTuihuiendtime(String tuihuiendtime) {
		this.tuihuiendtime = tuihuiendtime;
	}
	public int getValidflag2() {
		return validflag2;
	}
	public void setValidflag2(int validflag2) {
		this.validflag2 = validflag2;
	}
	public String getPointaddress3() {
		return pointaddress3;
	}
	public void setPointaddress3(String pointaddress3) {
		this.pointaddress3 = pointaddress3;
	}
	public String getSpecialName() {
		return specialName;
	}
	public void setSpecialName(String specialName) {
		this.specialName = specialName;
	}
	public String getFeedbackcontent() {
		return feedbackcontent;
	}
	public void setFeedbackcontent(String feedbackcontent) {
		this.feedbackcontent = feedbackcontent;
	}
	
	
}
