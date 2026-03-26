package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *风险人员基本信息主表 p_personnel_t
 */
public class Personnel {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private Integer id;
	private String personlabel;//人员标签
	private String attributelabels;//属性标签id
	private String cardnumber;//身份证号
	private String personname;//姓名
	private String usedname;//曾用名
	private String nickname;//绰号
	private String sexes;//性别
	private String personheight;//身高
	private String nation;//民族
	private String marrystatus;//婚姻状态
	private String education;//文化程度
	private String netskillhabit;//有无网络社交技能习惯
	private String persontype;//人员类别
	private String soldierstatus;//兵役情况
	private String heathstatus;//健康状态
	private String politicalposition;//政治面貌
	private String faith;//宗教信仰
	private String houseplace;//户籍地详址
	private String housepolice;//户籍地派出所
	private String homeplace;//现住地详址
	private String homepolice;//现住地派出所
	private String homewifi;//居住地wifi
	private String homewide;//居住地 宽带
	private String housex;//户籍地经度
	private String housey;//户籍地纬度
	private String homex;//居住地经度
	private String homey;//居住地纬度
	private String workx;//工作地经度
	private String worky;//工作地纬度
	private String workplace;//工作地详址
	private String workpolice;//工作地派出所
	private String workwifi;//工作地wifi
	private String workwide;//工作地 宽带
	private String feature;//特殊特征
	private String speciality;//技能专长
	private String records;//前科劣迹
	private String checkmethod;//信息核查方式
	private Integer maintainrate1;//维护率1
	private Integer maintainrate2;//维护率2
	private Integer maintainrate3;//维护率3
	private Integer maintainrate4;//维护率4
	private Integer validflag;//状态标识
	private String addoperator;//添加人
	private Integer addoperatorid;//添加人id
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	private String jdunit1;//管辖责任单位
	private String jdpolice1;//管辖责任民警
	private String pphone1;//管辖责任民警手机
	private String jdunit2;//双管辖责任单位
	private String jdpolice2;//双管辖责任民警
	private String pphone2;//双管辖责任民警电话
	private String lslabel1;//临时标签1级
	private String lslabel2;//临时标签子级
	private String zslabel1;//正式标签1级
	private String zslabel2;//正式标签子级
	private Integer isrisk;		//是否是风险人员（1-是 2-不是）
	private String cytype;	//从业人员类型
	private String control_power;	//管控力量-人员
	private String control_plan;	//管控方案-附件
	private String control_emergency;	//应急预案-附件

	// 新增：户籍地址结构化字段
	private String houseProvince;	//户籍-省
	private String houseCity;		//户籍-地级市
	private String houseCounty;		//户籍-县级市/区
	private String houseTown;		//户籍-镇/街道
	private Integer housePoliceStationId;	//户籍-所属派出所ID(关联sys_department_t_new.id)
	private String housePoliceStationName;	//户籍派出所名称(非数据库字段)

	// 新增：现住地址结构化字段
	private String homeProvince;	//现住-省
	private String homeCity;		//现住-地级市
	private String homeCounty;		//现住-县级市/区
	private String homeTown;		//现住-镇/街道
	private Integer homePoliceStationId;	//现住-所属派出所ID(关联sys_department_t_new.id)
	private String homePoliceStationName;	//派出所名称(非数据库字段)


	// 新增：前科标识
	private Integer hasSheduRecord;		//是否有涉赌前科 0-无 1-有
	private Integer hasSechangRecord;	//是否有涉黄前科 0-无 1-有
	private Integer isPeishi;			//是否陪侍人员 0-否 1-是
	private Integer isMinor;			//是否未成年 0-否 1-是

