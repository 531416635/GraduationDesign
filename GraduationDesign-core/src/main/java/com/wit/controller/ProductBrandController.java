package com.wit.controller;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.wit.model.Page;
import com.wit.model.ProductBrand;
import com.wit.model.ProductPic;
import com.wit.model.ProductType;
import com.wit.service.ProductBrandService;
import com.wit.service.ProductTypeService;

@Controller
@RequestMapping("productBrand")
public class ProductBrandController {
@Autowired
private ProductBrandService productBrandService;

@RequestMapping("productBrandList")
public String productTypeList(Page page,Model model){
	String json="";
	try {
	List<ProductBrand> productBrands = productBrandService.findAll(page);
	model.addAttribute("productBrands", productBrands);
	int rows = productBrandService.findAllRows(page);
	page.setRows(rows);
	model.addAttribute("page", page);
	json=JSONObject.fromObject(page).toString();
	model.addAttribute("json", json);
	return "Manager/products/productBrandList";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
}
/**
 * 删除品类信息
 * @param id
 * @return
 */
@RequestMapping("/deleteProductBrand")
public String deleteProductBrand(Integer id,Model model) {
	try {
		productBrandService.delete(id);
	return "redirect:productBrandList.do";
} catch (Exception e) {
	e.printStackTrace();
	model.addAttribute("InfoMessage",
			"信息载入失败！具体异常信息：" + e.getMessage());
	return "error";
}
}
/**
 * 进入添加页面
 * @param model
 * @return
 */
@RequestMapping("/toAddProductBrand")
public String toAddProductBrand(Model model) {
	try {
	return "Manager/products/productBrandAdd";
	} catch (Exception e) {
		e.printStackTrace();
		model.addAttribute("InfoMessage",
				"信息载入失败！具体异常信息：" + e.getMessage());
		return "error";
	}
}
/**
 * 新添品类信息
 * @param productCategory
 * @return
 */
@RequestMapping("/addProductBrand")
public String addProductBrand(ProductBrand productBrand,HttpServletRequest request){
	try {
		productBrandService.insert(productBrand);
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 取得上传文件
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file.getOriginalFilename();
					// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
					if (myFileName.trim() != "") {
						// 定义上传路径
						String path = request.getSession()
								.getServletContext()
								.getRealPath(File.separator);
						File webrootPath = new File(path + "/brandImg/"
								);
						if (!webrootPath.isDirectory()) {
							webrootPath.mkdirs();
						}
						// 重命名上传后的文件名
						path = webrootPath + ""+productBrand.getId()+".jpg";
						/* String path = "E:/" + fileName; */
						productBrand = productBrandService.findById(productBrand.getId());
						productBrand.setLogoPath("/brandImg/" + productBrand.getId() + ".jpg");
						productBrandService.update(productBrand);
						File localFile = new File(path);
						file.transferTo(localFile);
					}
				}
			}

		}
		return "redirect:productBrandList.do";
} catch (Exception e) {
	e.printStackTrace();
	return "error";
}
	}
/**
 *进入更新页面
 * @param id
 * @param model
 * @return
 */
@RequestMapping("/toUpdateProductBrand")
public String toUpdateProductBrand(Integer id,HttpServletRequest request ){ 
	try {
		ProductBrand productBrand=	productBrandService.findById(id);
		request.setAttribute("productBrand",productBrand);
	return "Manager/products/productBrandUpdate";
	} catch (Exception e) {
		e.printStackTrace();
		return "error";
	}
	}
/**
 * 更新信息
 * @param productType
 * @return
 */
@RequestMapping("/updateProductBrand")
public String updateProductBrand(ProductBrand productBrand,HttpServletRequest request){
	try {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 取得上传文件
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file.getOriginalFilename();
					// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
					if (myFileName.trim() != "") {
						// 定义上传路径
						String path = request.getSession()
								.getServletContext()
								.getRealPath(File.separator);
						File webrootPath = new File(path + "/brandImg/"
								+ productBrand.getId());
						if (!webrootPath.isDirectory()) {
							webrootPath.mkdirs();
						}
						// 重命名上传后的文件名
						path = webrootPath +".jpg";
						/* String path = "E:/" + fileName; */
						productBrand.setLogoPath("/brandImg/" + productBrand.getId() + ".jpg");
						productBrandService.update(productBrand);
						File localFile = new File(path);
						file.transferTo(localFile);
					}
				}
			}

		}
		return "redirect:productBrandList.do";
} catch (Exception e) {
	e.printStackTrace();
	return "error";
}
	}

}
