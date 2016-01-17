package com.wit.model;

public class DictionaryPage extends Page{
	private Integer dicType;//字典类型
	private String typeName;//字典类型
	private String dicName; //名称
	public Integer getDicType() {
		return dicType;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public void setDicType(Integer dicType) {
		this.dicType = dicType;
	}
	public String getDicName() {
		return dicName;
	}
	public void setDicName(String dicName) {
		this.dicName = dicName;
	}
	@Override
	public String toString() {
		return "DictionaryPage [dicType=" + dicType + ", dicName=" + dicName
				+ "]";
	}
	
	

}
