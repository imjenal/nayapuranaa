package nayapuranaa.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nayapuranaa.PMF;
import nayapuranaa.dao.ProductDao;
import nayapuranaa.model.Category;
import nayapuranaa.model.InnerSubCategory;
import nayapuranaa.model.SubCategory;
import nayapuranaa.model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

@Controller
public class IndexController {

	@Autowired ProductDao productDao;
	
	@RequestMapping("/index")
	public String getHomePage(ModelMap model) {
		model.addAttribute("productDao",productDao);
		return "index";
	}

	@RequestMapping("/contact-us")
	public String getContact(ModelMap model) {
		return "contact-us";
	}

	@RequestMapping("/about-us")
	public String getAbout(ModelMap model) {
		return "about-us";
	}

	@RequestMapping(value = "/resetforgotpassword", method = RequestMethod.GET)
	public String resetforgotpassword(ModelMap model, @RequestParam String key) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		key = HtmlUtils.htmlEscape(key);
		Query q = pm.newQuery(User.class);
		q.setFilter("passwordResetCode==key");
		q.declareParameters("String key");
		List<User> userlist = (List<User>) q.execute(key);
		if (userlist.isEmpty()) {
			model.addAttribute("result", "Forgot Password link expire");
			return "login";
		} else {
			model.addAttribute("email", userlist.get(0).getEmail());
			return "resetforgotpassword";
		}
	}

	@RequestMapping(value = "/forgotpassword", method = RequestMethod.GET)
	public String getForgotPasswordPage(HttpServletRequest request,
			ModelMap model) {
		return "forgotpassword";
	}

	@RequestMapping(value = "/forgotpassword", method = RequestMethod.POST)
	public String getForgotPassword(HttpServletRequest request, ModelMap model) {
		String email = HtmlUtils.htmlEscape(request.getParameter("email"));
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(User.class);
		q.setFilter("email==emailid");
		q.declareParameters("String emailid");
		List<User> userlist = (List<User>) q.execute(email);
		if (userlist.isEmpty()) {
			model.addAttribute("result",
					"You haven't a registered ever. Please Sign Up to create your account");
			return "forgotpassword";
		} else {
			User user = (User) pm.getObjectById(User.class, userlist.get(0)
					.getUserId());
			String uuid = UUID.randomUUID().toString();
			user.setPasswordResetCode(uuid);
			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);
			Message msg1 = new MimeMessage(session);
			try {
				msg1.setFrom(new InternetAddress("care.nayapuranaa@gmail.com",
						"NayaPuranaa"));
				msg1.addRecipient(Message.RecipientType.TO,
						new InternetAddress(email, userlist.get(0)
								.getUserName()));
				msg1.setSubject("Reset Your Password | NayaPuranaa");
				String makehtml = "<div>To reset your password,please click on the following link:<br>"
						+ "<br><a href='www.nayapuranaa.com/resetforgotpassword?key="
						+ uuid
						+ "' >Click here</a><br><br>Cheers!<br>Team <a href='www.nayapuranaa.com/>NayaPuranaa</a>"
						+ "<br><br><br> <h6><i><center>This is an auto-generated mail. Please don't reply to this mail. </center></i></h6></div>";
				msg1.setContent(makehtml, "text/html");
				Transport.send(msg1);
			} catch (UnsupportedEncodingException | MessagingException e) {
				e.printStackTrace();
			}
			model.addAttribute("result", "Please check your mail! ");
			return "forgotpassword";
		}
	}

	@RequestMapping("/faq")
	public String getFaq(ModelMap model) {
		return "faq";
	}

	@RequestMapping("/userAgreement")
	public String getUserAgreement(ModelMap model) {
		return "userAgreement";
	}

	@RequestMapping("/team")
	public String getTeam(ModelMap model) {
		return "team";
	}

	@RequestMapping("/yourposts")
	public String getYourPosts(ModelMap model, HttpServletRequest request) {
		HttpSession hs = request.getSession(false);
		if (hs != null && hs.getAttribute("userid") != null)
			return "yourposts";
		else {
			model.addAttribute("p", "yourposts");
			return "login";
		}
	}

	@RequestMapping("/ambassador")
	public String getAmbassdor(ModelMap model) {
		return "ambassador";
	}

	@RequestMapping("/ambassadorform")
	public String getAmbassadorForm(ModelMap model) {
		return "ambassadorform";
	}

	@RequestMapping("/productdetails")
	public String getProductDetails(ModelMap model,
			@RequestParam(value = "id") String id) {
		model.addAttribute("id", id);
		return "product-details";
	}

	@RequestMapping("/privacy")
	public String getPrivacy(ModelMap model) {
		return "privacy";
	}

	@RequestMapping("/wishlist")
	public String getWishList(ModelMap model, HttpServletRequest request) {
		HttpSession hs = request.getSession(false);
		if (hs != null && hs.getAttribute("userid") != null)
			return "wishlist";
		else {
			model.addAttribute("p", "wishlist");
			return "login";
		}
	}

	@RequestMapping(value = "/postyourbook", method = RequestMethod.GET)
	public String getPostYourBook(ModelMap model, HttpServletRequest request) {
		HttpSession hs = request.getSession(false);
		if ((hs != null) && (hs.getAttribute("userid") != null)) {
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
			if(request.getAttribute("posted")!=null)
				model.addAttribute("posted",(String)request.getAttribute("posted"));
			return "postyourbook";
		} else {
			model.addAttribute("p", "postyourbook");
			return "login";
		}
	}

	@RequestMapping("/getSubCategory")
	@ResponseBody
	public String getSubCategory(ModelMap model, @RequestParam String category) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
 		Query q = pm.newQuery(SubCategory.class);
		q.setFilter("categoryId==category");
		q.setOrdering("name");
		q.declareParameters("String category");
		List<SubCategory> subCategory = (List<SubCategory>) q.execute(category);
		String subs = "";	
		for (SubCategory subCategory2 : subCategory) {
			subs = subs + subCategory2.getName() + ",";
		}
		return subs.substring(0, subs.length() - 1);
	}

	@RequestMapping("/getInnerSubCategory")
	@ResponseBody
	public String getInnerSubCategory(ModelMap model,
			@RequestParam String subCategory) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(InnerSubCategory.class);
		q.setFilter("subCategoryId==subCategory");
		q.setOrdering("name");
		q.declareParameters("String subCategory");
		List<InnerSubCategory> innerSubCategory = (List<InnerSubCategory>) q
				.execute(subCategory);
		String subs = "";
		for (InnerSubCategory innerSubCategory2 : innerSubCategory) {
			subs = subs + innerSubCategory2.getName() + ",";
		}
		if (subs.length() > 1)
			return subs.substring(0, subs.length() - 1);
		else
			return "";
	}

	@RequestMapping("/products")
	public String getProducts(ModelMap model,
			@RequestParam(value = "name") String id) {
		model.addAttribute("name", id);
		return "products";
	}

	@RequestMapping("/productss")
	public String getProductss(ModelMap model,
			@RequestParam(value = "name") String id,
			@RequestParam(value = "order") String order) {
		model.addAttribute("order", order);
		model.addAttribute("name", id);
		return "products";
	}

	@RequestMapping("/subproducts")
	public String getSubProducts(ModelMap model,
			@RequestParam(value = "name") String id) {
		model.addAttribute("name", id);
		return "subproducts";
	}

	@RequestMapping("/subproductss")
	public String getSubProductss(ModelMap model,
			@RequestParam(value = "name") String id,
			@RequestParam(value = "order") String order) {
		model.addAttribute("order", order);
		model.addAttribute("name", id);
		return "subproducts";
	}

	@RequestMapping("/innersubproducts")
	public String getInnerSubProducts(ModelMap model,
			@RequestParam(value = "name") String id) {
		model.addAttribute("name", id);
		return "innersubproducts";
	}

	@RequestMapping("/innersubproductss")
	public String getInnerSubProductss(ModelMap model,
			@RequestParam(value = "name") String id,
			@RequestParam(value = "order") String order) {
		model.addAttribute("order", order);
		model.addAttribute("name", id);
		return "innersubproducts";
	}

	@RequestMapping("/orderplace")
	public String getOrder(ModelMap model) {
		return "placeorder";
	}

	@RequestMapping("/shoelaundary")
	public String getShoeLaundary(ModelMap model) {
		return "shoelaundary";
	}

	@RequestMapping("/register")
	public String getlogin(ModelMap model) {
		return "register";
	}
}