	// 新增：打处单位
	private String handleUnit;		//打处单位(外部接口获取)
	private String handleUnitCode;	//打处单位编码


	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String jurisdictunit;//管辖单位
	private String jurisdictpolice;//管辖民警
	private String policephone;//管辖民警电话
	private String incontrolleve;//在控状态
	private String birthday;	//生日
	private String sqlall;//查询语句（综合）
	private String fileallName;//文件全名
	private String jointcontrollevel;//联控级别  数据字典汉字
	private String personlabelname;//人员标签名称
	private String attributelabelname;//自定义人员标签名称
	private Integer personcount;//人员计数
	private String appellation;//人员关系
	private Integer relationid;//relation表Id
	private Integer riskpersonnel;//是否是危险人物
	//显示权限 0-全部 1-派出所 2-民警 3-责任警种
	private Integer personFilter;//民警过滤
	private Integer unitFilter;//派出所字段
	private String telnumber;//名下手机号
	private String personneltype;//新增风险人员时人员类别
	private Integer personnelid;
	private Integer ajcount;	//涉案信息数量
	private Integer jqcount;	//涉警信息数量
	//排序
	private String sortsql;
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCardnumber() {
		return cardnumber;
	}
	public void setCardnumber(String cardnumber) {
		this.cardnumber = cardnumber;
	}
	public String getPersonname() {
		return personname;
	}
	public void setPersonname(String personname) {
		this.personname = personname;
	}
	public String getUsedname() {
		return usedname;
	}
	public void setUsedname(String usedname) {
		this.usedname = usedname;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getMarrystatus() {
		return marrystatus;
	}
	public void setMarrystatus(String marrystatus) {
		this.marrystatus = marrystatus;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getPersontype() {
		return persontype;
	}
	public void setPersontype(String persontype) {
		this.persontype = persontype;
	}
	public String getSoldierstatus() {
		return soldierstatus;
	}
	public void setSoldierstatus(String soldierstatus) {
		this.soldierstatus = soldierstatus;
	}
	public String getHouseplace() {
		return houseplace;
	}
	public void setHouseplace(String houseplace) {
		this.houseplace = houseplace;
	}
	public String getHousepolice() {
		return housepolice;
	}
	public void setHousepolice(String housepolice) {
		this.housepolice = housepolice;
	}
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getHomepolice() {
		return homepolice;
	}
	public void setHomepolice(String homepolice) {
		this.homepolice = homepolice;
	}
	public String getHomewifi() {
		return homewifi;
	}
	public void setHomewifi(String homewifi) {
		this.homewifi = homewifi;
	}
	public String getHomewide() {
		return homewide;
	}
	public void setHomewide(String homewide) {
		this.homewide = homewide;
	}
	public String getWorkplace() {
		return workplace;
	}
	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}
	public String getWorkpolice() {
		return workpolice;
	}
	public void setWorkpolice(String workpolice) {
		this.workpolice = workpolice;
	}
	public String getWorkwifi() {
		return workwifi;
	}
	public void setWorkwifi(String workwifi) {
		this.workwifi = workwifi;
	}
	public String getWorkwide() {
		return workwide;
	}
	public void setWorkwide(String workwide) {
		this.workwide = workwide;
	}
	public String getFeature() {
		return feature;
	}
	public void setFeature(String feature) {
		this.feature = feature;
	}
	public String getSpeciality() {
		return speciality;
	}
	public void setSpeciality(String speciality) {
		this.speciality = speciality;
	}
	public String getRecords() {
		return records;
	}
	public void setRecords(String records) {
		this.records = records;
	}
	public String getCheckmethod() {
		return checkmethod;
	}
	public void setCheckmethod(String checkmethod) {
		this.checkmethod = checkmethod;
	}
	public String getPersonlabel() {
		return personlabel;
	}
	public void setPersonlabel(String personlabel) {
		this.personlabel = personlabel;
	}
	public Integer getMaintainrate1() {
		return maintainrate1;
	}
	public void setMaintainrate1(Integer maintainrate1) {
		this.maintainrate1 = maintainrate1;
	}
	public Integer getMaintainrate2() {
		return maintainrate2;
	}
	public void setMaintainrate2(Integer maintainrate2) {
		this.maintainrate2 = maintainrate2;
	}
	public Integer getMaintainrate3() {
		return maintainrate3;
	}
	public void setMaintainrate3(Integer maintainrate3) {
		this.maintainrate3 = maintainrate3;
	}
	public Integer getMaintainrate4() {
		return maintainrate4;
	}
	public void setMaintainrate4(Integer maintainrate4) {
		this.maintainrate4 = maintainrate4;
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
	public Integer getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(Integer addoperatorid) {
		this.addoperatorid = addoperatorid;
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
	public String getJurisdictunit() {
		return jurisdictunit;
	}
	public void setJurisdictunit(String jurisdictunit) {
		this.jurisdictunit = jurisdictunit;
	}
	public String getJurisdictpolice() {
		return jurisdictpolice;
	}
	public void setJurisdictpolice(String jurisdictpolice) {
		this.jurisdictpolice = jurisdictpolice;
	}
	public String getPolicephone() {
		return policephone;
	}
	public void setPolicephone(String policephone) {
		this.policephone = policephone;
	}
	public String getIncontrolleve() {
		return incontrolleve;
	}
	public void setIncontrolleve(String incontrolleve) {
		this.incontrolleve = incontrolleve;
	}
	public String getHeathstatus() {
		return heathstatus;
	}
	public void setHeathstatus(String heathstatus) {
		this.heathstatus = heathstatus;
	}
	public String getPoliticalposition() {
		return politicalposition;
	}
	public void setPoliticalposition(String politicalposition) {
		this.politicalposition = politicalposition;
	}
	public String getFaith() {
		return faith;
	}
	public void setFaith(String faith) {
		this.faith = faith;
	}
	public String getPersonheight() {
		return personheight;
	}
	public void setPersonheight(String personheight) {
		this.personheight = personheight;
	}
	public String getNetskillhabit() {
		return netskillhabit;
	}
	public void setNetskillhabit(String netskillhabit) {
		this.netskillhabit = netskillhabit;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getSqlall() {
		return sqlall;
	}
	public void setSqlall(String sqlall) {
		this.sqlall = sqlall;
	}
	public String getFileallName() {
		return fileallName;
	}
	public void setFileallName(String fileallName) {
		this.fileallName = fileallName;
	}
	public String getJointcontrollevel() {
		return jointcontrollevel;
	}
	public void setJointcontrollevel(String jointcontrollevel) {
		this.jointcontrollevel = jointcontrollevel;
	}
	public String getPersonlabelname() {
		return personlabelname;
	}
	public void setPersonlabelname(String personlabelname) {
		this.personlabelname = personlabelname;
	}
	public Integer getPersoncount() {
		return personcount;
	}
	public void setPersoncount(Integer personcount) {
		this.personcount = personcount;
	}
	public String getAppellation() {
		return appellation;
	}
	public void setAppellation(String appellation) {
		this.appellation = appellation;
	}
	public Integer getRelationid() {
		return relationid;
	}
	public void setRelationid(Integer relationid) {
		this.relationid = relationid;
	}
	public Integer getRiskpersonnel() {
		return riskpersonnel;
	}
	public void setRiskpersonnel(Integer riskpersonnel) {
		this.riskpersonnel = riskpersonnel;
	}
	public String getAttributelabels() {
		return attributelabels;
	}
	public void setAttributelabels(String attributelabels) {
		this.attributelabels = attributelabels;
	}
	public String getAttributelabelname() {
		return attributelabelname;
	}
	public void setAttributelabelname(String attributelabelname) {
		this.attributelabelname = attributelabelname;
	}
	public String getJdunit1() {
		return jdunit1;
	}
	public void setJdunit1(String jdunit1) {
		this.jdunit1 = jdunit1;
	}
	public String getJdpolice1() {
		return jdpolice1;
	}
	public void setJdpolice1(String jdpolice1) {
		this.jdpolice1 = jdpolice1;
	}
	public String getPphone1() {
		return pphone1;
	}
	public void setPphone1(String pphone1) {
		this.pphone1 = pphone1;
	}
	public String getJdunit2() {
		return jdunit2;
	}
	public void setJdunit2(String jdunit2) {
		this.jdunit2 = jdunit2;
	}
	public String getJdpolice2() {
		return jdpolice2;
	}
	public void setJdpolice2(String jdpolice2) {
		this.jdpolice2 = jdpolice2;
	}
	public String getPphone2() {
		return pphone2;
	}
	public void setPphone2(String pphone2) {
		this.pphone2 = pphone2;
	}
	public String getLslabel1() {
		return lslabel1;
	}
	public void setLslabel1(String lslabel1) {
		this.lslabel1 = lslabel1;
	}
	public String getLslabel2() {
		return lslabel2;
	}
	public void setLslabel2(String lslabel2) {
		this.lslabel2 = lslabel2;
	}
	public String getZslabel1() {
		return zslabel1;
	}
	public void setZslabel1(String zslabel1) {
		this.zslabel1 = zslabel1;
	}
	public String getZslabel2() {
		return zslabel2;
	}
	public void setZslabel2(String zslabel2) {
		this.zslabel2 = zslabel2;
	}
	public Integer getPersonFilter() {
		return personFilter;
	}
	public void setPersonFilter(Integer personFilter) {
		this.personFilter = personFilter;
	}
	public Integer getUnitFilter() {
		return unitFilter;
	}
	public void setUnitFilter(Integer unitFilter) {
		this.unitFilter = unitFilter;
	}
	public String getTelnumber() {
		return telnumber;
	}
	public void setTelnumber(String telnumber) {
		this.telnumber = telnumber;
	}
	public String getPersonneltype() {
		return personneltype;
	}
	public void setPersonneltype(String personneltype) {
		this.personneltype = personneltype;
	}
	public Integer getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(Integer personnelid) {
		this.personnelid = personnelid;
	}
	public Integer getIsrisk() {
		return isrisk;
	}
	public void setIsrisk(Integer isrisk) {
		this.isrisk = isrisk;
	}
	public Integer getAjcount() {
		return ajcount;
	}
	public void setAjcount(Integer ajcount) {
		this.ajcount = ajcount;
	}
	public Integer getJqcount() {
		return jqcount;
	}
	public void setJqcount(Integer jqcount) {
		this.jqcount = jqcount;
	}
	public String getHousex() {
		return housex;
	}
	public void setHousex(String housex) {
		this.housex = housex;
	}
	public String getHousey() {
		return housey;
	}
	public void setHousey(String housey) {
		this.housey = housey;
	}
	public String getHomex() {
		return homex;
	}
	public void setHomex(String homex) {
		this.homex = homex;
	}
	public String getHomey() {
		return homey;
	}
	public void setHomey(String homey) {
		this.homey = homey;
	}
	public String getWorkx() {
		return workx;
	}
	public void setWorkx(String workx) {
		this.workx = workx;
	}
	public String getWorky() {
		return worky;
	}
	public void setWorky(String worky) {
		this.worky = worky;
	}
	public String getCytype() {
		return cytype;
	}
	public void setCytype(String cytype) {
		this.cytype = cytype;
	}
	public String getSortsql() {
		return sortsql;
	}
	public void setSortsql(String sortsql) {
		this.sortsql = sortsql;
	}

	public String getControl_power() {
		return control_power;
	}

	public void setControl_power(String control_power) {
		this.control_power = control_power;
	}

	public String getControl_plan() {
		return control_plan;
	}

	public void setControl_plan(String control_plan) {
		this.control_plan = control_plan;
	}

	public String getControl_emergency() {
		return control_emergency;
	}

	public void setControl_emergency(String control_emergency) {
		this.control_emergency = control_emergency;
	}

	// 新增字段getter/setter
	public String getHouseCity() {
		return houseCity;
	}
	public void setHouseCity(String houseCity) {
		this.houseCity = houseCity;
	}
	public String getHouseCounty() {
		return houseCounty;
	}
	public void setHouseCounty(String houseCounty) {
		this.houseCounty = houseCounty;
	}
	public String getHouseTown() {
		return houseTown;
	}
	public void setHouseTown(String houseTown) {
		this.houseTown = houseTown;
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
    public Integer getHasSheduRecord() {
		return hasSheduRecord;
	}
	public void setHasSheduRecord(Integer hasSheduRecord) {
		this.hasSheduRecord = hasSheduRecord;
	}
	public Integer getHasSechangRecord() {
		return hasSechangRecord;
	}
	public void setHasSechangRecord(Integer hasSechangRecord) {
		this.hasSechangRecord = hasSechangRecord;
	}
	public Integer getIsPeishi() {
		return isPeishi;
	}
	public void setIsPeishi(Integer isPeishi) {
		this.isPeishi = isPeishi;
	}
	public Integer getIsMinor() {
		return isMinor;
	}
	public void setIsMinor(Integer isMinor) {
		this.isMinor = isMinor;
	}
	public String getHandleUnit() {
		return handleUnit;
	}
	public void setHandleUnit(String handleUnit) {
		this.handleUnit = handleUnit;
	}
	public String getHandleUnitCode() {
		return handleUnitCode;
	}
	public void setHandleUnitCode(String handleUnitCode) {
		this.handleUnitCode = handleUnitCode;
	}
	public String getHouseProvince() {
		return houseProvince;
	}
	public void setHouseProvince(String houseProvince) {
		this.houseProvince = houseProvince;
	}
	public Integer getHousePoliceStationId() {
		return housePoliceStationId;
	}
	public void setHousePoliceStationId(Integer housePoliceStationId) {
		this.housePoliceStationId = housePoliceStationId;
	}
	public String getHousePoliceStationName() {
		return housePoliceStationName;
	}
	public void setHousePoliceStationName(String housePoliceStationName) {
		this.housePoliceStationName = housePoliceStationName;
	}

	// ==================== 搜索条件字段（非数据库字段） ====================
	// 涉赌查询条件（与前端参数名一致）
	private String duPersonAttribute;	// 涉赌人员属性（对应表字段 person_attribute）
	private String duMethod;			// 涉赌方式（对应表字段 dbfs）
	private String duPart;				// 涉赌部位（对应表字段 dbbw）

	// 涉娼查询条件（与前端参数名一致）
	private String changPersonAttribute;	// 涉娼人员属性（对应表字段 chang_scjs）
	private String changMethod;			// 涉娼方式（对应表字段 chang_myfs）
	private String changType;			// 涉娼类型（对应表字段 chang_type）

	// 处罚时间区间（统一参数，��时作用于涉赌和涉娼）
	private String punishDateStart;		// 处罚日期起（涉赌表：chsj，涉娼表：chang_chsj）
	private String punishDateEnd;		// 处罚日期止（涉赌表：chsj，涉��表：chang_chsj）

	// 未成年案件标识
	private String isMinorCase;			// 是否未成年案件(涉娼记录查询条件，对应表字段 is_minor_case)

	// 涉案处罚时间搜索（从t_xjw_aj_clcs_jgzxb.JDSJ字段查询，8位yyyyMMdd格式）
	private String caseDate;			// 涉案处罚时间（格式：yyyyMMdd，对应t_xjw_aj_clcs_jgzxb.JDSJ）

	// 陪侍人员角色标签搜索
	private String peiMemo;				// 陪侍角色标签（对应ZaPei.memo字段）

	public String getDuPersonAttribute() {
		return duPersonAttribute;
	}
	public void setDuPersonAttribute(String duPersonAttribute) {
		this.duPersonAttribute = duPersonAttribute;
	}
	public String getDuMethod() {
		return duMethod;
	}
	public void setDuMethod(String duMethod) {
		this.duMethod = duMethod;
	}
	public String getDuPart() {
		return duPart;
	}
	public void setDuPart(String duPart) {
		this.duPart = duPart;
	}
	public String getChangPersonAttribute() {
		return changPersonAttribute;
	}
	public void setChangPersonAttribute(String changPersonAttribute) {
		this.changPersonAttribute = changPersonAttribute;
	}
	public String getChangMethod() {
		return changMethod;
	}
	public void setChangMethod(String changMethod) {
		this.changMethod = changMethod;
	}
	public String getChangType() {
		return changType;
	}
	public void setChangType(String changType) {
		this.changType = changType;
	}
	public String getPunishDateStart() {
		return punishDateStart;
	}
	public void setPunishDateStart(String punishDateStart) {
		this.punishDateStart = punishDateStart;
	}
	public String getPunishDateEnd() {
		return punishDateEnd;
	}
	public void setPunishDateEnd(String punishDateEnd) {
		this.punishDateEnd = punishDateEnd;
	}
	public String getIsMinorCase() {
		return isMinorCase;
	}
	public void setIsMinorCase(String isMinorCase) {
		this.isMinorCase = isMinorCase;
	}
	public String getCaseDate() {
		return caseDate;
	}
	public void setCaseDate(String caseDate) {
		this.caseDate = caseDate;
	}
	public String getPeiMemo() {
		return peiMemo;
	}
	public void setPeiMemo(String peiMemo) {
		this.peiMemo = peiMemo;
	}
}
