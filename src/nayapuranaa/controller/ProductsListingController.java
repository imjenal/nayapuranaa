package nayapuranaa.controller;

import java.util.List;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import nayapuranaa.PMF;
import nayapuranaa.model.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductsListingController {

	@RequestMapping("/catlist")
	public String getCatList(ModelMap model,
			@RequestParam(value = "name") String id) {
		// model.addAttribute("name", id);
		PersistenceManager p = PMF.get().getPersistenceManager();
		Query q = p.newQuery(Product.class);
		q.setFilter("category==cat");
		q.declareParameters("String cat");
		List<Product> product = (List<Product>) q.execute(id);
		model.addAttribute("prod", product);
		return "shop";
	}

	@RequestMapping("/subcatlist")
	public String getSubCatList(ModelMap model,
			@RequestParam(value = "name") String id) {
		// model.addAttribute("name", id);
		PersistenceManager p = PMF.get().getPersistenceManager();
		Query q = p.newQuery(Product.class);
		q.setFilter("subCategory==subcat");
		q.declareParameters("String subcat");
		List<Product> product = (List<Product>) q.execute(id);
		model.addAttribute("prod", product);
		return "shop";
	}

	@RequestMapping("/innersubcatlist")
	public String getInnerSubCatList(ModelMap model,
			@RequestParam(value = "name") String id) {
		// model.addAttribute("name", id);
		PersistenceManager p = PMF.get().getPersistenceManager();
		Query q = p.newQuery(Product.class);
		q.setFilter("innerSubCategory==innersubcat");
		q.declareParameters("String innersubcat");
		List<Product> product = (List<Product>) q.execute(id);
		model.addAttribute("prod", product);
		return "shop";
	}

}
