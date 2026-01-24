package com.szrj.business.model;

/**
 * @author szrj_huaxia
 * @全国轨迹查询信息表 p_trail_information_t 
 */
public class TrailInformation {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int trailtype;//1-全国银行信息 2-全国铁路信息 3-全国民航离港信息 4-全国民航订票信息 5-全国机动车违章信息 6-全国出入境信息
	private String personname;//姓名
	private String cardnumber;//身份证
	private String sexes;//性别
	private String parameter1;
	private String parameter2;
	private String parameter3;
	private String parameter4;
	private String parameter5;
	private String parameter6;
	private String parameter7;
	private String parameter8;
	private String parameter9;
	private String parameter10;
	private String parameter11;
	private String parameter12;
	private String parameter13;
	private String parameter14;
	private String parameter15;
	private int validflag;//状态标识   1：正常 0:作废 
	private String addoperator;//添加人 
	private String addtime;//添加时间 
	private String updateoperator;//最新修改人 
	private String updatetime;//最新修改时间 
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String sortsql;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTrailtype() {
		return trailtype;
	}
	public void setTrailtype(int trailtype) {
		this.trailtype = trailtype;
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
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getParameter1() {
		return parameter1;
	}
	public void setParameter1(String parameter1) {
		this.parameter1 = parameter1;
	}
	public String getParameter2() {
		return parameter2;
	}
	public void setParameter2(String parameter2) {
		this.parameter2 = parameter2;
	}
	public String getParameter3() {
		return parameter3;
	}
	public void setParameter3(String parameter3) {
		this.parameter3 = parameter3;
	}
	public String getParameter4() {
		return parameter4;
	}
	public void setParameter4(String parameter4) {
		this.parameter4 = parameter4;
	}
	public String getParameter5() {
		return parameter5;
	}
	public void setParameter5(String parameter5) {
		this.parameter5 = parameter5;
	}
	public String getParameter6() {
		return parameter6;
	}
	public void setParameter6(String parameter6) {
		this.parameter6 = parameter6;
	}
	public String getParameter7() {
		return parameter7;
	}
	public void setParameter7(String parameter7) {
		this.parameter7 = parameter7;
	}
	public String getParameter8() {
		return parameter8;
	}
	public void setParameter8(String parameter8) {
		this.parameter8 = parameter8;
	}
	public String getParameter9() {
		return parameter9;
	}
	public void setParameter9(String parameter9) {
		this.parameter9 = parameter9;
	}
	public String getParameter10() {
		return parameter10;
	}
	public void setParameter10(String parameter10) {
		this.parameter10 = parameter10;
	}
	public String getParameter11() {
		return parameter11;
	}
	public void setParameter11(String parameter11) {
		this.parameter11 = parameter11;
	}
	public String getParameter12() {
		return parameter12;
	}
	public void setParameter12(String parameter12) {
		this.parameter12 = parameter12;
	}
	public String getParameter13() {
		return parameter13;
	}
	public void setParameter13(String parameter13) {
		this.parameter13 = parameter13;
	}
	public String getParameter14() {
		return parameter14;
	}
	public void setParameter14(String parameter14) {
		this.parameter14 = parameter14;
	}
	public String getParameter15() {
		return parameter15;
	}
	public void setParameter15(String parameter15) {
		this.parameter15 = parameter15;
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
	public String getSortsql() {
		return sortsql;
	}
	public void setSortsql(String sortsql) {
		this.sortsql = sortsql;
	}
	
}
