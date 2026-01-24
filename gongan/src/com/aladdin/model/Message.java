package com.aladdin.model;
   

public class Message {
    private String result;  //成功失败标示字符串 一般为true或者false
    private String msg;    //成功失败提示信息
    private String mark;
    private int flag;           //根据不同情况的设置的标示位

    public Message(String result, String msg) {
        this.result = result;
        this.msg = msg;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}
    
}
