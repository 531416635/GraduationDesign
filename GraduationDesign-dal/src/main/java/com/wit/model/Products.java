package com.wit.model;

import java.math.BigDecimal;
import java.util.List;


/**
 * 商品实体类
 * @author Administrator
 *
 */
public class Products {
	private Integer id;//ID
	private String productName;//商品名称
	private String productTitle;//特供商品标题语
	//保存时，用于封装提交的一组商品类别ID
	private List<Integer> productTypeIds;
	private List<ProductType> productTypes; //商品类别
	private List<ProductCategory> productCategorys; //商品类别

	private BigDecimal unitPrice;//商品单价
	private String productInfo;//商品简介
	private Integer productBrandId;//商品品牌
	private String productCategory;//添加时保存商品所有品类及类别属性值
	/*private ProductCategory productCategorys;//商品品类
*/	private List<Companys> companys;
	private ProductPic productPic;
	private List<ProductPic> productPics;//用于三级商品详情展现图片
	private String filePath; //图片路径
	private   Integer  isHotShow=0;  
	private  Integer   isSubPageShow=0;
	private  Integer   isHomeShow=0;
	private Integer productModel;
	private String ProductUnit;
	private String status="0";
	private String productBrand;
	private String productCode;
	private BigDecimal spotUnitPrice;//现货特供商品的特价
	private String productType;
	private String productDescription; //商品简述
	private String originPlace;//产地id
	private String originPlaces; //产地
	private List<Dictionarys> originArea;//地域对象集
	private String detailAddress;//详细地址

	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public List<Dictionarys> getOriginArea() {
		return originArea;
	}
	public void setOriginArea(List<Dictionarys> originArea) {
		this.originArea = originArea;
	}
	public String getOriginPlaces() {
		return originPlaces;
	}
	public void setOriginPlaces(String originPlaces) {
		this.originPlaces = originPlaces;
	}
	public String getOriginPlace() {
		return originPlace;
	}
	public void setOriginPlace(String originPlace) {
		this.originPlace = originPlace;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public String getProductTitle() {
		return productTitle;
	}
	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
	}
	public BigDecimal getSpotUnitPrice() {
		return spotUnitPrice;
	}
	public void setSpotUnitPrice(BigDecimal spotUnitPrice) {
		this.spotUnitPrice = spotUnitPrice;
	}
	public  String getProductCode() {
		return productCode;
	}
	public  void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getProductBrand() {
		return productBrand;
	}
	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer  getProductModel() {
		return productModel;
	}
	public void setProductModel(Integer  productModel) {
		this.productModel = productModel;
	}
	public List<ProductPic> getProductPics() {
		return productPics;
	}
	public void setProductPics(List<ProductPic> productPics) {
		this.productPics = productPics;
	}
	public List<ProductCategory> getProductCategorys() {
		return productCategorys;
	}
	public void setProductCategorys(List<ProductCategory> productCategorys) {
		this.productCategorys = productCategorys;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public ProductPic getProductPic() {
		return productPic;
	}
	public void setProductPic(ProductPic productPic) {
		this.productPic = productPic;
	}
	public List<Integer> getProductTypeIds() {
		return productTypeIds;
	}
	public void setProductTypeIds(List<Integer> productTypeIds) {
		this.productTypeIds = productTypeIds;
	}
	public List<ProductType> getProductTypes() {
		return productTypes;
	}
	public void setProductTypes(List<ProductType> productTypes) {
		this.productTypes = productTypes;
	}
	public List<Companys> getCompanys() {
		return companys;
	}
	public void setCompanys(List<Companys> companys) {
		this.companys = companys;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public BigDecimal getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getProductInfo() {
		return productInfo;
	}
	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}
	
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	public Integer getIsHotShow() {
		return isHotShow;
	}
	public void setIsHotShow(Integer isHotShow) {
		this.isHotShow = isHotShow;
	}
	public Integer getIsSubPageShow() {
		return isSubPageShow;
	}
	public void setIsSubPageShow(Integer isSubPageShow) {
		this.isSubPageShow = isSubPageShow;
	}
	public Integer getIsHomeShow() {
		return isHomeShow;
	}
	public void setIsHomeShow(Integer isHomeShow) {
		this.isHomeShow = isHomeShow;
	}
	public Integer getProductBrandId() {
		return productBrandId;
	}
	public void setProductBrandId(Integer productBrandId) {
		this.productBrandId = productBrandId;
	}

	public String getProductUnit() {
		return ProductUnit;
	}
	public void setProductUnit(String productUnit) {
		ProductUnit = productUnit;
	}
	public String getProductType() {
		return productType;
	}
	public void setProductType(String productType) {
		this.productType = productType;
	}
	@Override
	public String toString() {
		return "Products [id=" + id + ", productName=" + productName
				+ ", productTitle=" + productTitle + ", productTypeIds="
				+ productTypeIds + ", productTypes=" + productTypes
				+ ", productCategorys=" + productCategorys + ", unitPrice="
				+ unitPrice + ", productInfo=" + productInfo
				+ ", productBrandId=" + productBrandId + ", productCategory="
				+ productCategory + ", companys=" + companys + ", productPic="
				+ productPic + ", productPics=" + productPics + ", filePath="
				+ filePath + ", isHotShow=" + isHotShow + ", isSubPageShow="
				+ isSubPageShow + ", isHomeShow=" + isHomeShow
				+ ", productModel=" + productModel + ", ProductUnit="
				+ ProductUnit + ", status=" + status + ", productBrand="
				+ productBrand + ", productCode=" + productCode
				+ ", spotUnitPrice=" + spotUnitPrice + ", productType="
				+ productType + ", productDescription=" + productDescription
				+ ", originPlace=" + originPlace + ", originPlaces="
				+ originPlaces + ", originArea=" + originArea
				+ ", detailAddress=" + detailAddress + "]";
	}


	
}
