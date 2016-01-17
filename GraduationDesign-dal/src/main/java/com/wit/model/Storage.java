package com.wit.model;

import java.math.BigDecimal;

/**
 * 仓储实体类
 * @author Administrator
 *
 */
public class Storage {
	private Integer id;//ID
	private String storageCode;//仓储编号
	private String storageName;//仓储名称
	private Integer supplierId;//供应商ID
	private Integer goodsId;//商品ID
	private BigDecimal goodsNum;//数量
	private String goodsUnit;//数量单位
	private BigDecimal goodsPrice;//商品单价
	

	
	@Override
	public String toString() {
		return "Storage [id=" + id + ", storageCode=" + storageCode
				+ ", storageName=" + storageName + ", supplierId=" + supplierId
				+ ", goodsId=" + goodsId + ", goodsNum=" + goodsNum
				+ ", goodsUnit=" + goodsUnit + ", goodsPrice=" + goodsPrice
				+ "]";
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStorageCode() {
		return storageCode;
	}
	public void setStorageCode(String storageCode) {
		this.storageCode = storageCode;
	}
	public String getStorageName() {
		return storageName;
	}
	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}
	public Integer getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}
	public Integer getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}
	public BigDecimal getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(BigDecimal goodsNum) {
		this.goodsNum = goodsNum;
	}
	public String getGoodsUnit() {
		return goodsUnit;
	}
	public void setGoodsUnit(String goodsUnit) {
		this.goodsUnit = goodsUnit;
	}
	public BigDecimal getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(BigDecimal goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	
	
}
