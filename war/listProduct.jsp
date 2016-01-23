<%@page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%@ page import="java.util.List"%>
<%@ page import="nayapuranaa.model.Product"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<html>
<body>
	Function :
	<a href="add">Add Product</a>
	<hr />
	<h2>All Products</h2>
	<table border="1">
		<thead>
			<tr>
				<th>Name</th>
				<th>Product Image</th>
				<th>Created Date</th>
				<th>Category</th>
				<th>SubCategory</th>
				<th>InnerSubCategory</th>
				<th>Special Category</th>
				<th>Action</th>
			</tr>
		</thead>
		<%
			if (request.getAttribute("listProduct") != null) {
				List<Product> products = (List<Product>) request
						.getAttribute("listProduct");
				//System.out.println(" empty");
				if (!products.isEmpty()) {
					//System.out.println("not empty");
					for (Product c : products) {
		%>
		<tr>
			<td><%=c.getProductName()%></td>
			<td><img width="200" height="150"
				src='<%="serve?blob-key=" + c.getProductImage()%>' /></td>
			<td><%=c.getDate()%></td>
			<td><%=c.getCategory()%></td>
			<td><%=c.getSubCategory()%></td>
			<td><%=c.getInnerSubCategory()%></td>
			<td><%=c.getSpecialCategory()%></td>
			<td><a href="update/<%=c.getProductName()%>">&nbsp;Update </a> |
				| <a href="delete/<%=KeyFactory.keyToString(c.getProductId())%>">Delete
					&nbsp;</a></td>
		</tr>
		<%
			}
				}
			}
		%>
	</table>
</body>
</html>