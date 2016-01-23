<!DOCTYPE html>
<%@page import="javax.jdo.Query"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Product"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
<title>Your Posts | NayaPuranaa</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<!-- <section id="advertisement">
		<div class="container">
			<img src="/images/advertisement.jpg" alt="" />
		</div>
	</section> -->
	<%
		HttpSession hs = request.getSession(false);
			String userid = (String) hs.getAttribute("userid");
			PersistenceManager pm = PMF.get().getPersistenceManager();
			Query q = pm.newQuery(Product.class);
			q.setFilter("userId==userid");
			q.setOrdering("date desc");
			q.declareParameters("String userid");
			List<Product> listProduct = (List<Product>) q.execute(userid);
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
							  <h2 class="text-center" style="color: #008DDF">You haven't
										posted any book yet!</h2>
									<div align="center" class="pagination-area">
										<ul class="pagination">
											<li><a href="/postyourbook" class="active">Post Your
													First Book</a></li>
										</ul>
									</div>
						
						 <%  } else { %>
						<h2 class="title text-center">Your Posts</h2>
							<% for (Product product : listProduct) {
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
											class="fa fa-crosshairs"></i>View post</a>
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
												class="fa fa-crosshairs"></i>View Post</a>
										</div>
									</div>
								</div>
								<div class="choose">
									<ul class="nav nav-pills nav-justified">
										<li><a
											href="/product/delete/<%=KeyFactory.keyToString(product.getProductId())%>"><i
												class="glyphicon glyphicon-trash"></i>Remove This Post</a></li>
									</ul>
								</div>
							</div>
						</div>
						<%
							}}
							//if (listProduct.size() > 15) {
						%>
					
						<%-- <ul class="pagination">
							<li class="active"><a href="">1</a></li>
							<li><a href="">2</a></li>
							<li><a href="">3</a></li>
							<li><a href="">&raquo;</a></li>
						</ul>
						<%
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