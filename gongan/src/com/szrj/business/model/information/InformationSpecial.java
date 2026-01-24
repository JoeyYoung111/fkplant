package com.szrj.business.model.information;

/**
 * 专项标签 i_information_special
 * @author 李昊
 * Nov 1, 2021
 */
public class InformationSpecial {
	private Integer id;				//标签id
	private String specialName;		//标签名称
	private Integer departmentid;	//部门id
	private Integer validflag;		//有效表示
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private Integer count;			//数量
	/*------------非数据库字段------------------*/
	/*------------get/set方法-----------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSpecialName() {
		return specialName;
	}
	public void setSpecialName(String specialName) {
		this.specialName = specialName;
	}
	public Integer getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(Integer departmentid) {
		this.departmentid = departmentid;
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
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
}
