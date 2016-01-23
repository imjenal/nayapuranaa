<!DOCTYPE html>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="nayapuranaa.model.Wishlist"%>
<%@page import="javax.jdo.Query"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<html lang="en">
<head>
   <title>Wishlist | NayaPuranaa</title>
</head>
<body>
 <jsp:include page="header.jsp"/>
	<section id="cart_items">
		<div class="container">
			<div class="breadcrumbs">
				<ol class="breadcrumb">
				  <li><a href="/index">Home</a></li>
				  <li class="active"><a href="/cart">Wishlist</a></li>
				</ol>
			</div>
			<div class="table-responsive cart_info">
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu">
							<td class="image">Item</td>
							<td class="description"></td>
							<td class="price">Price</td>
							<td class="quantity">Sell/Exchange/Free</td>
							<td class="total">Contact Person</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
                      <%
                         HttpSession hs=request.getSession(false);
                         String userid=(String)hs.getAttribute("userid");
						PersistenceManager pm = PMF.get().getPersistenceManager();
						Query q = pm.newQuery(Wishlist.class);
						q.setOrdering("date desc");
						q.setFilter("userId==userid");
						q.declareParameters("String userid");
						List<Wishlist> results2 = null;
							try {
								results2 = (List<Wishlist>) q.execute(userid);
								for (Wishlist wishlist : results2) {
									Product product=pm.getObjectById(Product.class,KeyFactory.stringToKey(wishlist.getProductId()));
									%>
						<tr>
							<td class="cart_product">
								<a href="/productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>"><img style="width:100px; height:80px" src='<%="product/serve?blob-key="
							+ product.getProductImage()%>' alt=""></a>
							</td>
							<td class="cart_description">
								<h4><a href="/productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>"><%=product.getProductName()%></a></h4>
								<p><%=KeyFactory.stringToKey(wishlist.getProductId())%></p>
							</td>
							<td class="cart_price">
								<p><!-- Rupee -->
												&#8377;<%=product.getPrice()%></p>
							</td>
							<td class="cart_quantity">
							<p><%=product.getType()%></p>
							
								<!-- <div class="cart_quantity_button">
									<a class="cart_quantity_up" href=""> + </a>
									<input class="cart_quantity_input" type="text" name="quantity" value="1" autocomplete="off" size="2">
									<a class="cart_quantity_down" href=""> - </a>
								</div> -->
							</td>
							<td class="cart_total">
								<p class="cart_total_price"><%=product.getContactperson()%></p>
							</td>
							<td class="cart_delete">
								<a class="cart_quantity_delete" href="/wishlist/delete/<%=KeyFactory.keyToString(wishlist.getWishlistId())%>"><i class="fa fa-times"></i></a>
							</td>
						</tr>
						<% }
								} 
						finally
						{
						q.closeAll();
						pm.close();
						}%>
					</tbody>
				</table>
			</div>
		</div>
	</section> <!--/#cart_items-->
 <jsp:include page="footer.jsp"/>
</body>
</html>