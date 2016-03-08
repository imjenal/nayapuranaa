package nayapuranaa.controller;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import nayapuranaa.PMF;
import nayapuranaa.dao.CategoryDao;
import nayapuranaa.dao.ProductDao;
import nayapuranaa.model.Category;
import nayapuranaa.model.User;

@Controller
public class LoginController {


	@Autowired ProductDao productDao;
	@Autowired CategoryDao categoryDao;

	@RequestMapping("/login")
	public String userlogin(ModelMap map, HttpServletRequest request) {
		map.addAttribute("p",  HtmlUtils.htmlEscape(request.getParameter("p")));
		HttpSession hs = request.getSession(false);
		if (hs != null && hs.getAttribute("userid") != null){
			map.addAttribute("subCategoryList", categoryDao.getSubCategoryList());
			return "index";
		}
		else
			return "login";
	}

	@RequestMapping("/logout")
	public String userlogout(ModelMap map,HttpServletRequest req) {
		HttpSession hs = req.getSession(false);
		if (hs != null) {
			hs.removeAttribute("userid");
			hs.invalidate();
			map.addAttribute("subCategoryList", categoryDao.getSubCategoryList());
		}
		return "index";
	}

	@RequestMapping("/profile")
	public String userprofile(ModelMap map, HttpServletRequest request) {
		HttpSession hs = request.getSession(false);
		if (hs != null && hs.getAttribute("userid") != null){
			map.addAttribute("subCategoryList", categoryDao.getSubCategoryList());
			return "profile";
		}
		else {
			map.addAttribute("p", "profile");
			return "/login";
		}
	}

	@RequestMapping(value = "/resetpassword", method = RequestMethod.POST)
	public ModelAndView resetPassword(HttpServletRequest request, ModelMap model) {
		HttpSession hs = request.getSession(false);
		if (hs != null) {
			String userid = (String) hs.getAttribute("userid");
			String password = HtmlUtils.htmlEscape(request
					.getParameter("password"));
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Query q = pm.newQuery(User.class);
			q.setFilter("email==userid");
			q.declareParameters("String userid");
			List<User> result = (List<User>) q.execute(userid);
			try {
				User c = pm
						.getObjectById(User.class, result.get(0).getUserId());
				c.setPassword(password);
				model.addAttribute("resultresetpage",
						"Password reset successfully");
			} finally {
				pm.close();
			}
			return new ModelAndView("redirect:resetpassword");
		} else
			return new ModelAndView("redirect:resetpassword");
	}

	@RequestMapping(value = "/resetforgotpassword", method = RequestMethod.POST)
	public String resetforgotPassword(HttpServletRequest request,
			ModelMap model) {
		String email = HtmlUtils.htmlEscape(request.getParameter("email"));
		if (email != null) {
			String userid = email;
			String password = HtmlUtils.htmlEscape(request.getParameter("password"));
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Query q = pm.newQuery(User.class);
			q.setFilter("email==userid");
			q.declareParameters("String userid");
			List<User> result = (List<User>) q.execute(userid);
			try {
				User c = pm
						.getObjectById(User.class, result.get(0).getUserId());
				c.setPassword(password);
				model.addAttribute("registered",
						"Password reset successfully, Login now !!");
				model.addAttribute("subCategoryList", categoryDao.getSubCategoryList());
			} finally {
				pm.close();
			}
			return "login";
		} else{
			model.addAttribute("subCategoryList", categoryDao.getSubCategoryList());
			return "login";}
	}

	@RequestMapping(value = "/resetpassword", method = RequestMethod.GET)
	public String resetPassword1(HttpServletRequest request, ModelMap model) {
		HttpSession hs = request.getSession(false);
		if (hs != null && hs.getAttribute("userid") != null) {
			String result = (String) request.getAttribute("resultresetpage");
			if (result != null) {
				model.addAttribute("resultresetpage", result);
			}
			model.addAttribute("subCategoryList", categoryDao.getSubCategoryList());
			return "resetpassword";
		} else {
			model.addAttribute("p", "resetpassword");
			return "login";
		}
	}

	@RequestMapping("/checkexist")
	@ResponseBody
	public String userlogin(@RequestParam(value = "emailid") String email) {
		return "login";
	}

	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public String authenticate(ModelMap model, HttpServletRequest request) {
		String email = HtmlUtils.htmlEscape(request.getParameter("email"));
		String password = HtmlUtils
				.htmlEscape(request.getParameter("password"));
		String p =  HtmlUtils.htmlEscape(request.getParameter("p"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Category.class);
		List<Category> result = null;
		model.addAttribute("subCategoryList", categoryDao.getSubCategoryList());
		try {
			result = (List<Category>) q.execute();
			if (result.isEmpty()) {
				model.addAttribute("listCategory", null);
			} else {
				model.addAttribute("listCategory", result);
			}
			pm = PMF.get().getPersistenceManager();
			Query q1 = null;
			q = pm.newQuery(User.class);
			q.setFilter("email == emailParam && password == passwordParam");
			// q.setOrdering("date desc");
			q.declareParameters("String emailParam,String passwordParam");
			List<User> results = (List<User>) q.execute(email, password);
			// System.out.println(email + " " + password + results.size());
			if (results.size() >= 1) {
				HttpSession hs = request.getSession(true);
				hs.setAttribute("userid", email);
				hs.setAttribute("username", results.get(0).getUserName());
				hs.setAttribute("collegeName", results.get(0).getCollege());
				hs.setAttribute("contactNo", results.get(0).getMobile());
				model.addAttribute("productDao",productDao);
				model.addAttribute("result", "Login Successfully!");
				if (p != null && (!p.equals("null")))
					// return new ModelAndView("redirect:"+p);
					return p;
				else
					return "index";
			} else {
				model.addAttribute("result",
						"Incorrect User ID or Password! Try Again");
				model.addAttribute("p", p);
				return "login";
			}
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("in exception");
			model.addAttribute("result",
					"Incorrect Userid or Password! Try Again");
			return "login";
		} finally {
			q.closeAll();
			pm.close();
		}
	}
}
