package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *风险人员-现实表现 p_reality_show_t
 */
public class RealityShow {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID
	private int datalabel;//数据标签  1-涉稳2-涉黑3-涉恐4-涉毒
	private int personnelid;//人员主表id
	private String lifepattern;//日常生活规律
	private String healthstate;//健康状况
	private String characteristic;//性格特点
	private String lifehabit;//生活习惯
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
	public int getDatalabel() {
		return datalabel;
	}
	public void setDatalabel(int datalabel) {
		this.datalabel = datalabel;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public String getLifepattern() {
		return lifepattern;
	}
	public void setLifepattern(String lifepattern) {
		this.lifepattern = lifepattern;
	}
	public String getHealthstate() {
		return healthstate;
	}
	public void setHealthstate(String healthstate) {
		this.healthstate = healthstate;
	}
	public String getCharacteristic() {
		return characteristic;
	}
	public void setCharacteristic(String characteristic) {
		this.characteristic = characteristic;
	}
	public String getLifehabit() {
		return lifehabit;
	}
	public void setLifehabit(String lifehabit) {
		this.lifehabit = lifehabit;
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
