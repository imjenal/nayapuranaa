package nayapuranaa.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

import nayapuranaa.PMF;
import nayapuranaa.dao.ProductDao;
import nayapuranaa.dao.UserDao;
import nayapuranaa.model.Category;
import nayapuranaa.model.InnerSubCategory;
import nayapuranaa.model.Product;
import nayapuranaa.model.SpecialCategory;
import nayapuranaa.model.SubCategory;

@Controller
@RequestMapping("/product")
public class ProductController {
	BlobstoreService blobstoreService = BlobstoreServiceFactory
			.getBlobstoreService();

	@Autowired
	UserDao userDao;
	@Autowired
	ProductDao productDao;

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String getAddProductPage(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Category.class);
		List<Category> results = null;
		try {
			results = (List<Category>) q.execute();
			if (results.isEmpty()) {
				model.addAttribute("listCategory", null);
			} else {
				model.addAttribute("listCategory", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		pm = PMF.get().getPersistenceManager();
		q = pm.newQuery(SubCategory.class);
		List<SubCategory> results1 = null;
		try {
			results1 = (List<SubCategory>) q.execute();
			if (results1.isEmpty()) {
				model.addAttribute("listSubCategory", null);
			} else {
				model.addAttribute("listSubCategory", results1);
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		pm = PMF.get().getPersistenceManager();
		q = pm.newQuery(SpecialCategory.class);
		List<SpecialCategory> results2 = null;
		try {
			results2 = (List<SpecialCategory>) q.execute();
			if (results2.isEmpty()) {
				model.addAttribute("specCategoryList", null);
			} else {
				model.addAttribute("specCategoryList", results2);
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		pm = PMF.get().getPersistenceManager();
		q = pm.newQuery(InnerSubCategory.class);
		List<InnerSubCategory> results3 = null;
		try {
			results3 = (List<InnerSubCategory>) q.execute();
			if (results3.isEmpty()) {
				model.addAttribute("listInnerSubCategory", null);
			} else {
				model.addAttribute("listInnerSubCategory", results3);
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		return "addProduct";
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public ModelAndView upload(HttpServletRequest req, ModelMap model,
			HttpServletResponse res) {
		Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
		BlobKey blobKey = blobs.get("productImage");
		String userid = HtmlUtils.htmlEscape(req.getParameter("userid"));
		String name = HtmlUtils.htmlEscape(req.getParameter("productName"));
		String description = HtmlUtils.htmlEscape(req
				.getParameter("description"));
		String category = HtmlUtils.htmlEscape(req.getParameter("category"));
		String subcategory = HtmlUtils.htmlEscape(req
				.getParameter("subcategory"));
		String innersubcategory = HtmlUtils.htmlEscape(req
				.getParameter("innersubcategory"));
		String speccategory = HtmlUtils.htmlEscape(req
				.getParameter("speccategory"));
		String productDetails = HtmlUtils.htmlEscape(req
				.getParameter("productDetails"));
		String otherDetails = HtmlUtils.htmlEscape(req
				.getParameter("otherDetails"));
		String cancelledprice = HtmlUtils.htmlEscape(req
				.getParameter("cancelledprice"));
		String price = HtmlUtils.htmlEscape(req.getParameter("price"));
		String quantity = HtmlUtils.htmlEscape(req.getParameter("quantity"));
		String edition = HtmlUtils.htmlEscape(req.getParameter("edition"));
		String author = HtmlUtils.htmlEscape(req.getParameter("author"));
		String publications = HtmlUtils.htmlEscape(req
				.getParameter("publications"));
		String condition = HtmlUtils.htmlEscape(req.getParameter("condition"));
		String contactperson = HtmlUtils.htmlEscape(req
				.getParameter("contactperson"));
		String phoneno = HtmlUtils.htmlEscape(req.getParameter("phoneno"));
		String email = HtmlUtils.htmlEscape(req.getParameter("email"));
		String fbprofile = HtmlUtils.htmlEscape(req.getParameter("fbprofile"));
		String collegeName = HtmlUtils.htmlEscape(req
				.getParameter("collegeName"));
		Product c = new Product();
		c.setUserId(userid);
		c.setLocation(userDao.getUserByEmail(userid).getCity());
		c.setProductName(name);
		c.setDescription(description);
		c.setCategory(category);
		c.setSubCategory(subcategory);
		c.setInnerSubCategory(innersubcategory);
		c.setSpecialCategory(speccategory);
		if (productDetails != null) {
			c.setProductDetails(productDetails);
		} else {
			c.setProductDetails("");
		}
		if (otherDetails != null) {
			c.setOtherDetails(otherDetails);
		} else {
			c.setOtherDetails("");
		}
		c.setCancelledPrice(Integer.parseInt(cancelledprice));
		c.setPrice(Integer.parseInt(price));
		c.setQuantity(Integer.parseInt(quantity));
		c.setEdition(edition);
		c.setAuthor(author);
		c.setPublications(publications);
		c.setCondition(condition);
		c.setContactperson(contactperson);
		c.setPhoneno(phoneno);
		c.setEmail(email);
		c.setFbprofile(fbprofile);
		c.setCollegeName(collegeName);
		String[] type = req.getParameterValues("type");
		String types = "";
		for (int i = 0; i < type.length; i++) {
			types = types + HtmlUtils.htmlEscape(type[i]) + " ,";
		}
		c.setType(types);
		c.setProductImage(blobKey.getKeyString());
		c.setDate(new Date());
		c.setModificatioDate(new Date());
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(c);
		} finally {
			pm.close();
		}
		if (blobKey == null) {
			model.addAttribute("posted", "Error Occured! Post Again!");
			return new ModelAndView("redirect:../postyourbook");
		} else {
			model.addAttribute("posted", "You have posted successfully!!");
			return new ModelAndView("redirect:../postyourbook");
		}
	}

	@RequestMapping(value = "/serve", method = RequestMethod.GET)
	public void serve(HttpServletRequest req, HttpServletResponse res) {
		BlobKey blobKey = new BlobKey(HtmlUtils.htmlEscape(req
				.getParameter("blob-key")));
		try {
			blobstoreService.serve(blobKey, res);
		} catch (IOException e) {
		}
	}

	/*
	 * @RequestMapping(value = "/add", method = RequestMethod.POST) public
	 * ModelAndView add(HttpServletRequest request, ModelMap model) {
	 * System.out.println("blob testing"); String name =
	 * HtmlUtils.htmlEscape(request.getParameter("productName")); Product c =
	 * new Product(); c.setProductName(name); c.setDate(new Date());
	 * c.setDescription(
	 * HtmlUtils.htmlEscape(request.getParameter("description")));
	 * c.setModificatioDate(new Date()); c.setPrice(
	 * HtmlUtils.htmlEscape(request.getParameter("price")));
	 * c.setQuantity(Integer.parseInt(
	 * HtmlUtils.htmlEscape(request.getParameter("quantity"))));
	 * PersistenceManager pm = PMF.get().getPersistenceManager(); try {
	 * pm.makePersistent(c); } finally { pm.close(); } return new
	 * ModelAndView("redirect:listProduct");
	 * 
	 * }
	 */

	@RequestMapping(value = "/update/{name}", method = RequestMethod.GET)
	public String getUpdateProductPage(@PathVariable String name,
			HttpServletRequest request, ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		q.setFilter("productName == nameParameter");
		q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<Product> results = (List<Product>) q.execute(name);
			if (results.isEmpty()) {
				model.addAttribute("Product", null);
			} else {
				model.addAttribute("Product", results.get(0));
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		pm = PMF.get().getPersistenceManager();
		q = pm.newQuery(Category.class);
		List<Category> results = null;
		try {
			results = (List<Category>) q.execute();
			if (results.isEmpty()) {
				model.addAttribute("listCategory", null);
			} else {
				model.addAttribute("listCategory", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		pm = PMF.get().getPersistenceManager();
		q = pm.newQuery(SubCategory.class);
		List<SubCategory> results1 = null;
		try {
			results1 = (List<SubCategory>) q.execute();
			if (results1.isEmpty()) {
				model.addAttribute("listSubCategory", null);
			} else {
				model.addAttribute("listSubCategory", results1);
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		pm = PMF.get().getPersistenceManager();
		q = pm.newQuery(SpecialCategory.class);
		List<SpecialCategory> results2 = null;
		try {
			results2 = (List<SpecialCategory>) q.execute();
			if (results2.isEmpty()) {
				model.addAttribute("specCategoryList", null);
			} else {
				model.addAttribute("specCategoryList", results2);
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		pm = PMF.get().getPersistenceManager();
		q = pm.newQuery(InnerSubCategory.class);
		List<InnerSubCategory> results3 = null;
		try {
			results3 = (List<InnerSubCategory>) q.execute();
			if (results3.isEmpty()) {
				model.addAttribute("listInnerSubCategory", null);
			} else {
				model.addAttribute("listInnerSubCategory", results3);
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "updateProduct";

	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(HttpServletRequest req, ModelMap model) {
		Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);
		BlobKey blobKey = blobs.get("productImage");
		String name = HtmlUtils.htmlEscape(req.getParameter("productName"));
		String key = HtmlUtils.htmlEscape(req.getParameter("key"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Product c = pm.getObjectById(Product.class, key);
			c.setDate(new Date());
			c.setCategory(HtmlUtils.htmlEscape(req.getParameter("category")));
			c.setSubCategory(HtmlUtils.htmlEscape(req
					.getParameter("subcategory")));
			c.setSpecialCategory(HtmlUtils.htmlEscape(req
					.getParameter("speccategory")));
			c.setProductName(name);
			c.setDate(new Date());
			c.setDescription(HtmlUtils.htmlEscape(req
					.getParameter("description")));
			c.setModificatioDate(new Date());
			c.setCancelledPrice(Integer.parseInt(HtmlUtils.htmlEscape(req
					.getParameter("cancelledprice"))));
			c.setPrice(Integer.parseInt(HtmlUtils.htmlEscape(req
					.getParameter("price"))));
			c.setQuantity(Integer.parseInt(HtmlUtils.htmlEscape(req
					.getParameter("quantity"))));
			c.setInnerSubCategory(HtmlUtils.htmlEscape(req
					.getParameter("innersubcategory")));
			if (HtmlUtils.htmlEscape(req.getParameter("productDetails")) != null) {

				c.setProductDetails(HtmlUtils.htmlEscape(req
						.getParameter("productDetails")));
			} else {
				c.setProductDetails("");
			}
			if (HtmlUtils.htmlEscape(req.getParameter("otherDetails")) != null) {

				c.setOtherDetails(HtmlUtils.htmlEscape(req
						.getParameter("otherDetails")));
			} else {
				c.setOtherDetails("");
			}
			c.setProductImage(blobKey.getKeyString());
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:listProduct");
	}

	@RequestMapping(value = "/delete/{key}", method = RequestMethod.GET)
	public String delete(@PathVariable String key, HttpServletRequest request,
			ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Product c = pm.getObjectById(Product.class, key);
			pm.deletePersistent(c);
		} finally {
			pm.close();
		}
		return "/yourposts";
	}

	// get all customers
	@RequestMapping(value = "/listProduct", method = RequestMethod.GET)
	public String listProduct(ModelMap model, HttpServletRequest request) {
		// System.out.println("this is product list.");
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
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

		model.addAttribute("listProduct",
				productDao.getProductListByLocation(location));

		return "listProduct";
	}
}
