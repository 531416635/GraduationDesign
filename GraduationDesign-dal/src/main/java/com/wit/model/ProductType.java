package com.wit.model;

import java.util.List;

//产品类别
public class ProductType {
	private Integer id;
	private String typeName;  //类别名称
	private Integer parentType; //父类别
	private ProductType parentTypee; //父类别
	private String typeCode; //类别简称
	private Integer productCategoryId; 
	private ProductType element; //成分
	private ProductType standard; //规格
	private ProductType manufacturer; //厂商
	private ProductType wrap; //包装
	private ProductType technology; //工艺
	private List<ProductType> productTypes;
	
	public List<ProductType> getProductTypes() {
		return productTypes;
	}
	public void setProductTypes(List<ProductType> productTypes) {
		this.productTypes = productTypes;
	}
	public ProductType getElement() {
		return element;
	}
	public void setElement(ProductType element) {
		this.element = element;
	}
	public ProductType getStandard() {
		return standard;
	}
	public void setStandard(ProductType standard) {
		this.standard = standard;
	}
	public ProductType getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(ProductType manufacturer) {
		this.manufacturer = manufacturer;
	}
	public ProductType getWrap() {
		return wrap;
	}
	public void setWrap(ProductType wrap) {
		this.wrap = wrap;
	}
	public ProductType getTechnology() {
		return technology;
	}
	public void setTechnology(ProductType technology) {
		this.technology = technology;
	}
	public Integer getProductCategoryId() {
		return productCategoryId;
	}
	public void setProductCategoryId(Integer productCategoryId) {
		this.productCategoryId = productCategoryId;
	}
	public ProductType getParentTypee() {
		return parentTypee;
	}
	public void setParentTypee(ProductType parentTypee) {
		this.parentTypee = parentTypee;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public Integer getParentType() {
		return parentType;
	}
	public void setParentType(Integer parentType) {
		this.parentType = parentType;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	@Override
	public String toString() {
		return "ProductType [id=" + id + ", typeName=" + typeName
				+ ", parentType=" + parentType + ", parentTypee=" + parentTypee
				+ ", typeCode=" + typeCode + ", productCategoryId="
				+ productCategoryId + ", element=" + element + ", standard="
				+ standard + ", manufacturer=" + manufacturer + ", wrap="
				+ wrap + ", technology=" + technology + "]";
	}

}
