package com.szrj.business.model.information;


/**
 * 情报信息表 i_information_t
 * @author 李昊
 * Oct 8, 2021
 */
public class Information {
	/*----------数据库中字段-------------------*/
	private int id;				//自增id
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
	private String pointaddress3;//地址描述
	private String reviewer;	//核稿人
	private String issuer;		//签发人
	private String attachments;	//照片附件
	private int gatherid;		//采编标签 未采编存0
	private int annotationid;	//最新批注id 批注id
	private int validflag;		//状态标识
	private String addoperator;	//上报人(发送方)
	private String addtime;		//上报时间(发送方)
	private int departmentid;	//上报人单位(发送方)
	/*----------非数据库中字段-------------------*/
	private String starttime;
	private String endtime;
	private String departname;
	private String receivename;
	private String yuantoupizhu;
	private int value;			//计数
	private int departtype;		//部门类型
	/*-------------set/get----------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public int getAnnotationid() {
		return annotationid;
	}
	public void setAnnotationid(int annotationid) {
		this.annotationid = annotationid;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(int departmentid) {
		this.departmentid = departmentid;
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
	public String getYuantoupizhu() {
		return yuantoupizhu;
	}
	public void setYuantoupizhu(String yuantoupizhu) {
		this.yuantoupizhu = yuantoupizhu;
	}
	public String getPointaddress3() {
		return pointaddress3;
	}
	public void setPointaddress3(String pointaddress3) {
		this.pointaddress3 = pointaddress3;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public int getDeparttype() {
		return departtype;
	}
	public void setDeparttype(int departtype) {
		this.departtype = departtype;
	}
}
