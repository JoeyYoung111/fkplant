package com.szrj.business.model.personel;

public class JointControlRecord {
	private int id;
	private int personnelid;//人员主表id
	private int wenvisitid;//涉稳关联绑定
	private String jointorigin;//情报来源
	private String infodate;//情报日期
	private String infotype;//情报内容类别
	private String infomemo;//情报内容列表备注
	private String information;//情报内容
	private String cardnumber1;//同行人1身份证号
	private String togethername1;//同行人1姓名
	private String cardnumber2;//同行人2身份证号
	private String togethername2;//同行人2姓名
	private String cardnumber3;//同行人3身份证号
	private String togethername3;//同行人3姓名
	private String cardnumber4;//同行人4身份证号
	private String togethername4;//同行人4姓名
	private String cardnumber5;//同行人5身份证号
	private String togethername5;//同行人5姓名
	private String grouptype;//群类型
	private String groupname;//群名称
	private String groupid;//群ID
	private String vehicletype;//交通工具类型
	private String vehicleinfo;//交通信息
	private String attachments;//附件
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	
	private String attachmentsname;//备注信息
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
	public String getJointorigin() {
		return jointorigin;
	}
	public void setJointorigin(String jointorigin) {
		this.jointorigin = jointorigin;
	}
	public String getInfodate() {
		return infodate;
	}
	public void setInfodate(String infodate) {
		this.infodate = infodate;
	}
	public String getInfotype() {
		return infotype;
	}
	public void setInfotype(String infotype) {
		this.infotype = infotype;
	}
	public String getInfomemo() {
		return infomemo;
	}
	public void setInfomemo(String infomemo) {
		this.infomemo = infomemo;
	}
	public String getInformation() {
		return information;
	}
	public void setInformation(String information) {
		this.information = information;
	}
	public String getCardnumber1() {
		return cardnumber1;
	}
	public void setCardnumber1(String cardnumber1) {
		this.cardnumber1 = cardnumber1;
	}
	public String getTogethername1() {
		return togethername1;
	}
	public void setTogethername1(String togethername1) {
		this.togethername1 = togethername1;
	}
	public String getCardnumber2() {
		return cardnumber2;
	}
	public void setCardnumber2(String cardnumber2) {
		this.cardnumber2 = cardnumber2;
	}
	public String getTogethername2() {
		return togethername2;
	}
	public void setTogethername2(String togethername2) {
		this.togethername2 = togethername2;
	}
	public String getCardnumber3() {
		return cardnumber3;
	}
	public void setCardnumber3(String cardnumber3) {
		this.cardnumber3 = cardnumber3;
	}
	public String getTogethername3() {
		return togethername3;
	}
	public void setTogethername3(String togethername3) {
		this.togethername3 = togethername3;
	}
	public String getCardnumber4() {
		return cardnumber4;
	}
	public void setCardnumber4(String cardnumber4) {
		this.cardnumber4 = cardnumber4;
	}
	public String getTogethername4() {
		return togethername4;
	}
	public void setTogethername4(String togethername4) {
		this.togethername4 = togethername4;
	}
	public String getCardnumber5() {
		return cardnumber5;
	}
	public void setCardnumber5(String cardnumber5) {
		this.cardnumber5 = cardnumber5;
	}
	public String getTogethername5() {
		return togethername5;
	}
	public void setTogethername5(String togethername5) {
		this.togethername5 = togethername5;
	}
	public String getGrouptype() {
		return grouptype;
	}
	public void setGrouptype(String grouptype) {
		this.grouptype = grouptype;
	}
	public String getGroupname() {
		return groupname;
	}
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	public String getGroupid() {
		return groupid;
	}
	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}
	public String getVehicletype() {
		return vehicletype;
	}
	public void setVehicletype(String vehicletype) {
		this.vehicletype = vehicletype;
	}
	public String getVehicleinfo() {
		return vehicleinfo;
	}
	public void setVehicleinfo(String vehicleinfo) {
		this.vehicleinfo = vehicleinfo;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
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
	public String getUpdateoperator() {
		return updateoperator;
	}
	public void setUpdateoperator(String updateoperator) {
		this.updateoperator = updateoperator;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getWenvisitid() {
		return wenvisitid;
	}
	public void setWenvisitid(int wenvisitid) {
		this.wenvisitid = wenvisitid;
	}
	public String getAttachmentsname() {
		return attachmentsname;
	}
	public void setAttachmentsname(String attachmentsname) {
		this.attachmentsname = attachmentsname;
	}
	
	
	
	
}
