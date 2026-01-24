package com.szrj.business.model.interfaces;

import java.util.List;

/**
 * @author huaxia
 * 预警推送
 */
public class Yujing {
	private int id;
	private String modelId;//模型id
	private String model_title;//推送标题
	private String table_name;//推送表名
	private String exec_column;//推送id
	private String create_time;//感知时间
	
	private String result;//感知结果
	private String header;//结果注释
	private String row_key;//结果id
	
	private String cardnumber;//民警身份证
	private String result_status;//结果状态 0-已接收  1-已签收  2-已反馈
	private String result_feedback;//反馈结果
	private String addtime;//接收时间
	private String updatetime;//修改时间
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	public String getExec_column() {
		return exec_column;
	}

	public void setExec_column(String exec_column) {
		this.exec_column = exec_column;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getRow_key() {
		return row_key;
	}

	public void setRow_key(String row_key) {
		this.row_key = row_key;
	}

	public String getResult_status() {
		return result_status;
	}

	public void setResult_status(String result_status) {
		this.result_status = result_status;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}

	public String getCardnumber() {
		return cardnumber;
	}

	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}

	public String getModel_title() {
		return model_title;
	}

	public void setModel_title(String model_title) {
		this.model_title = model_title;
	}

	public String getModelId() {
		return modelId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public String getResult_feedback() {
		return result_feedback;
	}

	public void setResult_feedback(String result_feedback) {
		this.result_feedback = result_feedback;
	}

}
