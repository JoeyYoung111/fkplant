package com.szrj.business.model.event;

//情报线索信息
public class LeadsInfo {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int cdtid;				//矛盾id
	private String ldate;			//预计发生时间
	private String ltitle;			//线索标题
	private String lsource;			//线索来源
	private String lpointto;		//线索指向
	private String lcontent;		//线索内容
	private String xscz;			//线索处置
	private String czqkgs;			//处置情况概述
	private int conneteventid;		//关联事件ID
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
	private String sql;				//查询语句
	private String fileids;			//文件ids
	private String filenames;		//文件名s
	private String conneteventname;	//关联事件名称
	/*---------------------静态字段------------------------------*/
	public static String columnName="{\"ltitle\":\"线索标题\",\"lpointto\":\"线索指向\",\"lsource\":\"线索来源\",\"lcontent\":\"线索内容\","+
	"\"ldate\":\"预计发生时间\",\"xscz\":\"线索处置\",\"czqkgs\":\"处置情况概述\",\"conneteventid\":\"关联事件ID\",\"attachments\":\"附件\"," +
	"\"memo\":\"备注信息\"}";
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
	public String getLdate() {
		return ldate;
	}
	public void setLdate(String ldate) {
		this.ldate = ldate;
	}
	public String getLtitle() {
		return ltitle;
	}
	public void setLtitle(String ltitle) {
		this.ltitle = ltitle;
	}
	public String getLsource() {
		return lsource;
	}
	public void setLsource(String lsource) {
		this.lsource = lsource;
	}
	public String getLpointto() {
		return lpointto;
	}
	public void setLpointto(String lpointto) {
		this.lpointto = lpointto;
	}
	public String getLcontent() {
		return lcontent;
	}
	public void setLcontent(String lcontent) {
		this.lcontent = lcontent;
	}
	public String getXscz() {
		return xscz;
	}
	public void setXscz(String xscz) {
		this.xscz = xscz;
	}
	public String getCzqkgs() {
		return czqkgs;
	}
	public void setCzqkgs(String czqkgs) {
		this.czqkgs = czqkgs;
	}
	public int getConneteventid() {
		return conneteventid;
	}
	public void setConneteventid(int conneteventid) {
		this.conneteventid = conneteventid;
	}
	public String getConneteventname() {
		return conneteventname;
	}
	public void setConneteventname(String conneteventname) {
		this.conneteventname = conneteventname;
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
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
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
