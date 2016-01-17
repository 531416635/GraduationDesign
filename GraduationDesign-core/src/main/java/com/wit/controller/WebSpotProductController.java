package com.wit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.comm.Common;
import com.wit.model.Dictionarys;
import com.wit.model.News;
import com.wit.model.ProductBrand;
import com.wit.model.ProductCategory;
import com.wit.model.Products;
import com.wit.service.CompanysService;
import com.wit.service.DictionaryService;
import com.wit.service.FAQService;
import com.wit.service.InquirySheetService;
import com.wit.service.NewsService;
import com.wit.service.ProductBrandService;
import com.wit.service.ProductCategoryService;
import com.wit.service.ProductsService;


@Controller
@RequestMapping("/web")
public class WebSpotProductController {
		
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private NewsService newsService;
	@Autowired
	private ProductBrandService brandService;
	@Autowired
	private ProductsService productsService;


	private static Logger log = Logger.getLogger(WebSpotProductController.class);
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/spotProduct")
	public String spotProduct(Model model,HttpServletRequest request) {
		String pagenum=  request.getParameter("currentPage");
		try {
			// 1.品类展示
						List<ProductCategory> productCategorys = null;
						Object objpc=request.getSession().getAttribute("productCategorys");
						if(objpc!=null)
						{
							productCategorys =	(List<ProductCategory>)	objpc;	
						}
						else
						{
							productCategorys = productCategoryService
									.getWebAll();//.findProductCategory();
							request.getSession().setAttribute("productCategorys",productCategorys);
						}

						List<ProductCategory> sunProductCategorys = null;
						Object objsunpc=request.getSession().getAttribute("sunProductCategorys");
						if(objpc!=null)
						{
							sunProductCategorys =	(List<ProductCategory>)	objsunpc;	
						}
						else
						{
							 sunProductCategorys = productCategoryService
										.findProductCategory();
							 request.getSession().setAttribute("sunProductCategorys",sunProductCategorys);
						}
						model.addAttribute("productCategorys", productCategorys);
						model.addAttribute("sunProductCategorys", sunProductCategorys);

			// 2.商品展示
			/*ProductCategory productCategory = null;
			for (int flag = 0; flag < productCategorys.size(); flag++) {
				productCategory = productCategorys.get(flag);
				if (productCategory.getParentCateGory() == null) {
					List<Products> products = productsService
							.findProducts(productCategory.getId());
					productCategory.setProducts(products);
					productCategorys.set(flag, productCategory);
				}
			}*/
			// 2.商品展示
						ProductCategory productCategory = null;
						for (int flag = 0; flag < productCategorys.size(); flag++) {
							productCategory = productCategorys.get(flag);
							//System.out.println("productCategory____"+productCategory);
							//System.out.println("productCategory.getParentCateGory() :::::"+productCategory.getParentCateGory() );
							if(productCategory.getParentCateGory() == null) {
								//System.out.println("productCategory.getId()_____"+productCategory.getId());
								List<Products> products = productsService
										.findProductspot(productCategory.getId());
							//	System.out.println("products:::::"+products);
								productCategory.setProducts(products);
								productCategorys.set(flag, productCategory);
							}
						}
			// 3.logo信息的展示
			// 4.版权信息
			List<Dictionarys> pageInfo = dictionaryService.getDicsByDicType(3);
			for (Dictionarys dic : pageInfo) {
				if (dic.getDicCode().equals("banner")) {
					model.addAttribute("banner", dic);
				} else if (dic.getDicCode().equals("logo")) {
					model.addAttribute("logo", dic);
				} else if (dic.getDicCode().equals("copyright")) {
					model.addAttribute("copyright", dic);
				}
			}
			List<ProductBrand> productBrands = brandService.getIndexAll();
			System.out.println(productBrands);
			model.addAttribute("brand", productBrands);
			int top = 5;
			// 4.新闻展示
			List<News> listNews = newsService.findNewsLimit(top,
					Common.NewsType.News.getIndex());
			if (listNews != null && listNews.size() > 0) {
				model.addAttribute("listNews", listNews);
			}
			// 4.公告展示
			List<News> listNotices = newsService.findNewsLimit(top,
					Common.NewsType.Notice.getIndex());
			if (listNotices != null && listNotices.size() > 0) {
				model.addAttribute("listNotices", listNotices);
			}
			//5.用户信息
			Object user=request.getSession().getAttribute("user");
			if(user!=null)
			{
				model.addAttribute("user",user);
			}
		} catch (Exception ex) {
			log.debug(ex);
		}

		return "website/spotProduct";
	}
}
