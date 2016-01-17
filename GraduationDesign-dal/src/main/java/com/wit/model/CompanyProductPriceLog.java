package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * 供应商商品历史价格实体类
 * @author Jason-Tang
 *
 */
public class CompanyProductPriceLog {
	//供应商商品历史价格id
	private Integer id;
	//供应商商品id
	private Integer companyProductId;
	//最小数量
	private BigDecimal minNum;
	//最大数量
	private BigDecimal maxNum;
	//价格
	private BigDecimal price;
	//毛利价格id
	private Integer grossmMarginPriceId;
	
	private GrossMargin grossMargins;
	//用户id
	private Integer userId;
	//价格时间
	private Date priceDate;
	//商品价格编码
	private String companyProductCode;

	@Override
	public String toString() {
		return "CompanyProductPriceLog [id=" + id + ", companyProductId="
				+ companyProductId + ", minNum=" + minNum + ", maxNum="
				+ maxNum + ", price=" + price + ", grossmMarginPriceId="
				+ grossmMarginPriceId + ", grossMargins=" + grossMargins
				+ ", userId=" + userId + ", priceDate=" + priceDate
				+ ", companyProductCode=" + companyProductCode + "]";
	}
	public GrossMargin getGrossMargins() {
		return grossMargins;
	}
	public void setGrossMargins(GrossMargin grossMargins) {
		this.grossMargins = grossMargins;
	}
	public CompanyProductPriceLog() {
	}
	public CompanyProductPriceLog(Integer id, Integer companyProductId,
			BigDecimal minNum, BigDecimal maxNum, BigDecimal price,
			Integer grossmMarginPriceId, Integer userId, Date priceDate,
			String companyProductCode) {
		super();
		this.id = id;
		this.companyProductId = companyProductId;
		this.minNum = minNum;
		this.maxNum = maxNum;
		this.price = price;
		this.grossmMarginPriceId = grossmMarginPriceId;
		this.userId = userId;
		this.priceDate = priceDate;
		this.companyProductCode = companyProductCode;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCompanyProductId() {
		return companyProductId;
	}
	public void setCompanyProductId(Integer companyProductId) {
		this.companyProductId = companyProductId;
	}
	public BigDecimal getMinNum() {
		return minNum;
	}
	public void setMinNum(BigDecimal minNum) {
		this.minNum = minNum;
	}
	public BigDecimal getMaxNum() {
		return maxNum;
	}
	public void setMaxNum(BigDecimal maxNum) {
		this.maxNum = maxNum;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Integer getGrossmMarginPriceId() {
		return grossmMarginPriceId;
	}
	public void setGrossmMarginPriceId(Integer grossmMarginPriceId) {
		this.grossmMarginPriceId = grossmMarginPriceId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Date getPriceDate() {
		return priceDate;
	}
	public void setPriceDate(Date priceDate) {
		this.priceDate = priceDate;
	}
	public String getCompanyProductCode() {
		return companyProductCode;
	}
	public void setCompanyProductCode(String companyProductCode) {
		this.companyProductCode = companyProductCode;
	}
	
}
