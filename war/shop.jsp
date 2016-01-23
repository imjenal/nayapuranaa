<!DOCTYPE html>
<%@page import="nayapuranaa.model.Wishlist"%>
<%@page import="javax.jdo.Query"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Product"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
<title>Products | NayaPuranaa</title>
</head>
<body>
	<jsp:include page="header.jsp" />
<!-- 	<section id="advertisement">
		<div class="container">
			<img src="images/shop/advertisement.jpg" alt="" />
		</div>
	</section> -->
	<%
		List<Product> listProduct = (List<Product>) request
				.getAttribute("prod");
	%>
	<section>
		<div class="container">
			<div class="row">
				<jsp:include page="leftsidebar.jsp" />
				<div class="col-sm-9 padding-right">
					<div class="features_items">
						<!--features_items-->
						<%
						  if(listProduct.isEmpty()) {%>
							  <br>
							  <h2 class="text-center" style="color: #008DDF">Oops! No posts yet! </h2>
					
<div align="center" class="pagination-area">
										<ul class="pagination">
											<li><a href="/postyourbook" class="active">Post Your Book</a></li>
										</ul>
									</div>					
						 <%  } else { %>
						<h2 class="title text-center">Featured Items</h2>
						<%
							for (Product product : listProduct) {
						%>
						<div class="col-sm-4">
							<div class="product-image-wrapper">
								<div class="single-products">
									<div class="productinfo text-center">
										<img height="191" width="205"
											src='<%="product/serve?blob-key=" + product.getProductImage()%>'
											alt="" />
										<h2>
											<!-- Rupee -->
											&#8377;
											<%=product.getPrice()%></h2>
										<p><%=product.getProductName()%></p>
										<a
											href='productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>'
											class="btn btn-default add-to-cart"><i
											class="fa fa-shopping-cart"></i>Buy this</a>
									</div>
									<div class="product-overlay">
										<div class="overlay-content">
											<h2>
												<!-- Rupee -->
												&#8377;
												<%=product.getPrice()%></h2>
											<p><%=product.getProductName()%></p>
											<a
												href='productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>'
												class="btn btn-default add-to-cart"><i
												class="fa fa-shopping-cart"></i>Buy this</a>
										</div>
									</div>
								</div>
								<div class="choose">
									<ul class="nav nav-pills nav-justified">
										<li style="cursor: pointer;"
											onclick="addToWishlist('<%=KeyFactory.keyToString(product.getProductId())%>')"><a>
												<%
													HttpSession hs = request.getSession(false);
														String userid = (String) hs.getAttribute("userid");
														if (userid != null) {
															PersistenceManager pm = PMF.get().getPersistenceManager();
															Query q1 = pm.newQuery(Wishlist.class);
															q1.setFilter("productId==prodid && userId==userid");
															q1.declareParameters("String prodid,String userid");
															List<Wishlist> res = (List<Wishlist>) q1.execute(
																	KeyFactory.keyToString(product.getProductId()),
																	userid);
															if (res.size() > 0) {
												%> Added to wishlist <%
													} else {
												%> <span
												id="addWishlist<%=KeyFactory.keyToString(product.getProductId())%>">
													<i class="fa fa-plus-square"></i> Add to wishlist
											</span> <%
 	}
 		} else {
 %> <span
												id="addWishlist<%=KeyFactory.keyToString(product.getProductId())%>">
													<i class="fa fa-plus-square"></i> Add to wishlist
											</span> <%
 	}
 %>
										</a></li>
									</ul>
								</div>
							</div>
						</div>
						<%
							}}
							//if (listProduct.size() > 15) {
						%>

						<!-- <ul class="pagination">
							<li class="active"><a href="">1</a></li>
							<li><a href="">2</a></li>
							<li><a href="">3</a></li>
							<li><a href="">&raquo;</a></li>
						</ul> -->
						<%-- <%
							}
						%> --%>
					</div>
					<!--featured_items-->
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="footer.jsp" />
</body>
</html>