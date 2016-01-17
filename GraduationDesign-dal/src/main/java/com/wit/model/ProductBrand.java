package com.wit.model;

public class ProductBrand {
private Integer id;
private String brandName;
private String logoPath;
private Integer isHomeShow;
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public String getBrandName() {
	return brandName;
}
public void setBrandName(String brandName) {
	this.brandName = brandName;
}
public String getLogoPath() {
	return logoPath;
}
public void setLogoPath(String logoPath) {
	this.logoPath = logoPath;
}
public Integer getIsHomeShow() {
	return isHomeShow;
}
public void setIsHomeShow(Integer isHomeShow) {
	this.isHomeShow = isHomeShow;
}
@Override
public String toString() {
	return "ProductBrand [id=" + id + ", brandName=" + brandName
			+ ", logoPath=" + logoPath + ", isHomeShow=" + isHomeShow + "]";
}

}
