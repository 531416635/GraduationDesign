package com.wit.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.comm.Cache;
import com.wit.comm.CacheManager;
import com.wit.comm.Common;
import com.wit.model.Companys;
import com.wit.model.Dictionarys;
import com.wit.model.FAQ;
import com.wit.model.FiltratePage;
import com.wit.model.InquirySheet;
import com.wit.model.Menus;
import com.wit.model.News;

import com.wit.model.Page;

import com.wit.model.Orders;

import com.wit.model.ProductBrand;
import com.wit.model.ProductCategory;
import com.wit.model.ProductPic;
import com.wit.model.ProductReview;
import com.wit.model.ProductType;
import com.wit.model.Products;
import com.wit.model.QuestionType;
import com.wit.model.SecondPage;
import com.wit.model.SystemLogs;
import com.wit.model.Users;
import com.wit.model.newOrNoticePage;
import com.wit.service.CompanysService;
import com.wit.service.DictionaryService;
import com.wit.service.FAQService;
import com.wit.service.InquirySheetService;
import com.wit.service.NewsService;
import com.wit.service.ProductBrandService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductPicService;
import com.wit.service.ProductTypeService;
import com.wit.service.ProductsService;
import com.wit.service.QuestionTypeService;

@Controller
@RequestMapping("/web")
public class WebController {
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private NewsService newsService;
	@Autowired
	private ProductBrandService brandService;
	@Autowired
	private ProductTypeService typeService;
	@Autowired
	private ProductsService productsService;
	@Autowired
	private FAQService faqService;
	@Autowired
	private QuestionTypeService questionTypeService;
	@Autowired
	private InquirySheetService inquirySheetService;
	@Autowired
	private CompanysService companyService;
	@Autowired
	private ProductPicService productPicService;

	private static Logger log = Logger.getLogger(WebController.class);

