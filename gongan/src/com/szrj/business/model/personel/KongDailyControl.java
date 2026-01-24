package com.szrj.business.model.personel;

public class KongDailyControl {
	private int id;
	private int personnelid;//人员主表id
	private int controltype;//1-三天一走访 2-每月评估
	private String controltime;//管控时间
	private String controlmode;//管控方式
	private String controlcontent;//管控内容
	private String fileattachments;//文件附件
	private int validflag;
	private int addoperatorid;//添加人id
	private String addoperator;//添加人
	private String addtime;//添加时间
	private String updateoperator;//最新修改人
	private String updatetime;//最新修改时间
	private String memo;//备注信息
	
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String addoperatordepart;//添加人部门
    private String filesname;
    private String filesallname;
    
    private String isFilter;//数据过滤 1-民警过滤 2-单位过滤
    private String filtervalue;//数据过滤 过滤值
    private String cardnumber;//身份证号
	private String personname;//姓名
	private String starttime;//管控时间 开始
	private String endtime;//管控时间 结束
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

	public int getControltype() {
		return controltype;
	}

	public void setControltype(int controltype) {
		this.controltype = controltype;
	}

	public String getControltime() {
		return controltime;
	}

	public void setControltime(String controltime) {
		this.controltime = controltime;
	}

	public String getControlmode() {
		return controlmode;
	}

	public void setControlmode(String controlmode) {
		this.controlmode = controlmode;
	}

	public String getControlcontent() {
		return controlcontent;
	}

	public void setControlcontent(String controlcontent) {
		this.controlcontent = controlcontent;
	}

	public String getFileattachments() {
		return fileattachments;
	}

	public void setFileattachments(String fileattachments) {
		this.fileattachments = fileattachments;
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

	public String getAddoperatordepart() {
		return addoperatordepart;
	}

	public void setAddoperatordepart(String addoperatordepart) {
		this.addoperatordepart = addoperatordepart;
	}

	public String getFilesname() {
		return filesname;
	}

	public void setFilesname(String filesname) {
		this.filesname = filesname;
	}

	public String getFilesallname() {
		return filesallname;
	}

	public void setFilesallname(String filesallname) {
		this.filesallname = filesallname;
	}

	public String getIsFilter() {
		return isFilter;
	}

	public void setIsFilter(String isFilter) {
		this.isFilter = isFilter;
	}

	public String getFiltervalue() {
		return filtervalue;
	}

	public void setFiltervalue(String filtervalue) {
		this.filtervalue = filtervalue;
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

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	
	
	
}
