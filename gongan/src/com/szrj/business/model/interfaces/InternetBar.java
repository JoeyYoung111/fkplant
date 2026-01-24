package com.szrj.business.model.interfaces;

public class InternetBar {
	private String insert_time;
	private String USER_NAME;
	private String CERTIFICATE_CODE;
	private String ONLINE_TIME;
	private String OFFLINE_TIME;
	private String SERVICE_NAME;
	private String ADDRESS;
	public String getInsert_time() {
		return insert_time;
	}
	public void setInsert_time(String insert_time) {
		this.insert_time = insert_time;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String user_name) {
		USER_NAME = user_name;
	}
	public String getCERTIFICATE_CODE() {
		return CERTIFICATE_CODE;
	}
	public void setCERTIFICATE_CODE(String certificate_code) {
		CERTIFICATE_CODE = certificate_code;
	}
	public String getONLINE_TIME() {
		return ONLINE_TIME;
	}
	public void setONLINE_TIME(String online_time) {
		ONLINE_TIME = online_time;
	}
	public String getOFFLINE_TIME() {
		return OFFLINE_TIME;
	}
	public void setOFFLINE_TIME(String offline_time) {
		OFFLINE_TIME = offline_time;
	}
	public String getSERVICE_NAME() {
		return SERVICE_NAME;
	}
	public void setSERVICE_NAME(String service_name) {
		SERVICE_NAME = service_name;
	}
	public String getADDRESS() {
		return ADDRESS;
	}
	public void setADDRESS(String address) {
		ADDRESS = address;
	}
	
}
