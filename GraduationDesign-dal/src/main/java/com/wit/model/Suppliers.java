package com.wit.model;

import java.util.Date;

public class Suppliers {
	private Integer id;
	private Integer buyCompanyId; //
	private Integer sellCompanyProductId;//
	private Integer isDefault;//
	private Integer isLock; //
	private Date updateTime;//
	private Integer updateBy;//
	
	
	public Integer getBuyCompanyId() {
		return buyCompanyId;
	}
	public void setBuyCompanyId(Integer buyCompanyId) {
		this.buyCompanyId = buyCompanyId;
	}

	public Integer getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(Integer isDefault) {
		this.isDefault = isDefault;
	}
	public Integer getIsLock() {
		return isLock;
	}
	public void setIsLock(Integer isLock) {
		this.isLock = isLock;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSellCompanyProductId() {
		return sellCompanyProductId;
	}
	public void setSellCompanyProductId(Integer sellCompanyProductId) {
		this.sellCompanyProductId = sellCompanyProductId;
	}
	public Integer getUpdateBy() {
		return updateBy;
	}
	public void setUpdateBy(Integer updateBy) {
		this.updateBy = updateBy;
	}
	
}
