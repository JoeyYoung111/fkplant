package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *社会关系表 p_social_relations_t
 */
public class SocialRelations {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int personnelid;//人员主表id
	private int riskpersonnel;//是否风险人员0-否1-是
	private String gainorigin;//获取来源  走访排查、信息查询、技术分析
	private String relationtype;//关系类别  家庭成员、血缘至亲、近亲姻亲、同行访友、同事朋友
	private String appellation;//称谓
	private String cardnumber;//身份照号
	private String personname;//姓名
	private String homeplace;//现居地
	private String workplace;//工作单位
	private String telnumber1;//联系电话1
	private String telnumber2;//联系电话2
	private String telnumber3;//联系电话3
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
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
	
	public int getRiskpersonnel() {
		return riskpersonnel;
	}
	public void setRiskpersonnel(int riskpersonnel) {
		this.riskpersonnel = riskpersonnel;
	}
	public String getGainorigin() {
		return gainorigin;
	}
	public void setGainorigin(String gainorigin) {
		this.gainorigin = gainorigin;
	}
	public String getRelationtype() {
		return relationtype;
	}
	public void setRelationtype(String relationtype) {
		this.relationtype = relationtype;
	}
	public String getAppellation() {
		return appellation;
	}
	public void setAppellation(String appellation) {
		this.appellation = appellation;
	}
	public String getCardnumber() {
		return cardnumber;
	}
	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}
	public String getPersonname() {
		return personname;
	}
	public void setPersonname(String personname) {
		this.personname = personname;
	}
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getWorkplace() {
		return workplace;
	}
	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}
	public String getTelnumber1() {
		return telnumber1;
	}
	public void setTelnumber1(String telnumber1) {
		this.telnumber1 = telnumber1;
	}
	public String getTelnumber2() {
		return telnumber2;
	}
	public void setTelnumber2(String telnumber2) {
		this.telnumber2 = telnumber2;
	}
	public String getTelnumber3() {
		return telnumber3;
	}
	public void setTelnumber3(String telnumber3) {
		this.telnumber3 = telnumber3;
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
	
}
