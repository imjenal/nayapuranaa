package nayapuranaa.controller;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.HtmlUtils;

import nayapuranaa.PMF;
import nayapuranaa.model.Order;
import nayapuranaa.model.OrderedItems;

@Controller
@RequestMapping
public class OrderController {

	@RequestMapping("/confirmorder")
	public String getOrder(ModelMap map, HttpServletRequest request) {
		String makehtml = "<div style='width:100%;background-color:#ededed;'>"
				+ "<a href='http://www.apnidukanonline.com' ><img src='http://www.apnidukanonline.com/web/images/logo.png' />"
				+ "</a> </div>"
				+ "<div><table style='width:100%;'>"
				+ "<tr style='background-color:#dff0d8;text-align:center;height:40px;'>"
				+ "<th>S.No</th>" + "<th>Product Name</th>"
				+ "<th>Quantity</th>" + "<th>Offered Price</th>" + "</tr>";
		try {
			Order order = new Order();
			OrderedItems c = new OrderedItems();
			HttpSession hs = request.getSession(false);
			if (hs.getAttribute("userid") != null) {
				int count = Integer.parseInt( HtmlUtils.htmlEscape(request.getParameter("counter")));
				for (int m = 1; m <= count; m++) {
					c.setUserMailId((String) hs.getAttribute("userid"));
					c.setProductId( HtmlUtils.htmlEscape(request.getParameter(m + "productid")));
					c.setCancelledprice(Integer.parseInt( HtmlUtils.htmlEscape(request.getParameter(m
							+ "cancelledprice"))));
					c.setPrice(Integer.parseInt( HtmlUtils.htmlEscape(request.getParameter(m
							+ "price"))));
					c.setQuantity(Integer.parseInt( HtmlUtils.htmlEscape(request.getParameter(m
							+ "quantity"))));
					c.setStatus(true);
					makehtml += "<tr style='background-color:#fcf8e3;text-align:center;height:40px;'>"
							+ "<td>"
							+ m
							+ "</td>"
							+ "<td><a href='http://www.apnaagharonline.com/preview-2?id="
							+  HtmlUtils.htmlEscape(request.getParameter(m + "productid"))
							+ "' >"
							+  HtmlUtils.htmlEscape(request.getParameter(m + "productname"))
							+ "</a></td>"
							+ "<td>"
							+ c.getQuantity()
							+ "</td>"
							+ "<td>Rs." + c.getPrice() + "</td>"
							/*
							 * +"<td>Rs."+quant*(c.getCancelledPrice()-c.getPrice
							 * ())+"</td>"
							 */
							+ "</tr>";
					PersistenceManager pm = PMF.get().getPersistenceManager();
					try {
						pm.makePersistent(c);
					} finally {
						pm.close();
					}
				}
				makehtml += "<tr style='background-color:#fcf8e3;text-align:center;height:40px;'>"
						+ "<td colspan='3'>Total</td>"
						+ "<td >"
						+  HtmlUtils.htmlEscape(request.getParameter("total")) + "</td>" + "</tr>";
				makehtml += "<tr style='background-color:#fcf8e3;text-align:center;height:40px;'>"
						+ "<td colspan='3'>Delivery Charges</td>"
						+ "<td >"
						+  HtmlUtils.htmlEscape(request.getParameter("delivery")) + "</td>" + "</tr>";
				makehtml += "<tr style='background-color:#fcf8e3;text-align:center;height:40px;'>"
						+ "<td colspan='3'>Grand Total</td>"
						+ "<td >"
						+  HtmlUtils.htmlEscape(request.getParameter("gtotal")) + "</td>" + "</tr>";
				order.setOrderDate(new Date());
				order.setPaidStatus(false);
				order.setTotalPrice( HtmlUtils.htmlEscape(request.getParameter("gtotal")));
				order.setUserMailId((String) hs.getAttribute("userid"));
				PersistenceManager pm = PMF.get().getPersistenceManager();
				try {
					pm.makePersistent(order);
					Properties props = new Properties();
					Session session = Session.getDefaultInstance(props, null);
				    //String msgBody =  HtmlUtils.htmlEscape(request.getParameter("fullhtml"));
					try {
						Message msg = new MimeMessage(session);
						msg.setFrom(new InternetAddress(
								"rohitiwari30oct@gmail.com",
								"Apni Dukan Online"));
						msg.addRecipient(
								Message.RecipientType.TO,
								new InternetAddress((String) hs
										.getAttribute("userid"), (String) hs
										.getAttribute("userid")));
						msg.setSubject("Thankyou for shopping with Apni Dukan Online.");
						makehtml += "</table></div><div>Contact Us: +91 9506003804, +91 8115844668<br>Email: apnidukanonline@gmail.com</div>";
						msg.setContent(makehtml, "text/html");
						Message msg1 = new MimeMessage(session);
						msg1.setFrom(new InternetAddress(
								"rohitiwari30oct@gmail.com", "Rohit Tiwari"));
						msg1.addRecipient(Message.RecipientType.TO,
								new InternetAddress(
										"rohitiwari30oct@gmail.com",
										"Rohit Tiwari"));
						msg1.setSubject("a new order");
						makehtml += "</table>";
			  			msg1.setContent(makehtml, "text/html");
						Transport.send(msg);
						Transport.send(msg1);
					} catch (AddressException e) {
						e.printStackTrace();
					} catch (MessagingException e) {
						e.printStackTrace();
					}
				} finally {
					pm.close();
				}
				return "confirmorder";
			} else {
				return "userlogin";
			}
		} catch (Exception e) {
			return "index";
		}
	}
}
