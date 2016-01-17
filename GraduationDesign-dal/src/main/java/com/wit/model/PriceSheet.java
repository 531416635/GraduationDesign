package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;

import jxl.write.DateTime;

/**
 * 报价单管理
 * @author Administrator
 *
 */
public class PriceSheet {
	private Integer id;	//ID
	private Integer userId;//用户ID
	private String priceSheetId;//报价单编号
	private Integer companyProductId;
	private Integer quantity;//数量
	private String productUnit;//数量单位
	private BigDecimal unitPrice;//单价
	private Date deliveryDate;//交货期
	private Date validUntil;//有效期至
	private Integer status;//状态
	private Integer IsBargain;//是否议价
	private Users users;
	private DateTime  createDate;
	
	public DateTime getCreateDate() {
		return createDate;
	}
	public void setCreateDate(DateTime createDate) {
		this.createDate = createDate;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	public Integer getIsBargain() {
		return IsBargain;
	}
	public void setIsBargain(Integer isBargain) {
		IsBargain = isBargain;
	}
	public BigDecimal getBargainPrice() {
		return BargainPrice;
	}
	public void setBargainPrice(BigDecimal bargainPrice) {
		BargainPrice = bargainPrice;
	}
	private BigDecimal BargainPrice;//议价单价

	
	@Override
	public String toString() {
		return "PriceSheet [id=" + id + ", userId=" + userId
				+ ", priceSheetId=" + priceSheetId + ", productType="
				+ ", quantity=" + quantity + ", productUnit=" + productUnit
				+ ", unitPrice=" + unitPrice + ", deliveryDate=" + deliveryDate
				+ ", validUntil=" + validUntil + ", status=" + status + "]";
	}
	public Integer getCompanyProductId() {
		return companyProductId;
	}
	public void setCompanyProductId(Integer companyProductId) {
		this.companyProductId = companyProductId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getPriceSheetId() {
		return priceSheetId;
	}
	public void setPriceSheetId(String priceSheetId) {
		this.priceSheetId = priceSheetId;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public String getProductUnit() {
		return productUnit;
	}
	public void setProductUnit(String productUnit) {
		this.productUnit = productUnit;
	}
	public BigDecimal getUnitPrice() {
		if(unitPrice==null){
			return unitPrice;
		}else {
			return unitPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		
	}
	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}
	public Date getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	public Date getValidUntil() {
		return validUntil;
	}
	public void setValidUntil(Date validUntil) {
		this.validUntil = validUntil;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}
