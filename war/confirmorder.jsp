<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Order Confirmation | Apni Dukan Online</title>
</head>
<%
HttpSession hs=request.getSession(false);
if(hs.getAttribute("userid")!=null){
}
else{
	response.sendRedirect("/userlogin");
}
%>
<body onload="eraseCookie()">
<div class="wrap">
	<jsp:include page="header.jsp" />
 <div class="main">
    <div class="content">
    	<div class="order-details">
    	<h2>Congratulation you have placed your order successfully.</h2>
    	</div>
    	  	
    </div>
 </div>
<jsp:include page="footer.jsp" />
</body>
</html>