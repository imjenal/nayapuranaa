package nayapuranaa.controller;

import javax.jdo.PersistenceManager;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.appengine.api.datastore.KeyFactory;

import nayapuranaa.PMF;
import nayapuranaa.model.Product;

@Controller
@RequestMapping("/cart")
public class CartController {

	@RequestMapping
	public String getHomePage(ModelMap model) {
		return "cart";
	}

	/*
	 * @RequestMapping("/add") public ModelAndView getOrder(ModelMap
	 * map,HttpServletRequest request){ String name =
	 * HtmlUtils.htmlEscape(request.getParameter("productid")); String key =
	 * HtmlUtils.htmlEscape(request.getParameter("")); SubCategory sc = new
	 * SubCategory(); sc.setName(name); sc.setCategoryId(key);
	 * PersistenceManager pm = PMF.get().getPersistenceManager(); try {
	 * pm.makePersistent(sc); } finally { pm.close(); } return new
	 * ModelAndView(); }
	 */

	@RequestMapping("/showcart")
	@ResponseBody
	public String showcart(@RequestParam(value = "productid") String productid) {
		String[] products = productid.split(",");
		String makehtml = "<table class='table table-hover'>"
				+ "<tr	 class='success'>" + "<th>S.No</th>"
				+ "<th>Product Name</th>" + "<th>Product Image</th>"
				+ "<th>Quantity</th>" + "<th>Actual Price</th>"
				+ "<th>Offered Price</th>" + "<th>You saved</th>" + "</tr>";
		int j = 0;
		int duplicate = 1;
		String newprods = "";
		for (j = 0; j < products.length - 1; j++) {
			duplicate = 1;
			for (int k = j + 1; k < products.length - 1; k++) {
				if (k != j && products[k].equals(products[j])) {
					// System.out.println(duplicate +"this is duplicate");
					duplicate++;
				}
			}
			int flag = 0;
			for (int n = j - 1; n >= 0; n--) {
				if (products[j].equals(products[n])) {
					flag = 1;
				}
			}
			if (flag == 0) {
				newprods += products[j] + "apnidukan" + duplicate + ",";
			}
		}
		j = 0;
		products = newprods.split(",");
		for (int i = products.length - 1; i >= 0; i--) {
			PersistenceManager pm = PMF.get().getPersistenceManager();
			try {
				j++;
				String[] prod = products[i].split("apnidukan");
				if (prod[0] != null && prod[0] != "") {
					Product c = pm.getObjectById(Product.class, prod[0]);
					int quant = Integer.parseInt(prod[1]);
					if (c.getQuantity() > 0) {
						makehtml += "<tr  class='warning'>" + "<td> " + j
								+ "</td>" + "<td><a href='' >"
								+ c.getProductName() + "</a></td>"
								+ "<td><img src='/product/serve?blob-key="
								+ c.getProductImage()
								+ "' style='height:50px;width:50px;' /></td>"
								+ "<td>" + quant + "</td>" + "<td>Rs." + quant
								* c.getCancelledPrice() + "</td>" + "<td>Rs."
								+ quant * c.getPrice() + "</td>" + "<td>Rs."
								+ quant
								* (c.getCancelledPrice() - c.getPrice())
								+ "</td>" + "</tr>";
					}
				}
			} catch (Exception e) {
				return "";
			} finally {
				pm.close();
			}
		}
		makehtml += "</table>";
		return makehtml;
	}

	@RequestMapping("/cartitems")
	public int cartitems(@RequestParam(value = "productid") String productid) {
		String[] products = productid.split(",");
		int j = 0, l = 0;
		int duplicate = 1;
		String newprods = "";
		for (j = 0; j < products.length - 1; j++) {
			duplicate = 1;
			for (int k = j + 1; k < products.length - 1; k++) {
				if (k != j && products[k].equals(products[j])) {
					duplicate++;
				}
			}
			int flag = 0;
			for (int n = j - 1; n >= 0; n--) {
				if (products[j].equals(products[n])) {
					flag = 1;
				}
			}
			if (flag == 0) {
				newprods += products[j] + "apnidukan" + duplicate + ",";
			}
		}
		j = 0;
		products = newprods.split(",");
		for (int i = products.length - 1; i >= 0; i--) {
			PersistenceManager pm = PMF.get().getPersistenceManager();
			try {
				j++;
				String[] prod = products[i].split("apnidukan");
				if (prod[0] != null && prod[0] != "") {
					Product c = pm.getObjectById(Product.class, prod[0]);
					int quant = Integer.parseInt(prod[1]);
					if (c.getQuantity() > 0) {
						l++;
					}
				}
			} finally {
				pm.close();
			}
		}
		return l;
	}

