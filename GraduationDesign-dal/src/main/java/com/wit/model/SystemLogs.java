package com.wit.model;
/**
 * 系统日志
 * @author Administrator
 *
 */
public class SystemLogs {
private Integer id;//系统日志Id
private Integer logType;//日志类型
private String logTime;//日志时间
private String logContent;//日志内容
private Integer logBy;//记录人
private String logByName;//记录人
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public Integer getLogType() {
	return logType;
}
public void setLogType(Integer logType) {
	this.logType = logType;
}
public String getLogTime() {
	return logTime;
}
public void setLogTime(String string) {
	this.logTime = string;
}
public String getLogContent() {
	return logContent;
}
public void setLogContent(String logContent) {
	this.logContent = logContent;
}
public Integer getLogBy() {
	return logBy;
}
public void setLogBy(Integer logBy) {
	this.logBy = logBy;
}
@Override
public String toString() {
	return "SystemLogs [id=" + id + ", logType=" + logType + ", logTime="
			+ logTime + ", logContent=" + logContent + ", logBy=" + logBy + "]";
}
public String getLogByName() {
	return logByName;
}
public void setLogByName(String logByName) {
	this.logByName = logByName;
}


}
