<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<div class="recommended_items">
		<!--recommended_items-->
		<h2 class="title text-center">Recently Viewed</h2>

		<div id="recommended-item-carousel" class="carousel slide"
			data-ride="carousel">
			<div class="carousel-inner">
				<div class="item active">

					<div class="col-sm-4">
						<div class="product-image-wrapper">
							<div class="single-products">
								<div class="productinfo text-center">
									<img src=<%-- '<%="product/serve?blob-key="
							+ product.getProductImage()%>' --%> alt="" />
									<h2>
										<!-- Rupee -->
										&#8377; <%-- <%=product.getPrice() %> --%>
									</h2>
									<p><%-- <%=product.getProductName() %> --%></p>
									<button type="button" class="btn btn-default add-to-cart">
										<i class="fa fa-shopping-cart"></i>Buy this
									</button>
								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- /item active -->

				<div class="item">
					<div class="col-sm-4">
						<div class="product-image-wrapper">
							<div class="single-products">
								<div class="productinfo text-center">
									<img src=<%-- '<%="product/serve?blob-key="
							+ product.getProductImage()%>' --%> alt="" />
									<h2>
										<!-- Rupee -->
										&#8377; <%-- <%=product.getPrice() %> --%>
									</h2>
									<p><%-- <%=producct.getProductName() %> --%></p>
									<button type="button" class="btn btn-default add-to-cart">
										<i class="fa fa-shopping-cart"></i>Buy this
									</button>
								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- /item -->
			</div>
			<!-- carousel-inner -->

			<a class="left recommended-item-control"
				href="#recommended-item-carousel" data-slide="prev"> <i
				class="fa fa-angle-left"></i>
			</a> <a class="right recommended-item-control"
				href="#recommended-item-carousel" data-slide="next"> <i
				class="fa fa-angle-right"></i>
			</a>
		</div>
	</div>
	<!--/recommended_items-->
</body>
</html>