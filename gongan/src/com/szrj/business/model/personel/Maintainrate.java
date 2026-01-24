package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 * @风险人员维护率表 p_maintainrate_t 
 */
public class Maintainrate {
	private int id;
	private int personnelid;
	private int personlabel;//人员标签1-涉稳、2-涉恐、3-涉黑、4-涉毒、5-电诈
	private int parameter1;//涉稳-基本信息
	private int parameter2;//涉稳-头像照片
	private int parameter3;//涉稳-现实表现
	private int parameter4;//涉稳-关联信息
	private int parameter5;//涉稳-风险背景
	private int parameter6;//涉稳-涉诉涉访经历
	private int parameter7;//涉稳-联控记录
	private int parameter8;//涉稳-社会关系
	private int parameter9;//涉稳-暂无
	private int parameter10;//涉稳-暂无
	private int totalpoints;//总分
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
	public int getPersonlabel() {
		return personlabel;
	}
	public void setPersonlabel(int personlabel) {
		this.personlabel = personlabel;
	}
	public int getParameter1() {
		return parameter1;
	}
	public void setParameter1(int parameter1) {
		this.parameter1 = parameter1;
	}
	public int getParameter2() {
		return parameter2;
	}
	public void setParameter2(int parameter2) {
		this.parameter2 = parameter2;
	}
	public int getParameter3() {
		return parameter3;
	}
	public void setParameter3(int parameter3) {
		this.parameter3 = parameter3;
	}
	public int getParameter4() {
		return parameter4;
	}
	public void setParameter4(int parameter4) {
		this.parameter4 = parameter4;
	}
	public int getParameter5() {
		return parameter5;
	}
	public void setParameter5(int parameter5) {
		this.parameter5 = parameter5;
	}
	public int getParameter6() {
		return parameter6;
	}
	public void setParameter6(int parameter6) {
		this.parameter6 = parameter6;
	}
	public int getParameter7() {
		return parameter7;
	}
	public void setParameter7(int parameter7) {
		this.parameter7 = parameter7;
	}
	public int getParameter8() {
		return parameter8;
	}
	public void setParameter8(int parameter8) {
		this.parameter8 = parameter8;
	}
	public int getParameter9() {
		return parameter9;
	}
	public void setParameter9(int parameter9) {
		this.parameter9 = parameter9;
	}
	public int getParameter10() {
		return parameter10;
	}
	public void setParameter10(int parameter10) {
		this.parameter10 = parameter10;
	}
	public int getTotalpoints() {
		return totalpoints;
	}
	public void setTotalpoints(int totalpoints) {
		this.totalpoints = totalpoints;
	}
	
	
}
