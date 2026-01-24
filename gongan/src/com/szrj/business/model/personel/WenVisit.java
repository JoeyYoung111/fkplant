package com.szrj.business.model.personel;

/**
 * @author szrj_huaxia
 *涉访涉诉经历-涉稳 p_wen_visit_t
 */
public class WenVisit {
	/*---------------------------------------数据库中字段------------------------------------------------------------------------*/
	private int id;//ID 
	private int personnelid;//人员主表id 
	private String startdate;//活动开始日期 
	private String enddate;//活动结束日期 
	private int sensitivenode;//是否敏感节点 
	private String nodename;//敏感节点名称 数据字典，存汉字 
	private String nodememo;//敏感节点备注说明
	private String activitytype;//当次行为活动类别  数据字典，存汉字 
	private String activitymemo;//当次行为活动类别 备注 
	private String activitydirection;//行为活动方向 市县、赴省、赴京、其它 
	private String directionmemo;//行为活动方向 备注 
	private String relatedplace;//行为活动涉及场所 
	private String placememo;//行为活动涉及场所 备注 
	private String placecharacter;//单位场所性质 根据行为活动涉及场所 自动填充 
	private String activityform;//行为活动具体形式 数据字典，存汉字 
	private String formmemo;//行为活动具体形式 备注 
	private String activitything;//行为活动携带物品 数据字典，存汉字 
	private String thingmemo;//行为活动携带物品 备注 
	private String activityprocess;//行为活动具体经过 
	private String acceptance;//行为活动涉及单位登记受理情况 
	private String traffictype;//行为活动前往方式 
	private String togetherperson;//前往活动同行人员 
	private String staytype;//行为活动落脚方式 旅馆住宿、租住房屋、关系借宿、其它落脚方式 
	private String staymemo;//行为活动落脚方式 备注 
	//旅馆住宿
	private String hotelintime;//(旅馆住宿)入住时间
	private String hotelouttime;//(旅馆住宿)退房时间
	private String hotelname;//(旅馆住宿)旅馆名称
	private String hotelroom;//(旅馆住宿)入住房号
	private String hotelcode;//(旅馆住宿)旅馆编码
	private String hoteladdress;//(旅馆住宿)旅馆地址
	//旅馆住宿-end
	private String findunit;//行为活动现场发现单位 
	private String handleresult;//现场处置结果情况 数据字典，存汉字 
	private String admonishfile;//训诫书附件 
	private String returntype;//行为人员返回方式 自行返回、中途劝返、对接领回 
	private String returnvehicle;//行为人员返回使用交通工具 数据字典，存汉字 
	private String vehiclememo;//返回使用交通工具备注说明
	//非自行返回
	private String powerunit;//(非自行返回)接回力量单位	
	private String personstate;//(非自行返回)人员情况
	//非自行返回-end
	private String returncollect;//人员回澄采集情况 已标采、采手机、未采集、无采集条件 
	private String returnpunish;//人员回澄处罚结果 教育训诫、行政处罚、刑事强制、暂不处理 
	private String punishcontent;//具体处罚内容 
	private String unitreply;//登记受理单位答复情况 
	private String attachments;//附件 
	private int validflag;//状态标识   1：正常 0:作废 
	private String addoperator;//添加人 
	private String addtime;//添加时间 
	private String updateoperator;//最新修改人 
	private String updatetime;//最新修改时间 
	private String memo;//备注信息 
	/*---------------------------------------非数据库中字段-------------------------------------*/
	private String admonishfilename;//训诫书附件名称 
	private String attachmentsname;//附件名称 
	/*-----------------------------------------get/set方法---------------------------------------------------------------------*/
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
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public int getSensitivenode() {
		return sensitivenode;
	}
	public void setSensitivenode(int sensitivenode) {
		this.sensitivenode = sensitivenode;
	}
	public String getNodename() {
		return nodename;
	}
	public void setNodename(String nodename) {
		this.nodename = nodename;
	}
	public String getActivitytype() {
		return activitytype;
	}
	public void setActivitytype(String activitytype) {
		this.activitytype = activitytype;
	}
	public String getActivitymemo() {
		return activitymemo;
	}
	public void setActivitymemo(String activitymemo) {
		this.activitymemo = activitymemo;
	}
	public String getActivitydirection() {
		return activitydirection;
	}
	public void setActivitydirection(String activitydirection) {
		this.activitydirection = activitydirection;
	}
	public String getDirectionmemo() {
		return directionmemo;
	}
	public void setDirectionmemo(String directionmemo) {
		this.directionmemo = directionmemo;
	}
	public String getRelatedplace() {
		return relatedplace;
	}
	public void setRelatedplace(String relatedplace) {
		this.relatedplace = relatedplace;
	}
	public String getPlacememo() {
		return placememo;
	}
	public void setPlacememo(String placememo) {
		this.placememo = placememo;
	}
	public String getPlacecharacter() {
		return placecharacter;
	}
	public void setPlacecharacter(String placecharacter) {
		this.placecharacter = placecharacter;
	}
	public String getActivityform() {
		return activityform;
	}
	public void setActivityform(String activityform) {
		this.activityform = activityform;
	}
	public String getFormmemo() {
		return formmemo;
	}
	public void setFormmemo(String formmemo) {
		this.formmemo = formmemo;
	}
	public String getActivitything() {
		return activitything;
	}
	public void setActivitything(String activitything) {
		this.activitything = activitything;
	}
	public String getThingmemo() {
		return thingmemo;
	}
	public void setThingmemo(String thingmemo) {
		this.thingmemo = thingmemo;
	}
	public String getActivityprocess() {
		return activityprocess;
	}
	public void setActivityprocess(String activityprocess) {
		this.activityprocess = activityprocess;
	}
	public String getAcceptance() {
		return acceptance;
	}
	public void setAcceptance(String acceptance) {
		this.acceptance = acceptance;
	}
	public String getTraffictype() {
		return traffictype;
	}
	public void setTraffictype(String traffictype) {
		this.traffictype = traffictype;
	}
	public String getTogetherperson() {
		return togetherperson;
	}
	public void setTogetherperson(String togetherperson) {
		this.togetherperson = togetherperson;
	}
	public String getStaytype() {
		return staytype;
	}
	public void setStaytype(String staytype) {
		this.staytype = staytype;
	}
	public String getStaymemo() {
		return staymemo;
	}
	public void setStaymemo(String staymemo) {
		this.staymemo = staymemo;
	}
	public String getFindunit() {
		return findunit;
	}
	public void setFindunit(String findunit) {
		this.findunit = findunit;
	}
	public String getHandleresult() {
		return handleresult;
	}
	public void setHandleresult(String handleresult) {
		this.handleresult = handleresult;
	}
	public String getAdmonishfile() {
		return admonishfile;
	}
	public void setAdmonishfile(String admonishfile) {
		this.admonishfile = admonishfile;
	}
	public String getReturntype() {
		return returntype;
	}
	public void setReturntype(String returntype) {
		this.returntype = returntype;
	}
	public String getReturnvehicle() {
		return returnvehicle;
	}
	public void setReturnvehicle(String returnvehicle) {
		this.returnvehicle = returnvehicle;
	}
	public String getVehiclememo() {
		return vehiclememo;
	}
	public void setVehiclememo(String vehiclememo) {
		this.vehiclememo = vehiclememo;
	}
	public String getReturncollect() {
		return returncollect;
	}
	public void setReturncollect(String returncollect) {
		this.returncollect = returncollect;
	}
	public String getReturnpunish() {
		return returnpunish;
	}
	public void setReturnpunish(String returnpunish) {
		this.returnpunish = returnpunish;
	}
	public String getPunishcontent() {
		return punishcontent;
	}
	public void setPunishcontent(String punishcontent) {
		this.punishcontent = punishcontent;
	}
	public String getUnitreply() {
		return unitreply;
	}
	public void setUnitreply(String unitreply) {
		this.unitreply = unitreply;
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
	public String getHotelintime() {
		return hotelintime;
	}
	public void setHotelintime(String hotelintime) {
		this.hotelintime = hotelintime;
	}
	public String getHotelouttime() {
		return hotelouttime;
	}
	public void setHotelouttime(String hotelouttime) {
		this.hotelouttime = hotelouttime;
	}
	public String getHotelname() {
		return hotelname;
	}
	public void setHotelname(String hotelname) {
		this.hotelname = hotelname;
	}
	public String getHotelroom() {
		return hotelroom;
	}
	public void setHotelroom(String hotelroom) {
		this.hotelroom = hotelroom;
	}
	public String getHotelcode() {
		return hotelcode;
	}
	public void setHotelcode(String hotelcode) {
		this.hotelcode = hotelcode;
	}
	public String getHoteladdress() {
		return hoteladdress;
	}
	public void setHoteladdress(String hoteladdress) {
		this.hoteladdress = hoteladdress;
	}
	public String getPowerunit() {
		return powerunit;
	}
	public void setPowerunit(String powerunit) {
		this.powerunit = powerunit;
	}
	public String getPersonstate() {
		return personstate;
	}
	public void setPersonstate(String personstate) {
		this.personstate = personstate;
	}
	public String getNodememo() {
		return nodememo;
	}
	public void setNodememo(String nodememo) {
		this.nodememo = nodememo;
	}
	public String getAdmonishfilename() {
		return admonishfilename;
	}
	public void setAdmonishfilename(String admonishfilename) {
		this.admonishfilename = admonishfilename;
	}
	public String getAttachmentsname() {
		return attachmentsname;
	}
	public void setAttachmentsname(String attachmentsname) {
		this.attachmentsname = attachmentsname;
	}
	
}
