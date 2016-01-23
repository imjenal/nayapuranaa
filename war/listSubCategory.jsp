<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SubCategory List | NayaPuranaa</title>
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
	<br>Location :
	<a target="_blank" href="/location/add">Add</a> | |
	<a target="_blank" href="/location/list">List</a>
	<br>
	<hr>
	<h2>SubCategory List</h2>
	<table border="1">
		<thead>
			<tr>
				<th>SubCategory</th>
				<th>Category</th>
				<!--	<td>Created Date</td> -->
				<th>Action</th>
			</tr>
		</thead>
		<%
			if (request.getAttribute("listSubCategory") != null) {
				List<SubCategory> subcategories = (List<SubCategory>) request
						.getAttribute("listSubCategory");
				if (!subcategories.isEmpty()) {
					for (SubCategory c : subcategories) {
		%>
		<tr>
			<td><%=c.getName()%></td>
			<td><%=c.getCategoryId()%></td>
			<%--  <td><%=c.getDate() %></td> --%>
			<td><a href="update/<%=c.getName()%>">&nbsp;Update</a> | | <a
				href="delete/<%=KeyFactory.keyToString(c.getSubCategoryId())%>">Delete&nbsp;</a>
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