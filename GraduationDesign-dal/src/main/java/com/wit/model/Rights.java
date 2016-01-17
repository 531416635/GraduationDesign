package com.wit.model;

public class Rights {
	private Integer id;
	private String rightName;
	private String rightCode;
	private Integer menuId;
	private String menuName;
	private Integer status;
	private Integer menuType;
	private Integer roleRightsId;
	
	
	
	public Integer getRoleRightsId() {
		return roleRightsId;
	}
	public void setRoleRightsId(Integer roleRightsId) {
		this.roleRightsId = roleRightsId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getMenuType() {
		return menuType;
	}
	public void setMenuType(Integer menuType) {
		this.menuType = menuType;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRightName() {
		return rightName;
	}
	public void setRightName(String rightName) {
		this.rightName = rightName;
	}
	public String getRightCode() {
		return rightCode;
	}
	public void setRightCode(String rightCode) {
		this.rightCode = rightCode;
	}
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	

}
