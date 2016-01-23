<%@page import="nayapuranaa.model.College"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>College List | NayaPuranaa</title>
</head>
<body>
	College :
	<a target="_blank" href="/college/add">Add</a> | |
	<a target="_blank" href="/college/list">List</a>
	<br>
	Location :
	<a target="_blank" href="/location/add">Add</a> | |
	<a target="_blank" href="/location/list">List</a>
	<br> Category :
	<a target="_blank" href="/category/add">Add</a> | |
	<a target="_blank" href="/category/list">List</a>
	<br> SubCategory :
	<a target="_blank" href="/subcategory/add">Add</a> | |
	<a target="_blank" href="/subcategory/list">List</a>
	<br> InnerSubCategory :
	<a target="_blank" href="/innersub/add">Add</a> | |
	<a target="_blank" href="/innersub/list">List</a>
	<br>
	<br>
	<hr>
	<h2>College List</h2>
	<table border="1">
		<thead>
			<tr>
				<th>College</th>
				<th>Action</th>
			</tr>
		</thead>
		<%
			if(request.getAttribute("listCollege")!=null){
				List<College> college = (List<College>)request.getAttribute("listCollege");
				if(!college.isEmpty()){
					 for(College c : college){
		%>
		<tr>
			<td><%=c.getCollegeName() %></td>
			<td><a href="update/<%=c.getCollegeName()%>">&nbsp;Update</a> |
				| <a href="delete/<%=KeyFactory.keyToString(c.getCollegeId()) %>">Delete&nbsp;</a>
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