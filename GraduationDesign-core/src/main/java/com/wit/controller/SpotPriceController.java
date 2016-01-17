package com.wit.controller;
/**
 * 现货特供相关控制器
 */
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Cache;
import com.wit.comm.CacheManager;
import com.wit.comm.Common;
import com.wit.model.CompanyContracts;
import com.wit.model.Companys;
import com.wit.model.Dictionarys;
import com.wit.model.ProductBrand;
import com.wit.model.ProductCategory;
import com.wit.model.ProductPic;
import com.wit.model.ProductReview;
import com.wit.model.Products;
import com.wit.model.SecondPage;
import com.wit.model.ShoppingCart;
import com.wit.model.SystemLogs;
import com.wit.model.Users;
import com.wit.service.CompanyContractService;
import com.wit.service.CompanyProductsService;
import com.wit.service.CompanysService;
import com.wit.service.DictionaryService;
import com.wit.service.ProductBrandService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductPicService;
import com.wit.service.ProductReviewService;
import com.wit.service.ProductsService;
import com.wit.service.ShoppingCartService;
import com.wit.service.SystemLogsService;

@Controller
@RequestMapping("web")
public class SpotPriceController {
	
	@Autowired
	private ProductCategoryService productCategoryService;
	
	@Autowired
	private ProductsService productsService;
	
	@Autowired
	private ShoppingCartService shoppingCartService;
	
	@Autowired
	private CompanysService companyService;
	
	@Autowired
	private CompanyContractService companyContractService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private SystemLogsService systemLoggerService;
	@Autowired
	private ProductPicService productPicService;
	@Autowired
	private ProductReviewService productReviewService;
	@Autowired
	private CompanyProductsService companyProductsService;
	@Autowired
	private ProductBrandService productBrandService;
	
	private static Logger log = Logger.getLogger(WebController.class);
	
