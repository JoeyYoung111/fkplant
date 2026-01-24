package com.szrj.business.model.event;

//领导交办情况
public class HandleInfo {
	/*---------------------数据库中字段--------------------------------*/
	private int id;					//ID
	private int cdtid;				//矛盾id
	private int htype;				//工作单类别（1-领导批示、2-涉稳专报、3-维稳专报、4-涉稳风险交办处置建议、5-专题会议纪要）
	private String hdate;			//时间（年-月-日）
	private String htitle;			//标题
	private String hcontent;		//内容
	private String attachments;		//附件
	private String receivedept;		//接受单位
	private String receiver;		//接收人
	private String hsituation;		//办理情况
	private String hresult;			//处置结果
	private String leaderlevel;		//领导级别
	private String approveperson;	//批示人
	private int validflag;			//状态标识
	private int addoperatorid;		//添加人id
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String updateoperator;	//最新修改人
	private String updatetime;		//最新修改时间
	private String memo;			//备注信息
	/*---------------------非数据库中字段------------------------------*/
	private String fileids;			//文件ids
	private String filenames;		//文件名s
	private int nums;				//各类单子数量
	private String cdtlevel;		//风险等级
	private String cdtname;			//风险名称
	/*---------------------静态字段------------------------------*/
	public static String columnName="{\"hdate\":\"时间\",\"htitle\":\"标题\",\"hcontent\":\"内容\",\"attachments\":\"附件\","+
	"\"leaderlevel\":\"领导级别\",\"approveperson\":\"批示人\"}";
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
	public int getHtype() {
		return htype;
	}
	public void setHtype(int htype) {
		this.htype = htype;
	}
	public String getHdate() {
		return hdate;
	}
	public void setHdate(String hdate) {
		this.hdate = hdate;
	}
	public String getHtitle() {
		return htitle;
	}
	public void setHtitle(String htitle) {
		this.htitle = htitle;
	}
	public String getHcontent() {
		return hcontent;
	}
	public void setHcontent(String hcontent) {
		this.hcontent = hcontent;
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
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getHsituation() {
		return hsituation;
	}
	public void setHsituation(String hsituation) {
		this.hsituation = hsituation;
	}
	public String getHresult() {
		return hresult;
	}
	public void setHresult(String hresult) {
		this.hresult = hresult;
	}
	public String getLeaderlevel() {
		return leaderlevel;
	}
	public void setLeaderlevel(String leaderlevel) {
		this.leaderlevel = leaderlevel;
	}
	public String getApproveperson() {
		return approveperson;
	}
	public void setApproveperson(String approveperson) {
		this.approveperson = approveperson;
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
	public String getCdtlevel() {
		return cdtlevel;
	}
	public void setCdtlevel(String cdtlevel) {
		this.cdtlevel = cdtlevel;
	}
	public String getCdtname() {
		return cdtname;
	}
	public void setCdtname(String cdtname) {
		this.cdtname = cdtname;
	}
	
}
