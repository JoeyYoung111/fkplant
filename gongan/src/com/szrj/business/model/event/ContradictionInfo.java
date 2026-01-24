package com.szrj.business.model.event;

//矛盾风险信息
public class ContradictionInfo {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int type;				//类型（1-巡特警事件 2-政保事件）
	private String cdtname;			//风险名称
	private String cdtcontent;		//风险矛盾概况  （情况经过）
	private String cdtlevel;		//风险等级
	private String cdttype;			//风险类别
	private String cdtresult;		//处置结果  （主要活动方式）
	private String sfdz;			//事发地址
	private String ssrs;			//涉事人数
	private String sjje;			//涉及金额
	private int isshield;			//是否屏蔽 0-否 1-是
	private int nowstate;			//最新状态 1-待审核 2-审核通过 3-审核不通过
	private int validflag;			//状态标识
	private int adddepartment;		//添加人单位
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String examineman;		//审核人
	private String examinetime;		//审核时间  （处置时间）
	private String examineopinion;	//审核反馈意见 （处置状态）
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//备注信息
	private int sponsor;			//主办部门
	private String assistdept;		//协办部门
	private String ssdwxx;			//涉事单位信息（名称、负责人、联系电话）
	private String sdpcsldxx;		//属地派出所领导信息（领导、电话）
	private String sdpcsmjxx;		//属地派出所社区民警信息（民警、电话）
	private String zfqtmbxx;		//政府牵头处置部门（部门、领导、联系电话）
	private String yfhg;			//会引发的后果
	private int isjq;				//是否建群(0-否 1-是)
	private String qxx;				//群信息
	private int iswjxxy;			//是否物建信息员(0-否 1-是)
	private String xxyxx;			//信息员信息
	private String jtsq;			//具体诉求
	private String sfdzx;			//事发地址经度
	private String sfdzy;			//事发地址纬度
	private String cdtcode;			//事件编码
	/*---------------------非数据库中字段------------------------------*/
	private String rkdept;			//入库部门
	private String zbdept;			//主办部门查询字符串
	private String sql;				//查询语句
	private String sponsorname;		//主办部门名称
	private String typename;		//风险类型名称
	private int rolefilterdept;		//角色过滤部门
	private String eventname;		//事件名
	private String eventtime;		//事件发生时间
	private String eventdetail;		//事件细节
	private String assistdeptname;	//协助部门名
	private int personnelid;		//主要组织人员id
	private String policaname;
	private String controlPhone;
	private int zdDeptid;			//中队部门id
	//显示权限 0-全部 1-派出所 2-民警
	private int personFilter;//民警过滤
	private int unitFilter;//派出所字段
	private String startTime;		//（入库时间）起始时间
	private String endTime;			//结束时间
	private String updatestartTime;	//（更新时间）起始时间
	private String updateendTime;	//结束时间
	/*---------------------导出------------------------------*/
	private EventsInfo exportEventsInfo=new EventsInfo();
	private LeadsInfo exportLeadsInfo=new LeadsInfo();
	private DefuseInfo exportDefuseInfo=new DefuseInfo();
	private WorkInfo exportWorkInfo=new WorkInfo();
	private HandleInfo exportHandleInfo=new HandleInfo();
	//排序
	private String sortsql;
	/*---------------------静态字段------------------------------*/
	public static String columnName="{\"cdtname\":\"风险名称\",\"cdtcontent\":\"风险矛盾概况\",\"cdtlevel\":\"风险等级\","+
	"\"cdttype\":\"风险类别\",\"cdtresult\":\"处置结果\",\"sfdz\":\"事发地址\",\"ssrs\":\"涉事人数\",\"sjje\":\"涉及金额\",\"assistdept\":\"协办部门\","+
	"\"sponsor\":\"主办部门\",\"ssdwxx\":\"涉事单位信息\",\"sdpcsldxx\":\"属地派出所领导信息\",\"sdpcsmjxx\":\"属地派出所社区民警信息\","+
	"\"zfqtmbxx\":\"政府牵头处置部门\",\"yfhg\":\"会引发的后果\",\"isjq\":\"是否建群\",\"qxx\":\"群信息\",\"iswjxxy\":\"是否物建信息员\","+
	"\"xxyxx\":\"信息员信息\",\"jtsq\":\"具体诉求\"}";
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCdtname() {
		return cdtname;
	}
	public void setCdtname(String cdtname) {
		this.cdtname = cdtname;
	}
	public String getCdtcontent() {
		return cdtcontent;
	}
	public void setCdtcontent(String cdtcontent) {
		this.cdtcontent = cdtcontent;
	}
	public String getCdtlevel() {
		return cdtlevel;
	}
	public void setCdtlevel(String cdtlevel) {
		this.cdtlevel = cdtlevel;
	}
	public String getCdttype() {
		return cdttype;
	}
	public void setCdttype(String cdttype) {
		this.cdttype = cdttype;
	}
	public String getCdtresult() {
		return cdtresult;
	}
	public void setCdtresult(String cdtresult) {
		this.cdtresult = cdtresult;
	}
	public String getSfdz() {
		return sfdz;
	}
	public void setSfdz(String sfdz) {
		this.sfdz = sfdz;
	}
	public String getSsrs() {
		return ssrs;
	}
	public void setSsrs(String ssrs) {
		this.ssrs = ssrs;
	}
	public String getSjje() {
		return sjje;
	}
	public void setSjje(String sjje) {
		this.sjje = sjje;
	}
	public int getIsshield() {
		return isshield;
	}
	public void setIsshield(int isshield) {
		this.isshield = isshield;
	}
	public int getNowstate() {
		return nowstate;
	}
	public void setNowstate(int nowstate) {
		this.nowstate = nowstate;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getAdddepartment() {
		return adddepartment;
	}
	public void setAdddepartment(int adddepartment) {
		this.adddepartment = adddepartment;
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
	public String getExamineman() {
		return examineman;
	}
	public void setExamineman(String examineman) {
		this.examineman = examineman;
	}
	public String getExaminetime() {
		return examinetime;
	}
	public void setExaminetime(String examinetime) {
		this.examinetime = examinetime;
	}
	public String getExamineopinion() {
		return examineopinion;
	}
	public void setExamineopinion(String examineopinion) {
		this.examineopinion = examineopinion;
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
	public String getAssistdept() {
		return assistdept;
	}
	public void setAssistdept(String assistdept) {
		this.assistdept = assistdept;
	}
	public String getRkdept() {
		return rkdept;
	}
	public void setRkdept(String rkdept) {
		this.rkdept = rkdept;
	}
	public int getSponsor() {
		return sponsor;
	}
	public void setSponsor(int sponsor) {
		this.sponsor = sponsor;
	}
	public String getZbdept() {
		return zbdept;
	}
	public void setZbdept(String zbdept) {
		this.zbdept = zbdept;
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	public String getSponsorname() {
		return sponsorname;
	}
	public void setSponsorname(String sponsorname) {
		this.sponsorname = sponsorname;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public int getRolefilterdept() {
		return rolefilterdept;
	}
	public void setRolefilterdept(int rolefilterdept) {
		this.rolefilterdept = rolefilterdept;
	}
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
	public String getAssistdeptname() {
		return assistdeptname;
	}
	public void setAssistdeptname(String assistdeptname) {
		this.assistdeptname = assistdeptname;
	}
	public int getPersonnelid() {
		return personnelid;
	}
	public void setPersonnelid(int personnelid) {
		this.personnelid = personnelid;
	}
	public String getSsdwxx() {
		return ssdwxx;
	}
	public void setSsdwxx(String ssdwxx) {
		this.ssdwxx = ssdwxx;
	}
	public String getSdpcsldxx() {
		return sdpcsldxx;
	}
	public void setSdpcsldxx(String sdpcsldxx) {
		this.sdpcsldxx = sdpcsldxx;
	}
	public String getSdpcsmjxx() {
		return sdpcsmjxx;
	}
	public void setSdpcsmjxx(String sdpcsmjxx) {
		this.sdpcsmjxx = sdpcsmjxx;
	}
	public String getZfqtmbxx() {
		return zfqtmbxx;
	}
	public void setZfqtmbxx(String zfqtmbxx) {
		this.zfqtmbxx = zfqtmbxx;
	}
	public String getYfhg() {
		return yfhg;
	}
	public void setYfhg(String yfhg) {
		this.yfhg = yfhg;
	}
	public int getIsjq() {
		return isjq;
	}
	public void setIsjq(int isjq) {
		this.isjq = isjq;
	}
	public String getQxx() {
		return qxx;
	}
	public void setQxx(String qxx) {
		this.qxx = qxx;
	}
	public int getIswjxxy() {
		return iswjxxy;
	}
	public void setIswjxxy(int iswjxxy) {
		this.iswjxxy = iswjxxy;
	}
	public String getXxyxx() {
		return xxyxx;
	}
	public void setXxyxx(String xxyxx) {
		this.xxyxx = xxyxx;
	}
	public String getJtsq() {
		return jtsq;
	}
	public void setJtsq(String jtsq) {
		this.jtsq = jtsq;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public EventsInfo getExportEventsInfo() {
		return exportEventsInfo;
	}
	public void setExportEventsInfo(EventsInfo exportEventsInfo) {
		this.exportEventsInfo = exportEventsInfo;
	}
	public LeadsInfo getExportLeadsInfo() {
		return exportLeadsInfo;
	}
	public void setExportLeadsInfo(LeadsInfo exportLeadsInfo) {
		this.exportLeadsInfo = exportLeadsInfo;
	}
	public DefuseInfo getExportDefuseInfo() {
		return exportDefuseInfo;
	}
	public void setExportDefuseInfo(DefuseInfo exportDefuseInfo) {
		this.exportDefuseInfo = exportDefuseInfo;
	}
	public WorkInfo getExportWorkInfo() {
		return exportWorkInfo;
	}
	public void setExportWorkInfo(WorkInfo exportWorkInfo) {
		this.exportWorkInfo = exportWorkInfo;
	}
	public HandleInfo getExportHandleInfo() {
		return exportHandleInfo;
	}
	public void setExportHandleInfo(HandleInfo exportHandleInfo) {
		this.exportHandleInfo = exportHandleInfo;
	}
	public String getSortsql() {
		return sortsql;
	}
	public void setSortsql(String sortsql) {
		this.sortsql = sortsql;
	}
	public String getPolicaname() {
		return policaname;
	}
	public void setPolicaname(String policaname) {
		this.policaname = policaname;
	}
	public String getControlPhone() {
		return controlPhone;
	}
	public void setControlPhone(String controlPhone) {
		this.controlPhone = controlPhone;
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
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getUpdatestartTime() {
		return updatestartTime;
	}
	public void setUpdatestartTime(String updatestartTime) {
		this.updatestartTime = updatestartTime;
	}
	public String getUpdateendTime() {
		return updateendTime;
	}
	public void setUpdateendTime(String updateendTime) {
		this.updateendTime = updateendTime;
	}
	public String getSfdzx() {
		return sfdzx;
	}
	public void setSfdzx(String sfdzx) {
		this.sfdzx = sfdzx;
	}
	public String getSfdzy() {
		return sfdzy;
	}
	public void setSfdzy(String sfdzy) {
		this.sfdzy = sfdzy;
	}
	public String getCdtcode() {
		return cdtcode;
	}
	public void setCdtcode(String cdtcode) {
		this.cdtcode = cdtcode;
	}
	public int getZdDeptid() {
		return zdDeptid;
	}
	public void setZdDeptid(int zdDeptid) {
		this.zdDeptid = zdDeptid;
	}
}
