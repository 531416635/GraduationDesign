package com.wit.model;

public class ProductCantegoryPage extends Page {
	private String cateGoryCode;//类别简称
	private Integer parentCateGory;//父类别
	public String getCateGoryCode() {
		return cateGoryCode;
	}
	public void setCateGoryCode(String cateGoryCode) {
		this.cateGoryCode = cateGoryCode;
	}
	public Integer getParentCateGory() {
		return parentCateGory;
	}
	public void setParentCateGory(Integer parentCateGory) {
		this.parentCateGory = parentCateGory;
	}
}
