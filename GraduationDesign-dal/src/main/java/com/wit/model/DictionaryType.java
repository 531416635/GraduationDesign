package com.wit.model;

public class DictionaryType {
	private Integer id;
	private String typeName;
	private String typeCode;
	private String typeValue;
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
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getTypeValue() {
		return typeValue;
	}
	public void setTypeValue(String typeValue) {
		this.typeValue = typeValue;
	}
	@Override
	public String toString() {
		return "DictionaryType [id=" + id + ", typeName=" + typeName
				+ ", typeCode=" + typeCode + ", typeValue=" + typeValue + "]";
	}
	

}
