<!DOCTYPE HTML>
<%@page import="java.util.List"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="javax.jdo.Query"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Product"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<head>
<title>Preview | Apni Dukan Online</title>

</head>
<body>
<%
String proid=(String)request.getAttribute("id");

PersistenceManager pm = PMF.get().getPersistenceManager();
try{
Product c1 = pm.getObjectById(Product.class, proid);
%>
  <div class="wrap">
<jsp:include page="header.jsp" />
 <div class="main">
    <div class="content">
    	<div class="content_top">
    		<div class="back-links">
    		<p><a href="index">Home</a> >> <a href="products?name=<%=c1.getCategory()%>"><%=c1.getCategory() %></a> >> <a href="subproducts?name=<%=c1.getSubCategory()%>"><%=c1.getSubCategory() %></a></p>
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
    	<div class="section group">
				<div class="cont-desc span_1_of_2">				
					<div class="grid images_3_of_2">
						<img src="<%="/product/serve?blob-key="+c1.getProductImage()  %>" alt="" />
					</div>
				<div class="desc span_3_of_2">
					
					<h2><%=c1.getProductName() %></h2>
					<p><%=c1.getDescription() %></p>					
					<div class="price">
						<p>Price: <span>Rs. <%=c1.getPrice() %></span></p>
					</div>
			<!-- 		<div class="available">
						<p>Available Options :</p>
					<ul>
						<li>Color:
							<select>
							<option>Silver</option>
							<option>Black</option>
							<option>Dark Black</option>
							<option>Red</option>
						</select></li>
						<li>Size:<select>
							<option>Large</option>
							<option>Medium</option>
							<option>small</option>
							<option>Large</option>
							<option>small</option>
						</select></li>
						<li>Quality:<select>
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
						</select></li>
					</ul>
					</div> -->
					<!-- <div class="share">
						<p>Share Product :</p>
						<ul>
					    	<li><a href="#"><img src="web/images/youtube.png" alt=""></a></li>
					    	<li><a href="#"><img src="web/images/facebook.png" alt=""></a></li>
					    	<li><a href="#"><img src="web/images/twitter.png" alt=""></a></li>
					    	<li><a href="#"><img src="web/images/linkedin.png" alt=""></a></li>
			    		</ul>
					</div> -->
				<div class="add-cart">
					<!-- <div class="rating">
						<p>Rating:<img src="web/images/rating.png" alt="" /><span>[3 of 5 Stars]</span></p>
					</div> -->
					 <div class="button" ><span><img src="web/images/cart.jpg" alt="" /><input data-toggle="modal" data-target="#myModal" type="button" id='<%=KeyFactory.keyToString(c1.getProductId())+"," %>' class="cartbutton" value="Buy Now" onclick="createCookie(this.id,10)" /></span> </div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="product-desc">
			<h2>Product Details</h2>
			<p><%=c1.getProductDetails() %></p>
			<p><%=c1.getOtherDetails() %></p>
	    </div>
	  <!--   <div class="product-tags">
			<h2>Product Tags</h2>
			<h4>Add Your Tags:</h4>
			<div class="input-box">
				<input type="text" value="" />
			</div>
			<div class="button"><span><a href="#">Add Tags</a></span></div>
	    </div> -->				
	</div>
				<div class="rightsidebar span_3_of_1">
					<h2>CATEGORIES</h2>
					<ul>
				     <%

pm = PMF.get().getPersistenceManager();
Query q = pm.newQuery(Category.class);
List<Category> cats = null;
try {
	cats = (List<Category>) q.execute();
} finally {
	//q.closeAll();
//	pm.close();
}

%>
   <%
		// System.out.println(cats.size());
		 for(Category cat:cats){
		 %>
				      <li><a href="products?name=<%=cat.getName() %>"><%=cat.getName() %></a></li>
				     <%} %>
    				</ul>
    				<!-- <div class="subscribe">
    					<h2>Newsletters Signup</h2>
    						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.......</p>
						    <div class="signup">
							    <form>
							    	<input type="text" value="E-mail address" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'E-mail address';"><input type="submit" value="Sign up">
							    </form>
						    </div>
      				</div> -->
      				 <!-- <div class="community-poll">
      				 	<h2>Community POll</h2>
      				 	<p>What is the main reason for you to purchase products online?</p>
      				 	<div class="poll">
      				 		<form>
      				 			<ul>
									<li>
									<input type="radio" name="vote" class="radio" value="1">
									<span class="label"><label>More convenient shipping and delivery </label></span>
									</li>
									<li>
									<input type="radio" name="vote" class="radio" value="2">
									<span class="label"><label for="vote_2">Lower price</label></span>
									</li>
									<li>
									<input type="radio" name="vote" class="radio"  value="3">
									<span class="label"><label for="vote_3">Bigger choice</label></span>
									</li>
									<li>
									<input type="radio" name="vote" class="radio"  value="5">
									<span class="label"><label for="vote_5">Payments security </label></span>
									</li>
									<li>
									<input type="radio" name="vote" class="radio" value="6">
									<span class="label"><label for="vote_6">30-day Money Back Guarantee </label></span>
									</li>
									<li>
									<input type="radio" name="vote" class="radio" value="7">
									<span class="label"><label for="vote_7">Other.</label></span>
									</li>
									</ul>
      				 		</form>
      				 	</div>
      				 </div> -->
 				</div>
 		</div>
 	</div>
	</div>
   <jsp:include page="footer.jsp" />
    <%}catch(Exception e){}finally{
    pm.close();	
    }	%>
    
</body>
</html>

