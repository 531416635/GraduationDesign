package com.wit.model;
/**
 * 商品收藏实体类
 * @author Administrator
 *
 */
public class Favorite {
	private Integer id;//ID
	private Integer userId;//用户ID
	private Integer productId;//商品ID
	private Products product;//商品
	private String favoriteName;//收藏名称
	private Integer favoriteType;//收藏类别
	private String favoriteAddress;//收藏的地址
	
	public Products getProduct() {
		return product;
	}
	public void setProduct(Products product) {
		this.product = product;
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
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public String getFavoriteName() {
		return favoriteName;
	}
	public void setFavoriteName(String favoriteName) {
		this.favoriteName = favoriteName;
	}
	public Integer getFavoriteType() {
		return favoriteType;
	}
	public void setFavoriteType(Integer favoriteType) {
		this.favoriteType = favoriteType;
	}
	public String getFavoriteAddress() {
		return favoriteAddress;
	}
	public void setFavoriteAddress(String favoriteAddress) {
		this.favoriteAddress = favoriteAddress;
	}
	@Override
	public String toString() {
		return "Favorite [id=" + id + ", userId=" + userId + ", productId="
				+ productId + ", product=" + product + ", favoriteName="
				+ favoriteName + ", favoriteType=" + favoriteType
				+ ", favoriteAddress=" + favoriteAddress + "]";
	}
	
	
	
	
}
