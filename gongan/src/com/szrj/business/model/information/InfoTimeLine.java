package com.szrj.business.model.information;

/**
 * 时光轴(试用)
 * @author 李昊
 * Oct 18, 2021
 */
public class InfoTimeLine {

	private Integer id;					//自增ID
	private Integer infoid;				//情报information id
	private String informationsendid;	//情报informationSend id
	private String  informationreceiveid;//情报informationReceice id列表
	private Integer infoAnnotationid;	//批注id
	private Integer infoAssign;			//情报交办id
	private Integer assignSignfor;		//交办反馈id
	private String title;				//标题
	private String content;				//内容
	private String addtime;				//时间
	private Integer validflag;			//状态标识
	
	public InfoTimeLine(){}

	public InfoTimeLine(Integer infoid,String informationsendid,String informationreceiveid,
			Integer infoAssign,Integer assignSignfor, String title,String content,String addtime,Integer infoAnnotationid){
		this.infoid = infoid;
		this.informationsendid = informationsendid;
		this.informationreceiveid = informationreceiveid;
		this.title = title;
		this.content = content;
		this.addtime = addtime;
		this.infoAnnotationid = infoAnnotationid;
		this.infoAssign = infoAssign;
		this.assignSignfor = assignSignfor;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getInfoid() {
		return infoid;
	}
	public void setInfoid(Integer infoid) {
		this.infoid = infoid;
	}
	public String getInformationsendid() {
		return informationsendid;
	}
	public void setInformationsendid(String informationsendid) {
		this.informationsendid = informationsendid;
	}
	public String getInformationreceiveid() {
		return informationreceiveid;
	}
	public void setInformationreceiveid(String informationreceiveid) {
		this.informationreceiveid = informationreceiveid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Integer getValidflag() {
		return validflag;
	}
	public void setValidflag(Integer validflag) {
		this.validflag = validflag;
	}

	public Integer getInfoAnnotationid() {
		return infoAnnotationid;
	}

	public void setInfoAnnotationid(Integer infoAnnotationid) {
		this.infoAnnotationid = infoAnnotationid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getInfoAssign() {
		return infoAssign;
	}

	public void setInfoAssign(Integer infoAssign) {
		this.infoAssign = infoAssign;
	}

	public Integer getAssignSignfor() {
		return assignSignfor;
	}

	public void setAssignSignfor(Integer assignSignfor) {
		this.assignSignfor = assignSignfor;
	}

	
	
	
}
