package com.szrj.business.model.personel;

public class ZaChang {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;		//人员主表id
	private String chang_lsscqk;	//历史涉嫖情况综述
	private String chang_scjs;		//涉娼角色(人员属性)(数据字典)
	private String chang_scbw;		//涉娼部位(数据字典)
	private String chang_myfs;		//卖淫方式(涉黄方式)(数据字典)
	private String chang_chsj;		//处罚时间
	private String chang_chjg;		//查获经过
	private String chang_cfjg;		//处罚结果
	private String chang_clxq;		//处理详情
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//备注信息
	private int validflag;			//状态标识   1：正常 0:作废

	// 新增字段
    private String changType;		//涉黄类型(数据字典)
	private String collectSource;	//采集来源(案件/警情/日常工作发现)
	private String otherMemo;		//其他备注
	private int isMinorCase;		//是否属于未成年案件 0-否 1-是

	// 现住地结构化字段
	private String homeProvince;	//现住-省
	private String homeCity;		//现住-地级市
	private String homeCounty;		//现住-县级市/区
	private String homeTown;		//现住-镇/街道
	private Integer homePoliceStationId;	//现住-所属派出所ID(关联sys_department_t_new.id)
	private String homePoliceStationName;	//派出所名称(非数据库字段,用于展示)
	private String homeDetail;		//现住-详细地址
	private String homeLng;			//现住-经度
	private String homeLat;			//现住-纬度

	// 其他新增字段
	private int hasShechangRecord;	//涉黄前科 0-否 1-是
	private String handleUnitCode;	//打处单位编码
	private String phone;			//手机号码
	private String caseAddressList;	//涉案地址列表，多个地址用逗号分隔
	private String collectDate;		//采集日期

	// 关联信息字段（非数据库字段，用于列表展示）
	private String relAjIds;		//关联的案件ID列表，逗号分隔
	private String relJqIds;		//关联的警情ID列表，逗号分隔

	/*---------------------------------------非数据库中字段-------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public String getChang_lsscqk() {
		return chang_lsscqk;
	}
	public void setChang_lsscqk(String chang_lsscqk) {
		this.chang_lsscqk = chang_lsscqk;
	}
	public String getChang_scjs() {
		return chang_scjs;
	}
	public void setChang_scjs(String chang_scjs) {
		this.chang_scjs = chang_scjs;
	}
	public String getChang_scbw() {
		return chang_scbw;
	}
	public void setChang_scbw(String chang_scbw) {
		this.chang_scbw = chang_scbw;
	}
	public String getChang_myfs() {
		return chang_myfs;
	}
	public void setChang_myfs(String chang_myfs) {
		this.chang_myfs = chang_myfs;
	}
	public String getChang_chsj() {
		return chang_chsj;
	}
	public void setChang_chsj(String chang_chsj) {
		this.chang_chsj = chang_chsj;
	}
	public String getChang_chjg() {
		return chang_chjg;
	}
	public void setChang_chjg(String chang_chjg) {
		this.chang_chjg = chang_chjg;
	}
	public String getChang_cfjg() {
		return chang_cfjg;
	}
	public void setChang_cfjg(String chang_cfjg) {
		this.chang_cfjg = chang_cfjg;
	}
	public String getChang_clxq() {
		return chang_clxq;
	}
	public void setChang_clxq(String chang_clxq) {
		this.chang_clxq = chang_clxq;
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
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	
	// 新增字段的getter/setter
    public String getChangType() {
		return changType;
	}
	public void setChangType(String changType) {
		this.changType = changType;
	}
	public String getCollectSource() {
		return collectSource;
	}
	public void setCollectSource(String collectSource) {
		this.collectSource = collectSource;
	}
	public String getOtherMemo() {
		return otherMemo;
	}
	public void setOtherMemo(String otherMemo) {
		this.otherMemo = otherMemo;
	}
	public int getIsMinorCase() {
		return isMinorCase;
	}
	public void setIsMinorCase(int isMinorCase) {
		this.isMinorCase = isMinorCase;
	}
	public String getHomeProvince() {
		return homeProvince;
	}
	public void setHomeProvince(String homeProvince) {
		this.homeProvince = homeProvince;
	}
	public String getHomeCity() {
		return homeCity;
	}
	public void setHomeCity(String homeCity) {
		this.homeCity = homeCity;
	}
	public String getHomeCounty() {
		return homeCounty;
	}
	public void setHomeCounty(String homeCounty) {
		this.homeCounty = homeCounty;
	}
	public String getHomeTown() {
		return homeTown;
	}
	public void setHomeTown(String homeTown) {
		this.homeTown = homeTown;
	}
	public Integer getHomePoliceStationId() {
		return homePoliceStationId;
	}
	public void setHomePoliceStationId(Integer homePoliceStationId) {
		this.homePoliceStationId = homePoliceStationId;
	}
	public String getHomePoliceStationName() {
		return homePoliceStationName;
	}
	public void setHomePoliceStationName(String homePoliceStationName) {
		this.homePoliceStationName = homePoliceStationName;
	}
	public String getHomeDetail() {
		return homeDetail;
	}
	public void setHomeDetail(String homeDetail) {
		this.homeDetail = homeDetail;
	}
	public String getHomeLng() {
		return homeLng;
	}
	public void setHomeLng(String homeLng) {
		this.homeLng = homeLng;
	}
	public String getHomeLat() {
		return homeLat;
	}
	public void setHomeLat(String homeLat) {
		this.homeLat = homeLat;
	}
	public int getHasShechangRecord() {
		return hasShechangRecord;
	}
	public void setHasShechangRecord(int hasShechangRecord) {
		this.hasShechangRecord = hasShechangRecord;
	}
	public String getHandleUnitCode() {
		return handleUnitCode;
	}
	public void setHandleUnitCode(String handleUnitCode) {
		this.handleUnitCode = handleUnitCode;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
    public String getCaseAddressList() {
		return caseAddressList;
	}
	public void setCaseAddressList(String caseAddressList) {
		this.caseAddressList = caseAddressList;
	}
	public String getCollectDate() {
		return collectDate;
	}
	public void setCollectDate(String collectDate) {
		this.collectDate = collectDate;
	}
	public String getRelAjIds() {
		return relAjIds;
	}
	public void setRelAjIds(String relAjIds) {
		this.relAjIds = relAjIds;
	}
	public String getRelJqIds() {
		return relJqIds;
	}
	public void setRelJqIds(String relJqIds) {
		this.relJqIds = relJqIds;
	}

	// VO层方法：将逗号分隔的字符串转换为List
	public java.util.List<String> getCaseAddressArray() {
		if (caseAddressList == null || caseAddressList.trim().isEmpty()) {
			return java.util.Collections.emptyList();
		}
		return java.util.Arrays.asList(caseAddressList.split("，"));
	}

	// VO层方法：将List转换为逗号分隔的字符串
	public void setCaseAddressArray(java.util.List<String> list) {
		if (list == null || list.isEmpty()) {
			this.caseAddressList = null;
		} else {
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < list.size(); i++) {
				if (i > 0) {
					sb.append("，");
				}
				sb.append(list.get(i));
			}
			this.caseAddressList = sb.toString();
		}
	}

}
