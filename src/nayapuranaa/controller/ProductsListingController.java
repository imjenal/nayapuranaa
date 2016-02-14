package nayapuranaa.controller;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import nayapuranaa.PMF;
import nayapuranaa.dao.ProductDao;
import nayapuranaa.model.Product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductsListingController {

	@Autowired
	ProductDao productDao;

	@RequestMapping("/catlist")
	public String getCatList(ModelMap model,
			@RequestParam(value = "name") String id, HttpServletRequest request) {
		String location = "";
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("location")) {
					location = cookies[i].getValue();
					break;
				}
			}
		}
		List<Product> product = productDao.getProductListByCategory(
				location, id);

		model.addAttribute("prod", product);
		return "shop";
	}

	@RequestMapping("/subcatlist")
	public String getSubCatList(ModelMap model,
			@RequestParam(value = "name") String id, HttpServletRequest request) {
		String location = "";
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("location")) {
					location = cookies[i].getValue();
					break;
				}
			}
		}

		List<Product> product = productDao.getProductListBySubCategory(
				location, id);
		model.addAttribute("prod", product);
		return "shop";
	}

	@RequestMapping("/innersubcatlist")
	public String getInnerSubCatList(ModelMap model,
			@RequestParam(value = "name") String id, HttpServletRequest request) {
		String location = "";
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("location")) {
					location = cookies[i].getValue();
					break;
				}
			}
		}

		List<Product> product = productDao
				.getProductListByInnerSubCategory(location, id);
		model.addAttribute("prod", product);
		return "shop";
	}

}
