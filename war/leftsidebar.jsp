<%@page import="nayapuranaa.model.InnerSubCategory"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.Query"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="java.util.List"%>
<div class="col-sm-3">
	<div class="left-sidebar">
	<%
	List<SubCategory> results = (List<SubCategory>)request.getAttribute("subCategoryList");
	
	PersistenceManager pm = PMF.get().getPersistenceManager();
	Query q=null;
	try { 
		q = pm.newQuery(Category.class);
		List<Category> catlist = (List<Category>)q.execute();
		for (Category cat : catlist) {
	%>
		<h2><%=cat.getName() %></h2>
		<div class="panel-group category-products" id="accordian">
			<!--category-products-->
				<%
					
						for (SubCategory subcat : results) {
							String key=KeyFactory.keyToString(subcat.getSubCategoryId());
				%>
				<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordian"
							href="#<%=key %>"> <span class="badge pull-right"><i
								class="fa fa-plus"></i></span> <%=subcat.getName()%>
						</a>
					</h4>
				</div>
				<div id="<%=key %>" class="panel-collapse collapse">
					<div class="panel-body">
						<ul>
							<%
							q = pm.newQuery(InnerSubCategory.class);
							q.setFilter("subCategoryId == nameParameter");
							q.setOrdering("name");
							q.declareParameters("String nameParameter");
								List<InnerSubCategory> innersubcatList = (List<InnerSubCategory>) q.execute(subcat.getName());
										for (InnerSubCategory innersubcat : innersubcatList) {
							%>
							<li><a href="innersubcatlist?name=<%=innersubcat.getName()%>"><%=innersubcat.getName()%> </a></li>
							<% } %>
						</ul>

					</div>
			</div>	</div>
				<%
					}
				%>
		</div>
		<%}}finally {
			q.closeAll();
			//pm.close();
		} %>
		<!--/category-products-->

		<!-- <div class="brands_products">
			brands_products
			<h2>Filter By</h2>
			<div class="brands-name">
				<ul class="nav nav-pills nav-stacked">
					<li><a href="#"> <span class="pull-right">(50)</span>
					</a></li>
					<li><a href="#"> <span class="pull-right">(56)</span>College
					</a></li>
				</ul>
			</div>
		</div>
		 /brands_products
 -->
		<!-- <div class="price-range">
			price-range
			<h2>Price Range</h2>
			<div class="well text-center">
				<input type="text" class="span2" value="" data-slider-min="0"
					data-slider-max="600" data-slider-step="5"
					data-slider-value="[250,450]" id="sl2"><br /> <b
					class="pull-left"> Rupee &#8377; 0
				</b> <b class="pull-right"> Rupee &#8377; 600
				</b>
			</div>
		</div>
		 /price-range -->

		<!-- <div class="shipping text-center">
			shipping
			<img src="/images/app.png" alt="" />
		</div> -->
		<!--/shipping-->

	</div>
</div>