	@RequestMapping("/placeorder")
	@ResponseBody
	public String placeOrder(@RequestParam(value = "productid") String productid) {
		String[] products = productid.split(",");
		String makehtml = "" + "<table class='table table-hover'>"
				+ "<tr class='success'>" + "<th>S.No</th>"
				+ "<th>Product Name</th>" + "<th>Product Image</th>"
				+ "<th>Quantity</th>" + "<th>Actual Price</th>"
				+ "<th>Offered Price</th>" + "<th>Action</th>" + "</tr>";
		int j = 0, m = 0;
		int duplicate = 1;
		String newprods = "";
		for (j = 0; j < products.length - 1; j++) {
			duplicate = 1;
			for (int k = j + 1; k < products.length - 1; k++) {
				if (k != j && products[k].equals(products[j])) {
					// System.out.println(duplicate +"this is duplicate");
					duplicate++;
				}
			}
			int flag = 0;
			for (int n = j - 1; n >= 0; n--) {
				if (products[j].equals(products[n])) {
					flag = 1;
				}
			}
			if (flag == 0) {
				newprods += products[j] + "apnidukan" + duplicate + ",";
			}
		}
		j = 0;
		products = newprods.split(",");
		String pselected = "";
		for (int i = products.length - 1; i >= 0; i--) {
			PersistenceManager pm = PMF.get().getPersistenceManager();
			try {
				j++;
				String[] prod = products[i].split("apnidukan");
				// System.out.println(prod[0]);
				if (prod[0] != null && prod[0] != "" && (!prod[0].equals(""))) {
					Product c = pm.getObjectById(Product.class, prod[0]);
					int quant = Integer.parseInt(prod[1]);
					if (c.getQuantity() > 0) {
						m++;
						pselected = pselected
								+ KeyFactory.keyToString(c.getProductId())
								+ ",";
						makehtml += "<tr  class='warning'>"
								+ "<td><input type='hidden' required='required' id='"
								+ m
								+ "productid' name='"
								+ m
								+ "productid' value='"
								+ KeyFactory.keyToString(c.getProductId())
								+ "' />"
								+ "<input type='hidden' required='required' id='"
								+ m
								+ "sno' name='"
								+ m
								+ "sno' />"
								+ m
								+ "</td>"
								+ "<td><input type='hidden' required='required' id='"
								+ m
								+ "productname' name='"
								+ m
								+ "productname' value='"
								+ c.getProductName()
								+ "'  /><a href='' >"
								+ c.getProductName()
								+ "</a></td>"
								+ "<td><input type='hidden' required='required' id='"
								+ m
								+ "productimage' name='"
								+ m
								+ "productimage' value='"
								+ c.getProductImage()
								+ "'  />"
								+ "<img src='/product/serve?blob-key="
								+ c.getProductImage()
								+ "' style='height:50px;width:50px;' /></td>"
								+ "<td><input type='text' onblur='getTotal()' required='required' id='"
								+ m
								+ "quantity' name='"
								+ m
								+ "quantity' value='"
								+ quant
								+ "' /></td>"
								+ "<td><input type='hidden' required='required' id='"
								+ m
								+ "cancelledprice' name='"
								+ m
								+ "cancelledprice' value='"
								+ c.getCancelledPrice()
								+ "' />Rs."
								+ c.getCancelledPrice()
								+ "</td>"
								+ "<td><input type='hidden' required='required' id='"
								+ m
								+ "price' name='"
								+ m
								+ "price' value='"
								+ c.getPrice()
								+ "' />Rs."
								+ c.getPrice()
								+ "</td>"
								+ "<td><span style='cursor:pointer;' id='"
								+ prod[0]
								+ "' onclick='removeProduct(this.id)' >Remove Item</span></td>"
								+ "</tr>";
					}
				}
			} finally {
				pm.close();
			}
		}
		makehtml += "<tr><td><input type='hidden' name='pselected' id='pselected' value='"
				+ pselected
				+ "' />"
				+ "<input type='hidden' name='counter' id='counter' value='"
				+ m
				+ "' />"
				+ "<input type='button' id='"
				+ m
				+ "' onclick='getTotal()' value='Get Total' /></td><td colspan='5'></td></tr>"
				+ "<tr><td colspan='4'></td><td>Total: </td><td><input type='text' readonly='readonly' id='total' name='total'  value='' /></td></tr>"
				+ "<tr><td colspan='4'></td><td>Delivery Charges: </td><td><input type='text' readonly='readonly' id='delivery' name='delivery' value='' /></td></tr>"
				+ "<tr><td colspan='4'></td><td>Grant Total: </td><td><input type='text' readonly='readonly' id='gtotal' name='gtotal' value='' /></td></tr>"
				+ "<tr><td colspan='5'></td><td><input type='submit' value='Confirm Order' /></td></tr></table>";

		if (pselected != "" && (!pselected.equals(""))) {
			return makehtml;
		} else {
			return "Your cart is empty Now. ";
		}
	}
}
