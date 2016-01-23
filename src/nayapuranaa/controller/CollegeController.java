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
import nayapuranaa.model.College;
import nayapuranaa.model.User;

@Controller
@RequestMapping("/college")
public class CollegeController {

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String getAddUserPage(ModelMap model) {
		return "addCollege";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView add(HttpServletRequest request, ModelMap model) {
		String collegeName =  HtmlUtils.htmlEscape(request.getParameter("collegeName"));
		College c = new College();
		c.setCollegeName(collegeName);
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
		Query q = pm.newQuery(College.class);
		q.setFilter("collegeName == nameParameter");
		// q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<User> results = (List<User>) q.execute(name);
			if (results.isEmpty()) {
				model.addAttribute("college", null);
			} else {
				model.addAttribute("college", results.get(0));
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "updateCollege";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		String collegeName =  HtmlUtils.htmlEscape(request.getParameter("collegeName"));
		// String email =  HtmlUtils.htmlEscape(request.getParameter("email"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("key"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			College c = pm.getObjectById(College.class, key);
			c.setCollegeName(collegeName);
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
			College c = pm.getObjectById(College.class, key);
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
		Query q = pm.newQuery(College.class);
		q.setOrdering("collegeName");
		List<College> results = null;
		try {
			results = (List<College>) q.execute();
			if (results.isEmpty()) {
				model.addAttribute("listCollege", null);
			} else {
				model.addAttribute("listCollege", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "listCollege";
	}
}