	/*
	 * @RequestMapping(value = "/webAddInquirySheet", produces = {
	 * "application/json;charset=UTF-8" })
	 * 
	 * @ResponseBody public String AddInquirySheet(HttpServletRequest request) {
	 * 
	 * String json = "{'result':'false'}"; int productId =
	 * Integer.parseInt(request.getParameter("productId")); Object user =
	 * request.getSession().getAttribute("user"); if (user == null) { return
	 * "{'result':'1'}"; } else if (companyService.webfindById(((Users)
	 * user).getCompanyId()) .getStatus() != 1) { return "{'result':'2'}"; }
	 * InquirySheet inquirySheet = new InquirySheet();
	 * inquirySheet.setProductID(productId); inquirySheet.setUserId(((Users)
	 * user).getId()); try { inquirySheetService.add(inquirySheet); json =
	 * "{result:'true',inquiryId:'" + inquirySheet.getInquiryId() + "'}"; }
	 * catch (Exception e) { Common.setLog(e); return json; } return json; }
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getSunCateGory", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getSunCateGory(HttpServletRequest request) {
		String json = null;
		String CateGoryId = request.getParameter("CateGoryId");
		try {
			List<ProductCategory> productCategorys = null;
			Cache tmpCache = CacheManager.getCacheInfo("productCategorys"
					+ CateGoryId.toString());
			if (tmpCache != null) {
				productCategorys = (List<ProductCategory>) (tmpCache.getValue());
			} else {
				productCategorys = productCategoryService
						.findProductCategorysSun(CateGoryId);
				tmpCache = new Cache();
				tmpCache.setKey(CateGoryId.toString());
				tmpCache.setValue(productCategorys);
				CacheManager.putCache(
						"productCategorys" + CateGoryId.toString(), tmpCache);
			}
			if (productCategorys != null && productCategorys.size() > 0) {
				json = JSONArray.fromObject(productCategorys.toArray())
						.toString();
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/toIndex")
	public String toIndex(Model model, HttpServletRequest request) {
		String pagenum = request.getParameter("currentPage");
		try {
			// 1.品类展示
			List<ProductCategory> productCategorys = null;
			Cache tmpCache = CacheManager.getCacheInfo("productCategorys");
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
				sunProductCategorys = (List<ProductCategory>) (tmpCache2
						.getValue());
			} else {
				sunProductCategorys = productCategoryService.getWebAllSun();
				tmpCache2 = new Cache();
				tmpCache2.setKey("sunProductCategorys");
				tmpCache2.setValue(sunProductCategorys);
				CacheManager.putCache("sunProductCategorys", tmpCache2);
			}
			model.addAttribute("sunProductCategorys", sunProductCategorys);
			model.addAttribute("productCategorys", productCategorys);

			// 2.商品展示
			ProductCategory productCategory = null;
			for (int flag = 0; flag < productCategorys.size(); flag++) {
				productCategory = productCategorys.get(flag);
				if (productCategory.getParentCateGory() == null
						&& productCategory.getProducts() == null) {
					List<Products> products = productsService
							.findProducts(productCategory.getId());
					productCategory.setProducts(products);
					productCategorys.set(flag, productCategory);
				}
			}

			// 3.logo信息的展示
			// 4.版权信息
			List<Dictionarys> pageInfo = null;
			Cache tmpCache3 = CacheManager.getCacheInfo("pageInfo");
			if (tmpCache3 != null) {
				pageInfo = (List<Dictionarys>) (tmpCache3.getValue());
			} else {
				pageInfo = dictionaryService.getDicsByDicType(3);
				tmpCache3 = new Cache();
				tmpCache3.setKey("pageInfo");
				tmpCache3.setValue(pageInfo);
				CacheManager.putCache("pageInfo", tmpCache3);
			}
			if (pageInfo != null) {
				for (Dictionarys dic : pageInfo) {
					if (dic.getDicCode().equals("banner")) {
						model.addAttribute("banner", dic);
					} else if (dic.getDicCode().equals("logo")) {
						model.addAttribute("logo", dic);
					} else if (dic.getDicCode().equals("copyright")) {
						model.addAttribute("copyright", dic);
					}
				}
			}

			int top = 5;
			// 4.新闻展示
			List<News> listNews = null;
			Cache tmpCache4 = CacheManager.getCacheInfo("listNews");
			if (tmpCache4 != null) {
				listNews = (List<News>) (tmpCache4.getValue());
			} else {
				listNews = newsService.findNewsLimit(top,
						Common.NewsType.News.getIndex());
				tmpCache4 = new Cache();
				tmpCache4.setKey("listNews");
				tmpCache4.setValue(listNews);
				CacheManager.putCache("listNews", tmpCache4);
			}
			if (listNews != null && listNews.size() > 0) {
				model.addAttribute("listNews", listNews);
			}
			// 4.公告展示
			List<News> listNotices = null;
			Cache tmpCache5 = CacheManager.getCacheInfo("listNotices");
			if (tmpCache5 != null) {
				listNotices = (List<News>) (tmpCache5.getValue());
			} else {
				listNotices = newsService.findNewsLimit(top,
						Common.NewsType.Notice.getIndex());
				tmpCache5 = new Cache();
				tmpCache5.setKey("listNotices");
				tmpCache5.setValue(listNotices);
				CacheManager.putCache("listNotices", tmpCache5);
			}
			if (listNotices != null && listNotices.size() > 0) {
				model.addAttribute("listNotices", listNotices);
			}
			// 5.用户信息
			Object user = request.getSession().getAttribute("user");
			if (user != null) {
				model.addAttribute("user", user);
			}
			// 6.精品推荐
			/*
			 * List<ProductBrand> productBrands = brandService.getIndexAll();
			 * System.out.println(productBrands); model.addAttribute("brand",
			 * productBrands);
			 */
		} catch (Exception ex) {
			log.debug(ex);
		}

		return "website/index";
	}

	/**
	 * 首页楼层ajax动态关联查询商品
	 * 
	 * 
	 * 
	 * @param model
	 * @return
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/findProductCategory", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String findProductCategory(HttpServletRequest request) {

		String cateGorySunId = request.getParameter("cateGorySunId");
		String json = "false";
		try {
			List<Products> products = null;
			Cache tmpCache = CacheManager.getCacheInfo("products"
					+ cateGorySunId.toString());
			if (tmpCache != null) {
				products = (List<Products>) (tmpCache.getValue());
			} else {
				products = productsService.findProducts(Integer
						.valueOf(cateGorySunId));
				tmpCache = new Cache();
				tmpCache.setKey(cateGorySunId.toString());
				tmpCache.setValue(products);
				CacheManager.putCache("products" + cateGorySunId.toString(),
						tmpCache);
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
	@RequestMapping("/toSecondIndex")
	public String toSecondIndex(SecondPage page, Integer cateGoryId,
			HttpServletRequest request) throws UnsupportedEncodingException {
		String cateGorySunId = request.getParameter("cateGorySunId");
		// 1.品类展示
		List<ProductCategory> productCategorys2 = null;
		productCategorys2 = productCategoryService.getWebAll();// .findProductCategory();
		/*Cache tmpCache2 = CacheManager.getCacheInfo("productCategorys");
		if (tmpCache2 != null) {
			productCategorys2 = (List<ProductCategory>) (tmpCache2.getValue());
		} else {
			productCategorys2 = productCategoryService.getWebAll();// .findProductCategory();
			tmpCache2 = new Cache();
			tmpCache2.setKey("productCategorys");
			tmpCache2.setValue(productCategorys2);
			CacheManager.putCache("productCategorys", tmpCache2);
			
		}*/
		List<ProductCategory> productCategorys = null;
		productCategorys = productCategoryService
				.getProductCategorys(cateGoryId);
		
		/*Cache tmpCache = CacheManager.getCacheInfo("productCategorys"+cateGoryId.toString());
		if (tmpCache != null) {
			productCategorys = (List<ProductCategory>) (tmpCache.getValue());
		} else {
			productCategorys = productCategoryService
					.getProductCategorys(cateGoryId);
			tmpCache = new Cache();
			tmpCache.setKey(cateGoryId.toString());
			tmpCache.setValue(productCategorys);
			CacheManager.putCache("productCategorys"+cateGoryId.toString(),
					tmpCache);
		}*/
		// 二级页面品类集合
		request.setAttribute("productCategorys", productCategorys);
		request.setAttribute("productCategorys2", productCategorys2);
		request.setAttribute("cateGoryId", cateGoryId);
		request.setAttribute("cateGorySunId", cateGorySunId);
		// cateGoryId=6&cateGorySunId=42&cg3Id=260&cg4Id=157&cateGoryLevel=4
		// 获取二级页面商品
		String cateGoryLevel = request.getParameter("cateGoryLevel");
		String products = request.getParameter("products");
		String superclass = "";
		String subclass = "5";
		String json = "";
		switch (cateGoryLevel) {
		case "1":
		default:
			if (products != null && !products.isEmpty()) {
				superclass = "5";
			} else {
				superclass = cateGoryId.toString();
			}
			break;
		case "2":
			superclass = request.getParameter("cateGorySunId");
			break;
		case "3":
			superclass = request.getParameter("cateGorySunId");
			subclass = request.getParameter("cg3Id");
			break;
		case "4":
			superclass = request.getParameter("cateGorySunId");
			subclass = request.getParameter("cg4Id");
			break;
		}
		// 二级界面处理参数
		request.setAttribute("superclass", superclass);
		request.setAttribute("subclass", subclass);
		page.setPageNum(20);
		page.setSuperclass(superclass);
		if (subclass.equals("5")) {
			subclass = "";
		}
		if (superclass.equals("5")) {
			superclass = "";
		}

		// 门户商品搜索查找
		if (products != null && !products.isEmpty()) {
			FiltratePage page1 = new FiltratePage();
			page1.setProductName(products);
			int rows = productsService.webfindRows(page1);
			page1.setRows(rows);
			/* page1.setPageNum(20); */
			List<Products> searchProducts = productsService
					.webfindProducts(page1);
			json = JSONArray.fromObject(searchProducts).toString();
			json = "{" + '\"' + "products" + '\"' + ":" + json + "," + '\"'
					+ "rows" + '\"' + ":" + rows + "}";
			request.getSession().setAttribute("filtratePage", page1);
			request.setAttribute("json", json);
			// 商品筛选查找
		} else {
			request.getSession().removeAttribute("filtratePage");
			page.setSubclass(subclass);
			/*
			 * String rows = String.valueOf(
			 * productsService.findRowsByCategorys(page));
			 * request.setAttribute("rows", rows);
			 */
			int rowss = productsService.findRowsByCategorys(page);
			page.setRows(rowss);
			List<Products> searchProducts = productsService
					.findProductsByCategorys(page);
			json = JSONArray.fromObject(searchProducts).toString();
			json = "{" + '\"' + "products" + '\"' + ":" + json + "," + '\"'
					+ "rows" + '\"' + ":" + rowss + "}";
			request.setAttribute("json", json);
		}

		String isHot = "";
		String isSub = "";
		String isHome = "";
		/*
		 * List<Products> searchProducts =
		 * productsService.findProductsByCategory( page, superclass.toString(),
		 * isHot, isHome, isSub); request.setAttribute("searchProducts",
		 * searchProducts);
		 */
		// 二级推荐
		isSub = "1";
		isHot = "";
		List<Products> subpageShows = productsService.findProductsByCategory(
				page, superclass, isHot, isHome, isSub);
		request.setAttribute("subpageShows", subpageShows);
		// 二级热销
		isSub = "";
		isHot = "1";
		List<Products> hotProducts = productsService.findProductsByCategory(
				page, superclass, isHot, isHome, isSub);

		request.setAttribute("hotProducts", hotProducts);
		// System.out.println("hotProducts:::::::::"+hotProducts);
		// 设置从

		return "website/list";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getDictionarysForHeader", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getDicsByDicType(HttpServletRequest request) {
		String json = null;
		String dicType = request.getParameter("dicType");
		List<Dictionarys> dicList = null;// dictionaryService.getDicsByDicType(dicType);
		try {
			Cache tmpCache = CacheManager.getCacheInfo("dicList"
					+ dicType.toString());
			if (tmpCache != null) {
				dicList = (List<Dictionarys>) (tmpCache.getValue());
			} else {
				dicList = dictionaryService.getDicsByDicType(Integer
						.valueOf(dicType));
				tmpCache = new Cache();
				tmpCache.setKey(dicType.toString());
				tmpCache.setValue(dicList);
				CacheManager.putCache("dicList" + dicType.toString(), tmpCache);
			}

			if (dicList != null && dicList.size() > 0) {
				json = JSONArray.fromObject(dicList).toString();
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getFAQForFooter", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getFAQ(HttpServletRequest request) {
		String json = null;
		String faqType = request.getParameter("faqType");
		List<FAQ> faqList = null;// faqService.getFaqByType(faqType);
		try {
			Cache tmpCache = CacheManager.getCacheInfo("faqList"
					+ faqType.toString());
			if (tmpCache != null) {
				faqList = (List<FAQ>) (tmpCache.getValue());
			} else {
				faqList = faqService.getFaqByType(Integer.valueOf(faqType));
				tmpCache = new Cache();
				tmpCache.setKey(faqType.toString());
				tmpCache.setValue(faqList);
				CacheManager.putCache("faqList" + faqType.toString(), tmpCache);
			}
			if (faqList != null && faqList.size() > 0) {
				json = JSONArray.fromObject(faqList.toArray()).toString();
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getFAQTypeForFooter", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String getFAQType(HttpServletRequest request) {
		String json = null;
		String top = request.getParameter("faqTypeTop");
		List<QuestionType> faqTypeList = null;// questionTypeService.getFaqType(top);
		try {
			Cache tmpCache = CacheManager.getCacheInfo("faqTypeList"
					+ top.toString());
			if (tmpCache != null) {
				faqTypeList = (List<QuestionType>) (tmpCache.getValue());
			} else {
				faqTypeList = questionTypeService.getFaqType(Integer
						.valueOf(top));
				tmpCache = new Cache();
				tmpCache.setKey(top.toString());
				tmpCache.setValue(faqTypeList);
				CacheManager.putCache("faqTypeList" + top.toString(), tmpCache);
			}

			if (faqTypeList != null && faqTypeList.size() > 0) {
				json = JSONArray.fromObject(faqTypeList.toArray()).toString();
			}
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	/*
	 * 二级内嵌商品列表页面
	 */
	@RequestMapping(value = "/toProductsList", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String toProductList(SecondPage page, HttpServletRequest request) {
		String json = "false";
		List<Products> searchProducts = null;
		int rows;
		try {
			FiltratePage page1 = (FiltratePage) request.getSession()
					.getAttribute("filtratePage");
			// 门户商品搜索查找
			if (page1 != null) {
				page1.setCurrentPage(page.getCurrentPage());
				searchProducts = productsService.webfindProducts(page1);
				request.getSession().setAttribute("filtratePage", page1);
				rows = page1.getRows();
				// 商品筛选查找
			} else {
				rows = productsService.findRowsByCategorys(page);
				page.setRows(rows);
				searchProducts = productsService.findProductsByCategorys(page);
			}
			json = JSONArray.fromObject(searchProducts).toString();
			json = "{" + '\"' + "products" + '\"' + ":" + json + "," + '\"'
					+ "rows" + '\"' + ":" + rows + "}";
		} catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}

	@RequestMapping("newOrNoiceMore")
	public String tonewOrNoiceMore(Integer type, newOrNoticePage page,
			HttpServletRequest request) {
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("page", page);
		maps.put("newType", type);
		List<News> news = newsService.findNews(maps);
		request.setAttribute("news", news);
		int rows = newsService.findRows(type);
		page.setRows(rows);
		request.setAttribute("page", page);
		request.setAttribute("type", type);
		return "website/newOrNoticeMore";
	}

	@RequestMapping("newOrNoiceInfo")
	public String tonewInfo(Integer type, Integer newOrNoticeId,
			HttpServletRequest request) {
		News news = newsService.findbyId(newOrNoticeId);
		request.setAttribute("news", news);
		if (type == 1) {
			return "website/newInfo";
		} else if(type==2) {
			return "website/noticeInfo";
		}else{
			return"website/industryNewsInfo";
		}

	}
	@RequestMapping("newsLists")
	public String newsLists(HttpServletRequest request){
		try{
		Page page1=new Page();	
		Page page2=new Page();
	    Page page3=new Page();
		
		//列出所有新闻标题, 新闻的类型值为1
		Map<String,Object> parm=new HashMap<>();		
		parm.put("newType", 1);
		parm.put("page", page1);
		List<News>newsList=newsService.findNewsTitle(parm);
		request.setAttribute("newsList", newsList);
		int rows1=newsService.findTitleRows(1);
		page1.setRows(rows1);
		request.setAttribute("newsPage", JSONObject.fromObject(page1).toString());
		
		
		//列出所有公告标题,公告的类型值为2
		Map<String,Object> parm2=new HashMap<>();
		parm2.put("newType", 2);
		parm2.put("page", page2);
		List<News> noticeList=newsService.findNewsTitle(parm2);
		request.setAttribute("noticeList",noticeList);
		int rows2=newsService.findTitleRows(2);
		page2.setRows(rows2);
		request.setAttribute("noticePage", JSONObject.fromObject(page2).toString());
		
		//列出行业新闻标题，类型值为3
		Map<String,Object> parm3=new HashMap<>();
		parm3.put("newType", 3);
		parm3.put("page", page3);
		List<News> industryNewsList=newsService.findNewsTitle(parm3);
		request.setAttribute("industryNewsList",industryNewsList);
		int rows3=newsService.findTitleRows(3);
		page3.setRows(rows3);
		request.setAttribute("industryNewsPage",JSONObject.fromObject(page3).toString());
		
		return"website/newsList";	
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "main/error";
		}
	}
	//新闻列表中的新闻分页
	@RequestMapping(value = "/findNewsList", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String findNewsList(HttpServletRequest request){
		String json="false";
		try{
			Page page1=new Page();
			String currentPage=request.getParameter("currentPage1");
			page1.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));
			//列出所有新闻标题, 新闻的类型值为1
			Map<String,Object> parm=new HashMap<>();		
			parm.put("newType", 1);
			parm.put("page", page1);
			List<News>newsList=newsService.findNewsTitle(parm);
			request.setAttribute("newsList", newsList);
			int rows1=newsService.findRows(1);
			page1.setRows(rows1);
			
			json = JSONArray.fromObject(newsList).toString();
			json = "{" + '\"' + "newsList" + '\"' + ":" + json + "}";		
	
		}catch (Exception e) {
			Common.setLog(e);
			return json;
		}
		return json;
	}
	//新闻列表中的公告分页
	@RequestMapping(value = "/findNoticeList", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String findNoticeList(HttpServletRequest request){
		String json="false";
		try{
			Page page2=new Page();
			String currentPage=request.getParameter("currentPage2");
			page2.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));
			//列出所有公告标题,公告的类型值为2
			Map<String,Object> parm2=new HashMap<>();
			parm2.put("newType", 2);
			parm2.put("page", page2);
			List<News> noticeList=newsService.findNewsTitle(parm2);
			request.setAttribute("noticeList",noticeList);
			int rows2=newsService.findTitleRows(2);
			page2.setRows(rows2);
			json = JSONArray.fromObject(noticeList).toString();
			json = "{" + '\"' + "noticeList" + '\"' + ":" + json + "}";	
		}catch (Exception e) {
			Common.setLog(e);
			return json;
		}		
		return json;
	}
	
	//新闻列表中的行业新闻分页
	@RequestMapping(value = "/industryNewsList", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String industryNewsList(HttpServletRequest request){
		String json="false";
		try{
			Page page3=new Page();
			String currentPage=request.getParameter("currentPage3");
			page3.setCurrentPage(Integer.parseInt(currentPage == null ? "1"
					: currentPage));
			//列出行业新闻标题，类型值为3
			Map<String,Object> parm3=new HashMap<>();
			parm3.put("newType", 3);
			parm3.put("page", page3);
			List<News> industryNewsList=newsService.findNewsTitle(parm3);
			request.setAttribute("industryNewsList",industryNewsList);
			int rows3=newsService.findTitleRows(3);
			page3.setRows(rows3);
			json = JSONArray.fromObject(industryNewsList).toString();
			json = "{" + '\"' + "industryNewsList" + '\"' + ":" + json + "}";
		}catch (Exception e) {
			Common.setLog(e);
			return json;
		}			
		return json;
	}
	
	
	
	
	
	// /ssm/WebRoot/pages/Bought/index.jsp
	@RequestMapping("BoughtIndex")
	public String BoughtIndex(HttpServletRequest request) {

		return "Bought/index";

	}

	// /ssm/WebRoot/pages/Bought/index.jsp
	@SuppressWarnings("unchecked")
	@RequestMapping("toProductInfo1")
	public String toProductInfo(SecondPage page, Integer ProductId,
			HttpServletRequest request) {
		String jsonAddrs = "";

		// 品类展示
		try {
			List<ProductCategory> productCategorys = null;
			Cache tmpCache = CacheManager.getCacheInfo("productCategorys"
					+ ProductId.toString());
			if (tmpCache != null) {
				productCategorys = (List<ProductCategory>) (tmpCache.getValue());
			} else {
				productCategorys = productCategoryService.getWebAll();// .findProductCategory();
				tmpCache = new Cache();
				tmpCache.setKey(ProductId.toString());
				tmpCache.setValue(productCategorys);
				CacheManager.putCache(
						"productCategorys" + ProductId.toString(), tmpCache);
			}

			List<ProductCategory> sunProductCategorys = null;
			Cache tmpCache2 = CacheManager.getCacheInfo("sunProductCategorys"
					+ ProductId.toString());
			if (tmpCache2 != null) {
				sunProductCategorys = (List<ProductCategory>) (tmpCache2
						.getValue());
			} else {
				sunProductCategorys = productCategoryService.getWebAllSun();
				tmpCache2 = new Cache();
				tmpCache2.setKey(ProductId.toString());
				tmpCache2.setValue(sunProductCategorys);
				CacheManager
						.putCache("sunProductCategorys" + ProductId.toString(),
								tmpCache2);
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

			}

			// 最近浏览Session中！
			List<Products> viewPros = new ArrayList<Products>();
			Cache tmpCache3 = CacheManager.getCacheInfo("viewProducts"
					+ ProductId.toString());
			if (tmpCache3 != null) {
				viewPros = (List<Products>) (tmpCache3.getValue());
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
				/*
				 * 这里为什么总是插入两次相同数据？？？？ for(int i=viewPros.size()-1;i>=0;i--){
				 * if(!viewPros.get(i).getId().equals(product.getId())){
				 * if(i==0){ if(viewPros.size()>=10){
				 * System.out.println("******************"+'\n'+'\n'+'\n'+'\n'+'
				 * \n'+'\n'); System.out.println(viewPros.remove(i));
				 * System.out.println('\n'+'\n'+'\n'+'\n'+'\n'+
				 * "******************"); } viewPros.add(product); } } }
				 */
			} else {
				viewPros.add(product);
			}
			tmpCache3 = new Cache();
			tmpCache3.setKey(ProductId.toString());
			tmpCache3.setValue(viewPros);
			CacheManager.putCache("viewProducts" + ProductId.toString(),
					tmpCache3);
			// 获取商品品类
			/*
			 * List<ProductCategory> productCategoryItems =
			 * productCategoryService
			 * .getCateGoryByIds(product.getProductCategory());
			 */
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

		return "Bought/productsInfo";

	}

	// 首页显示配送地址的选择
	@RequestMapping(value = "/AddDictionary", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String AddDictionary(HttpServletRequest request) {
		String jsonAddrs = "";
		// 查询省份信息（用户选择地区）
		try {
			/*// 查询省份信息（用户选择地区）
			try {
				List<Dictionarys> dictionarys = dictionaryService
						.findProvinceInfo();
				request.setAttribute("dictionarys", dictionarys);
				List<Dictionarys> addrs=dictionaryService.getDicsByDicType(1);
				jsonAddrs = JSONArray.fromObject(addrs).toString();
				request.setAttribute("jsonAddrs", jsonAddrs);
			} catch (Exception ex) {
			}*/
			List<Dictionarys> addrs=dictionaryService.getDicsByDicType(1);
			jsonAddrs = JSONArray.fromObject(addrs).toString();
		//	List<Dictionarys> dictionarys = dictionaryService
			//		.findProvinceInfo();
			//request.setAttribute("dictionarys", dictionarys);
			//List<Dictionarys> addrs = dictionaryService.findProvinceInfo();
			//jsonAddrs = JSONArray.fromObject(addrs).toString();
			request.setAttribute("jsonAddrs", jsonAddrs);
		} catch (Exception e) {
			Common.setLog(e);
			return jsonAddrs;
		}
		return jsonAddrs;
	}

	// header首页选中省，将相应的省市区存入session中
	@RequestMapping(value = "/addProvince", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public String addProvince( HttpServletRequest request) {
		String jsonAddrs = "false";
		// 将用户选择的省市区信息存储到session中
		HttpSession session = request.getSession();
		try {
			String provinceName1=(String) session.getAttribute("provinceName");
			String cityName1=(String) session.getAttribute("cityName");
			String areaName1=(String) session.getAttribute("areaName");
			String provinceName =request.getParameter("provinceName");
			String provinceId =request.getParameter("provinceId");
			String cityName =request.getParameter("cityName");
			String cityId =request.getParameter("cityId");
			String areaName =request.getParameter("areaName");
			String areaId =request.getParameter("areaId");
			
			if(provinceName.equals(provinceName1)&&cityName.equals(cityName1)){
				if(!areaName.equals(areaName1)){
					session.setAttribute("areaName", areaName);
					session.setAttribute("areaId", areaId);
					jsonAddrs = "true";
				}else{
					jsonAddrs = "false";
				}
			
			}else{
				session.setAttribute("provinceName", provinceName);
				session.setAttribute("provinceId", provinceId);
				session.setAttribute("cityName", cityName);
				session.setAttribute("cityId", cityId);
				session.setAttribute("areaName", areaName);
				session.setAttribute("areaId", areaId);
				jsonAddrs = "true";
			}
			
			
			
			
		
		//	session.setAttribute("province", province);
			//session.setAttribute("city", city);
			
			 
			// List<Dictionarys> addrs = dictionaryService.findById(id);
			// jsonAddrs = JSONArray.fromObject(addrs).toString();
		} catch (Exception e) {
			Common.setLog(e);
			return jsonAddrs;
		}
		return jsonAddrs;
	}
}
