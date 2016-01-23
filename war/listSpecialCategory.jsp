<%@page import="nayapuranaa.model.SpecialCategory"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Special Category</title>
</head>
<body>
	<h3>
		<a href="/product/add">Add Product</a>
	</h3>
	Function :
	<a href="add">Add Special Category</a>
	<hr>
	<h2>Special Category List</h2>
	<table border="1">
		<thead>
			<tr>
				<th>Special Category</th>
				<!-- 	<th>Created Date</th> -->
				<th>Action</th>
			</tr>
		</thead>
		<%
			if (request.getAttribute("listSpecialCategory") != null) {
				List<SpecialCategory> categories = (List<SpecialCategory>) request
						.getAttribute("listSpecialCategory");
				if (!categories.isEmpty()) {
					for (SpecialCategory c : categories) {
		%>
		<tr>
			<td><%=c.getName()%></td>
			<%-- <td><%=c.getEmail() %></td>
					  <td><%=c.getDate() %></td> --%>
			<td><a href="update/<%=c.getName()%>"> &nbsp;Update </a> | | <a
				href="delete/<%=KeyFactory.keyToString(c.getSpclCategoryId())%>">Delete
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