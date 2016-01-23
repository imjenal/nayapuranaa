<!DOCTYPE html>
<%@page import="org.springframework.web.util.HtmlUtils"%>
<html lang="en">
<head>
<title>Reset Forgot Password | NayaPuranaa</title>
<script>
	function resetpassword(){
		var password=$("#password").val();
		var confirmpassword=$("#confirmpassword").val();
		if(password.length<7||password.length>12){
			if((confirmpassword.length!= password.length) || (confirmpassword!= password)){
			$('#secondpassword').css("display","block");
			 $('#secondpassword').html("Password doesn't match!");
			 return false;
		    }else{
			$('#secondpassword').css("display","none");
	     	}
		
		$('#firstpassword').css("display","block");
		$('#firstpassword').html("Password length should be between 6 to 12!");
		return false;
		}
		else{
			if((confirmpassword.length!= password.length) || (confirmpassword!= password)){
				$('#secondpassword').css("display","block");
				 $('#secondpassword').html("Password doesn't match!");
				 return false;
			    }else{
				$('#secondpassword').css("display","none");
		     	}
		$('#firstpassword').css("display","none");
		}
			return true;
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<section id="form">
		<!--form-->
		<div class="container">
			<div class="row">
				<jsp:include page="leftsidebar.jsp" />
				<div class="col-sm-4 col-sm-offset-1">
					<div class="login-form">
						<!--login form-->
						<h2>Reset Your Password!</h2>
						<br>
						<%
						String result= HtmlUtils.htmlEscape((String)request.getParameter("resultresetpage"));
						String email= HtmlUtils.htmlEscape((String)request.getAttribute("email"));
						if(result!=null){
						%>
						<h4 style="color: green;"><%=result %></h4>
						<%} %>
						<form action="/resetforgotpassword" method="post"
							onsubmit="return resetpassword()">
							<input type="hidden" id="email" name="email" value="<%=email %>" />
							<input type="password" id="password" name="password"
								required="required" placeholder="Password" /> <span
								id="firstpassword"
								style="color: red; display: none; font-size: 12px;"></span> <input
								type="password" id="confirmpassword" name="confirmpassword"
								required="required" placeholder="Confirm Password" /> <span
								id="secondpassword" style="color: red; font-size: 12px;">
							</span>
							<button type="submit" class="btn btn-default">Reset</button>
						</form>
					</div>
					<!--/login form-->
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="footer.jsp" />
</body>
</html>