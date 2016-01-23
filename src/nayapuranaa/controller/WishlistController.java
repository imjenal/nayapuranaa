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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import com.google.appengine.api.datastore.KeyFactory;

import nayapuranaa.PMF;
import nayapuranaa.model.Category;
import nayapuranaa.model.User;
import nayapuranaa.model.Wishlist;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@ResponseBody
	public String add(HttpServletRequest request, ModelMap model) {
		HttpSession hs = request.getSession(false);
		if (hs != null && hs.getAttribute("userid") != null) {
			String userId = (String) hs.getAttribute("userid");
			Wishlist c = new Wishlist();
			c.setUserId(userId);
			c.setDate(new Date());
			String productId =  HtmlUtils.htmlEscape(request.getParameter("productId"));
			c.setProductId(productId);
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Query q = pm.newQuery(Wishlist.class);
			q.setFilter("productId==prodid && userId==userid");
			q.declareParameters("String prodid,String userid");
			List<Wishlist> res = (List<Wishlist>) q.execute(productId, userId);
			if (res.size() <= 0) {
				try {
					pm.makePersistent(c);
				} finally {
					pm.close();
				}
				return "Added to Wishlist";
			} else
				return "Already added";
		} else {
			return "false";
		}
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
	public String delete(@PathVariable String key, HttpServletRequest request,
			ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			Wishlist c = pm.getObjectById(Wishlist.class,
					KeyFactory.stringToKey(key));
			pm.deletePersistent(c);
		} finally {
			pm.close();
		}
		return "wishlist";
	}

	// get all customers
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listUser(ModelMap model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Category.class);
		// q.setOrdering("date desc");
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
