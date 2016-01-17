package com.wit.model;

import java.util.List;

public class Dictionarys {
private Integer id; //Id
private String dicName; //名称
private String dicCode; //编号
private String dicValue; //别名
private Integer dicParent;//父名
private Integer dicType; //字典类别
private String typeName; //字典类别
private String dicParentName;//父名
private List<Dictionarys> dictionarys;

public List<Dictionarys> getDictionarys() {
	return dictionarys;
}

public void setDictionarys(List<Dictionarys> dictionarys) {
	this.dictionarys = dictionarys;
}

public String getDicParentName() {
	return dicParentName;
}

public void setDicParentName(String dicParentName) {
	this.dicParentName = dicParentName;
}

public Integer getId() {
	return id;
}

public String getTypeName() {
	return typeName;
}

public void setTypeName(String typeName) {
	this.typeName = typeName;
}

public void setId(Integer id) {
	this.id = id;
}
public String getDicName() {
	return dicName;
}
public void setDicName(String dicName) {
	this.dicName = dicName;
}
public String getDicCode() {
	return dicCode;
}
public void setDicCode(String dicCode) {
	this.dicCode = dicCode;
}
public String getDicValue() {
	return dicValue;
}
public void setDicValue(String dicValue) {
	this.dicValue = dicValue;
}

public Integer getDicParent() {
	return dicParent;
}
public void setDicParent(Integer dicParent) {
	this.dicParent = dicParent;
}
public Integer getDicType() {
	return dicType;
}
public void setDicType(Integer dicType) {
	this.dicType = dicType;
}

@Override
public String toString() {
	return "Dictionarys [id=" + id + ", dicName=" + dicName + ", dicCode="
			+ dicCode + ", dicValue=" + dicValue + ", dicParent=" + dicParent
			+ ", dicType=" + dicType + ", typeName=" + typeName
			+ ", dicParentName=" + dicParentName + ", dictionarys="
			+ dictionarys + "]";
}



}
