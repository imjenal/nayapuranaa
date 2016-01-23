<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Category List</title>
</head>
<body>
	Category :
	<a target="_blank" href="/category/add">Add</a> | |
	<a target="_blank" href="/category/list">List</a>
	<br> SubCategory :
	<a target="_blank" href="/subcategory/add">Add</a> | |
	<a target="_blank" href="/subcategory/list">List</a>
	<br> InnerSubCategory :
	<a target="_blank" href="/innersub/add">Add</a> | |
	<a target="_blank" href="/innersub/list">List</a>
	<br>
	<br> College :
	<a target="_blank" href="/college/add">Add</a> | |
	<a target="_blank" href="/college/list">List</a>
	<br>
	Location :
	<a target="_blank" href="/location/add">Add</a> | |
	<a target="_blank" href="/location/list">List</a>
	<br>
	<hr>
	<h2>Category List</h2>
	<table border="1">
		<thead>
			<tr>
				<th>Category</th>
				<!-- <td>Created Date</td> -->
				<th>Action</th>
			</tr>
		</thead>
		<%
			if (request.getAttribute("listCategory") != null) {
				List<Category> categories = (List<Category>) request
						.getAttribute("listCategory");
				if (!categories.isEmpty()) {
					for (Category c : categories) {
		%>
		<tr>
			<td><%=c.getName()%></td>
			<%-- <td><%=c.getEmail() %></td>
					  <td><%=c.getDate() %></td> --%>
			<td><a href="update/<%=c.getName()%>">&nbsp;Update</a> | | <a
				href="delete/<%=KeyFactory.keyToString(c.getCategoryId())%>">Delete&nbsp;</a>
			</td>
		</tr>
		<%
			}
				}
			}
		%>
	</table>
</body>
</html>