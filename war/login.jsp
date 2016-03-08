<!DOCTYPE html>
<%@page import="javax.jdo.Query"%>
<%@page import="java.util.List"%>
<%@page import="nayapuranaa.model.Location"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<html lang="en">
<head>
<title>Login | NayaPuranaa</title>
<script type="text/javascript">
	var flag = 0;
	function checkValidation(email) {
		$.ajax({
			url : "/user/checkexist",
			data : {
				email : email
			}
		}).done(function(data) {
			if (data == 1) {
				flag = 1;
				$('#validation').css("display", "block");
				$('#validation').html("Email ID already exists!");
			} else {
				flag = 0;
				$('#validation').css("display", "none");
				$('#validation').html("Email ID already exists!");
			}
		});
	}

	function checkValidations() {
		var password = $("#checkpassword").val();
		if (password.length<7||password.length>12) {
			$('#passwordvalidmsg').css("display", "block");
			$('#passwordvalidmsg').html(
					"Password length should be between 6 to 12!");
			return false;
			flag = 0;
		} else {
			$('#passwordvalidmsg').css("display", "none");
			$('#result').css("display", "none");
			$('#passwordvalidmsg').html(
					"Password length should be between 6 to 12!");
		}
		//     return true;
		if (flag == 1) {
			$('#validation').css("display", "block");
			$('#validation').html("Email ID already exists!");
			return false;
		}

	}
</script>
</head>
<!--/head-->
<body>
	<div id="fb-root"></div>
	<script>
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=191721621179442";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>

	<jsp:include page="header.jsp" />
	<%
		String p = (String) request.getAttribute("p");
			String result = (String) request.getAttribute("result");
			String registered = (String) request.getAttribute("registered");
	%>
	<section id="form">
		<!--form-->

		<h4 style="color: #008DDF; text-align: center";>
			<%
				if (registered != null) {
			%>
			<%=registered%>
			<%
				}
			%>
		</h4>
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-sm-offset-1">
					<div class="login-form">
						<!--login form-->

						<h2>Login to your account!</h2>
						<form action="/authenticate" method="post">
							<input type="hidden" value="<%=p%>" name="p" /> <input
								type="email" id="email" name="email" required="required"
								placeholder="Email Address" /> <input type="password"
								id="password" name="password" required="required"
								placeholder="Password" /> <span id="result"
								style="color: red; font-size: 12px;"> <%
 	if (result != null) {
 %> <%=result%> <%
 	}
 %>
							</span>
							<button type="submit" class="btn btn-default">Login</button>
							<h5 style="color: #008DDF; text-align: right">
								<a href="/forgotpassword">Forgot Your Password </a>
							</h5>
						</form>
					</div>
					<!--/login form-->
				</div>
				<div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div>
				<div class="col-sm-4">
					<div class="signup-form">
						<!--sign up form-->
						<h2>New User SignUp!</h2>
						<form action="/user/add" method="post"
							onsubmit="return checkValidations()">
							<input type="text" id="name" name="name" required="required"
								placeholder="Name" /> <input type="email" id="email"
								onblur="checkValidation(this.value)" name="email"
								required="required" placeholder="Email Address" /> <span
								id="validation"
								style="color: red; display: none; font-size: 12px; padding-bottom: 7px;">
							</span> <input type="password" id="checkpassword" name="password"
								required="required" placeholder="Password" /> <span
								id="passwordvalidmsg"
								style="color: red; display: none; font-size: 12px;"></span> <input
								type="text" id="referral" name="referral"
								placeholder="Referral Code (Optional)" /> <select
								style="margin-bottom: 15px;" class="form-control"
								id="enterYourCity" name="enterYourCity">
								<option value="0">Select Your City</option>
								<option value="">All</option>

								<%
									try{
									PersistenceManager  pm = PMF.get().getPersistenceManager();
									Query q = pm.newQuery(Location.class);
									q.setOrdering("locationName");
									List<Location> locList = (List<Location>) q.execute();
										


									String location="";
								 Cookie[] cookies = request.getCookies();
								    if (cookies != null) {
								      for (int i = 0; i < cookies.length; i++) {
								        if (cookies[i].getName().equals("location")) {
								          location = cookies[i].getValue();
								          break;
								        }
								      }
								    }
								    
								for(Location loc:locList){    
								if(loc.getLocationName().equals(location)){
								%>
								<option selected="selected" value="<%=loc.getLocationName()%>">
									<%=loc.getLocationName()%></option>

								<%
									System.out.println(location);
																															}else{
								%>



								<option value="<%=loc.getLocationName()%>">
									<%=loc.getLocationName()%></option>
								<%
									}}
								%>
								<%
									}catch(Exception e ){ 
										e.printStackTrace();
										}
								%>

							</select>
							<button type="submit" class="btn btn-default">SignUp</button>
						</form>
					</div>
					<!--/sign up form-->
				</div>
			</div>
		</div>
	</section>
	<!--/form-->
	<jsp:include page="footer.jsp" />
</body>
</html>