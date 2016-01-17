package com.wit.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 公司供应商品实体类
 * @author Jason-Tang
 *
 */
public class CompanyProducts {
	//公司供应商品id
	private Integer id;
	//供应商id
	private Integer companyId;
	//供应商名称
	private String companyName;
	//供应商
	private Companys company;
	//商品id
	private Integer productId;
	//商品
	private Products product;
	//状态
	private Integer status;
	
	private Integer productStatus;
	
	private BigDecimal unitPrice;
	
	private String productName;
	
	private Integer picClass;
	
	private List<CompanyProductPic> companyProductPics;//用于详情图片
		
	
	
	private String productCategoryName;
	
	private Timestamp productDate;   //生产日期
	
	private String productRemark;  //商品备注
	
	private String companyProductCode;//商品编码
	
	private Timestamp requestTime; //修改时间（不做展示）

	private int isSample;//是否提供商品小样
	

	public Integer getProductStatus() {
		return productStatus;
	}


	public void setProductStatus(Integer productStatus) {
		this.productStatus = productStatus;
	}


	public Integer getPicClass() {
		return picClass;
	}


	public void setPicClass(Integer picClass) {
		this.picClass = picClass;
		
	}


	public List<CompanyProductPic> getCompanyProductPics() {
		return companyProductPics;
	}


	public void setCompanyProductPics(List<CompanyProductPic> companyProductPics) {
		this.companyProductPics = companyProductPics;
	}


	public int getIsSample() {
		return isSample;
	}


	public void setIsSample(int isSample) {
		this.isSample = isSample;
	}


	public Timestamp getRequestTime() {
		return requestTime;
	}




	public Timestamp getProductDate() {
		return productDate;
	}


	public void setProductDate(Timestamp productDate) {
		this.productDate = productDate;
	}


	public void setRequestTime(Timestamp requestTime) {
		this.requestTime = requestTime;
	}


	public String getCompanyProductCode() {
		return companyProductCode;
	}

	public void setCompanyProductCode(String companyProductCode) {
		this.companyProductCode = companyProductCode;
	}

	public String getProductRemark() {
		return productRemark;
	}

	public void setProductRemark(String productRemark) {
		this.productRemark = productRemark;
	}



	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}



	@Override
	public String toString() {
		return "CompanyProducts [id=" + id + ", companyId=" + companyId
				+ ", company=" + company + ", productId=" + productId
				+ ", product=" + product + ", status=" + status
				+ ", productStatus=" + productStatus + ", unitPrice="
				+ unitPrice + ", productName=" + productName + ", picClass="
				+ picClass + ", companyProductPics=" + companyProductPics
				+ ", companyName=" + companyName + ", productCategoryName="
				+ productCategoryName + ", productDate=" + productDate
				+ ", productRemark=" + productRemark + ", companyProductCode="
				+ companyProductCode + ", requestTime=" + requestTime
				+ ", isSample=" + isSample + "]";
	}


	public CompanyProducts() {
	}
	
	public Companys getCompany() {
		return company;
	}
	public void setCompany(Companys company) {
		this.company = company;
	}
	public Products getProduct() {
		return product;
	}
	public void setProduct(Products product) {
		this.product = product;
	}
	public CompanyProducts(Integer id, Integer companyId, Integer productId,
			Integer status) {
		super();
		this.id = id;
		this.companyId = companyId;
		this.productId = productId;
		this.status = status;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getProductCategoryName() {
		return productCategoryName;
	}

	public void setProductCategoryName(String productCategoryName) {
		this.productCategoryName = productCategoryName;
	}
	
}
