<!DOCTYPE html>
<html lang="en">
<head>
<title>Forgot Password | NayaPuranaa</title>
</head>
<!--/head-->
<body>
<%
	 String result=(String)request.getAttribute("result");
	 %>
	<jsp:include page="header.jsp"/>
	<div id="contact-page" class="container">
		<div class="bg">
			<div class="row">
				<div class="col-sm-12">
					<h2 class="title text-center">
						Forgot <strong>Your Password</strong>
					</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-8">
					<div class="contact-form">
						<div class="status alert alert-success" style="display: none"></div>
						<form id="main-contact-form" action="/forgotpassword" method="post" class="contact-form row"
							name="contact-form">
							<div class="form-group col-md-12">
								<input type="email" name="email" id="email" class="form-control"
									required="required" placeholder="Enter Email address where we'll send you mail">
							</div>
							<div class="form-group col-md-12">
								<input type="submit" name="submit"
									class="btn btn-primary pull-right" value="Submit">
									<h4 style="color: #008DDF; text-align: "center">
		                        	<%if(result!=null) {%>
		                               	<%=result %>
			                        <%} %>
	                         	</h4>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/#contact-page-->

	<jsp:include page="footer.jsp"/>
</body>
</html>