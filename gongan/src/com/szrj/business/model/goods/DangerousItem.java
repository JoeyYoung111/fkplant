package com.szrj.business.model.goods;

/**
 * @author lt
 *风险物品
 */
public class DangerousItem {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;						//id
	private String itemtype;			//物品品种
	private String goodscode;			//物品型号
	private String casename;			//案件名称
	private String codenum;				//唯一标识码
	private String sjdate;				//收缴日期
	private String sjgov;				//收缴单位
	private String sjmj;				//收缴民警
	private String sjfs;				//收缴方式
	private String sl;					//物品数量
	private String position;			//物品存放位置
	private String result;				//处置结果
	private String sjdx;				//收缴对象
	private String dxsfz;				//对象身份证
	private String attachments;			//附件
	private int validflag;				//状态标识   1：正常 0:作废
	private String addoperator;			//添加人
	private String addtime;				//添加时间
	private String updateoperator;		//最新修改人
	private String updatetime;			//最新修改时间
	private String memo;				//备注信息
	private int personid;				//关联人员ID
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String fileids;			//文件ids
	private String filenames;		//文件名s
	private String goodscodename;	//物品型号名称
	private String ybssid;			//一标三实id
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getItemtype() {
		return itemtype;
	}
	public void setItemtype(String itemtype) {
		this.itemtype = itemtype;
	}
	public String getGoodscode() {
		return goodscode;
	}
	public void setGoodscode(String goodscode) {
		this.goodscode = goodscode;
	}
	public String getCasename() {
		return casename;
	}
	public void setCasename(String casename) {
		this.casename = casename;
	}
	public String getCodenum() {
		return codenum;
	}
	public void setCodenum(String codenum) {
		this.codenum = codenum;
	}
	public String getSjdate() {
		return sjdate;
	}
	public void setSjdate(String sjdate) {
		this.sjdate = sjdate;
	}
	public String getSjgov() {
		return sjgov;
	}
	public void setSjgov(String sjgov) {
		this.sjgov = sjgov;
	}
	public String getSjmj() {
		return sjmj;
	}
	public void setSjmj(String sjmj) {
		this.sjmj = sjmj;
	}
	public String getSjfs() {
		return sjfs;
	}
	public void setSjfs(String sjfs) {
		this.sjfs = sjfs;
	}
	public String getSl() {
		return sl;
	}
	public void setSl(String sl) {
		this.sl = sl;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getSjdx() {
		return sjdx;
	}
	public void setSjdx(String sjdx) {
		this.sjdx = sjdx;
	}
	public String getDxsfz() {
		return dxsfz;
	}
	public void setDxsfz(String dxsfz) {
		this.dxsfz = dxsfz;
	}
	public String getAttachments() {
		return attachments;
	}
	public void setAttachments(String attachments) {
		this.attachments = attachments;
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
	public int getPersonid() {
		return personid;
	}
	public void setPersonid(int personid) {
		this.personid = personid;
	}
	public String getGoodscodename() {
		return goodscodename;
	}
	public void setGoodscodename(String goodscodename) {
		this.goodscodename = goodscodename;
	}
	public String getYbssid() {
		return ybssid;
	}
	public void setYbssid(String ybssid) {
		this.ybssid = ybssid;
	}
}
