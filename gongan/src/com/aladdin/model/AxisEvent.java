package com.aladdin.model;

public class AxisEvent {
	private String eventtype;
	private String eventname;
	private String eventtime;
	private String eventdetail;
	/*---------------------get/set方法-------------------------------*/
	public String getEventname() {
		return eventname;
	}
	public void setEventname(String eventname) {
		this.eventname = eventname;
	}
	public String getEventtime() {
		return eventtime;
	}
	public void setEventtime(String eventtime) {
		this.eventtime = eventtime;
	}
	public String getEventdetail() {
		return eventdetail;
	}
	public void setEventdetail(String eventdetail) {
		this.eventdetail = eventdetail;
	}
	public String getEventtype() {
		return eventtype;
	}
	public void setEventtype(String eventtype) {
		this.eventtype = eventtype;
	}
	
}
