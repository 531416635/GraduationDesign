package com.wit.model;

import java.math.BigDecimal;
import java.sql.Date;
/*
 * 团购
 */
public class Groupon {
	private Integer id;
	private Integer productId;
	private BigDecimal grouponPrice;  //团购价
	private Date validityTime;  //有效期
	private String remark;  //购买须知
	private BigDecimal discount;  //折扣
	private BigDecimal spare;  //节省
	private Integer status;
	private Integer soldOut; //已售
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public BigDecimal getGrouponPrice() {
		return grouponPrice;
	}
	public void setGrouponPrice(BigDecimal grouponPrice) {
		this.grouponPrice = grouponPrice;
	}
	public Date getValidityTime() {
		return validityTime;
	}
	public void setValidityTime(Date validityTime) {
		this.validityTime = validityTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public BigDecimal getDiscount() {
		return discount;
	}
	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}
	public BigDecimal getSpare() {
		return spare;
	}
	public void setSpare(BigDecimal spare) {
		this.spare = spare;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getSoldOut() {
		return soldOut;
	}
	public void setSoldOut(Integer soldOut) {
		this.soldOut = soldOut;
	}
	
}
