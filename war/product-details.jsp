<!DOCTYPE html>
<%@page import="nayapuranaa.model.User"%>
<%@page import="nayapuranaa.model.Wishlist"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="javax.jdo.Query"%>
<%@page import="java.util.List"%>
<%@page import="nayapuranaa.model.Product"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<html lang="en">
<head>



<title>Product Details | NayaPuranaa</title>
</head>
 <body>
 <%
	String proid = (String) request.getAttribute("id");
	PersistenceManager pm = PMF.get().getPersistenceManager();
	try {
		Product product = pm.getObjectById(Product.class, proid);
%>

<meta property="og:url"           content="http://www.your-domain.com/your-page.html" />
	<meta property="og:type"          content="website" />
	<meta property="og:title"         content="Your Website Title" />
	<meta property="og:description"   content="Your description" />
	<meta property="og:image"         content="http://www.your-domain.com/path/image.jpg" />
<script>
$(".outside-link").click(function(){
    $(".nav li").removeClass("active");
    $($(this).attr("data-toggle-tab")).parent("li").addClass("active");
});
</script> 
 <div id="fb-root"></div>
 <script type="text/javascript">
	$(document).ready(function() {
		FB.init({
			appId : '191721621179442',
			status : true,
			xfbml : true,
			version : 'v2.5' // or v2.0, v2.1, v2.2, v2.3
		});
	});
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
			return;
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=191721621179442";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
</script>

 
<div class="fb-share-button"
	data-href="http://www.nayapuranaa.com/productdetails?id=<%=KeyFactory.keyToString(product.getProductId()) %>"
	data-layout="button_count"></div>


 
 <!--  FB Share Button -->
<script>
	function fbs_click(id) {
		var url = 'http://www.facebook.com/sharer.php?u='
				+ encodeURIComponent('http://www.nayapuranaa.com/productdetails/?id=')
				+ id;
		window
				.open(
						url,
						'Share on FaceBook',
						'left=20,top=20,width=550,height=400,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
		return false;
	}
</script>



<jsp:include page="header.jsp" />

<section>
	<div class="container">
		<div class="row">
			<jsp:include page="leftsidebar.jsp" />
			<div class="col-sm-9 padding-right">
				<div class="product-details">
					<!--product-details-->
					<div class="col-sm-5">
						<div class="view-product">
							<%
								if (product.getProductImage() != null) {
							%>
							<img 
								src='<%="product/serve?blob-key="
							+ product.getProductImage()%>'
								alt="" width="266" height="381" />
							<%
								} else {
							%>
							<img src="/images/default.png" alt="" width="266" height="381" />
							<%
								}
							%>
							<!-- <h3>ZOOM</h3> -->
						</div>
						<div id="similar-product" class="carousel slide"
							data-ride="carousel">

							<!-- Wrapper for slides -->
							<!-- <div class="carousel-inner">
										<div class="item active">
										  <a href=""><img src="images/product-details/similar1.jpg" alt=""></a>
										  <a href=""><img src="images/product-details/similar2.jpg" alt=""></a>
										  <a href=""><img src="images/product-details/similar3.jpg" alt=""></a>
										</div>
										<div class="item">
										  <a href=""><img src="images/product-details/similar1.jpg" alt=""></a>
										  <a href=""><img src="images/product-details/similar2.jpg" alt=""></a>
										  <a href=""><img src="images/product-details/similar3.jpg" alt=""></a>
										</div>
										<div class="item">
										  <a href=""><img src="images/product-details/similar1.jpg" alt=""></a>
										  <a href=""><img src="images/product-details/similar2.jpg" alt=""></a>
										  <a href=""><img src="images/product-details/similar3.jpg" alt=""></a>
										</div>
										
									</div>  -->

							<!-- Controls -->
							<!-- <a class="left item-control" href="#similar-product"
									data-slide="prev"> <i class="fa fa-angle-left"></i>
								</a> <a class="right item-control" href="#similar-product"
									data-slide="next"> <i class="fa fa-angle-right"></i>
								</a> -->
						</div>

					</div>
					<div class="col-sm-7">
						<div class="product-information">
							<!--/product-information-->

							<!-- <img src="images/product-details/new.jpg" class="newarrival"
									alt="" /> -->
							<h2><%=product.getProductName()%></h2>
							<!-- <p>Web ID: 1089772</p> -->
							<!--<img src="images/product-details/rating.png" alt="" />  -->
							<span> <span> <!-- Rupee --> &#8377; <%=product.getPrice()%>
							</span> <label>Quantity :</label> <input type="text" readonly="readonly"
								value="<%=product.getQuantity()%>" />
								<button
									id="addWishlist<%=KeyFactory.keyToString(product.getProductId())%>"
									onclick="addToWishlist('<%=KeyFactory.keyToString(product.getProductId())%>')"
									type="button" class="btn btn-fefault cart">
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
									%>
									Added to wishlist
									<%
										} else {
									%>
									<i class="fa fa-plus-square"></i> Add to wishlist
									<%
										}
											} else {
									%>

									<i class="fa fa-plus-square"></i> Add to wishlist
									<%
										}
									%>
								</button>
							</span>
							<p>
								<%
									if (product.getCollegeName() != null) {
								%>
								<b>College : </b>
								<%=product.getCollegeName()%>
								<%
									}
								%>
							</p>
							<p>
								<%
									if (product.getContactperson() != null) {
								%>
								<b>Contact Person : </b> <a href="#contactdetails" id="contactdetails1"  data-toggle="tab"> <%=product.getContactperson()%></a>
								<% 
									}
								%>
							</p>

							<p>
								<%
									if (product.getCondition() != null) {
								%>
								<b>Condition :</b>
								<%=product.getCondition()%>
								<%
									}
								%>
							</p>

							<p>
								<%
									if (product.getType() != null) {
								%>
								<b>For : </b>
								<%=product.getType().substring(0,
							product.getType().length() - 1)%>
								<%
									}
								%>
							</p>
							<a id="fb_link" href="#fb_link"
								onclick="fbs_click('<%=KeyFactory.keyToString(product.getProductId())%>');">
								<img src="/images/fbshare1.png" class="share img-responsive"
								alt="" />
							</a>

						</div>
						<!--/product-information-->
					</div>
				</div>
				<!--/product-details-->

				<div class="category-tab shop-details-tab">
					<!--category-tab-->
					<div class="col-sm-12">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#contactdetails" data-toggle="tab">Contact
									<%=product.getContactperson()%></a></li>
							<li><a href="#reviews" data-toggle="tab">Product
									Details</a></li>
							<!-- <li><a href="#otherdetails" data-toggle="tab">Other
									Details</a></li> -->
							<li style="width: 150px; overflow: ellipse;"><a
								href="#otherposts" data-toggle="tab">Other Posts By <%=product.getContactperson()%></a></li>
							<li><a href="#details" data-toggle="tab">Similar Items</a></li>
						</ul>
					</div>
					<div class="tab-content">
						<div class="tab-pane fade" id="details">
							<%
								pm = PMF.get().getPersistenceManager();
									Query q = pm.newQuery(Product.class);
									q.setFilter("subCategory==subcat");
									q.setOrdering("date desc");
									q.declareParameters("String subcat");
									List<Product> prod = (List<Product>) q.execute(product
											.getSubCategory());
									if (prod.size() == 1) {
							%>
							<h4 class="text-center" style="color: #008DDF">There are no
								similar items</h4>
							<%
								} else {
										for (Product product1 : prod) {
											if (product1.getProductId() != product.getProductId()) {
							%>
							<div class="col-sm-3">
								<div class="product-image-wrapper">
									<div class="single-products">
										<div class="productinfo text-center">
											<%
												if (product1.getProductImage() != null) {
											%>
											<img
												src='<%="product/serve?blob-key="
										+ product1.getProductImage()%>'
												alt="" width="138" height="122" />
											<%
												} else {
											%>
											<img src="/images/default.png" alt="" width="138"
												height="122" />
											<%
												}
											%>

											<h2>
												<!-- Rupee -->
												&#8377;
												<%=product1.getPrice()%></h2>
											<p><%=product1.getProductName()%></p>
											<a
												href="productdetails?id=<%=KeyFactory.keyToString(product1
									.getProductId())%>"
												class="btn btn-default add-to-cart"><i
												class="fa fa-shopping-cart"></i>Buy This</a>
										</div>
									</div>
								</div>
							</div>
							<%
								}
										}
									}
							%>
						</div>

						<div class="tab-pane fade" id="otherposts">
							<%
								pm = PMF.get().getPersistenceManager();
									q = pm.newQuery(Product.class);
									q.setFilter("userId==email");
									q.setOrdering("date desc");
									q.declareParameters("String email");
									List<Product> prod1 = (List<Product>) q.execute(product
											.getEmail());
									if (prod1.isEmpty()) {
							%>
							<br>
							<h4 class="text-center" style="color: #008DDF"><%=product.getContactperson()%>
								hasn't posted other books
							</h4>
							<%
								} else {
										for (Product product2 : prod1) {
											if (product2.getProductId() != product.getProductId()) {
							%>
							<div class="col-sm-3">
								<div class="product-image-wrapper">
									<div class="single-products">
										<div class="productinfo text-center">
											<%
												if (product2.getProductImage() != null) {
											%>
											<img
												src='<%="product/serve?blob-key="
										+ product2.getProductImage()%>'
												alt="" width="138" height="122" />
											<%
												} else {
											%>
											<img src="/images/default.png" alt="" width="138"
												height="122" />
											<%
												}
											%>
											<h2>
												<!-- Rupee -->
												&#8377;
												<%=product2.getPrice()%></h2>
											<p><%=product2.getProductName()%></p>
											<a
												href='productdetails?id=<%=KeyFactory.keyToString(product2
									.getProductId())%>'
												class="btn btn-default add-to-cart"><i
												class="fa fa-shopping-cart"></i>Buy this</a>
										</div>
									</div>
								</div>
							</div>
							<%
								}
										}
									}
							%>
						</div>

						<div class="tab-pane fade " id="reviews">
							<div class="col-sm-12">
								<!-- <ul>
										<li><a href=""><i class="fa fa-user"></i>EUGEN</a></li>
										<li><a href=""><i class="fa fa-clock-o"></i>12:41 PM</a></li>
										<li><a href=""><i class="fa fa-calendar-o"></i>31 DEC
												2014</a></li>
									</ul> -->
								<p>
									<%
										if (product.getAuthor() != null) {
									%>
									<b>Author : </b>
									<%=product.getAuthor()%>
									<%
										}
									%>
								</p>
								<p>
									<%
										if (product.getEdition() != null) {
									%>
									<b>Edition : </b>
									<%=product.getEdition()%>
									<%
										}
									%>
								</p>
								<p>
									<%
										if (product.getPublications() != null) {
									%>
									<b>Publications :</b>
									<%=product.getPublications()%>
									<%
										}
									%>
								</p>
								<p>
									<%
										if (product.getDescription() != null) {
									%>
									<b>Description : </b>
									<%=product.getDescription()%>
									<%
										}
									%>
								</p>
								<p>
									<%
										if (product.getOtherDetails() != null) {
									%>
									<b>Other Details :</b>
									<%=product.getOtherDetails()%>
									<%
										}
									%>
								</p>
								<!-- <p>
										<b>Write Your Review</b>
									</p>

									<form action="#">
										<span> <input type="text" placeholder="Your Name" /> <input
											type="email" placeholder="Email Address" />
										</span>
										<textarea name=""></textarea>
										<b>Rating: </b> <img src="images/product-details/rating.png"
											alt="" />
										<button type="button" class="btn btn-default pull-right">
											Submit</button>
									</form> -->
							</div>
						</div>
						<!-- <div class="tab-pane fade" id="otherdetails">
							<div class="col-sm-12">
									
							</div>
						</div> -->
						<div class="tab-pane fade active in" id="contactdetails">
							<div class="col-sm-12">
								<p>
									<%
										if((product.getPhoneno() != null) && (product.getPhoneno().trim() =="")) {
									%>
									<b>Contact Number : </b>
									<%=product.getPhoneno()%>
									<%
										}
									%>
								</p>
								<p>
									<%
										if((product.getFbprofile() != null) && (product.getFbprofile().trim() =="")) {
									%>
									<b>Facebook Profile Link : </b> <a
										href="<%=product.getFbprofile()%>"> <%=product.getFbprofile()%></a>
									<%
										}
									%>
								</p>
								<p>
									<%
										if((product.getEmail() != null) && (product.getEmail().trim() =="")) {
									%>
									<b>Email ID : </b>
									<%=product.getEmail()%>
									<%
										}
									%>
								</p>
							</div>
						</div>
					</div>
				</div>
				<%
					} finally {
						pm.close();
					}
				%>
				<!--/category-tab-->

				<%-- <jsp:include page="recentlyviewed.jsp"/> --%>
			</div>
		</div>
	</div>
</section>
<jsp:include page="footer.jsp" />
</body>
</html>