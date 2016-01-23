<%@page import="nayapuranaa.model.InnerSubCategory"%>
<%@page import="nayapuranaa.model.SpecialCategory"%>
<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%@page import="nayapuranaa.model.Product"%>
<%@ page import="nayapuranaa.model.Customer"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<html>
<body>
	<h1>Update Product</h1>
	<%
		Product product = new Product();
		if (request.getAttribute("Product") != null) {
			product = (Product) request.getAttribute("Product");
		}
		BlobstoreService blobstoreService = BlobstoreServiceFactory
				.getBlobstoreService();
		List<Category> catList = (List<Category>) request
				.getAttribute("listCategory");
		List<SubCategory> subCatList = (List<SubCategory>) request
				.getAttribute("listSubCategory");
		List<SpecialCategory> specCatList = (List<SpecialCategory>) request
				.getAttribute("specCategoryList");
		List<InnerSubCategory> innerSubList = (List<InnerSubCategory>) request
				.getAttribute("listInnerSubCategory");
	%>
	<h1>Add Product Details</h1>
	<form
		action="<%=blobstoreService.createUploadUrl("/product/update")%>"
		method="post" enctype="multipart/form-data">
		<input type="hidden" id="key" name="key"
			value="<%=KeyFactory.keyToString(product.getProductId())%>" />
		<table>
			<tr>
				<td>Product Image :</td>
				<td><input type="file" style="width: 185px;" maxlength="30"
					name="productImage" id="productImage" /></td>
			</tr>
			<tr>
				<td>Select Category :</td>
				<td><select style="width: 185px;" name="category" id="category">
						<%
							for (Category cat : catList) {
						%>
						<option value="<%=cat.getName()%>"><%=cat.getName()%></option>
						<%
							}
						%>
				</select> <a href="/category/add">Add Category</a></td>
			</tr>
			<tr>
				<td>Select SubCategory :</td>
				<td><select style="width: 185px;" name="subcategory"
					id="subcategory">
						<%
							for (SubCategory cat : subCatList) {
						%>
						<option value="<%=cat.getName()%>"><%=cat.getName()%></option>
						<%
							}
						%>
				</select> <a href="/subcategory/add">Add SubCategory</a></td>
			</tr>
			<tr>
				<td>Select InnerSubCategory :</td>
				<td><select style="width: 185px;" name="innersubcategory"
					id="innersubcategory">
						<%
							for (InnerSubCategory cat : innerSubList) {
						%>
						<option value="<%=cat.getName()%>"><%=cat.getName()%></option>
						<%
							}
						%>
				</select> <a href="/innersub/add">Add InnerSubCategory</a></td>
			</tr>
			<tr>
				<td>Select SpecialCategory :</td>
				<td><select style="width: 185px;" name="speccategory"
					id="speccategory">
						<%
							for (SpecialCategory cat : specCatList) {
						%>
						<option value="<%=cat.getName()%>"><%=cat.getName()%></option>
						<%
							}
						%>
				</select> <a href="/specialcat/add">Add Special Cat</a></td>
			</tr>
			<tr>
				<td>Product Name :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="productName" id="productName"
					value="<%=product.getProductName()%>" /></td>
			</tr>
			<tr>
				<td>Description :</td>
				<td><textarea style="width: 185px;" maxlength="30"
						name="description" id="description"><%=product.getDescription()%></textarea></td>
			</tr>

			<tr>
				<td>Product Cancelled Price :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="cancelledprice" id="cancelledprice"
					value="<%=product.getCancelledPrice()%>" /></td>
			</tr>
			<tr>
				<td>Product Price :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="price" id="price" value="<%=product.getPrice()%>" /></td>
			</tr>
			<tr>
				<td>Product Quantity :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="quantity" id="quantity" value="<%=product.getQuantity()%>" /></td>
			</tr>
			<tr>
				<td>Product Details :</td>
				<td><textarea style="width: 185px;" maxlength="30"
						name="productDetails" id="productDetails" /></td>
			</tr>
			<tr>
				<td>Other Details :</td>
				<td><textarea style="width: 185px;" maxlength="30"
						name="otherdetails" id="otherdetails" /></td>
			</tr>
		</table>
		<input type="submit" class="save" title="Upload" value="Upload" />
	</form>
</body>
</html>