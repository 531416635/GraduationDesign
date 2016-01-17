package com.wit.model;

import java.sql.Timestamp;

public class News {
private Integer Id;//新闻公布Id
private String title;//标题
private String content;//内容
private Timestamp releaseTime;//发布时间
private Timestamp releaseAging;//发布时效
private String publishers;//发布人
private Integer status;//状态
private Integer newType;//新闻类型
private Integer newsIndex;//新闻序号

public Integer getNewType() {
	return newType;
}

public void setNewType(Integer newType) {
	this.newType = newType;
}

public Integer getNewsIndex() {
	return newsIndex;
}

public void setNewsIndex(Integer newsIndex) {
	this.newsIndex = newsIndex;
}

public Integer getId() {
	return Id;
}

public void setId(Integer id) {
	Id = id;
}

public String getTitle() {
	return title;
}

public void setTitle(String title) {
	this.title = title;
}

public String getContent() {
	return content;
}

public void setContent(String content) {
	this.content = content;
}

public Timestamp getReleaseTime() {
	return releaseTime;
}

public void setReleaseTime(Timestamp releaseTime) {
	this.releaseTime = releaseTime;
}

public Timestamp getReleaseAging() {
	return releaseAging;
}

public void setReleaseAging(Timestamp releaseAging) {
	this.releaseAging = releaseAging;
}

public String getPublishers() {
	return publishers;
}

public void setPublishers(String publishers) {
	this.publishers = publishers;
}

public Integer getStatus() {
	return status;
}

public void setStatus(Integer status) {
	this.status = status;
}

@Override
public String toString() {
	return "News [Id=" + Id + ", title=" + title + ", content=" + content
			+ ", releaseTime=" + releaseTime + ", releaseAging=" + releaseAging
			+ ", publishers=" + publishers + ", status=" + status + "]";
}
}
