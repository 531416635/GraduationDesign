package com.wit.model;

import java.sql.Date;
//商品评价
public class ProductReview {
	private Integer id;
	private Integer companyProductId;
	private String reviews;  //评论
	private Integer reviewBy; //评论者
	private String reviewByName; //评论者
	public String getReviewByName() {
		return reviewByName;
	}
	public void setReviewByName(String reviewByName) {
		this.reviewByName = reviewByName;
	}
	private Date reviewTime;
	private Integer starLevel; //星级
	private Integer status;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getReviews() {
		return reviews;
	}
	public void setReviews(String reviews) {
		this.reviews = reviews;
	}
	public Integer getReviewBy() {
		return reviewBy;
	}
	public void setReviewBy(Integer reviewBy) {
		this.reviewBy = reviewBy;
	}
	public Date getReviewTime() {
		return reviewTime;
	}
	public void setReviewTime(Date reviewTime) {
		this.reviewTime = reviewTime;
	}
	public Integer getStarLevel() {
		return starLevel;
	}
	public void setStarLevel(Integer starLevel) {
		this.starLevel = starLevel;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getCompanyProductId() {
		return companyProductId;
	}
	public void setCompanyProductId(Integer companyProductId) {
		this.companyProductId = companyProductId;
	}
	

}
