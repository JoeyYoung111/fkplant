package com.szrj.business.model;
/**
 *系统日志表 sys_operationlog_t
 *@author:华夏
 *@date:2020-2-24 上午09:13:38
 */
public class Log {
	/*---------------------数据库中字段--------------------------------*/
	private int    id; 							//id
	private String operator;					//操作人
	private String operationTime;				//操作时间
	private int    menuId;						//操作菜单  系统菜单 id
	private String operation;					//操作行为
	private String operationResult;				//操作结果
	private String memo;						//备注信息
	private String operatedept;					//操作部门
	/*---------------------非数据库中字段------------------------------*/
	private String menuname;					//菜单名称
	private String startTime;					//开始时间
	private String endTime;						//结束时间
	private String parentmenuname;				//父菜单名称
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getOperationTime() {
		return operationTime;
	}
	public void setOperationTime(String operationTime) {
		this.operationTime = operationTime;
	}
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	public String getOperationResult() {
		return operationResult;
	}
	public void setOperationResult(String operationResult) {
		this.operationResult = operationResult;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getParentmenuname() {
		return parentmenuname;
	}
	public void setParentmenuname(String parentmenuname) {
		this.parentmenuname = parentmenuname;
	}
	public String getOperatedept() {
		return operatedept;
	}
	public void setOperatedept(String operatedept) {
		this.operatedept = operatedept;
	}
}
