package nayapuranaa.controller;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import nayapuranaa.PMF;
import nayapuranaa.model.Category;
import nayapuranaa.model.SubCategory;

@Controller
@RequestMapping("/subcategory")
public class SubCategoryController {

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String getAddUserPage(ModelMap model) {
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
		return "addSubCategory";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView add(HttpServletRequest request, ModelMap model) {
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("category"));
		SubCategory sc = new SubCategory();
		sc.setName(name);
		sc.setCategoryId(key);
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(sc);
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:list");
	}

	@RequestMapping(value = "/update/{name}", method = RequestMethod.GET)
	public String getUpdateUserPage(@PathVariable String name,
			HttpServletRequest request, ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(SubCategory.class);
		q.setFilter("name == nameParameter");
		// q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<SubCategory> results = (List<SubCategory>) q.execute(name);
			if (results.isEmpty()) {
				model.addAttribute("subcategory", null);
			} else {
				model.addAttribute("subcategory", results.get(0));
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "updateSubCategory";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("key"));
		String catkey =  HtmlUtils.htmlEscape(request.getParameter("category"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			SubCategory c = pm.getObjectById(SubCategory.class, key);
			c.setName(name);
			c.setCategoryId(catkey);
			// c.setDate(new Date());
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:list");
	}

	@RequestMapping(value = "/delete/{key}", method = RequestMethod.GET)
	public ModelAndView delete(@PathVariable String key,
			HttpServletRequest request, ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			SubCategory c = pm.getObjectById(SubCategory.class, key);
			pm.deletePersistent(c);
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:../list");
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listUser(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(SubCategory.class);
		q.setOrdering("name");
		List<SubCategory> results = null;
		try {
			results = (List<SubCategory>) q.execute();
			// System.out.println(results);
			if (results.isEmpty()) {
				// System.out.println("empty");
				model.addAttribute("listSubCategory", null);
			} else {
				model.addAttribute("listSubCategory", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "listSubCategory";
	}
}
