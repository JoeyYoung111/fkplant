package com.szrj.business.model.information;

/**
 * 情报新增涉及人员 联控信息 i_infojointperson_t
 * @author 李昊
 * Oct 13, 2021
 */
public class InfoJointPerson {
	/*------------数据库字段---------------------*/
	private int id;					//自增ID
	private String jointCardNumber;	//身份证
	private String jointTelephone;	//联系电话
	private String jointName;		//姓名
	private String jointNickName;	//昵称绰号
	private String jointWechat;		//微信
	private String jointQQ;			//QQ
	private String jointHousePlace;	//户籍地详址
	private String jointHomePlace;	//居住地详址
	private Integer validflag;		//有效标识
	private Integer isAdd;			//1-新增 2-已有 联控
	private Integer infoTId;		//关联信息表Id
	private String addoperator;		//记录人
	private String addtime;			//记录时间
	/*------------非数据库字段---------------------*/
	private int flag;           //根据不同情况的设置的标示位
	/*-------------get/set方法--------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getJointCardNumber() {
		return jointCardNumber;
	}
	public void setJointCardNumber(String jointCardNumber) {
		this.jointCardNumber = jointCardNumber;
	}
	public String getJointTelephone() {
		return jointTelephone;
	}
	public void setJointTelephone(String jointTelephone) {
		this.jointTelephone = jointTelephone;
	}
	public String getJointName() {
		return jointName;
	}
	public void setJointName(String jointName) {
		this.jointName = jointName;
	}
	public String getJointNickName() {
		return jointNickName;
	}
	public void setJointNickName(String jointNickName) {
		this.jointNickName = jointNickName;
	}
	public String getJointWechat() {
		return jointWechat;
	}
	public void setJointWechat(String jointWechat) {
		this.jointWechat = jointWechat;
	}
	public String getJointQQ() {
		return jointQQ;
	}
	public void setJointQQ(String jointQQ) {
		this.jointQQ = jointQQ;
	}
	public String getJointHousePlace() {
		return jointHousePlace;
	}
	public void setJointHousePlace(String jointHousePlace) {
		this.jointHousePlace = jointHousePlace;
	}
	public String getJointHomePlace() {
		return jointHomePlace;
	}
	public void setJointHomePlace(String jointHomePlace) {
		this.jointHomePlace = jointHomePlace;
	}
	public Integer getValidflag() {
		return validflag;
	}
	public void setValidflag(Integer validflag) {
		this.validflag = validflag;
	}
	public Integer getIsAdd() {
		return isAdd;
	}
	public void setIsAdd(Integer isAdd) {
		this.isAdd = isAdd;
	}
	public Integer getInfoTId() {
		return infoTId;
	}
	public void setInfoTId(Integer infoTId) {
		this.infoTId = infoTId;
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
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	
	
}
