package com.szrj.business.model.personel;

import java.util.List;

/**
 * @author szrj_huaxia
 *风险人员-通用扩展表 p_personnel_extend_t
 */
public class PersonnelExtend {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;
	private int personnelid;//人员主表id
	private int personlabelid;//人员类型表id
	private String attributelabels;//属性标签id，逗号拼接
	private String jointcontrollevel;//联控级别  数据字典汉字
	private String incontrollevel;//在控状态  数据字典汉字
	private int jurisdictunit1;//管辖责任单位  必选、默认当前登录人单位
	private int jurisdictpolice1;//管辖责任民警  必选、默认当前登录人id
	private String policephone1;//管辖责任民警手机  自动带出
	private String jurisdictunit2;//双管辖责任单位
	private String jurisdictpolice2;//双管辖责任民警
	private String policephone2;//双管辖责任民警电话
	private String vocation;//身份/职业
	private String workunit;//工作单位
	private String workjob;//职务
	private String country;//国籍
	private String birthday;//出生日期
	private int validflag;//状态标识   1：正常 0:作废
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	/*---------------------------------------非数据库中字段-------------------------------------*/
	//查询条件
    private List<Integer> personnelIdList;
	private String cardnumber;//身份证号
	private String personname;//姓名
	private String homeplace;//现居住地详址
	private String persontype;//户籍类别（人员类别）
	private String telnumber;//名下手机号
	private String labelsql;
    private String phone;
	private Integer isMinor; // 是否未成年 0-否 1-是（查询条件）
	private String zslabel1; // 治安分类标签（查询条件）例如：2046-治安分类
	// 新增：管辖单位和民警查询条件
	private String jdunit1; // 管辖责任单位（查询条件）
	private String jdunit2; // 双管辖责任单位（查询条件）
	// 新增：籍贯相关查询条件
	private String homeProvince; // 籍贯-省
	private String homeCity; // 籍贯-市
	private String homeCounty; // 籍贯-区县
	private String homeTown; // 籍贯-乡镇
	private Integer homePoliceStationId; // 籍贯-派出所ID
	//补充显示字段
	private String sexes;//性别
	//关联字段
	private String unitname1;//管辖责任单位名称
	private String policename1;//管辖责任民警名称
	private String unitname2;//双管辖责任单位名称
	private String policename2;//双管辖责任民警名称
	private String personlabelname;//人员类型名称
	private String pphone1;//管辖责任民警手机主表
	private String pphone2;//双管辖责任民警电话主表
	//显示权限 0-全部 1-派出所 2-民警
	private int personFilter;//民警过滤
	private int unitFilter;//派出所字段
	//导出类
	private Personnel exportPersonnel=new Personnel();
	private Relation exportRelation=new Relation();
	private String personnelIdListStr; // 人员ID列表字符串，逗号分隔
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
    public List<Integer> getPersonnelIdList() {
        return personnelIdList;
    }

