package com.wit.model;
import java.sql.Date;

public class WebPriceSheetPage extends Page{
	private String priceSheetId;
	private String productName;
	private String companyName;
	private Date createDateStart;
	private Date createDateStop;
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getPriceSheetId() {
		return priceSheetId;
	}
	public void setPriceSheetId(String priceSheetId) {
		this.priceSheetId = priceSheetId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Date getCreateDateStart() {
		return createDateStart;
	}
	public void setCreateDateStart(Date createDateStart) {
		this.createDateStart = createDateStart;
	}
	public Date getCreateDateStop() {
		return createDateStop;
	}
	public void setCreateDateStop(Date createDateStop) {
		this.createDateStop = createDateStop;
	}
	@Override
	public String toString() {
		return "webPriceSheetPage [priceSheetId=" + priceSheetId
				+ ", productName=" + productName + ", companyName="
				+ companyName + ", createDateStart=" + createDateStart
				+ ", createDateStop=" + createDateStop + "]";
	}
	
}
