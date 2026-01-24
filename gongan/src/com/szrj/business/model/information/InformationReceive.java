package com.szrj.business.model.information;

/**
 * 转阅接收表
 * i_information_receive_t
 */
public class InformationReceive {
	
	private int id;
	private Integer informationid;	//情报信息id i_information_send_t中informationid
	private Integer informationsendid;//转阅前的信息id i_information_send_t中id
	private Integer receiveid;		//接收单位/被转阅部门id
	private Integer validflag;		//1-未签收 2-已签收
	private Integer feedbackflag;	//1-未反馈 2-已反馈
	private String transferoper;	//转阅人
	private Integer transferoperid;	//转阅人id
	private Integer transferdepid;	//转阅人部门id
	private String transfertime;	//转阅时间
	private String signoper;		//签收人
	private Integer signoperid;		//签收人id
	private String signtime;		//签收时间
	private String feedbackoper;	//反馈人
	private Integer feedbackoperid;	//反馈人id
	private String feedbacktime;	//反馈时间
	private String feedbackcontent;	//反馈内容
	/*--------------------非数据库字段-------------------*/
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
	private int specialid;		//专项标签 未专项存0
	private int annotationid;	//最新批注id 批注id
	private int departmentid;	//上报人单位(发送方)
	private String addtime;
	private String starttime;
	private String endtime;
	private String departname;
	private String receivename;
	/*--------------------set/get方法-------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Integer getInformationid() {
		return informationid;
	}
	public void setInformationid(Integer informationid) {
		this.informationid = informationid;
	}
	public Integer getInformationsendid() {
		return informationsendid;
	}
	public void setInformationsendid(Integer informationsendid) {
		this.informationsendid = informationsendid;
	}
	public Integer getReceiveid() {
		return receiveid;
	}
	public void setReceiveid(Integer receiveid) {
		this.receiveid = receiveid;
	}
	public Integer getValidflag() {
		return validflag;
	}
	public void setValidflag(Integer validflag) {
		this.validflag = validflag;
	}
	public String getTransferoper() {
		return transferoper;
	}
	public void setTransferoper(String transferoper) {
		this.transferoper = transferoper;
	}
	public Integer getTransferdepid() {
		return transferdepid;
	}
	public void setTransferdepid(Integer transferdepid) {
		this.transferdepid = transferdepid;
	}
	public String getTransfertime() {
		return transfertime;
	}
	public void setTransfertime(String transfertime) {
		this.transfertime = transfertime;
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
	public Integer getTransferoperid() {
		return transferoperid;
	}
	public void setTransferoperid(Integer transferoperid) {
		this.transferoperid = transferoperid;
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
	public Integer getFeedbackflag() {
		return feedbackflag;
	}
	public void setFeedbackflag(Integer feedbackflag) {
		this.feedbackflag = feedbackflag;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getPointaddress3() {
		return pointaddress3;
	}
	public void setPointaddress3(String pointaddress3) {
		this.pointaddress3 = pointaddress3;
	}
	public String getFeedbackcontent() {
		return feedbackcontent;
	}
	public void setFeedbackcontent(String feedbackcontent) {
		this.feedbackcontent = feedbackcontent;
	}
	

}
