package com.wit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wit.model.CompanyProductPic;
import com.wit.model.CompanyProductPrice;
import com.wit.model.CompanyProducts;
import com.wit.model.Companys;
import com.wit.model.GrossMargin;
import com.wit.model.Page;
import com.wit.model.ProductPic;
import com.wit.model.ProductTransfer;
import com.wit.model.Products;
import com.wit.service.CompanyProductPicService;
import com.wit.service.CompanyProductsService;
import com.wit.service.CompanyProductPriceService;
import com.wit.service.CompanysService;
import com.wit.service.GrossMarginService;
import com.wit.service.ProductPicService;
import com.wit.service.ProductTransferService;
import com.wit.service.ProductsService;

/**
 * 公司商品
 * 
 * @author chenqiulong
 * 
 */
@Controller
@RequestMapping("/companyProducts")
public class CompanyProductsController extends BaseController {
	@Autowired
	private CompanyProductsService companyProductsService;
	@Autowired
	private CompanysService companyservice;
	@Autowired
	private ProductsService productsService;
	@Autowired
	private CompanyProductPriceService companyProductPriceService;
	@Autowired
	private ProductTransferService productTransferService;
	@Autowired
	private GrossMarginService grossMarginService;
	@Autowired
	private CompanyProductPicService companyProductPicService;
/*	@Autowired
	private ProductPicService productPicService;*/
	/**
	 * 公司商品列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/companyProductsList")
	public String companyProductsList(Page page, Model model) {
		String json = "";
		try {
			List<CompanyProducts> companyProducts = companyProductsService
					.findCompanyProducts(page);
			model.addAttribute("companyProducts", companyProducts);
			int rows = companyProductsService.findRows();
			page.setRows(rows);
			model.addAttribute("page", page);
			json = JSONObject.fromObject(page).toString();
			model.addAttribute("json", json);
			return "Manager/products/companyProductsList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 删除供应商商品
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteCompanyProducts")
	public String deleteCompanyProducts(Integer id, Model model) {
		try {
			companyProductsService.deleteCompanyProduct(id);
			return "redirect:companyProductsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入添加供应商商品页面
	 * 
	 * @return
	 */
	@RequestMapping("/toAddCompanyProducts")
	public String toAddCompanyProducts(Model model) {
		try {
			return "Manager/products/companyProductsAdd";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 添加供应商商品信息
	 * 
	 * @param companyProduct
	 * @return
	 */
	@RequestMapping("/addCompanyProducts")
	public String addCompanyProducts(CompanyProducts companyProduct, Model model) {
		try {
			companyProductsService.addCompanyProduct(companyProduct);
			return "redirect:companyProductsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入供应商商品更新页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toUpdateCompanyProducts")
	public String toUpdateCompanyProducts(Integer id, Model model) {
		try {
			CompanyProducts companyProduct = companyProductsService
					.findbyId(id);
			model.addAttribute("companyProduct", companyProduct);
			return "Manager/products/companyProductUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 更新供应商商品信息
	 * 
	 * @param companyProduct
	 * @return
	 */
	@RequestMapping("/updateCompanyProducts")
	public String updateProduct(CompanyProducts companyProduct, Model model) {
		try {
			companyProductsService.updateCompanyProducts(companyProduct);
			return "redirect:companyProductsList.do";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 批量删除供应商商品信息
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/deleteMore")
	public void deleteMore(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String sid = request.getParameter("Uid");
			companyProductsService.deleteCompanyProductByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}

	/**
	 * 进入公司详情页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toCompanyInfo")
	public String toCompanyInfo(Integer id, Model model) {
		try {
			Companys company = companyservice.findById(id);
			model.addAttribute("company", company);
			return "Manager/products/companyInfo";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入商品详情页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toProductInfos")
	public String toProductInfos(Integer id, Model model) {
		try {
			Products product = productsService.findById(id);
			System.out.println(product);
			model.addAttribute("product", product);
			return "Manager/products/productInfos";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入价格详情页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toCompanyProductPriceInfo")
	public String toCompanyProductPriceInfo(Page page, Integer id, Model model) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("page", page);
			List<CompanyProductPrice> companyProductPrices = companyProductPriceService
					.findByCompanyProductIds(map);
			int rows = companyProductPriceService.findRows(id);
			page.setRows(rows);
			model.addAttribute("page", page);
			model.addAttribute("companyProductPrices", companyProductPrices);
			model.addAttribute("companyProductId", id);
			return "Manager/products/companyProductsPriceList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入价格详情页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toCompanyProductPicInfo")
	public String toCompanyProductPicInfo(Integer id,Integer productId, Model model) {
		try {

			List<CompanyProductPic> companyProductPic = companyProductPicService
					.findCompanyProductPicByCompanyId(id);
			//List<ProductPic> productPic=productPicService.getProductPicByProductId(productId);
			
			model.addAttribute("companyProductId", id);

			model.addAttribute("companyProductPic", companyProductPic);
		
			//model.addAttribute("ProductPic", productPic);
			return "Manager/products/companyProductPicList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 下载文件页面
	 * 
	 * @param filePath
	 * @param request
	 * @param response
	 * @return
	 * @return
	 */

	@RequestMapping("/downloadFile")
	public void downloadFile(String filePath, HttpServletRequest request,
			HttpServletResponse response) {

		try {
			String Name = request.getParameter("filePath").replace('/', '\\');
			int id = Integer.parseInt(request.getParameter("id"));
			String realFilePath = request.getSession().getServletContext()
					.getRealPath(File.separator);

			// String fileName = new String(a.getBytes("iso-8859-1"), "UTF-8");

			File f = new File(realFilePath, Name.substring(1));

			if (f.exists()) {
				response.setContentType("application/x-msdownload");
				response.setHeader(
						"Content-disposition",
						"attachment;filename="
								+ new String(Name.getBytes("GB2312"),
										"ISO-8859-1"));
				FileInputStream in = new FileInputStream(f);
				OutputStream o = response.getOutputStream();

				byte b[] = new byte[2048];
				int n = 0;
				while ((n = in.read(b)) != -1)
					o.write(b, 0, n);
				in.close();
				o.flush();
				o.close();

			} else {

				PrintWriter out = response.getWriter();
				out.println("<script language='javascript'>alert('本地图片不存在！');</script>");
				out.println("<script language='javascript'>window.location='/ssm/companyProducts/toCompanyProductPicInfo.do?id="+id+"';</script>");
				out.flush();
				out.close();

			}

		} catch (Exception e) {
			e.printStackTrace();

			/*
			 * model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" +
			 * e.getMessage());
			 */

		}
	}

	/**
	 * 删除供应商商品价格信息
	 * 
	 * @param companyProductId
	 * @param GrossMarginPriceId
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteCompanyProductPrice")
	public String deleteCompanyProductPrice(Integer companyProductId,
			Integer id, Integer grossMarginPriceId, Model model) {
		try {
			companyProductPriceService.delete(id);
			grossMarginService.deleteGrossMargin(grossMarginPriceId);
			return "redirect:toCompanyProductPriceInfo.do?id="
					+ companyProductId;
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
	@RequestMapping("/deleteMoreCompanyProductPrice")
	public void deleteMoreCompanyProductPrice(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String sid = request.getParameter("Uid");
			System.out.println(sid);
			String[] item1 = sid.split(",");
			StringBuilder companyProductPriceIds = new StringBuilder();
			StringBuilder grossMarginPriceIds = new StringBuilder();
			for (int i = 0; i < item1.length; i++) {
				String[] item2 = item1[i].split("@");
				companyProductPriceIds.append(item2[0]);
				companyProductPriceIds.append(",");
				grossMarginPriceIds.append(item2[1]);
				grossMarginPriceIds.append(",");
			}
			companyProductPriceService.deleteByIds(companyProductPriceIds
					.substring(0, companyProductPriceIds.length() - 1));
			grossMarginService.deleteByIds(grossMarginPriceIds.substring(0,
					companyProductPriceIds.length() - 1));
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}

	/**
	 * 进入添加价格信息页面
	 * 
	 * @param companyProductId
	 * @param model
	 * @return
	 */
	@RequestMapping("toCompanyProductPriceAdd")
	public String toCompanyProductPriceAdd(Integer companyProductId, Model model) {
		try {
			model.addAttribute("companyProductId", companyProductId);
			return "Manager/products/companyProductsPriceAdd";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 添加价格信息
	 * 
	 * @param companyProductPrice
	 * @param grossMargin
	 * @param model
	 * @return
	 */
	@RequestMapping("companyProductPriceAdd")
	public String companyProductPriceAdd(
			CompanyProductPrice companyProductPrice, GrossMargin grossMargin,
			Model model) {
		try {
			grossMarginService.addGrossMarginr(grossMargin);
			companyProductPrice.setGrossmMarginPriceId(grossMargin.getId());
			companyProductPriceService.insert(companyProductPrice);
			return "redirect:toCompanyProductPriceInfo.do?id="
					+ companyProductPrice.getCompanyProductId();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入价格更新页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("toCompanyProductPriceUpdate")
	public String toCompanyProductPriceUpdate(Integer id, Model model) {
		try {
			CompanyProductPrice companyProductPrice = companyProductPriceService
					.findById(id);
			model.addAttribute("companyProductPrice", companyProductPrice);
			return "Manager/products/companyProductsPriceUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 价格更新
	 * 
	 * @param companyProductPrice
	 * @param grossMargin
	 * @return
	 */
	@RequestMapping("companyProductPriceUpdate")
	public String companyProductPriceUpdate(
			CompanyProductPrice companyProductPrice, GrossMargin grossMargin,
			HttpServletRequest request) {
		try {
			grossMargin.setId(companyProductPrice.getGrossmMarginPriceId());
			companyProductPriceService.update(companyProductPrice);
			grossMarginService.updateGrossMargin(grossMargin);

			return "redirect:toCompanyProductPriceInfo.do?id="
					+ companyProductPrice.getCompanyProductId();

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入物流追朔页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/toProductTransfer")
	public String toProductTransfer(Page page, Integer id, Model model) {
		try {

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("companyProductId", id);
			map.put("page", page);
			List<ProductTransfer> productTransfers = productTransferService
					.findbycompanyProductIds(map);
			int rows = productTransferService.findRows(id);
			page.setRows(rows);
			model.addAttribute("page", page);
			model.addAttribute("companyProductId", id);
			model.addAttribute("productTransfers", productTransfers);
			return "Manager/products/productTransferList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 删除物流信息
	 * 
	 * @param companyProductId
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteProductTransfer")
	public String deleteProductTransfer(Integer companyProductId, Integer id,
			Model model) {
		try {
			productTransferService.deleteProductTransfer(id);
			return "redirect:toProductTransfer.do?id=" + companyProductId;
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
	@RequestMapping("/deleteProductTransfers")
	public void deleteProductTransfers(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String sid = request.getParameter("Uid");
			productTransferService.deleteProductTransferByIds(sid);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("InfoMessage",
					"信息载入失败！具体异常信息：" + e.getMessage());
		}
	}

	/**
	 * 进入物流更新页面
	 * 
	 * @param companyProductId
	 * @param model
	 * @return
	 */
	@RequestMapping("toProductTransferAdd")
	public String toProductTransferAdd(Integer companyProductId, Model model) {
		try {
			model.addAttribute("companyProductId", companyProductId);
			return "Manager/products/productTransferAdd";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 更新物流信息
	 * 
	 * @param productTransfer
	 * @param model
	 * @return
	 */
	@RequestMapping("productTransferAdd")
	public String productTransferAdd(ProductTransfer productTransfer,
			Model model) {
		try {
			productTransferService.addProductTransfer(productTransfer);
			return "redirect:toProductTransfer.do?id="
					+ productTransfer.getCompanyProductId();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 进入物流更新页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("toProductTransferUpdate")
	public String toProductTransferUpdate(Integer id, Model model) {
		try {
			ProductTransfer productTransfer = productTransferService
					.findbyId(id);
			model.addAttribute("productTransfer", productTransfer);
			return "Manager/products/productTransferUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}

	/**
	 * 更新物流信息
	 * 
	 * @param productTransfer
	 * @return
	 */
	@RequestMapping("productTransferUpdate")
	public String productTransferUpdate(ProductTransfer productTransfer,
			Model model) {
		try {
			productTransferService.updateProductTransfer(productTransfer);
			return "redirect:toProductTransfer.do?id="
					+ productTransfer.getCompanyProductId();
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("InfoMessage", "信息载入失败！具体异常信息：" + e.getMessage());
			return "error";
		}
	}
}
