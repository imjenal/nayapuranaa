<!DOCTYPE html>
<%@page import="nayapuranaa.dao.ProductDao"%>
<%@page import="nayapuranaa.model.Wishlist"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="nayapuranaa.model.Product"%>
<%@page import="javax.jdo.Query"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
<title>Home | NayaPuranaa</title>
</head>
<!--/head-->
<body>
	<jsp:include page="header.jsp" />
	<section id="slider">
		<!--slider-->
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div id="slider-carousel" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#slider-carousel" data-slide-to="0"
								class="active"></li>
							<li data-target="#slider-carousel" data-slide-to="1"></li>
							<li data-target="#slider-carousel" data-slide-to="2"></li>
						</ol>

						<div class="carousel-inner">
							<div class="item active">
								<div class="col-sm-6">
									<h1>
										<span>Naya</span>Puranaa
									</h1>
									<h2>SELL EXCHANGE DONATE</h2>
									<p>
										Don't you think that your books are getting under-valued and
										you get lesser money in return?<br> <br>SELL them
										here at your own price!
									</p>

									<button onclick="redirectPost()" type="button"
										class="btn btn-default get">Sell them now</button>
								</div>
								<div class="col-sm-6">
									<img src="/images/sell.png" class="girl img-responsive" alt="" />
								</div>
							</div>
							<div class="item">
								<div class="col-sm-6">
									<h1>
										<span>Naya</span>Puranaa
									</h1>
									<h2>SELL EXCHANGE DONATE</h2>
									<p>
										Are your old books of no use and using too much of your space?<br>
										<br>EXCHANGE them here with the books you need!
									</p>
									<button onclick="redirectPost()" type="button"
										class="btn btn-default get">Exchange them now</button>
								</div>
								<div class="col-sm-6">
									<img src="/images/exchange.png" class="girl img-responsive"
										alt="" />
								</div>
							</div>

							<div class="item">
								<div class="col-sm-6">
									<h1>
										<span>Naya</span>Puranaa
									</h1>
									<h2>SELL EXCHANGE DONATE</h2>
									<p>
										Are your books too old to exchange them for money or want to
										help a person in need?<br> <br> DONATE them to the
										one who don't have the luxury to afford them!
									</p>
									<button onclick="redirectPost()" type="button"
										class="btn btn-default get">Donate them now</button>
								</div>
								<div class="col-sm-6">
									<img src="/images/donate.png" class="girl img-responsive"
										alt="" />
								</div>
							</div>
						</div>
						<a href="#slider-carousel" class="left control-carousel hidden-xs"
							data-slide="prev"> <i class="fa fa-angle-left"></i>
						</a> <a href="#slider-carousel"
							class="right control-carousel hidden-xs" data-slide="next"> <i
							class="fa fa-angle-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/slider-->

	<section>
		<div class="container">
			<div class="row">
				<jsp:include page="leftsidebar.jsp" />
				<div class="col-sm-9 padding-right">
					<div class="features_items">
						<!--features_items-->
						<h2 class="title text-center">Featured Items</h2>
						<%
							String location = "";
							Cookie[] cookies = request.getCookies();
							if (cookies != null) {
								for (int i = 0; i < cookies.length; i++) {
									if (cookies[i].getName().equals("location")) {
										location = cookies[i].getValue();
										break;
									}
								}
							}

							ProductDao productDao = (ProductDao) request
									.getAttribute("productDao");
							List<Product> results2 = productDao
									.getProductListByLocationByRange(location, 0, 9);
							PersistenceManager	pm = PMF.get().getPersistenceManager();
							Query q=null;
							
							try {
								for (Product product : results2) {
						%>
						<div class="col-sm-4">
							<div class="product-image-wrapper">
								<div class="single-products">
									<div class="productinfo text-center">
										<img width="205" height="191"
											src='<%="product/serve?blob-key="
							+ product.getProductImage()%>'
											alt="" />
										<h2>
											<!-- Rupee -->
											&#8377;
											<%=product.getPrice()%></h2>
										<p><%=product.getProductName()%></p>
										<a
											href="/productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>"
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
												href="/productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>"
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
																pm = PMF.get().getPersistenceManager();
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
												id="addWishlist<%=KeyFactory.keyToString(product
									.getProductId())%>">
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
							}
							} finally {
								
							}
						%>

					</div>
					<!--features_items-->

					<div class="category-tab">
						<!--category-tab-->

						<div class="col-sm-12">
							<ul class="nav nav-tabs">
								<%
									pm = PMF.get().getPersistenceManager();
									q = pm.newQuery(Category.class);
									List<Category> results1 = null;
									try {
										results1 = (List<Category>) q.execute();
										int i = 0;
										for (Category cat : results1) {
											if (i == 0) {
												i++;
								%>
								<li class="active"><a
									href="#<%=KeyFactory.keyToString(cat.getCategoryId())%>"
									data-toggle="tab"><%=cat.getName()%></a></li>
								<%
									} else {
								%>
								<li><a
									href="#<%=KeyFactory.keyToString(cat.getCategoryId())%>"
									data-toggle="tab"><%=cat.getName()%></a></li>
								<%
									}
										}
									} finally {
									}
								%>
							</ul>
						</div>
						<!--  /col-sm-12 -->

						<div class="tab-content">
							<%
								int i = 0;
								for (Category cat : results1) {
									if (i == 0) {
										i++;
							%>

							<div class="tab-pane fade active in"
								id="<%=KeyFactory.keyToString(cat.getCategoryId())%>">
								<%
							
											List<Product> listProduct =productDao.getProductListByCategoryByRange(location, cat.getName(), 0, 4);
											for (Product product : listProduct) {
								%>


								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<%
													if (product.getProductImage() != null) {
												%>
												<img
													src='<%="product/serve?blob-key="
									+ product.getProductImage()%>'
													alt="" width="146" height="129" />
												<%
													} else {
												%>
												<img src="/images/default.png" alt="" width="146"
													height="129" />
												<%
													}
												%>
												<h2>
													<!-- Rupee -->
													&#8377;<%=product.getPrice()%></h2>
												<p><%=product.getProductName()%></p>
												<a
													href="productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>"
													class="btn btn-default add-to-cart"><i
													class="fa fa-shopping-cart"></i>Buy This</a>
											</div>
											<!--  /productinfo text-center -->
										</div>
										<!-- /single-products   -->
									</div>
									<!--  /product-image-wrapper -->
								</div>
								<!--  /col-sm-3 -->
								<%
									}
								%>

							</div>
							<!--  /tab-pane fade active in -->

							<%
								} else {
							%>

							<div class="tab-pane fade"
								id="<%=KeyFactory.keyToString(cat.getCategoryId())%>">
								<%
								List<Product> listProduct =productDao.getProductListByCategoryByRange(location, cat.getName(), 0, 4);
								
											for (Product product : listProduct) {
								%>


								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<%
													if (product.getProductImage() != null) {
												%>
												<img
													src='<%="product/serve?blob-key="
									+ product.getProductImage()%>'
													alt="" width="146" height="129" />
												<%
													} else {
												%>
												<img src="/images/default.png" alt="" width="146"
													height="129" />
												<%
													}
												%>
												<h2>
													<!-- Rupee -->
													&#8377;<%=product.getPrice()%></h2>
												<p><%=product.getProductName()%></p>
												<a
													href="productdetails?id=<%=KeyFactory.keyToString(product.getProductId())%>"
													class="btn btn-default add-to-cart"><i
													class="fa fa-shopping-cart"></i>Buy This</a>
											</div>

										</div>
									</div>
								</div>
								<%
									}
								%>
							</div>
							<!--  /tab-pane fade -->
							<%
								}
								}
							%>
						</div>
						<!--  /tab-content -->
					</div>
					<!--/category-tab-->

					<%-- <jsp:include page="recentlyviewed.jsp"/> --%>
				</div>
				<!-- /col-sm-9 padding-right -->
			</div>
			<!--  /row -->
		</div>
		<!--  /container -->
	</section>
	<jsp:include page="footer.jsp" />

</body>
</html>