package nayapuranaa.controller;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;

import nayapuranaa.PMF;
import nayapuranaa.model.Product;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.HtmlUtils;

@Controller
public class SearchController {
	@RequestMapping("/search")
	public String search(ModelMap map, HttpServletRequest request) {
		String hint =  HtmlUtils.htmlEscape(request.getParameter("hint")).toLowerCase();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		 /*q.setFilter("productName.matches(\"subcatParam*\")");
		 q.declareParameters("String subcatParam");*/
		q.setOrdering("productName desc");
		List<Product> results = null;
		List<Product> result = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute();
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
			q.closeAll();
			// pm.close();
		}
		map.addAttribute("listProduct", result);
		return "search";
	}
}