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
import nayapuranaa.model.InnerSubCategory;
import nayapuranaa.model.SubCategory;

@Controller
@RequestMapping("/innersub")
public class InnerSubCategoryController {
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addInnerSubCategory(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(SubCategory.class);
		List<SubCategory> results = null;
		try {
			results = (List<SubCategory>) q.execute();
			if (results.isEmpty()) {
				model.addAttribute("listCategory", null);
			} else {
				model.addAttribute("listCategory", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "addInnerSubCategory";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView add(HttpServletRequest request, ModelMap model) {
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("subcategory"));
		InnerSubCategory sc = new InnerSubCategory();
		sc.setName(name);
		sc.setSubCategoryId(key);
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
		Query q = pm.newQuery(InnerSubCategory.class);
		q.setFilter("name == nameParameter");
		//q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<InnerSubCategory> results = (List<InnerSubCategory>) q.execute(name);
			if (results.isEmpty()) {
				model.addAttribute("innersubcategory", null);
			} else {
				model.addAttribute("innersubcategory", results.get(0));
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		return "updateInnerSubCategory";

	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("key"));
		String catkey= HtmlUtils.htmlEscape(request.getParameter("subcategory"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			InnerSubCategory c = pm.getObjectById(InnerSubCategory.class, key);
			c.setName(name);
			c.setSubCategoryId(catkey);
		//	c.setDate(new Date());

		} finally {

			pm.close();
		}

		// return to list
		return new ModelAndView("redirect:list");

	}

	@RequestMapping(value = "/delete/{key}", method = RequestMethod.GET)
	public ModelAndView delete(@PathVariable String key,
			HttpServletRequest request, ModelMap model) {

		PersistenceManager pm = PMF.get().getPersistenceManager();

		try {

			InnerSubCategory c = pm.getObjectById(InnerSubCategory.class, key);
			pm.deletePersistent(c);

		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:../list");

	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listUser(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(InnerSubCategory.class);
	    q.setOrdering("name");
		List<InnerSubCategory> results = null;
		try {
			results = (List<InnerSubCategory>) q.execute();
			//System.out.println(results);
			if (results.isEmpty()) {
				//System.out.println("empty");
				model.addAttribute("listInnerSubCategory", null);
			} else {
				model.addAttribute("listInnerSubCategory", results);
			}

		} finally {
			q.closeAll();
			pm.close();
		}
		return "listInnerSubCategory";
	}
	}
