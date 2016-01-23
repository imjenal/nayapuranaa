<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Login | Apni Dukan Online</title>
</head>
<body>
<%
HttpSession hs=request.getSession(false);
if(hs.getAttribute("userid")!=null){
	//System.out.println("logged i n");
	response.sendRedirect("index");
}
else{

	//System.out.println(" not logged i n");
}
%>
  <div class="wrap">
<jsp:include page="header.jsp" />
	<%
if(request.getAttribute("result")!=null){
	%>
	<%=(String)request.getAttribute("result") %>
	
	<%
}
%>
 <div class="main">
 <div class="content">
<h3>User Login</h3>
<form class="form-horizontal" role="form" action="authenticate" method="post">
  <div class="form-group">
    <!-- <label for="inputEmail3" class="col-sm-2 control-label">Email</label> -->
    <div class="col-sm-10">
      <input type="email" class="form-control" id="email" name="email" placeholder="Email">
    </div>
  </div>
  <div class="form-group">
   <!--  <label for="inputPassword3" class="col-sm-2 control-label">Password</label> -->
    <div class="col-sm-10">
      <input type="password" name="password" id="password" class="form-control" placeholder="Password">
    </div>
  </div>
<!--   <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="checkbox">
        <label>
          <input type="checkbox"> Remember me
        </label>
      </div>
    </div>
  </div> -->
  <div class="form-group" style="padding-left:15px;">
      <button type="submit" class="btn btn-default">Sign in</button>
<a href="register"><h4>New User Register</h4></a>

</div>
</form>
 <div class="clear"></div>
				</div>	
				</div>
      
   <jsp:include page="footer.jsp" /></body>
</html>