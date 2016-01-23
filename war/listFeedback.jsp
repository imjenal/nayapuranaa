<%@page import="nayapuranaa.model.Feedback"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Query / Feedback</title>
</head>
<body>
<h2>Query / Feedback</h2>
	<hr>
	<table border="1">
		<thead>
			<tr>
			<th> Date </th>
				<th>Name</th>
				<th>Email</th>
                <th>Subject</th>
                <th>Message</th>
				<!-- <th>Action</th> -->
			</tr>
		</thead>
		<%
			if (request.getAttribute("listFeedback") != null) {
				List<Feedback> feedbacks = (List<Feedback>) request
						.getAttribute("listFeedback");
				if (!feedbacks.isEmpty()) {
					for (Feedback c : feedbacks) {
		%>
		<tr>
		<td><%=c.getDate() %></td>
			<td><%=c.getName()%></td>
			<td><%=c.getEmail() %></td>
			<td><%=c.getSubject() %></td>
			<td><%=c.getMessage() %></td>			
			<%-- <td><a href="update/<%=c.getName()%>">&nbsp;Update</a> | | <a
				href="delete/<%=KeyFactory.keyToString(c.getCategoryId())%>">Delete&nbsp;</a>
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