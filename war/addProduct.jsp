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
<title>Add Product</title>
</head>
<body>
<jsp:include page="header.jsp"/>
	<%
BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
List<Category> catList=(List<Category>)request.getAttribute("listCategory");
List<SubCategory> subCatList=(List<SubCategory>)request.getAttribute("listSubCategory");
List<SpecialCategory> specCatList=(List<SpecialCategory>)request.getAttribute("specCategoryList");
List<InnerSubCategory> innerSubList=(List<InnerSubCategory>)request.getAttribute("listInnerSubCategory");
%>
	<h1>Add Product Details</h1>
	<form
		action="<%=blobstoreService.createUploadUrl("/product/upload") %>"
		method="post" enctype="multipart/form-data">
		<table class="table table-responsive">
			<tr>
				<td>Product Image :</td>
				<td><input type="file" style="width: 185px;" maxlength="30"
					name="productImage" id="productImage" /></td>
			</tr>
			<tr>
				<td>Select Category :</td>
				<td><select style="width: 185px;" name="category" id="category">
						<%
					for(Category cat:catList){
					%>
						<option value="<%=cat.getName() %>"><%=cat.getName()  %></option>
						<%} %>
				</select> <a href="/category/add">Add Category</a></td>
			</tr>
			<tr>
				<td>Select SubCategory :</td>
				<td><select style="width: 185px;" name="subcategory"
					id="subcategory">
						<%
					for(SubCategory cat:subCatList){
					%>
						<option value="<%=cat.getName() %>"><%=cat.getName()  %></option>
						<%} %>
				</select> <a href="/subcategory/add">Add SubCategory</a></td>
			</tr>
			<tr>
				<td>Select InnerSubCategory :</td>
				<td><select style="width: 185px;" name="innersubcategory"
					id="innersubcategory">
						<%
					for(InnerSubCategory cat:innerSubList){
					%>
						<option value="<%=cat.getName() %>"><%=cat.getName()  %></option>
						<%} %>
				</select> <a href="/innersub/add">Add InnerSubCategory</a></td>
			</tr>
			<tr>
				<td>Select SpecialCategory :</td>
				<td><select style="width: 185px;" name="speccategory"
					id="speccategory">
						<%
					for(SpecialCategory cat:specCatList){
					%>
						<option value="<%=cat.getName() %>"><%=cat.getName()  %></option>
						<%} %>
				</select> <a href="/specialcat/add">Add Special Cat</a></td>
			</tr>
			<tr>
				<td>Product Name :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="productName" id="productName" /></td>
			</tr>
			<tr>
				<td>Description :</td>
				<td><textarea style="width: 185px;" name="description"
						id="description"></textarea></td>
			</tr>
			<tr>
				<td>For :</td>
				<td><input type="checkbox" name="type" id="type" value="SALE">Sale
					<input type="checkbox" name="type" id="type" value="EXCHANGE">Exchange
					<input type="checkbox" name="type" id="type" value="FREE">Free
					</td>
			</tr>
			<tr>
				<td>Product Cancelled Price :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="cancelledprice" id="cancelledprice" /></td>
			</tr>
			<tr>
				<td>Product Price :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="price" id="price" /></td>
			</tr>
			<tr>
				<td>Product Quantity :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="quantity" id="quantity" /></td>
			</tr>
			<tr>
				<td>Product Details :</td>
				<td><textarea style="width: 185px;" name="productDetails"
						id="productDetails"></textarea></td>
			</tr>
			<tr>
				<td>Product Author :</td>
				<td><textarea style="width: 185px;" name="author" id="author"></textarea></td>
			</tr>
			<tr>
				<td>Publications :</td>
				<td><textarea style="width: 185px;" name="publications"
						id="publications"></textarea></td>
			</tr>
			<tr>
				<td>Product Edition :</td>
				<td><textarea style="width: 185px;" name="edition" id="edition"></textarea></td>
			</tr>
			<tr>
				<td>Product Condition :</td>
				<td><textarea style="width: 185px;" name="condition"
						id="condition"></textarea></td>
			</tr>
			<tr>
				<td>Contact Person :</td>
				<td><textarea style="width: 185px;" name="contactperson"
						id="contactperson"></textarea></td>
			</tr>
			<tr>
				<td>Other Details :</td>
				<td><textarea style="width: 185px;" name="otherDetails"
						id="otherDetails"></textarea></td>
			</tr>
		</table>
		<input type="submit" class="save" title="Upload" value="Upload" />
	</form>
	<!-- <h1>Add Product Details</h1>
	<form method="post" action="add" method="post"  >
		<table>
			<tr>
				<td>Product Name :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="productName" id="productName" /></td>
			</tr>
			<tr>
				<td>Description :</td>
				<td><textarea style="width: 185px;" maxlength="30"
					name="description" id="description" ></textarea></td>
			</tr>
			
			<tr>
				<td>Product Price :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="price" id="price" /></td>
			</tr>
			<tr>
				<td>Product Quantity :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="quantity" id="quantity" /></td>
			</tr>
			</table>
		<input type="submit" class="save" title="Save" value="Save" />
	</form> -->
	<jsp:include page="footer.jsp"/>
</body>
</html>