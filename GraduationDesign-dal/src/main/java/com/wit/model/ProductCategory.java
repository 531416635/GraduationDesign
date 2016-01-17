package com.wit.model;

import java.util.List;
import java.util.Map;

/**
 * 商品品类实体类
 * @author Administrator
 *
 */
public class ProductCategory {
	private Integer id;//ID
	private String cateGoryName;//类别名称
	private Integer parentCateGory;//父类别
	private ProductCategory parentCateGoryy;//父类别对象属性
	private String cateGoryCode;//类别简称
	private  List<Products> products; //首页推荐商品
	private List<ProductCategory> productCategorys;//二级类别集合
	private List<ProductBrand> commodityBrands; //二级类别下属商标集合
	private List<ProductType> productTypes; //二级类别下属商品属性集合
	private List<ProductType> elements;
	private List<ProductType> standards;
	
	private  List<Map<String,Object>> soptProducts; //首页推荐商品
	
	public List<Map<String, Object>> getSoptProducts() {
		return soptProducts;
	}
	public void setSoptProducts(List<Map<String, Object>> soptProducts) {
		this.soptProducts = soptProducts;
	}
	public List<ProductType> getElements() {
		return elements;
	}
	public void setElements(List<ProductType> elements) {
		this.elements = elements;
	}
	public List<ProductType> getStandards() {
		return standards;
	}
	public void setStandards(List<ProductType> standards) {
		this.standards = standards;
	}
	public List<ProductCategory> getProductCategorys() {
		return productCategorys;
	}
	public void setProductCategorys(List<ProductCategory> productCategorys) {
		this.productCategorys = productCategorys;
	}
	public List<Products> getProducts() {
		return products;
	}
	public void setProducts(List<Products> products) {
		this.products = products;
	}
	public ProductCategory getParentCateGoryy() {
		return parentCateGoryy;
	}
	public void setParentCateGoryy(ProductCategory parentCateGoryy) {
		this.parentCateGoryy = parentCateGoryy;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCateGoryName() {
		return cateGoryName;
	}
	public void setCateGoryName(String cateGoryName) {
		this.cateGoryName = cateGoryName;
	}
	public Integer getParentCateGory() {
		return parentCateGory;
	}
	public void setParentCateGory(Integer parentCateGory) {
		this.parentCateGory = parentCateGory;
	}
	public String getCateGoryCode() {
		return cateGoryCode;
	}
	public void setCateGoryCode(String cateGoryCode) {
		this.cateGoryCode = cateGoryCode;
	}
	public List<ProductBrand> getCommodityBrands() {
		return commodityBrands;
	}
	public void setCommodityBrands(List<ProductBrand> commodityBrands) {
		this.commodityBrands = commodityBrands;
	}
	
	public List<ProductType> getProductTypes() {
		return productTypes;
	}
	public void setProductTypes(List<ProductType> productTypes) {
		this.productTypes = productTypes;
	}
	@Override
	public String toString() {
		return "ProductCategory [id=" + id + ", cateGoryName=" + cateGoryName
				+ ", parentCateGory=" + parentCateGory + ", parentCateGoryy="
				+ parentCateGoryy + ", cateGoryCode=" + cateGoryCode
				+ ", products=" + products + ", productCategorys="
				+ productCategorys + ", commodityBrands=" + commodityBrands
				+ ", productTypes=" + productTypes + ", elements=" + elements
				+ ", standards=" + standards + "]";
	}

	

}
