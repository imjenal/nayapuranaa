<%@page import="nayapuranaa.model.College"%>
<%@page import="javax.jdo.Query"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="nayapuranaa.model.InnerSubCategory"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.SpecialCategory"%>
<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Post Your Book | NayaPuranaa</title>

<script type="text/javascript">
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : evt.keyCode
    return !(charCode > 31 && (charCode < 48 || charCode > 57));
}
</script>
</head>
<body>
	<%
		HttpSession hs = request.getSession(false);
		String userid = (String) hs.getAttribute("userid");
		String email = (String) hs.getAttribute("email");
		String username = (String) hs.getAttribute("username");
		String phoneno = (String) hs.getAttribute("phoneno");
		String college = (String) hs.getAttribute("college");
		String fbprofile = (String) hs.getAttribute("fbprofile");
		String posted=(String)request.getAttribute("posted");
		BlobstoreService blobstoreService = BlobstoreServiceFactory
				.getBlobstoreService();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Category.class);
		List<Category> catList = (List<Category>) request
				.getAttribute("listCategory");
	%>
	<jsp:include page="header.jsp" />
	<h4 style="color: #008DDF; text-align: center";>
		<%if(posted!=null) {%>
		<%=posted %>
		<%} %>
	</h4>
	<div id="contact-page" class="container">
		<div class="bg">
			<div class="row">
				<jsp:include page="leftsidebar.jsp" />
				<div class="col-sm-8">
					<div class="contact-form">
						<h2 class="title text-center">Post Your Book</h2>
						<div class="status alert alert-success" style="display: none"></div>
						<form
							action="<%=blobstoreService.createUploadUrl("/product/upload")%>"
							method="post" enctype="multipart/form-data"
							id="main-contact-form" class="contact-form row"
							`							onsubmit="return checkValidation()">

							<input type="hidden" name="userid" id="userid"
								class="form-control" required="required" value="<%=userid%>" />

							<div class="form-group col-md-12">
								<input type="text" name="productName" id="productName"
									class="form-control" required="required"
									placeholder="Product Name" />
							</div>
							<div class="form-group col-md-12">
								<textarea name="description" id="description"
									required="required" class="form-control" rows="8"
									placeholder="Description"></textarea>
							</div>

							<div class="form-group col-md-6">
								<select name="category" id="category"
									onchange="getSubCategory(this.value)">
									<option value="0">Select Category</option>
									<%
										for (Category cat : catList) {
									%>
									<option value="<%=cat.getName()%>"><%=cat.getName()%></option>
									<%
										}
									%>
									<option value="other">Other</option>
								</select>
								<!-- <a href="/category/add">Add Category</a> -->
							</div>

							<div class="form-group col-md-6">
								<select name="subcategory" id="subcategory"
									onchange="getInnerSubCategory(this.value)">
									<option value="0">Select SubCategory</option>
									<option value="other">Other</option>
								</select>
								<!--  <a href="/subcategory/add">Add SubCategory</a> -->
							</div>

							<div class="form-group col-md-6">
								<select name="innersubcategory" id="innersubcategory">
									<option value="0">Select Inner SubCategory</option>
									<option value="other">Other</option>
								</select>
								<!-- <a href="/innersub/add">Add InnerSubCategory</a> -->
							</div>



							<div class="form-group col-md-12">
								<input type="text" name="productDetails" id="productDetails"
									class="form-control" placeholder="Product Details" />
							</div>

							<div class="form-group col-md-12">
								<input type="text" name="otherDetails" id="otherDetails"
									class="form-control" placeholder="Other Details" />
							</div>

							<div class="form-group col-md-6">
								<input type="text" name="cancelledprice" id="cancelledprice"
									class="form-control" required="required"
									placeholder="Actual Price" onblur="return isNumberKey(event)" />
							</div>

							<div class="form-group col-md-6">
								<input type="text" name="price" id="price" class="form-control"
									placeholder="Selling Price" onblur="return isNumberKey(event)" />
							</div>

							<div class="form-group col-md-6">

								<input type="text" name="quantity" id="quantity"
									class="form-control" required="required"
									placeholder="Product Quantity"
									onblur="return isNumberKey(event)" />
							</div>

							<div class="form-group col-md-6">
								<input type="text" name="edition" id="edition"
									class="form-control" placeholder="Product Edition" />
							</div>

							<div class="form-group col-md-6">
								<input type="text" name="author" id="author"
									class="form-control" required="required"
									placeholder="Product Author" />
							</div>

							<div class="form-group col-md-6">
								<input type="text" name="publications" id="publications"
									class="form-control" placeholder="Publications" />
							</div>

							<div class="form-group col-md-6">
								<select name="condition" id="condition" class="form-control">
									<option value="0">Product Condition</option>
									<option value="New">New</option>
									<option value="Used">Used</option>

								</select>
							</div>

							<div class="form-group col-md-6">
								<input type="text" name="contactperson" id="contactperson"
									class="form-control" required="required"
									placeholder="Contact Person" value="<%=username%>"
									readonly="readonly" />
							</div>


							<div class="form-group col-md-6">
								<% if (phoneno != null) {
								%>
								<input type="text" name="phoneno" id="phoneno"
									class="form-control" placeholder="Contact Number"
									pattern="\d{10}" maxlength="10"
									onblur="return isNumberKey(event)" value="<%=phoneno%>" />
								<%
									} else {
								%>
								<input type="text" name="phoneno" id="phoneno" pattern="\d{10}"
									maxlength="10" class="form-control"
									placeholder="Contact Number" onblur="return isNumberKey(event)" />

								<%
									}
								%>
							</div>

							<div class="form-group col-md-6">
								<% if (userid != null) {
								%>
								<input type="email" name="email" id="email" class="form-control"
									placeholder="Email Address" value="<%=userid%>" />
								<%
									} else {
								%>
								<input type="email" name="email" id="email" class="form-control"
									placeholder="Email Address" />
								<%
									}
								%>
							</div>

							<!-- <div class="form-group col-md-8 input-group  input-group-sm">
  <span class="input-group-addon">Rs</span>
  <input type="text" class="form-control" aria-label="Amount">
  <span class="input-group-addon">.00</span>
</div>
							
							<div class="col-md-12 input-group input-group-lg ">
                       <span class="input-group-addon" id="basic-addon3">https://www.facebook.com/</span>
                       <input type="text" class="form-control col-md-6" id="fbprofile"name="fbprofile"  placeholder="Facebook Profile Link"  aria-describedby="basic-addon3">
                         </div> -->

							<div class="form-group col-md-12">
								<% if (fbprofile != null) {
								%>
								<input type="url" name="fbprofile" id="fbprofile"
									class="form-control"
									placeholder="Facebook Profile Link (https://www.facebook.com/USERNAME/)"
									value="<%=fbprofile%>"
									pattern="http://www\.facebook\.com\/(.+)|https://www\.facebook\.com\/(.+)" />

								<%
									} else {
								%>
								<input type="url" name="fbprofile" id="fbprofile"
									class="form-control"
									placeholder="Facebook Profile Link (https://www.facebook.com/USERNAME/)"
									pattern="http://www\.facebook\.com\/(.+)|https://www\.facebook\.com\/(.+)" />

								<%
									}
								%>
							</div>
							<div class="ui-widget form-group col-md-12">
								<%
									if (college != null) {
								%>
								<input type="text" name="selectcollege" id="selectcollege"
									class="form-control" placeholder="Enter the College"
									value="<%=college%>" />
								<%
									} else {
								%>
								<input type="text" name="selectcollege" id="selectcollege"
									class="form-control" placeholder="Enter the College" />

								<%
									}
								%>
								
											
								
								<!-- <a href="/college/add">Add College</a> -->
							</div>
							<div class="form-group col-md-6">
								<label> <input type="checkbox" name="type" id="type"
									value="SALE" checked="checked"> Sale
								</label> <label> <input type="checkbox" name="type" id="type"
									value="EXCHANGE"> Exchange
								</label> <label> <input type="checkbox" name="type" id="type"
									value="FREE"> Free
								</label>
							</div>

							<div class="form-group col-md-6">
								Upload Image: <input type="file" accept="image/*"
									required="required" name="productImage" id="productImage" />
							</div>

							<div class="form-group col-md-12">
								<input type="submit" name="submit"
									class="btn btn-primary pull-right" title="Post" value="Post">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/#contact-page-->


	<jsp:include page="footer.jsp" />
</body>
</html>