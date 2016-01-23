<!DOCTYPE HTML>
<%@page import="org.springframework.web.util.HtmlUtils"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Product"%>
<%@page import="javax.jdo.Query"%>
<%@page import="java.util.List"%>
<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<head>
<title>Product List | Apni Dukan Online</title>
<script type="text/javascript">
function callPage(id,valu){
	location.href="subproductss?name="+id+"&order="+valu;
}
</script>
</head>
<body>
  <div class="wrap">
<jsp:include page="header.jsp" />
 <div class="main">
    <div class="content">
    	<%
    	PersistenceManager pm = PMF.get().getPersistenceManager();
		String subcateg= HtmlUtils.htmlEscape((String)request.getParameter("name"));
    	Query q1 = pm.newQuery(Product.class);
    	q1.setFilter("innerSubCategory==subcatParam");
    	q1.declareParameters("String subcatParam");
    	q1.setOrdering("modificatioDate desc");
    	if(request.getAttribute("order")!=null&&request.getAttribute("order")!=""){
        	q1.setOrdering("price "+(String)request.getAttribute("order"));	
        	}
    	List<Product> listProduct = null;
    	try {
    		//System.out.println(sub.getName());
    		listProduct = (List<Product>) q1.execute(subcateg);
    		//System.out.println("product size"+listProduct.size());
        	if(listProduct.size()>0){
    	%>
    	    	<div class="content_top">
    		<div class="back-links">
    		<p><a href="index">Home</a> >> <a href="products?name=<%=listProduct.get(0).getCategory()%>"><%=listProduct.get(0).getCategory() %></a>
    		>> <a href="subproducts?name=<%=listProduct.get(0).getSubCategory()%>"><%=listProduct.get(0).getSubCategory() %></a>
    		</p>
    	    </div>
    	<!-- 	<div class="sort">
    		<p>Sort by:
    			<select>
    				<option>Lowest Price</option>
    				<option>Highest Price</option>
    				<option>Lowest Price</option>
    				<option>Lowest Price</option>
    				<option>Lowest Price</option>
    				<option>In Stock</option>  				   				
    			</select>
    		</p>
    		</div> -->
    		<!-- <div class="show">
    		<p>Show:
    			<select>
    				<option>4</option>
    				<option>8</option>
    				<option>12</option>
    				<option>16</option>
    				<option>20</option>
    				<option>In Stock</option>  				   				
    			</select>
    		</p>
    		</div>
    		<div class="page-no">
    			<p>Result Pages:<ul>
    				<li><a href="#">1</a></li>
    				<li class="active"><a href="#">2</a></li>
    				<li><a href="#">3</a></li>
    				<li>[<a href="#"> Next>>></a >]</li>
    				</ul></p>
    		</div> -->
    		<div class="clear"></div>
    	</div>
    	<div class="content_top">
    		<div class="heading">
    		<h3><%=subcateg %></h3>
    		</div>
    		<div class="sort">
    		<p>Sort by:
    			<select id="<%=subcateg%>" onchange="callPage(this.id,this.value)">
    				<option value="">Select Relevance</option>
    				<option value="desc">Price (High to Low)</option>
    				<option value="asc">Price (Low to High)</option>
    				<!-- <option>Lowest Price</option>
    				<option>Lowest Price</option>
    				<option>Lowest Price</option>
    				<option>In Stock</option>  	 -->			   				
    			</select>
    		</p>
    		</div>
    		<!-- 
    		<div class="show">
    		<p>Show:
    			<select>
    				<option>4</option>
    				<option>8</option>
    				<option>12</option>
    				<option>16</option>
    				<option>20</option>
    				<option>In Stock</option>  				   				
    			</select>
    		</p>
    		</div>
    		<div class="page-no">
    			<p>Result Pages:<ul>
    				<li><a href="#">1</a></li>
    				<li class="active"><a href="#">2</a></li>
    				<li><a href="#">3</a></li>
    				<li>[<a href="#"> Next>>></a >]</li>
    				</ul></p>
    		</div> -->
    		<div class="clear"></div>
    	</div>
				<%
				int counter=0;
				for(Product product:listProduct){
				if(counter%4==0){
					%>
					   <div class="section group">
					<%
				}
				%>
				<div class="grid_1_of_4 images_1_of_4">
				<input type="hidden" id="productid" name="productid" />
					<a href='preview-2?id=<%=KeyFactory.keyToString(product.getProductId())%>'><img class="twoonetwo" src="<%="/product/serve?blob-key="+product.getProductImage()  %>" alt="" /></a>
					 <div class="discount">
					 <span class="percentage"><%=(((product.getCancelledPrice()-product.getPrice())*100)/product.getCancelledPrice()) %>% </span>
					</div>
					 <h2><a href='preview-2?id=<%=KeyFactory.keyToString(product.getProductId())%>' ><%=product.getProductName() %> </a></h2>
					 <p><%=product.getDescription() %></p>
					 <p><span class="strike">Rs. <%=product.getCancelledPrice() %></span><span class="price">Rs. <%=product.getPrice() %></span></p>
					  <div class="button" ><span><img src="web/images/cart.jpg" alt="" />
					  <input data-toggle="modal" data-target="#myModal" type="button" id='<%=KeyFactory.keyToString(product.getProductId())+"," %>' class="cartbutton" value="Buy Now" onclick="createCookie(this.id,10)" /></span> </div>
				     <div class="button"><span><a href='preview-2?id=<%=KeyFactory.keyToString(product.getProductId())%>' class="details">Details</a></span></div>
				<!-- Button trigger modal -->

				<!-- <button class="btn btn-primary btn-lg">
 				 Launch demo modal
				</button> -->
				</div>
				<%
				counter++;
				if(counter%4==0){
					%>
					   <div class="section group">
					<%
				}
				%>
				<%}
			 %>
			</div>
			<%}else{
			%>
			No Products is available in this category.
			<%} %>
			<%
				} finally {
					q1.closeAll();
					pm.close();
				}
    	%>
		<!-- 	<div class="content_bottom">
    		<div class="heading">
    		<h3>New Products</h3>
    		</div>
    		<div class="sort">
    		<p>Sort by:
    			<select>
    				<option>Lowest Price</option>
    				<option>Highest Price</option>
    				<option>Lowest Price</option>
    				<option>Lowest Price</option>
    				<option>Lowest Price</option>
    				<option>In Stock</option>  				   				
    			</select>
    		</p>
    		</div>
    		<div class="show">
    		<p>Show:
    			<select>
    				<option>4</option>
    				<option>8</option>
    				<option>12</option>
    				<option>16</option>
    				<option>20</option>
    				<option>In Stock</option>  				   				
    			</select>
    		</p>
    		</div>
    		<div class="page-no">
    			<p>Result Pages:<ul>
    				<li><a href="#">1</a></li>
    				<li class="active"><a href="#">2</a></li>
    				<li><a href="#">3</a></li>
    				<li>[<a href="#"> Next>>></a >]</li>
    				</ul></p>
    		</div>
    		<div class="clear"></div>
    	</div>
			<div class="section group">
				<div class="grid_1_of_4 images_1_of_4">
					 <a href="preview-3.html"><img src="web/images/new-pic1.jpg" alt="" /></a>
					 <div class="discount">
					 <span class="percentage">40%</span>
					</div>
					 <h2>Lorem Ipsum is simply </h2>
					 <p><span class="strike">$438.99</span><span class="price">$403.66</span></p>
				     <div class="button"><span><img src="web/images/cart.jpg" alt="" /><a href="preview-3.html" class="cart-button">Add to Cart</a></span> </div>
				     <div class="button"><span><a href="preview-3.html" class="details">Details</a></span></div>
				</div>
				<div class="grid_1_of_4 images_1_of_4">
					<a href="preview-4.html"><img src="web/images/new-pic2.jpg" alt="" /></a>
					 <div class="discount">
					 <span class="percentage">22%</span>
					</div>
					 <h2>Lorem Ipsum is simply </h2>
					 <p><span class="strike">$667.22</span><span class="price">$621.75</span></p>
				      <div class="button"><span><img src="web/images/cart.jpg" alt="" /><a href="preview-4.html" class="cart-button">Add to Cart</a></span></div>
				     <div class="button"><span><a href="preview-4.html" class="details">Details</a></span></div>
				</div>
				<div class="grid_1_of_4 images_1_of_4">
					<a href="preview-2.html"><img src="web/images/feature-pic2.jpg" alt="" /></a>
					<div class="discount">
					 <span class="percentage">55%</span>
					</div>
					 <h2>Lorem Ipsum is simply </h2>
					 <p><span class="strike">$457.22</span><span class="price">$428.02</span></p>
				      <div class="button"><span><img src="web/images/cart.jpg" alt="" /><a href="preview-2.html" class="cart-button">Add to Cart</a></span> </div>
				     <div class="button"><span><a href="preview-2.html" class="details">Details</a></span></div>
				</div>
				<div class="grid_1_of_4 images_1_of_4">
				 <img src="web/images/new-pic3.jpg" alt="" />
				  <div class="discount">
					 <span class="percentage">66%</span>
					</div>
					 <h2>Lorem Ipsum is simply </h2>					 
					 <p><span class="strike">$643.22</span><span class="price">$457.88</span></p>
				      <div class="button"><span><img src="web/images/cart.jpg" alt="" /><a href="#" class="cart-button">Add to Cart</a></span> </div>
				     <div class="button"><span><a href="#" class="details">Details</a></span></div>
				</div>
			</div> -->
    </div>
 </div></div>
   <jsp:include page="footer.jsp" />
   </body>
</html>

