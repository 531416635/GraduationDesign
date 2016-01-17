package com.wit.model;

public class FiltratePage extends Page{
	@Override
	public int getPageNum() {
		pageNum=16;
		return pageNum;
	}
	private String productName;
	private String productCategory;
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	
	
}