    public void setPersonnelIdList(List<Integer> personnelIdList) {
        this.personnelIdList = personnelIdList;
        // 同时生成逗号分隔的字符串
        if (personnelIdList != null && !personnelIdList.isEmpty()) {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < personnelIdList.size(); i++) {
                if (i > 0) sb.append(",");
                sb.append(personnelIdList.get(i));
            }
            this.personnelIdListStr = sb.toString();
        }
    }

    public String getPersonnelIdListStr() {
        return personnelIdListStr;
    }

    public void setPersonnelIdListStr(String personnelIdListStr) {
        this.personnelIdListStr = personnelIdListStr;
    }

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
	public String getJointcontrollevel() {
		return jointcontrollevel;
	}
	public void setJointcontrollevel(String jointcontrollevel) {
		this.jointcontrollevel = jointcontrollevel;
	}
	public String getIncontrollevel() {
		return incontrollevel;
	}
	public void setIncontrollevel(String incontrollevel) {
		this.incontrollevel = incontrollevel;
	}
	public int getJurisdictunit1() {
		return jurisdictunit1;
	}
	public void setJurisdictunit1(int jurisdictunit1) {
		this.jurisdictunit1 = jurisdictunit1;
	}
	public int getJurisdictpolice1() {
		return jurisdictpolice1;
	}
	public void setJurisdictpolice1(int jurisdictpolice1) {
		this.jurisdictpolice1 = jurisdictpolice1;
	}
	public String getPolicephone1() {
		return policephone1;
	}
	public void setPolicephone1(String policephone1) {
		this.policephone1 = policephone1;
	}
	public String getJurisdictunit2() {
		return jurisdictunit2;
	}
	public void setJurisdictunit2(String jurisdictunit2) {
		this.jurisdictunit2 = jurisdictunit2;
	}
	public String getJurisdictpolice2() {
		return jurisdictpolice2;
	}
	public void setJurisdictpolice2(String jurisdictpolice2) {
		this.jurisdictpolice2 = jurisdictpolice2;
	}
	public String getPolicephone2() {
		return policephone2;
	}
	public void setPolicephone2(String policephone2) {
		this.policephone2 = policephone2;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
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
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getPersontype() {
		return persontype;
	}
	public void setPersontype(String persontype) {
		this.persontype = persontype;
	}
	public String getTelnumber() {
		return telnumber;
	}
	public void setTelnumber(String telnumber) {
		this.telnumber = telnumber;
	}
	public String getSexes() {
		return sexes;
	}
	public void setSexes(String sexes) {
		this.sexes = sexes;
	}
	public String getUnitname1() {
		return unitname1;
	}
	public void setUnitname1(String unitname1) {
		this.unitname1 = unitname1;
	}
	public String getPolicename1() {
		return policename1;
	}
	public void setPolicename1(String policename1) {
		this.policename1 = policename1;
	}
	public String getUnitname2() {
		return unitname2;
	}
	public void setUnitname2(String unitname2) {
		this.unitname2 = unitname2;
	}
	public String getPolicename2() {
		return policename2;
	}
	public void setPolicename2(String policename2) {
		this.policename2 = policename2;
	}
	public int getPersonFilter() {
		return personFilter;
	}
	public void setPersonFilter(int personFilter) {
		this.personFilter = personFilter;
	}
	public int getUnitFilter() {
		return unitFilter;
	}
	public void setUnitFilter(int unitFilter) {
		this.unitFilter = unitFilter;
	}
	public int getPersonlabelid() {
		return personlabelid;
	}
	public void setPersonlabelid(int personlabelid) {
		this.personlabelid = personlabelid;
	}
	public String getPersonlabelname() {
		return personlabelname;
	}
	public void setPersonlabelname(String personlabelname) {
		this.personlabelname = personlabelname;
	}
	public Personnel getExportPersonnel() {
		return exportPersonnel;
	}
	public void setExportPersonnel(Personnel exportPersonnel) {
		this.exportPersonnel = exportPersonnel;
	}
	public Relation getExportRelation() {
		return exportRelation;
	}
	public void setExportRelation(Relation exportRelation) {
		this.exportRelation = exportRelation;
	}
	public String getAttributelabels() {
		return attributelabels;
	}
	public void setAttributelabels(String attributelabels) {
		this.attributelabels = attributelabels;
	}
	public String getLabelsql() {
		return labelsql;
	}
	public void setLabelsql(String labelsql) {
		this.labelsql = labelsql;
	}
	public Integer getIsMinor() {
		return isMinor;
	}
	public void setIsMinor(Integer isMinor) {
		this.isMinor = isMinor;
	}
	public String getZslabel1() {
		return zslabel1;
	}
	public void setZslabel1(String zslabel1) {
		this.zslabel1 = zslabel1;
	}
    public String getphone() {
        return phone;
    }
    public void setphone(String phone) {
        this.phone = phone;
    }
	public String getJdunit1() {
		return jdunit1;
	}
	public void setJdunit1(String jdunit1) {
		this.jdunit1 = jdunit1;
	}
	public String getJdunit2() {
		return jdunit2;
	}
	public void setJdunit2(String jdunit2) {
		this.jdunit2 = jdunit2;
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
	public String getPphone1() {
		return pphone1;
	}
	public void setPphone1(String pphone1) {
		this.pphone1 = pphone1;
	}
	public String getPphone2() {
		return pphone2;
	}
	public void setPphone2(String pphone2) {
		this.pphone2 = pphone2;
	}
	public String getVocation() {
		return vocation;
	}
	public void setVocation(String vocation) {
		this.vocation = vocation;
	}
	public String getWorkunit() {
		return workunit;
	}
	public void setWorkunit(String workunit) {
		this.workunit = workunit;
	}
	public String getWorkjob() {
		return workjob;
	}
	public void setWorkjob(String workjob) {
		this.workjob = workjob;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
}
