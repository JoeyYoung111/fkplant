package com.szrj.business.model.information;

/**
 * 情报批注表 i_information_annotation_t
 * @author 李昊
 * Oct 14, 2021
 */
public class InfoAnnotation {

	private Integer id;				//自增id
	private Integer sendid;			//发布接收id i_ information_send_t中id
	private Integer informationid;	//情报信息id
	private Integer annotationtype;	//批注类型 1-源头批注 2-工作批注
	private Integer receiveid;		//接收单位id
	private String content;			//批注内容
	private Integer validflag;		//状态标识 1-未签收 2-已签收
	private String addoperator;		//添加人
	private String addtime;			//添加时间
	private String signoper;		//签收人
	private String signtime;		//签收时间
	private String memo;			//备注信息
	/*-------------------------*/
	private Integer limit;
	private String receivename;		//接收单位
	/*-------------------------*/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSendid() {
		return sendid;
	}
	public void setSendid(Integer sendid) {
		this.sendid = sendid;
	}
	public Integer getInformationid() {
		return informationid;
	}
	public void setInformationid(Integer informationid) {
		this.informationid = informationid;
	}
	public Integer getAnnotationtype() {
		return annotationtype;
	}
	public void setAnnotationtype(Integer annotationtype) {
		this.annotationtype = annotationtype;
	}
	public Integer getReceiveid() {
		return receiveid;
	}
	public void setReceiveid(Integer receiveid) {
		this.receiveid = receiveid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getValidflag() {
		return validflag;
	}
	public void setValidflag(Integer validflag) {
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
	public String getSignoper() {
		return signoper;
	}
	public void setSignoper(String signoper) {
		this.signoper = signoper;
	}
	public String getSigntime() {
		return signtime;
	}
	public void setSigntime(String signtime) {
		this.signtime = signtime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public String getReceivename() {
		return receivename;
	}
	public void setReceivename(String receivename) {
		this.receivename = receivename;
	}
	
	
}
