package com.szrj.business.model.interfaces;

/**
 * 卡口信息表 f_kakou_t
 * @author 李昊
 * Jan 14, 2022
 */
public class KaKou {
	/*---------------数据库字段---------------------*/
	private int id;
	private String data_origin;			//数据来源
	private String personcard_number;	//身份证号
	private String telephone_number;	//手机号
	private String appear_address;		//出现地址
	private String longitude;			//经度
	private String latitude;			//纬度
	private String appear_time;			//发现时间
	private String kakou_point;			//卡口点位
	private String driver_whether;		//是否驾驶员
	private String vehicle_number;		//车辆号码
	private String vehicle_direction;	//车辆方向
	private String insert_time;			//插入时间
	/*------------------非数据库字段--------------*/
	private int count;					//计算数量
	private String intervaltime;		//间隔时间
	/*------------get/set方法--------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getData_origin() {
		return data_origin;
	}
	public void setData_origin(String data_origin) {
		this.data_origin = data_origin;
	}
	public String getPersoncard_number() {
		return personcard_number;
	}
	public void setPersoncard_number(String personcard_number) {
		this.personcard_number = personcard_number;
	}
	public String getTelephone_number() {
		return telephone_number;
	}
	public void setTelephone_number(String telephone_number) {
		this.telephone_number = telephone_number;
	}
	public String getAppear_address() {
		return appear_address;
	}
	public void setAppear_address(String appear_address) {
		this.appear_address = appear_address;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getAppear_time() {
		return appear_time;
	}
	public void setAppear_time(String appear_time) {
		this.appear_time = appear_time;
	}
	public String getKakou_point() {
		return kakou_point;
	}
	public void setKakou_point(String kakou_point) {
		this.kakou_point = kakou_point;
	}
	public String getDriver_whether() {
		return driver_whether;
	}
	public void setDriver_whether(String driver_whether) {
		this.driver_whether = driver_whether;
	}
	public String getVehicle_number() {
		return vehicle_number;
	}
	public void setVehicle_number(String vehicle_number) {
		this.vehicle_number = vehicle_number;
	}
	public String getVehicle_direction() {
		return vehicle_direction;
	}
	public void setVehicle_direction(String vehicle_direction) {
		this.vehicle_direction = vehicle_direction;
	}
	public String getInsert_time() {
		return insert_time;
	}
	public void setInsert_time(String insert_time) {
		this.insert_time = insert_time;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getIntervaltime() {
		return intervaltime;
	}
	public void setIntervaltime(String intervaltime) {
		this.intervaltime = intervaltime;
	}
}
