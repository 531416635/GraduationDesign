package com.wit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.Orders;
import com.wit.model.Page;
import com.wit.model.Users;
import com.wit.service.OrdersService;

/**
 * 订单控制器
 * 
 * @author lj
 * 
 */
@Controller
@RequestMapping("/main")
public class OrdersController extends BaseController {
	@Resource
	private OrdersService ordersService;

	@RequestMapping("/Orders")
	public String linkOrders(Page page, Model model) {
		String json="";
		// 查询所有数据
		List<Orders> list = ordersService.getAll(page);
		model.addAttribute("dispatch", list);
		int rows = ordersService.findRows();
		page.setRows(rows);
		model.addAttribute("page", page);
		json=JSONObject.fromObject(page).toString();
		model.addAttribute("json", json);
		return "Manager/supplys/OrdersList";
	}

	// 删除一条记录
	@RequestMapping("/deleteOrders")
	public String delete(Orders orders) {
		Integer id = orders.getId();
		if (id != null) {
			ordersService.delete(id);
		}
		return "redirect:Orders.do";
	}

	// 跳转到添加界面
	@RequestMapping("/toOrdersAdd")
	public String toAdd() {
		return "Manager/supplys/OrdersListAdd";
	}

	// 添加
	@RequestMapping("/addOrdersList")
	public String add(Orders orders) {
		ordersService.add(orders);
		System.out.println("123");
		return "redirect:Orders.do";
	}

	// 跳转到修改界面
	@RequestMapping("/toOrdersListUpdate")
	public String toUpdate(Integer id, Model model) {
		Orders orders = ordersService.findById(id);
		model.addAttribute("orders", orders);
		return "Manager/supplys/OrdersListUpdate";
	}

	// 修改
	@RequestMapping("/updateOrdersList")
	public String update(Orders orders) {
		ordersService.update(orders);
		return "redirect:Orders.do";
	}

	// 批量删除
	@RequestMapping("/allDeleteOrders")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		String sid = request.getParameter("Uid");
		String[] item = sid.split("@");
		System.out.println("123");
		for (int i = 0; i < item.length; i++) {
			ordersService.delete(Integer.parseInt(item[i]));
		}
	}

	// 根据用户ID显示订单信息
	@RequestMapping("orderList")
	public String orderList(Page page, HttpServletRequest request) {
		try {
			// 获取用户登录信息
			Users user = (Users) request.getSession().getAttribute("userInfo");
			// 获取用户ID
			int userId = user.getId();
			Map<String, Object> parm = new HashMap<>();
			parm.put("page", page);
			parm.put("userId", userId);
			List<Orders> orders = ordersService.findAll(parm);
			int rows = ordersService.rows(userId);
			page.setRows(rows);
			request.setAttribute("orders", orders);
			request.setAttribute("userId", userId);
			request.setAttribute("page", page);
			return "Purchaser/orderList";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