	//到现货特供首页
	@SuppressWarnings("unchecked")
	@RequestMapping("toSpotPriceIndex")
	public String toSpotPriceIndex(HttpServletRequest request){
		try {
			// 1.品类展示
			List<ProductCategory> productCategorys = null;
			Cache  tmpCache= CacheManager.getCacheInfo("productCategorys");
			if (tmpCache != null) {
				productCategorys = (List<ProductCategory>) (tmpCache.getValue());
			} else {
				productCategorys = productCategoryService.getWebAll();// .findProductCategory();
				tmpCache = new Cache();
				tmpCache.setKey("productCategorys");
				tmpCache.setValue(productCategorys);
				CacheManager.putCache("productCategorys", tmpCache);
			}
			
			List<ProductCategory> sunProductCategorys = null;
			Cache tmpCache2 = CacheManager.getCacheInfo("sunProductCategorys");
			if (tmpCache2 != null) {
				sunProductCategorys = (List<ProductCategory>) (tmpCache2.getValue());
			} else {
				sunProductCategorys = productCategoryService.getWebAllSun();
				tmpCache2 = new Cache();
				tmpCache2.setKey("sunProductCategorys");
				tmpCache2.setValue(sunProductCategorys);
				CacheManager.putCache("sunProductCategorys", tmpCache2);
			}
			request.setAttribute("sunProductCategorys", sunProductCategorys);
			request.setAttribute("productCategorys", productCategorys);
			
			// 2.商品展示
			ProductCategory productCategory = null;
			for (int flag = 0; flag < productCategorys.size(); flag++) {
				productCategory = productCategorys.get(flag);
				if (productCategory.getParentCateGory() == null) {
					List<Map<String,Object>> soptProducts = productsService
							.findSpotProducts(productCategory.getId());
					productCategory.setSoptProducts(soptProducts);
					productCategorys.set(flag, productCategory);
				}
			}

			return "spots/spotPriceIndex";
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
	
	/**
	 * 查询商品
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/findSpotProductCategory", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String findSpotProductCategory(HttpServletRequest request) {
		String cateGorySunId = request
				.getParameter("cateGorySunId");
		String json = "false";
		try {
			List<Map<String, Object>> products = null;
			Cache tmpCache = CacheManager.getCacheInfo("products"+cateGorySunId.toString());
			if (tmpCache != null) {
				products = (List<Map<String, Object>>) (tmpCache.getValue());
			} else {
				products = productsService.findSpotProducts(Integer.valueOf(cateGorySunId));
				tmpCache = new Cache();
				tmpCache.setKey(cateGorySunId.toString());
				tmpCache.setValue(products);
				CacheManager.putCache("products"+cateGorySunId.toString(), tmpCache);
			}
			if (products != null && products.size() > 0) {
				json = JSONArray.fromObject(products).toString();
			}
		} catch (Exception ex) {
			log.debug(ex);
			return json;
		}
		return json;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/toSpotSecondIndex")
	public String toSpotSecondIndex(SecondPage page, Integer cateGoryId,
			HttpServletRequest request) throws UnsupportedEncodingException {
		//现货二级页面商品信息展示
		List<Map<String,Object>> parm = null;
		Cache tmpCache = CacheManager.getCacheInfo("productCategorys"+cateGoryId.toString());
		if (tmpCache != null) {
			parm = (List<Map<String,Object>>) (tmpCache.getValue());
		} else {
			parm = productsService
					.findSecondSpotProducts(cateGoryId);
			tmpCache = new Cache();
			tmpCache.setKey(cateGoryId.toString());
			tmpCache.setValue(parm);
			CacheManager.putCache("productCategorys"+cateGoryId.toString(),
					tmpCache);
		}
		
		//子类显示
		List<ProductCategory> productCategoryName = productCategoryService.findByCateGoryId(cateGoryId);
		//子类品牌显示
		List<ProductBrand> productBrandName = productBrandService.findByCateGoryId(cateGoryId);
		
		//现货二级页面热门推荐
		List<Map<String,Object>> parm2 = null;
		Cache tmpCache2 = CacheManager.getCacheInfo("hotProduct"+cateGoryId.toString());
		if (tmpCache2 != null) {
			parm2 = (List<Map<String,Object>>) (tmpCache.getValue());
		} else {
			parm2 = productsService.findHotSpotProducts(cateGoryId);
			tmpCache2 = new Cache();
			tmpCache2.setKey(cateGoryId.toString());
			tmpCache2.setValue(parm2);
			CacheManager.putCache("hotProduct"+cateGoryId.toString(),
					tmpCache2);
		}
		
		//现货二级页面最近浏览
		
		
		//当前位置显示
		ProductCategory productCategory = productCategoryService.findbyId(cateGoryId);
		// 最近浏览Session中！
		request.setAttribute("productInfo", parm);
		request.setAttribute("hotProduct", parm2);
		request.setAttribute("productCategory", productCategory);
		request.setAttribute("productCategoryName", productCategoryName);
		request.setAttribute("productBrandName", productBrandName);
		return "spots/spotSecondIndex";
	}
	
	//现货二级页面查询与分页
	@RequestMapping(value="conditionSearch",produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String conditionSearch(HttpServletRequest request){
		String json = "{'result':'false'}";
		try {
			//获取子品类ID
			String subclassCateGoryId = request.getParameter("subclassCateGoryId");
			//获取查询价格
			/*priceNum对应的是价格区间*/
			String priceNum = request.getParameter("priceNum");
			//获取品牌ID
			String brandId = request.getParameter("brandId");
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return json;
	}
	
	
	
	//三级页面
	@SuppressWarnings("unchecked")
	@RequestMapping("/toSpotProductInfo")
	public String toSpotProductInfo(SecondPage page, Integer ProductId,
			HttpServletRequest request) {
		String jsonAddrs = "";

		// 品类展示
		try {
			List<ProductCategory> productCategorys = null;
			Object objpc = request.getSession()
					.getAttribute("productCategorys");
			if (objpc != null) {
				productCategorys = (List<ProductCategory>) objpc;
			} else {
				productCategorys = productCategoryService.getWebAll();// .findProductCategory();
				request.getSession().setAttribute("productCategorys",
						productCategorys);
			}

			List<ProductCategory> sunProductCategorys = null;
			Object objsunpc = request.getSession().getAttribute(
					"sunProductCategorys");
			if (objpc != null) {
				sunProductCategorys = (List<ProductCategory>) objsunpc;
			} else {
				sunProductCategorys = productCategoryService.getWebAllSun();
				request.getSession().setAttribute("sunProductCategorys",
						sunProductCategorys);
			}
			request.setAttribute("productCategorys", productCategorys);
			request.setAttribute("sunProductCategorys", sunProductCategorys);
		} catch (Exception ex) {
		}
		// 查询省份信息（用户选择地区）
		try {
			List<Dictionarys> dictionarys = dictionaryService
					.findProvinceInfo();
			request.setAttribute("dictionarys", dictionarys);
			List<Dictionarys> addrs = dictionaryService.getDicsByDicType(1);
			jsonAddrs = JSONArray.fromObject(addrs).toString();
			request.setAttribute("jsonAddrs", jsonAddrs);
		} catch (Exception ex) {
		}
		// 精品推荐
		String isSub = "1";
		String isHot = "";
		String isHome = "";
		String superclass = "";
		List<Products> subpageShows = productsService.findProductsByCategory(
				page, superclass, isHot, isHome, isSub);
		request.setAttribute("subpageShows", subpageShows);
		// 获取商品详情并存入最近浏览Session中！
		try {

			Products product = productsService.findWebById(ProductId);
			request.setAttribute("product", product);
			request.setAttribute("productJson", JSONObject.fromObject(product).toString());  //便于前台展现多个规格！
			// 判断session是否登陆
			Users user = (Users) request.getSession().getAttribute("user");
			if (user != null) {
				// 添加访问日志
				SystemLogs form = new SystemLogs();
				StringBuilder sb = new StringBuilder();
				sb.append(Common.getDateTimeNow());
				sb.append(user.getUserName());
				sb.append("浏览了商品：");
				sb.append(product.getProductName());
				sb.append("，商品ID：");
				sb.append(product.getId());
				form.setLogContent(sb.toString());
				form.setLogTime(Common.getDateTimeNow());
				form.setLogType(user.getUserType());
				form.setLogBy(user.getId());
				this.systemLoggerService.AddLog(form);
			}

			// 最近浏览Session中！
			List<Products> viewPros = new ArrayList<Products>();
			Object viewProducts = request.getSession().getAttribute(
					"recentProducts");
			if (viewProducts != null) {
				viewPros = (List<Products>) viewProducts;
				for (int i = 0; i < viewPros.size(); i++) {
					if (!viewPros.get(i).getId().equals(product.getId())) {
						if ((i + 1) == viewPros.size()) {
							if (viewPros.size() >= 10) {
								viewPros.remove(0);
							}
							viewPros.add(product);
						}
					}
				}
			} else {
				viewPros.add(product);
			}
			request.getSession().setAttribute("recentProducts", viewPros);
			request.setAttribute("productCategoryItems",
					product.getProductCategorys());
		} catch (Exception ex) {
		}
		// 获取商品图片
		try {

			List<ProductPic> productPics = productPicService
					.getProductPicByProductId(ProductId);
			request.setAttribute("productPic", productPics);
		} catch (Exception ex) {
		}

		// 获取商品有机认证

		// 获取商品评价
		try {

			List<ProductReview> productReviews = productReviewService
					.getReviewByProductID(ProductId);
			request.setAttribute("productReviews", productReviews);
		} catch (Exception ex) {
		}

		// 获取商品小样
		try {

			// 判断session是否登陆
			Users user = (Users) request.getSession().getAttribute("user");
			// List<ProductSample> productSamples=new ArrayList<>();
			// ProductSample productSample=new ProductSample();
			String json = "";
			if (user != null) {

				Map<String, Object> parm = new HashMap<>();
				parm.put("page", page);
				parm.put("supplierId", user.getId());
				parm.put("productId", ProductId);
				List<Map<String, Object>> productSamples = productsService
						.selectProductSample(parm);
				request.setAttribute("productSamples", productSamples);

				int rows = productsService.findRowsSamples(parm);
				page.setRows(rows);
				request.setAttribute("page", page);
				json = JSONObject.fromObject(page).toString();
				request.setAttribute("json", json);

				// 查询商品小样是否可申请状态
				Map<String, Integer> par = new HashMap<>();
				par.put("ProductId", ProductId);
				par.put("companyId", user.getCompanyId());

				int findProductSample = companyProductsService
						.findProductSample(par);

				request.setAttribute("findProductSample", findProductSample);
			}
		} catch (Exception e) {
		}
		return "spots/spotThirdIndex";
	}
}
