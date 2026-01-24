package com.aladdin.model;

/**
 * 接口服务日志
 * @author lihao
 */
public class InterfaceServiceLog {
	
	private Long Num_ID;				//32  记录标识
	private String Reg_ID;				//12  应用系统标识
	private String interface_Name;		//50  *接口名称
	private String Requester;			//50  请求方名称
	private String User_ID;				//18  *用户标识
	private String Organization;		//100 *单位名称
	private String Organization_ID;		//12  *单位机构代码
	private String User_Name;			//30  *用户姓名
	private String Interface_Time;		//14   接口服务时间 YYYYMMDDhhmmss，24小时制格式
	private String Terminal_ID;			//40   终端标识
	private String interface_Result;	//1    接口服务结果 1:成功 0:失败
	private String Error_Code;			//4   *失败原因代码
	private String Interface_Condition;	//3000 接口服务条件
	
	public Long getNum_ID() {
		return Num_ID;
	}
	public void setNum_ID(Long num_ID) {
		Num_ID = num_ID;
	}
	public String getReg_ID() {
		return Reg_ID;
	}
	public void setReg_ID(String reg_ID) {
		Reg_ID = reg_ID;
	}
	public String getInterface_Name() {
		return interface_Name;
	}
	public void setInterface_Name(String interface_Name) {
		this.interface_Name = interface_Name;
	}
	public String getRequester() {
		return Requester;
	}
	public void setRequester(String requester) {
		Requester = requester;
	}
	public String getUser_ID() {
		return User_ID;
	}
	public void setUser_ID(String user_ID) {
		User_ID = user_ID;
	}
	public String getOrganization() {
		return Organization;
	}
	public void setOrganization(String organization) {
		Organization = organization;
	}
	public String getOrganization_ID() {
		return Organization_ID;
	}
	public void setOrganization_ID(String organization_ID) {
		Organization_ID = organization_ID;
	}
	public String getUser_Name() {
		return User_Name;
	}
	public void setUser_Name(String user_Name) {
		User_Name = user_Name;
	}
	public String getInterface_Time() {
		return Interface_Time;
	}
	public void setInterface_Time(String interface_Time) {
		Interface_Time = interface_Time;
	}
	public String getTerminal_ID() {
		return Terminal_ID;
	}
	public void setTerminal_ID(String terminal_ID) {
		Terminal_ID = terminal_ID;
	}
	public String getInterface_Result() {
		return interface_Result;
	}
	public void setInterface_Result(String interface_Result) {
		this.interface_Result = interface_Result;
	}
	public String getError_Code() {
		return Error_Code;
	}
	public void setError_Code(String error_Code) {
		Error_Code = error_Code;
	}
	public String getInterface_Condition() {
		return Interface_Condition;
	}
	public void setInterface_Condition(String interface_Condition) {
		Interface_Condition = interface_Condition;
	}
	
}
