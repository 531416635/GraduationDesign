package com.wit.model;

public class RoleRights {
private Integer id;//角色权限ID
private Integer roleId;//角色ID
private Integer rightId;//权限ID

public Integer getId() {
	return id;
}

public void setId(Integer id) {
	this.id = id;
}

public Integer getRoleId() {
	return roleId;
}

public void setRoleId(Integer roleId) {
	this.roleId = roleId;
}

public Integer getRightId() {
	return rightId;
}

public void setRightId(Integer rightId) {
	this.rightId = rightId;
}

@Override
public String toString() {
	return "RoleRights [id=" + id + ", roleId=" + roleId + ", rightId="
			+ rightId + "]";
}

}
