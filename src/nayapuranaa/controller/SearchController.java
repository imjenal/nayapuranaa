package nayapuranaa.controller;

import java.util.ArrayList;
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
import org.springframework.web.util.HtmlUtils;

@Controller
public class SearchController {
	@Autowired ProductDao productDao;
	
	@RequestMapping("/search")
	public String search(ModelMap map, HttpServletRequest request) {
		String hint =  HtmlUtils.htmlEscape(request.getParameter("hint")).toLowerCase();
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
		List<Product> results = productDao.getProductListByLocation(location);

		List<Product> result = new ArrayList<Product>();
		try {
			for (Product product : results) {
				if ((product.getProductName() != null && product
						.getProductName().toLowerCase().contains(hint))
						|| (product.getDescription() != null && product
								.getDescription().toLowerCase().contains(hint))
						|| (product.getCategory() != null && product
								.getCategory().toLowerCase().contains(hint))
						|| (product.getSubCategory() != null && product
								.getSubCategory().toLowerCase().contains(hint))
						|| (product.getInnerSubCategory() != null && product
								.getInnerSubCategory().toLowerCase()
								.contains(hint))
						|| (product.getCollegeName() != null && product
								.getCollegeName().toLowerCase().contains(hint))
						|| (product.getProductDetails() != null && product
								.getProductDetails().toLowerCase()
								.contains(hint))
						|| (product.getOtherDetails() != null && product
								.getOtherDetails().toLowerCase().contains(hint))
						|| (product.getAuthor() != null && product.getAuthor()
								.toLowerCase().contains(hint))
						|| (product.getPublications() != null && product
								.getPublications().toLowerCase().contains(hint))
						|| (product.getCondition() != null && product
								.getCondition().toLowerCase().contains(hint))
						|| (product.getContactperson() != null && product
								.getContactperson().toLowerCase()
								.contains(hint))
						|| (product.getType() != null && product.getType()
								.toLowerCase().contains(hint))) {
					result.add(product);
				}
			}
		} finally {
		}
		map.addAttribute("listProduct", result);
		return "search";
	}
}