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
import nayapuranaa.model.User;

@Controller
@RequestMapping("/category")
public class CategoryController {

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String getAddUserPage(ModelMap model) {
		return "addCategory";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView add(HttpServletRequest request, ModelMap model) {
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		Category c = new Category();
		c.setName(name);
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(c);
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:list");
	}

	@RequestMapping(value = "/update/{name}", method = RequestMethod.GET)
	public String getUpdateUserPage(@PathVariable String name,
			HttpServletRequest request, ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Category.class);
		q.setFilter("name == nameParameter");
		// q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<User> results = (List<User>) q.execute(name);
			if (results.isEmpty()) {
				model.addAttribute("category", null);
			} else {
				model.addAttribute("category", results.get(0));
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "updateCategory";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		// String email =  HtmlUtils.htmlEscape(request.getParameter("email"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("key"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Category c = pm.getObjectById(Category.class, key);
			c.setName(name);
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
			Category c = pm.getObjectById(Category.class, key);
			pm.deletePersistent(c);
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:../list");
	}

	// get all customers
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listUser(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Category.class);
		q.setOrdering("name");
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
		return "listCategory";
	}
}
