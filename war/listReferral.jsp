<%@page import="nayapuranaa.model.User"%>
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
<title>Referral List | NayaPuranaa</title>
</head>
<body>
	<h2>Referral List</h2>
	<hr>
	<table border="1">
		<thead>
			<tr>
				<th>User Name</th>
				<th>Email</th>
			</tr>
		</thead>
		<%
			if(request.getAttribute("listReferral")!=null){
				List<User> referral = (List<User>)request.getAttribute("listReferral");
				if(!referral.isEmpty()){
					 for(User c : referral){
		%>
		<tr>
		<td><%=c.getUserName() %></td>
		<td><%=c.getEmail() %></td>
			
			<%-- <td><a href="update/<%=c.getCollegeName()%>">&nbsp;Update</a> |
				| <a href="delete/<%=KeyFactory.keyToString(c.getCollegeId()) %>">Delete&nbsp;</a>
			</td> --%>
		</tr>
		<%	
					}
				}
		   	}
		%>
	</table>
</body>
</html>