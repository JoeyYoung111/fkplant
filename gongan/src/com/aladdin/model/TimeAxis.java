package com.aladdin.model;

import java.util.List;

public class TimeAxis {
	private String year;
	private List<AxisEvent> eventList;
	/*---------------------get/set方法-------------------------------*/
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public List<AxisEvent> getEventList() {
		return eventList;
	}
	public void setEventList(List<AxisEvent> eventList) {
		this.eventList = eventList;
	}
}
