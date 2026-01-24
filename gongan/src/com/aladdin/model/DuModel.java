package com.aladdin.model;  

/**
 * 
 * User: Ting
*  用户根据文本框的输入值 动态产生下拉列表
 * change this template use File | Settings | File Templates.
 */
public class DuModel {         
    private String text; //下拉列表现实值
    private String xi; //下拉列value值
    private String zhi;//补充字段
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

	public String getXi() {
		return xi;
	}

	public void setXi(String xi) {
		this.xi = xi;
	}

	public String getZhi() {
		return zhi;
	}

	public void setZhi(String zhi) {
		this.zhi = zhi;
	}

    
}
