package com.szrj.business.model.event;

//稳控化解情况
public class DefuseInfo {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int cdtid;				//矛盾id
	private String lsdate;			//预计落实时间
	private String csgs;			//措施概述
	private String sflsqk;			//是否落实情况（已落实、未落实）
	private String lsqkks;			//落实情况概述
	private int validflag;			//状态标识
	private int addoperatorid;		//添加人id
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//备注信息
	private int workinfoid;			//工作交办ID
	private String attachments;		//附件
	/*---------------------非数据库中字段------------------------------*/
	private String cdttypename;		//风险类别名称
	private String cdtname;			//风险名称
	private String cdtlevel;		//风险等级
	private String cdttype;			//风险类别
	private String fileids;			//文件ids
	private String filenames;		//文件名s
	/*---------------------静态字段------------------------------*/
	public static String columnName="{\"lsdate\":\"预计落实时间\",\"csgs\":\"措施概述\",\"sflsqk\":\"是否落实情况\",\"lsqkks\":\"落实情况概述\","+
	"\"attachments\":\"附件\"}";
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
	public String getLsdate() {
		return lsdate;
	}
	public void setLsdate(String lsdate) {
		this.lsdate = lsdate;
	}
	public String getCsgs() {
		return csgs;
	}
	public void setCsgs(String csgs) {
		this.csgs = csgs;
	}
	public String getSflsqk() {
		return sflsqk;
	}
	public void setSflsqk(String sflsqk) {
		this.sflsqk = sflsqk;
	}
	public String getLsqkks() {
		return lsqkks;
	}
	public void setLsqkks(String lsqkks) {
		this.lsqkks = lsqkks;
	}
	public int getValidflag() {
		return validflag;
	}
	public void setValidflag(int validflag) {
		this.validflag = validflag;
	}
	public int getAddoperatorid() {
		return addoperatorid;
	}
	public void setAddoperatorid(int addoperatorid) {
		this.addoperatorid = addoperatorid;
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
	public int getWorkinfoid() {
		return workinfoid;
	}
	public void setWorkinfoid(int workinfoid) {
		this.workinfoid = workinfoid;
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
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
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
	
}
