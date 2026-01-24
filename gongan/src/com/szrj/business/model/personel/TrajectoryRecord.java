package com.szrj.business.model.personel;

public class TrajectoryRecord {
	private int id;
	private String phonenumber;//感知手机号
	private String perceivedtime;//感知时间
	private String location;//位置
	private String tracktype;//轨迹类型
	private String pushtime;//推送时间
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getPerceivedtime() {
		return perceivedtime;
	}
	public void setPerceivedtime(String perceivedtime) {
		this.perceivedtime = perceivedtime;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getTracktype() {
		return tracktype;
	}
	public void setTracktype(String tracktype) {
		this.tracktype = tracktype;
	}
	public String getPushtime() {
		return pushtime;
	}
	public void setPushtime(String pushtime) {
		this.pushtime = pushtime;
	}
	
	
	
}
