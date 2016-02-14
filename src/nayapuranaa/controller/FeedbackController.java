package nayapuranaa.controller;

import java.util.Date;
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
import nayapuranaa.model.Feedback;

@Controller
@RequestMapping("/contact-us")
public class FeedbackController {

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String getAddUserPage(ModelMap model) {
		return "contact-us";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(HttpServletRequest request, ModelMap model) {
		String email =  HtmlUtils.htmlEscape(request.getParameter("email"));
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		String subject =  HtmlUtils.htmlEscape(request.getParameter("subject"));
		String message =  HtmlUtils.htmlEscape(request.getParameter("message"));
		Feedback c = new Feedback();
		c.setEmail(email);
		c.setDate(new Date());
		c.setName(name);
		c.setSubject(subject);
		c.setMessage(message);
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(c);
		} finally {
			pm.close();
		}
		model.addAttribute("contact",
				"Thanks for submitting!");
		
		return "contact-us";
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listUser(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Feedback.class);
		q.setOrdering("date desc");
		List<Feedback> results = null;
		try {
			results = (List<Feedback>) q.execute();
			if (results.isEmpty()) {
				model.addAttribute("listFeedback", null);
			} else {
				model.addAttribute("listFeedback", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "listFeedback";
	}	
	
/*	@RequestMapping(value = "/update/{name}", method = RequestMethod.GET)
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
       } */	

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

}
