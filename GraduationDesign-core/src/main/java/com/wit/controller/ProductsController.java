package com.wit.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.wit.comm.CacheManager;
import com.wit.comm.Common;
import com.wit.model.CompanyProductPic;
import com.wit.model.CompanyProducts;
import com.wit.model.Dictionarys;
import com.wit.model.Groupon;
import com.wit.model.InquirySheet;
import com.wit.model.News;
import com.wit.model.Page;
import com.wit.model.ProductBrand;
import com.wit.model.ProductCategory;
import com.wit.model.ProductPic;
import com.wit.model.Products;
import com.wit.model.Users;
import com.wit.model.newOrNoticePage;
import com.wit.service.CompanyProductPicService;
import com.wit.service.CompanyProductsService;
import com.wit.service.DictionaryService;
import com.wit.service.GrouponService;
import com.wit.service.ProductBrandService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductPicService;
import com.wit.service.ProductTypeService;
import com.wit.service.ProductsService;

/**
 * 商品管理
 * 
 * @author chenqiulong
 * 
 */
@Controller
@RequestMapping("/products")
public class ProductsController {
	@Autowired
	private ProductsService productsService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductTypeService productTypeService;
	@Autowired
	private ProductPicService picService;
	@Autowired
	private DictionaryService dictionarysService;
	@Autowired
	private CompanyProductsService companyProductsService;
	@Autowired
	private ProductPicService productPicService;
	@Autowired
	private GrouponService grouponService;
	@Autowired
	private CompanyProductPicService companyProductPicService;

	@Autowired
	private ProductBrandService productBrandService;
	
	/**
	 * 商品列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/productsList")
	public String productsList(Page page, Model model) {
		String json = "";
		try {
			List<Products> products = productsService.findAll(page);
			model.addAttribute("products", products);
			// System.out.println("products.get(2).getProductBrand()"+products.get(5).getId()+products.get(5).getProductName()+products.get(5).getProductBrand());

			int rows = productsService.findRows();
			page.setRows(rows);
			model.addAttribute("page", page);
			json = JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
			return "Manager/products/productsList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	/**
	 * 商品列表的搜索功能
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/productsListByName")
	public String productsListByName(Page page,HttpServletRequest request ,Model model) {
		String json = "";
		String productName=request.getParameter("productName");
		model.addAttribute("productName", productName);
		Map<String, Object> parm=new HashMap<>();
		parm.put("page", page);
		parm.put("productName", productName);
		try {
			List<Products> products = productsService.findAllByName(parm);
			model.addAttribute("products", products);
			int rows = productsService.findRowsByName(parm);
			page.setRows(rows);
			model.addAttribute("page", page);
			json = JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
			return "Manager/products/productsList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 商品审核
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/productsCheckList")
	public String productsCheckList(Page page, Model model,HttpServletRequest request) {
		String json = "";
		try {
			//搜索条件
			String productName=request.getParameter("productName");
			model.addAttribute("productName", productName);
			Map<String, Object> parm=new HashMap<>();
			parm.put("page", page);
			parm.put("productName", productName);
			
			
			List<Products> checkList = productsService.checkList(parm);
			model.addAttribute("checkList", checkList);
			int rows = productsService.findcheckListRows(parm);
			page.setRows(rows);
			model.addAttribute("page", page);
			json = JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
			return "Manager/products/productsCheckList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 商品审核通过
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/approveCheck")
	public String approveCheck(Integer id, Model model) {
		try {
			productsService.changeCheck(id, 1);
			return "redirect:productsCheckList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 商品审核未通过
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/disapproveCheck")
	public String disapproveCheck(Integer id, Model model) {
		try {
			productsService.changeCheck(id, 2);
			return "redirect:productsCheckList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 商品审核删除
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/deleteCheck")
	public String deleteCheck(Integer id, Model model) {
		try {
			companyProductsService.changeCheckProduct(id, 0);
			productsService.changeCheck(id, 3);

			return "redirect:productsCheckList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 供应审核
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/supplyCheckList")
	public String supplyCheckList(Page page, Model model,HttpServletRequest request) {
		String json = "";
		try {	
			//搜索条件
			String productName=request.getParameter("productName");
			model.addAttribute("productName", productName);
			Map<String, Object> parm2 = new HashMap<>();
			parm2.put("companyId", "");
			parm2.put("fileClass", "2,3,4,5,6,7");
			parm2.put("page", page);
			parm2.put("productName", productName);
			List<CompanyProducts> companyProductList = companyProductsService.webfindProductPicbyCompanyId(parm2);
			page.setRows(companyProductsService.webfindProductPicbyCompanyIdRows(parm2));
			model.addAttribute("companyProductList", companyProductList);
			request.setAttribute("companyProductLists",JSONArray.fromObject(companyProductList).toString());
			model.addAttribute("page", page);
			json = JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
			return "Manager/products/supplyCheckList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	/**
	 * 修改资质状态
	 */

