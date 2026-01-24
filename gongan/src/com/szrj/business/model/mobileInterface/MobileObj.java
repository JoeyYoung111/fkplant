package com.szrj.business.model.mobileInterface;
/**
 *@author:lt
 */
public class MobileObj {
	/*---------------------数据库中字段--------------------------------*/
	private int code; 							//返回编码
	private int currPage;						//当前页
	private String msg;							//返回消息
	private Object results;						//数据
	private int totalPage;						//总页数
	private int totalSize;						//总条数
	/*---------------------非数据库中字段------------------------------*/
	/*---------------------get/set方法-------------------------------*/
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public int getCurrPage() {
		return currPage;
	}
	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getResults() {
		return results;
	}
	public void setResults(Object results) {
		this.results = results;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalSize() {
		return totalSize;
	}
	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}
}
