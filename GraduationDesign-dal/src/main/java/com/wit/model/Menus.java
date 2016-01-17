package com.wit.model;

import java.util.Date;

/**
 * 菜单
 * 
 * @author Administrator
 * 
 */
public class Menus {
	private Integer id;// 菜单Id
	private String menuName;// 菜单名称
	private String menuCode;// 菜单简码
	private String menuUrl;// 菜单路径
	private Integer parentMenu;// 父菜单
	private Integer status;// 状态
	private Date createTime;// 创建时间
	private Integer createBy;// 创建人

	private Integer menuType;// 菜单类别
	private Integer patform;// 所属平台
	private String patformName;// 所属平台
	private String createByName;// 创建人名称
	private String parentMenuName;// 父菜单名称


	public String getPatformName() {
		switch (patform) {
		case 1:
			patformName = "管理端平台";
			break;
		case 2:
			patformName = "商户平台";
			break;
		default:
			break;
		}
		return patformName;
	}

	public void setPatformName(String patformName) {
		this.patformName = patformName;
	}

	private boolean isChecked;// 是否选中

	public boolean getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}

	public String getCreateByName() {
		return createByName;
	}

	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}

	public String getParentMenuName() {
		return parentMenuName;
	}

	public void setParentMenuName(String parentMenuName) {
		this.parentMenuName = parentMenuName;
	}

	private String menuTypeName;

	// 菜单类别名称
	public String getMenuTypeName() {
		switch (menuType) {
		case 1:
			menuTypeName = "菜单类型";
			break;
		case 2:
			menuTypeName = "页面类型";
			break;
		case 3:
			menuTypeName = "按钮类型";
			break;
		default:
			break;
		}
		return menuTypeName;
	}

	public void setMenuTypeName(String menuTypeName) {
		this.menuTypeName = menuTypeName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public Integer getParentMenu() {
		return parentMenu;
	}

	public void setParentMenu(Integer parentMenu) {
		this.parentMenu = parentMenu;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public Integer getMenuType() {
		return menuType;
	}

	public void setMenuType(Integer menuType) {
		this.menuType = menuType;
	}

	public Integer getPatform() {
		return patform;
	}

	public void setPatform(Integer patform) {
		this.patform = patform;
	}

	@Override
	public String toString() {
		return "Menus [id=" + id + ", menuName=" + menuName + ", menuCode="
				+ menuCode + ", menuUrl=" + menuUrl + ", parentMenu="
				+ parentMenu + ", status=" + status + ", createTime="
				+ createTime + ", createBy=" + createBy + ", menuType="
				+ menuType + ", patform=" + patform + ", createByName="
				+ createByName + ", parentMenuName=" + parentMenuName
				+ ", isChecked=" + isChecked + "]";
	}

}