	@RequestMapping(value = "/changePPSStatus", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String changePPSStatus(CompanyProductPic cpp,HttpServletRequest request) throws IOException {
		String result = "false";
		try {
			companyProductPicService.update(cpp);	
			result = "true";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "false";
		}
		return result;
	}

	/**
	 * 供应审核通过下架
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/supplyapproveCheckDown")
	public String supplyapproveCheckDown(Integer id, Model model) {
		try {
			companyProductsService.changeCheck(id, 0);
			return "redirect:supplyCheckList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 供应审核通过上架
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/supplyapproveCheckUp")
	public String supplyapproveCheckUp(Integer id, Model model) {
		try {
			companyProductsService.changeCheck(id, 1);
			return "redirect:supplyCheckList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 供应审核删除
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/supplydeleteCheck")
	public String supplydeleteCheck(Integer id, Model model) {
		try {
			companyProductsService.changeCheck(id, 2);
			return "redirect:productsCheckList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 供应审核未通过
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/supplydisapproveCheck")
	public String supplydisapproveCheck(Integer id, Model model) {
		try {
			companyProductsService.changeCheck(id, 4);
			return "redirect:supplyCheckList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	@RequestMapping(value = "/toProductCheck", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String toProductCheck(Integer id, HttpServletRequest request) {
		String json = "false";
		try {
			Products product = productsService.findById(id);
			if ("1".equals(product.getStatus())) {
				json = "true";
			}
		} catch (Exception e) {
			Common.setLog(e);
			return "error";
		}
		return json;
	}

	/**
	 * 删除商品
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteProduct")
	public String deleteProduct(Integer id, Model model) {
		try {
			productsService.deleteById(id);
			return "redirect:productsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入添加商品页面
	 * 
	 * @return
	 */
	@RequestMapping("/toAddProduct")
	public String toAddProduct(Model model) {
		try {		
			List<ProductCategory> productCategorys = productCategoryService
					.getAllSSS();
			model.addAttribute("productCategorys", productCategorys);
			List<Dictionarys> dictionarys = dictionarysService
					.getDicsByDicType(2);
			model.addAttribute("dictionarys", dictionarys);
			// 查询省份信息（用户选择地区）
			List<Dictionarys> provinces = dictionarysService.findProvinceInfo();
			model.addAttribute("provinces", provinces);
			List<ProductBrand> productBrand = productBrandService.getAll();
			model.addAttribute("productBrand", productBrand);
			return "Manager/products/productsAdd";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	//三级界面通过规格来切换商品信息
	@RequestMapping(value = "/findProductByModel", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String findProductByModel(String productName,Integer productModel,HttpServletRequest request) {
		String json = "{result:'false'}";	
		try {
			Integer id= productsService.findProductByModel(productName, productModel);
			if(id!=null){
				json = "{result:'true',productId:'"+id+"'}";
			};
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;

	}

	/**
	 * ajax动态关联商品类别查询
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/listProductCategoryson")
	@ResponseBody
	public String listProductCategoryson(Integer productCategoryId,
			HttpServletRequest request, HttpServletResponse response) {
		String json = null;
		try {
			List<ProductCategory> productCategorys = productCategoryService
					.findProductCategoryByParentID(productCategoryId);
			json = JSONArray.fromObject(productCategorys).toString();
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return null;
	}

	/**
	 * ajax动态关联商属性查询
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/listProductTypes")
	@ResponseBody
	public String listProductTypes(Integer productCategoryId,
			HttpServletRequest request, HttpServletResponse response) {
		String json = null;
		try {
			// 子类，品牌，规格
			List<ProductCategory> productCategorys = productCategoryService
					.getProductCategorys(productCategoryId);

			json = JSONArray.fromObject(productCategorys).toString();
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return null;
	}

	/**
	 * 添加商品
	 * 
	 * @param product
	 * @return
	 */
	@RequestMapping("/addProduct")
	public String addProduct(Products product, HttpServletRequest request) {
		try {
			String isDefault = request.getParameter("isDefault");
			String[] isDefs = isDefault.split(",");
			// 保存商品相对应信息
			productsService.insert(product);

			Integer productId = product.getId();
			// 保存商品相对应图片信息
			// 创建一个通用的多部分解析器
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
					request.getSession().getServletContext());
			// 判断 request 是否有文件上传,即多部分请求
			if (multipartResolver.isMultipart(request)) {
				// 转换成多部分request
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				// 取得request中的所有文件名
				int flag = 1;
				Iterator<String> iter = multiRequest.getFileNames();
				Integer isDef = 1;
				while (iter.hasNext()) {
					// 取得上传文件
					MultipartFile file = multiRequest.getFile(iter.next());
					if (file != null) {
						// 取得当前上传文件的文件名称
						String myFileName = file.getOriginalFilename();
						// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
						if (myFileName.trim() != "") {
							isDef = Integer.valueOf(isDefs[flag++]);
							// 定义上传路径
							String path = request.getSession()
									.getServletContext()
									.getRealPath(File.separator);
							File webrootPath = new File(path + "/img/"
									+ productId);
							if (!webrootPath.isDirectory()) {
								webrootPath.mkdirs();
							}
							ProductPic productpic = new ProductPic();
							productpic.setProductId(productId);
							productpic.setIsDefault(isDef);
							picService.insertPic(productpic);
							// 重命名上传后的文件名
							path = webrootPath + File.separator
									+ productpic.getId() + ".jpg";
							/* String path = "E:/" + fileName; */
							productpic = picService
									.findbyId(productpic.getId());
							productpic.setFilePath("/img/" + productId + "/"
									+ productpic.getId() + ".jpg");
							picService.update(productpic);
							File localFile = new File(path);
							file.transferTo(localFile);
						}
					}
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		return "redirect:productsList.do";
	}

	/**
	 * 进入更新页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toUpdateProduct")
	public String toUpdateProduct(Integer id, Model model) {
		try {
			/*
			 * List<ProductCategory> productCategorys = productCategoryService
			 * .findProductCategory(); model.addAttribute("productCategorys",
			 * productCategorys);
			 */
			/*
			 * List<ProductType> productTypes = productTypeService.getAll();
			 * model.addAttribute("productTypes", productTypes);
			 */
			Products product = productsService.findById(id);
			List<Dictionarys> originArea = dictionarysService.getDicsByDicType(1);
			model.addAttribute("originArea",originArea);
			// 查询省份信息（用户选择地区）
			List<Dictionarys> provinces = dictionarysService.findProvinceInfo();
			model.addAttribute("provinces", provinces);
			model.addAttribute("product", product);
			model.addAttribute("productJson", JSONObject.fromObject(product).toString()); //便于js展现规格
			model.addAttribute("productCategoryItems",
					product.getProductCategorys());

			List<ProductPic> productPics = productPicService.getProductPicByProductId(id);
			model.addAttribute("productPic", productPics);
			//列出所有品牌
			List<ProductBrand> productBrand = productBrandService.getAll();
			model.addAttribute("productBrand", productBrand);
			
			Groupon groupon = grouponService.findByProductId(product.getId());
			if (groupon == null) {
				model.addAttribute("grouponStatus", 1);
			} else {
				model.addAttribute("grouponStatus", groupon.getStatus());
			}
			
			List<ProductCategory> productCategory = productCategoryService
					.findProductCategory();
			model.addAttribute("productCategory", productCategory);
			model.addAttribute("productCategoryJson", JSONArray.fromObject(productCategory).toString()); //便于js展现规格
			List<ProductCategory> productCategorys = productCategoryService
					.getAllSSS();
			model.addAttribute("productCategorys", productCategorys);
			List<Dictionarys> dictionarys = dictionarysService
					.getDicsByDicType(2);
			model.addAttribute("dictionarys", dictionarys);
			CacheManager.clearAll();
			
			return "Manager/products/productsUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 更新商品
	 * 
	 * @param product
	 * @return
	 */
	@RequestMapping("/updateProduct")
	public String updateProduct(Products product, HttpServletRequest request) {
		try {
			String isDefault1 = request.getParameter("isDefault");
			String isDefault2 = request.getParameter("isDefault2");
			String Status1 = request.getParameter("GrouponStatus");
			Integer Status = 1;// 状态1代表不加入团购
			if (Status1 != null) {
				Status = Integer.parseInt(Status1);
			}

			String[] isDefs = isDefault1.split(",");
			String[] isDefs1 = isDefault2.split(",");
			for (int i = 1; i < isDefs1.length; i++) {
				String a[] = isDefs1[i].split(":");

				System.out.println(a[0] + "---" + a[1]);
				int id = Integer.parseInt(a[0]);
				int isDefault = Integer.parseInt(a[1]);
				Map<String, Integer> parm = new HashMap<>();
				parm.put("id", id);
				parm.put("isDefault", isDefault);
				productPicService.updateIsDefault(parm);

			}

			// System.out.println(">>>>" + isDefs);

			// 更新商品相对应信息
			productsService.update(product);
			Groupon groupon1 = new Groupon();
			groupon1.setProductId(product.getId());
			groupon1.setStatus(Status);

			Groupon groupon = grouponService.findByProductId(product.getId());

			if (groupon != null) {
				// 更新相关信息到商品团购表中
				groupon1.setId(groupon.getId());
				groupon1.setSoldOut(0);//初始出售数量为0
				grouponService.checkStatus(groupon1);
			} else {
				// 插入相关信息到商品团购表中
				if (groupon1.getStatus() == 2) {
					groupon1.setSoldOut(0);//初始出售数量为0
					grouponService.insert(groupon1);
				}
			}

			// productsService.

			Integer productId = product.getId();
			// 保存商品相对应图片信息
			// 创建一个通用的多部分解析器
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
					request.getSession().getServletContext());
			// 判断 request 是否有文件上传,即多部分请求
			if (multipartResolver.isMultipart(request)) {
				// 转换成多部分request
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				// 取得request中的所有文件名
				int flag = 1;
				Iterator<String> iter = multiRequest.getFileNames();
				Integer isDef = 1;
				while (iter.hasNext()) {
					// 取得上传文件
					MultipartFile file = multiRequest.getFile(iter.next());
					if (file != null) {
						// 取得当前上传文件的文件名称
						String myFileName = file.getOriginalFilename();
						// System.out.println(myFileName);
						if (myFileName.trim() != "") {
							isDef = Integer.valueOf(isDefs[flag++]);
							// 定义上传路径
							String path = request.getSession()
									.getServletContext()
									.getRealPath(File.separator);
							File webrootPath = new File(path + "/img/"
									+ productId);
							if (!webrootPath.isDirectory()) {
								webrootPath.mkdirs();
							}
							ProductPic productpic = new ProductPic();
							productpic.setProductId(productId);
							productpic.setIsDefault(isDef);
							picService.insertPic(productpic);
							// 重命名上传后的文件名
							path = webrootPath + File.separator
									+ productpic.getId() + ".jpg";
							/* String path = "E:/" + fileName; */
							productpic = picService
									.findbyId(productpic.getId());
							productpic.setFilePath("/img/" + productId + "/"
									+ productpic.getId() + ".jpg");
							picService.update(productpic);
							File localFile = new File(path);
							file.transferTo(localFile);
						}
					}
				}

			}

			/*
			 * List<Integer> productTypeIds = product.getProductTypeIds();
			 * StringBuilder str = new StringBuilder(); for (Integer id :
			 * productTypeIds) { str.append(id); str.append(","); }
			 * product.setProductCategory(str.toString());
			 * productsService.update(product);
			 */
			/* return "redirect:productsList.do"; */
			return "redirect:productsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入详情商品详情页
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toProductInfo")
	public String toProductInfo(Integer id, Model model) {
		try {
			Products product = productsService.findById(id);
			model.addAttribute("product", product);
			model.addAttribute("productCategoryItems",
					product.getProductCategorys());
			List<ProductPic> productPics = productPicService
					.getProductPicByProductId(id);
			model.addAttribute("productPic", productPics);
			System.out.println(productPics.toString());
			return "Manager/products/productInfo";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 批量删除
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/allDeleteDis")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String sid = request.getParameter("Uid");
			productsService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}

	/**
	 * 删除指定的图片
	 */

	@RequestMapping(value = "/deletePic", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String deletePic(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String status = "true";
		try {

			String filedir = new String(request.getParameter("picPath")
					.getBytes("iso-8859-1"), "UTF-8");
			System.out.println(filedir);

			String path1 = request.getSession().getServletContext()
					.getRealPath(File.separator);
			String path = path1.substring(0, path1.length() - 1);
			String filedir2 = filedir.replace('/', '\\');

			String filedir1 = path + filedir2;

			File file = new File(filedir1);

			boolean flag = false;

			String Id = request.getParameter("id");
			int id = Integer.parseInt(Id);
			productPicService.deleteById(id);
			if (file.exists()) { // 如果文件存在删除 如果文件不存在 打印出文件找不到
				flag = file.delete();
				System.out.println("flag" + flag);
				if (flag) {

					status = "true";
				} else {
					status = "false";
				}

			} else {
				System.out.println("file not exists  ");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		System.out.println("status" + status);
		return status;
	}

	/**
	 * 将特定商品加入现货特供
	 * 
	 * @param id
	 * 
	 *            /
	 */
	@RequestMapping("/spotProduct")
	public String spotProduct(HttpServletRequest request,Integer id,Integer productType) {
		try {
			Map<String,Object> parm = new HashMap<>();
			parm.put("productType", productType);
			parm.put("id", id);
			productsService.spotProduct(parm);
			return "redirect:productsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
		

	}

	/**
	 * 后台团购商品列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/grouponFindAll")
	public String grouponFindAll(Page page, Model model,HttpServletRequest request) {
		String json = "";
		try {
			
			//搜索条件
			String productName=request.getParameter("productName");
			model.addAttribute("productName", productName);
			Map<String, Object> parm=new HashMap<>();
			parm.put("page", page);
			parm.put("productName", productName);
			
			List<Groupon> groupons = grouponService.findAll(parm);
			model.addAttribute("groupons", groupons);

			int rows = grouponService.findRows(parm);
			page.setRows(rows);
			model.addAttribute("page", page);
			json = JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
			return "Manager/products/grouponsList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 后台团购修改页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toGrouponUpdate")
	public String toGrouponUpdate(Integer id, Model model) {
		try {

			List<Map<String, Object>> groupon = grouponService.findById(id);
			model.addAttribute("groupon", groupon);
			List<Dictionarys> dictionarys = dictionarysService
					.getDicsByDicType(2);
			model.addAttribute("dictionarys", dictionarys);
			return "Manager/products/grouponUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 团购商品批量删除
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/allDeleteGroupon")
	public void deleteGrouponMore(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String sid = request.getParameter("Uid");
			grouponService.deleteByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}

	/**
	 * 删除团购商品
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteGroup")
	public String deleteGroup(Integer id, Model model) {
		try {
			grouponService.deleteById(id);
			return "redirect:grouponFindAll.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 更新团购商品
	 * 
	 * @param product
	 * @return
	 */
	@RequestMapping("/updateGroupon")
	public String updateProduct(Groupon groupon, HttpServletRequest request) {
		try {
			if (groupon.getStatus() == null) {
				groupon.setStatus(1);
			}

			grouponService.update(groupon);
			return "redirect:grouponFindAll.do";

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}

	}

	/**
	 * 进入团购商品详情页
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toGrouponInfo")
	public String toGrouponInfo(Integer id, Model model) {

		try {

			List<Map<String, Object>> groupon = grouponService.findById(id);
			model.addAttribute("groupon", groupon);

			return "Manager/products/grouponInfo";

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
		@RequestMapping(value = "/findProductBrand", produces = { "application/json;charset=UTF-8" })
		@ResponseBody
		public String findProductBrand(HttpServletRequest request) {
			String json = "{result:'false'}";	
			try {
				List<ProductBrand> productBrands= productBrandService.getAll();
					json = "{result:'true',productBrands:"+JSONArray.fromObject(productBrands).toString()+"}";
			} catch (Exception e) {
				Common.setLog(e);
				return json;
			}
			return json;

		}
		@RequestMapping(value = "/addProductBrand", produces = { "application/json;charset=UTF-8" })
		@ResponseBody
		public String addProductBrand(ProductCategory productCategory,HttpServletRequest request) {
			String json = "{result:'false'}";	
			try {
				productCategoryService.addProductCategory(productCategory);
					json = "{result:'true',categoryId:"+productCategory.getId()+"}";
			} catch (Exception e) {
				Common.setLog(e);
				return json;
			}
			return json;

		} 
}
