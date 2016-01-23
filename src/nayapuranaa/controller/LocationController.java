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
import nayapuranaa.model.Location;
import nayapuranaa.model.User;

@Controller
@RequestMapping("/location")
public class LocationController {

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String getAddLocation(ModelMap model) {
		return "addLocation";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView add(HttpServletRequest request, ModelMap model) {
		String locationName =  HtmlUtils.htmlEscape(request.getParameter("locationName"));
		Location c = new Location();
		c.setLocationName(locationName);
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
		Query q = pm.newQuery(Location.class);
		q.setFilter("locationName == nameParameter");
		// q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<User> results = (List<User>) q.execute(name);
			if (results.isEmpty()) {
				model.addAttribute("location", null);
			} else {
				model.addAttribute("location", results.get(0));
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "updateLocation";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		String locationName =  HtmlUtils.htmlEscape(request.getParameter("locationName"));
		// String email =  HtmlUtils.htmlEscape(request.getParameter("email"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("key"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Location c = pm.getObjectById(Location.class, key);
			c.setLocationName(locationName);
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
			Location c = pm.getObjectById(Location.class, key);
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
		Query q = pm.newQuery(Location.class);
		q.setOrdering("locationName");
		List<Location> results = null;
		try {
			results = (List<Location>) q.execute();
			if (results.isEmpty()) {
				model.addAttribute("listLocation", null);
			} else {
				model.addAttribute("listLocation", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "listLocation";
	}
}
