package com.szrj.business.model.event;

//工作交办
public class WorkInfo {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int cdtid;				//矛盾id
	private int wtype;				//工作单类别(1-工作提示单、2-工作交办单、3-工作督办单、4-责任追究建议函)
	private String wtitle;			//标题
	private String wcontent;		//内容
	private String attachments;		//附件
	private String receivedept;		//接受单位
	private String receivername;	//接收人
	private int receiverid;			//接收人id
	private int xfperid;			//下发人id
	private String xfpername;		//下发人
	private String xfperdep;		//下发人单位
	private String xftime;			//下发时间
	private int qsperid;			//签收人id
	private String qspername;		//签收人
	private String qstime;			//签收时间
	private int fkperid;			//反馈人id
	private String fkname;			//反馈人
	private String fktime;			//反馈时间
	private String fkcontent;		//反馈内容
	private int nowstates;			//最新状态（1-已下发、2-已签收、3-已反馈）
	private int validflag;			//状态标识（0-正常 1-作废）
	private String code;			//编号
	private String hjzt;			//化解状态
	private String fkattachments;	//反馈附件
	private int receivedeptid;		//接收单位id
	/*---------------------非数据库中字段------------------------------*/
	private String fileids;			//文件ids
	private String filenames;		//文件名s
	private String fkfileids;		//文件ids
	private String fkfilenames;		//文件名s
	private int nums;				//各类单子数量
	private String startTime;		//起始时间
	private String endTime;			//结束时间
	private int defuseInfocount;	//稳控化解数量
	private int eventsInfocount;	//涉稳事件数量
	private int leadsInfocount;		//情报线索数量
	private int keypersonnelcount;	//主要组织人员数量
	private String cdtlevel;		//风险等级
	private String wtypename;		//工作单类别名称
	private String cdttypename;		//风险类别名称
	private String cdtname;			//风险名称
	private String rkdept;			//风险入库单位
	private String addoperator;		//入库人
	private String addtime;			//入库时间
	private String cdtresult;		//处置结果
	private String sfdz;			//事发地址
	private String ssrs;			//涉事人数
	private int sjje;				//涉及金额
	private String sponsorname;		//主办部门名称
	private String assistdeptname;	//协助部门名
	private String cdtcontent;		//风险矛盾概况
	/*---------------------get/set方法-------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCdtid() {
		return cdtid;
	}
	public void setCdtid(int cdtid) {
		this.cdtid = cdtid;
	}
	public int getWtype() {
		return wtype;
	}
	public void setWtype(int wtype) {
		this.wtype = wtype;
	}
	public String getWtitle() {
		return wtitle;
	}
	public void setWtitle(String wtitle) {
		this.wtitle = wtitle;
	}
	public String getWcontent() {
		return wcontent;
	}
	public void setWcontent(String wcontent) {
		this.wcontent = wcontent;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
	}
	public String getReceivedept() {
		return receivedept;
	}
	public void setReceivedept(String receivedept) {
		this.receivedept = receivedept;
	}
	public String getReceivername() {
		return receivername;
	}
	public void setReceivername(String receivername) {
		this.receivername = receivername;
	}
	public int getReceiverid() {
		return receiverid;
	}
	public void setReceiverid(int receiverid) {
		this.receiverid = receiverid;
	}
	public int getXfperid() {
		return xfperid;
	}
	public void setXfperid(int xfperid) {
		this.xfperid = xfperid;
	}
	public String getXfpername() {
		return xfpername;
	}
	public void setXfpername(String xfpername) {
		this.xfpername = xfpername;
	}
	public String getXfperdep() {
		return xfperdep;
	}
	public void setXfperdep(String xfperdep) {
		this.xfperdep = xfperdep;
	}
	public String getXftime() {
		return xftime;
	}
	public void setXftime(String xftime) {
		this.xftime = xftime;
	}
	public int getQsperid() {
		return qsperid;
	}
	public void setQsperid(int qsperid) {
		this.qsperid = qsperid;
	}
	public String getQspername() {
		return qspername;
	}
	public void setQspername(String qspername) {
		this.qspername = qspername;
	}
	public String getQstime() {
		return qstime;
	}
	public void setQstime(String qstime) {
		this.qstime = qstime;
	}
	public int getFkperid() {
		return fkperid;
	}
	public void setFkperid(int fkperid) {
		this.fkperid = fkperid;
	}
	public String getFkname() {
		return fkname;
	}
	public void setFkname(String fkname) {
		this.fkname = fkname;
	}
	public String getFktime() {
		return fktime;
	}
	public void setFktime(String fktime) {
		this.fktime = fktime;
	}
	public String getFkcontent() {
		return fkcontent;
	}
	public void setFkcontent(String fkcontent) {
		this.fkcontent = fkcontent;
	}
	public int getNowstates() {
		return nowstates;
	}
	public void setNowstates(int nowstates) {
		this.nowstates = nowstates;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public String getFileids() {
		return fileids;
	}
	public void setFileids(String fileids) {
		this.fileids = fileids;
	}
	public String getFilenames() {
		return filenames;
	}
	public void setFilenames(String filenames) {
		this.filenames = filenames;
	}
	public int getNums() {
		return nums;
	}
	public void setNums(int nums) {
		this.nums = nums;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getHjzt() {
		return hjzt;
	}
	public void setHjzt(String hjzt) {
		this.hjzt = hjzt;
	}
	public String getFkattachments() {
		return fkattachments;
	}
	public void setFkattachments(String fkattachments) {
		this.fkattachments = fkattachments;
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
	public int getDefuseInfocount() {
		return defuseInfocount;
	}
	public void setDefuseInfocount(int defuseInfocount) {
		this.defuseInfocount = defuseInfocount;
	}
	public int getEventsInfocount() {
		return eventsInfocount;
	}
	public void setEventsInfocount(int eventsInfocount) {
		this.eventsInfocount = eventsInfocount;
	}
	public int getLeadsInfocount() {
		return leadsInfocount;
	}
	public void setLeadsInfocount(int leadsInfocount) {
		this.leadsInfocount = leadsInfocount;
	}
	public int getKeypersonnelcount() {
		return keypersonnelcount;
	}
	public void setKeypersonnelcount(int keypersonnelcount) {
		this.keypersonnelcount = keypersonnelcount;
	}
	public int getReceivedeptid() {
		return receivedeptid;
	}
	public void setReceivedeptid(int receivedeptid) {
		this.receivedeptid = receivedeptid;
	}
	public String getCdtlevel() {
		return cdtlevel;
	}
	public void setCdtlevel(String cdtlevel) {
		this.cdtlevel = cdtlevel;
	}
	public String getWtypename() {
		return wtypename;
	}
	public void setWtypename(String wtypename) {
		this.wtypename = wtypename;
	}
	public String getCdttypename() {
		return cdttypename;
	}
	public void setCdttypename(String cdttypename) {
		this.cdttypename = cdttypename;
	}
	public String getCdtname() {
		return cdtname;
	}
	public void setCdtname(String cdtname) {
		this.cdtname = cdtname;
	}
	public String getRkdept() {
		return rkdept;
	}
	public void setRkdept(String rkdept) {
		this.rkdept = rkdept;
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
	public int getSjje() {
		return sjje;
	}
	public void setSjje(int sjje) {
		this.sjje = sjje;
	}
	public String getSponsorname() {
		return sponsorname;
	}
	public void setSponsorname(String sponsorname) {
		this.sponsorname = sponsorname;
	}
	public String getAssistdeptname() {
		return assistdeptname;
	}
	public void setAssistdeptname(String assistdeptname) {
		this.assistdeptname = assistdeptname;
	}
	public String getCdtcontent() {
		return cdtcontent;
	}
	public void setCdtcontent(String cdtcontent) {
		this.cdtcontent = cdtcontent;
	}
	public String getFkfileids() {
		return fkfileids;
	}
	public void setFkfileids(String fkfileids) {
		this.fkfileids = fkfileids;
	}
	public String getFkfilenames() {
		return fkfilenames;
	}
	public void setFkfilenames(String fkfilenames) {
		this.fkfilenames = fkfilenames;
	}
}
