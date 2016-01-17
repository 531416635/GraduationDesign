package com.wit.model;

import java.util.Date;

/**
 * 常见问题
 * @author Administrator
 *
 */
public class FAQ {
	private Integer id;//ID
	private Integer questionType;//问题类别
	private String title;//标题
	private String answer;//答案
	private Integer showIndex;//显示序号
	private Date createTime;//创建时间
	private Integer createBy;//创建人
	private String createByName;//创建人名字
	
	
	@Override
	public String toString() {
		return "FAQ [id=" + id + ", questionType=" + questionType + ", title="
				+ title + ", answer=" + answer + ", showIndex=" + showIndex
				+ ", createTime=" + createTime + ", createBy=" + createBy
				+ ", createByName=" + createByName + "]";
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getQuestionType() {
		return questionType;
	}
	public void setQuestionType(Integer questionType) {
		this.questionType = questionType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Integer getShowIndex() {
		return showIndex;
	}
	public void setShowIndex(Integer showIndex) {
		this.showIndex = showIndex;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getCreateBy() {
		return createBy;
	}
	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}
	
	
}
