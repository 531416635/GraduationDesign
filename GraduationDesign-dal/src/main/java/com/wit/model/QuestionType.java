package com.wit.model;
/**
 * 问题类别实体类
 * @author Administrator
 *
 */
public class QuestionType {
	private Integer id;//ID
	private String typeName;//类别名称
	
	
	@Override
	public String toString() {
		return "QuestionType [id=" + id + ", typeName=" + typeName + "]";
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
	
	
}
