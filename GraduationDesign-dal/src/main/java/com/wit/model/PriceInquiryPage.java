package com.wit.model;
import java.sql.Date;

public class PriceInquiryPage extends Page{
	private Integer inquiryId;
	private String productName;
	private Date inquiryTimeStart;
	private Date inquiryTimeStop;
	public Integer getInquiryId() {
		return inquiryId;
	}
	public void setInquiryId(Integer inquiryId) {
		this.inquiryId = inquiryId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Date getInquiryTimeStart() {
		return inquiryTimeStart;
	}
	public void setInquiryTimeStart(Date inquiryTimeStart) {
		this.inquiryTimeStart = inquiryTimeStart;
	}
	public Date getInquiryTimeStop() {
		return inquiryTimeStop;
	}
	public void setInquiryTimeStop(Date inquiryTimeStop) {
		this.inquiryTimeStop = inquiryTimeStop;
	}
	@Override
	public String toString() {
		return "PriceInquiryPage [inquiryId=" + inquiryId + ", productName="
				+ productName + ", inquiryTimeStart=" + inquiryTimeStart
				+ ", inquiryTimeStop=" + inquiryTimeStop + "]";
	}
	
	
	
}
