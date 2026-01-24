package com.szrj.business.model.event;

//引发涉稳事件
public class EventsInfo {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int cdtid;				//矛盾id
	private String etitle;			//事件标题
	private String fxdj;			//风险等级
	private String sjgk;			//事件概况
	private String sfbwd;			//事发部位
	private String fssj;			//发生时间
	private String ssrs;			//涉事人数
	private String sfgm;			//是否过激
	private String xwfs;			//行为方式
	private String xcczjg;			//现场处置结果
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
	/*---------------------静态字段------------------------------*/
	public static String columnName="{\"etitle\":\"事件标题\",\"sfbwd\":\"事发部位\",\"attachments\":\"附件\","+
	"\"fssj\":\"发生时间\",\"ssrs\":\"涉事人数\",\"sfgm\":\"是否过激\",\"xwfs\":\"行为方式\",\"sjgk\":\"事件概况\",\"memo\":\"备注信息\"}";
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
	public String getEtitle() {
		return etitle;
	}
	public void setEtitle(String etitle) {
		this.etitle = etitle;
	}
	public String getFxdj() {
		return fxdj;
	}
	public void setFxdj(String fxdj) {
		this.fxdj = fxdj;
	}
	public String getSjgk() {
		return sjgk;
	}
	public void setSjgk(String sjgk) {
		this.sjgk = sjgk;
	}
	public String getSfbwd() {
		return sfbwd;
	}
	public void setSfbwd(String sfbwd) {
		this.sfbwd = sfbwd;
	}
	public String getFssj() {
		return fssj;
	}
	public void setFssj(String fssj) {
		this.fssj = fssj;
	}
	public String getSsrs() {
		return ssrs;
	}
	public void setSsrs(String ssrs) {
		this.ssrs = ssrs;
	}
	public String getSfgm() {
		return sfgm;
	}
	public void setSfgm(String sfgm) {
		this.sfgm = sfgm;
	}
	public String getXwfs() {
		return xwfs;
	}
	public void setXwfs(String xwfs) {
		this.xwfs = xwfs;
	}
	public String getXcczjg() {
		return xcczjg;
	}
	public void setXcczjg(String xcczjg) {
		this.xcczjg = xcczjg;
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
