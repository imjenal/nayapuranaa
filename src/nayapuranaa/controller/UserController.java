package nayapuranaa.controller;

import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import nayapuranaa.PMF;
import nayapuranaa.model.User;

@Controller
@RequestMapping("/user")
public class UserController {

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String getAddUserPage(ModelMap model) {
		return "addUser";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(HttpServletRequest request, ModelMap model) {
		String name = HtmlUtils.htmlEscape(request.getParameter("name"));
		String email = HtmlUtils.htmlEscape(request.getParameter("email"));
		String referral = HtmlUtils.htmlEscape(request.getParameter("referral"));
		String password = HtmlUtils.htmlEscape(request.getParameter("password"));
		User c = new User();
		c.setUserName(name);
		c.setPassword(password);
		c.setEmail(email);
		c.setReferral(referral);
		c.setDate(new Date());
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(c);
		} finally {
			pm.close();
		}
		model.addAttribute("registered",
				"You have registered successfully! Login to your account now");
		return "login";
	}

	@RequestMapping(value = "/addfororder", method = RequestMethod.POST)
	public ModelAndView addfororder(HttpServletRequest request, ModelMap model) {
		String name = HtmlUtils.htmlEscape(request.getParameter("name"));
		String email = HtmlUtils.htmlEscape(request.getParameter("email"));
		String address = HtmlUtils.htmlEscape(request.getParameter("address"));
		String landmark = HtmlUtils.htmlEscape(request.getParameter("landmark"));
		String city = HtmlUtils.htmlEscape(request.getParameter("city"));
		String pincode = HtmlUtils.htmlEscape(request.getParameter("pincode"));
		String password = HtmlUtils.htmlEscape(request.getParameter("password"));
		String mobile = HtmlUtils.htmlEscape(request.getParameter("mobile"));
		User c = new User();
		c.setUserName(name);
		c.setEmail(email);
		c.setAddress(address);
		c.setLandmark(landmark);
		c.setCity(city);
		c.setPincode(pincode);
		c.setPassword(password);
		c.setMobile(mobile);
		c.setDate(new Date());
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(User.class);
		q.setFilter("email == nameParameter");
		q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<User> results = (List<User>) q.execute(email);
			if (results.isEmpty()) {
				pm = PMF.get().getPersistenceManager();
				try {
					pm.makePersistent(c);
				} finally {
					// pm.close();
				}
				return new ModelAndView("redirect:/orderplace");
			} else {
				return new ModelAndView("redirect:/register");
			}
		} finally {
			q.closeAll();
			pm.close();
		}
	}

	@RequestMapping(value = "/update/{name}", method = RequestMethod.GET)
	public String getUpdateUserPage(@PathVariable String name,
			HttpServletRequest request, ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(User.class);
		q.setFilter("name == nameParameter");
		q.setOrdering("date desc");
		q.declareParameters("String nameParameter");
		try {
			List<User> results = (List<User>) q.execute(name);
			if (results.isEmpty()) {
				model.addAttribute("user", null);
			} else {
				model.addAttribute("user", results.get(0));
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "updateUser";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(HttpServletRequest request, ModelMap model) {
		String name =  HtmlUtils.htmlEscape(request.getParameter("name"));
		String email =  HtmlUtils.htmlEscape(request.getParameter("email"));
		String key =  HtmlUtils.htmlEscape(request.getParameter("key"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			User c = pm.getObjectById(User.class, key);
			c.setUserName(name);
			c.setEmail(email);
			c.setDate(new Date());
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:userlist");
	}

	@RequestMapping(value = "/editProfile", method = RequestMethod.POST)
	public String editProfile(HttpServletRequest request, ModelMap model) {
		HttpSession hs = request.getSession(false);
		String userId =  HtmlUtils.htmlEscape(request.getParameter("userId"));
		String userName =  HtmlUtils.htmlEscape(request.getParameter("userName"));
		String email =  HtmlUtils.htmlEscape(request.getParameter("email"));
		String college =  HtmlUtils.htmlEscape(request.getParameter("college"));
		String phoneno =  HtmlUtils.htmlEscape(request.getParameter("phoneno"));
		String fbprofile =  HtmlUtils.htmlEscape(request.getParameter("fbprofile"));
		String city =  HtmlUtils.htmlEscape(request.getParameter("city"));
		String address =  HtmlUtils.htmlEscape(request.getParameter("address"));
		String pincode =  HtmlUtils.htmlEscape(request.getParameter("pincode"));
		hs.setAttribute("username", userName);
		hs.setAttribute("email", email);
		hs.setAttribute("college", college);
		hs.setAttribute("phoneno", phoneno);
		hs.setAttribute("fbprofile", fbprofile);
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			User c = pm.getObjectById(User.class, userId);
			c.setUserName(userName);
			c.setEmail(email);
			c.setCollege(college);
			c.setMobile(phoneno);
			c.setFbprofile(fbprofile);
			c.setCity(city);
			c.setAddress(address);
			c.setPincode(pincode);
		} finally {
			pm.close();
		}
		return "/profile";
	}

	 @RequestMapping("/referral")
		public String listReferral(@PathVariable String referral, ModelMap model) {
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Query q = pm.newQuery(User.class);
			q.setFilter("referral==nameParameter");
			q.declareParameters("String nameParameter");
			try {
				List<User> results = (List<User>) q.execute(referral);
				if (results.isEmpty()) {
					model.addAttribute("listReferral", null);
				} else {
					model.addAttribute("listReferral", results);
				}
			} finally {
				q.closeAll();
				pm.close();
			}
			return "listReferral";
		}
	
	
	@RequestMapping(value = "/delete/{key}", method = RequestMethod.GET)
	public ModelAndView delete(@PathVariable String key,
			HttpServletRequest request, ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			User c = pm.getObjectById(User.class, key);
			pm.deletePersistent(c);
		} finally {
			pm.close();
		}
		return new ModelAndView("redirect:../userlist");
	}

	// get all customers
	@RequestMapping(value = "/userlist", method = RequestMethod.GET)
	public String listUser(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(User.class);
		q.setOrdering("date desc");
		List<User> results = null;
		try {
			results = (List<User>) q.execute();
			if (results.isEmpty()) {
				model.addAttribute("userList", null);
			} else {
				model.addAttribute("userList", results);
			}
		} finally {
			q.closeAll();
			pm.close();
		}
		return "userlist";
	}

	@RequestMapping("/checkexist")
	@ResponseBody
	public String checkExist(@RequestParam(value = "email") String email) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(User.class);
		q.setFilter("email == nameParameter");
		q.declareParameters("String nameParameter");
		try {
			List<User> results = (List<User>) q.execute(email);
			if (results.isEmpty()) {
				return "0";
			} else {
				return "1";
			}
		} finally {
			q.closeAll();
			pm.close();
		}
	}
}
