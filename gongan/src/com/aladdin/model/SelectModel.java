package com.aladdin.model;  

/**
 * 
 * User: Ting
*  用户根据文本框的输入值 动态产生下拉列表
 * change this template use File | Settings | File Templates.
 */
public class SelectModel {         
    private String text; //下拉列表现实值
    private String name; //下拉列表现实值
    private String value; //下拉列value值
    private String memo;//补充字段
    private int max;
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getMax() {
		return max;
	}

	public void setMax(int max) {
		this.max = max;
	}
}
