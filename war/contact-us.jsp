<!DOCTYPE html>
<html lang="en">
<head>
<title>Contact Us | NayaPuranaa</title>

<!-- Google Map -->
<script src="https://maps.googleapis.com/maps/api/js"></script>
<script>
	function initialize() {
		var mapCanvas = document.getElementById('map');
		var mapOptions = {
			center : new google.maps.LatLng(26.84669, 80.94617),
			zoom : 8,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		}
		var map = new google.maps.Map(mapCanvas, mapOptions)
	}
	google.maps.event.addDomListener(window, 'load', initialize);
</script> <!-- /GoogleMap -->
</head>
<!--/head-->
<body>
<%
	 String contact=(String)request.getAttribute("contact");
	 %>
	<jsp:include page="header.jsp"/>
	<div id="contact-page" class="container">
		<div class="bg">
			<div class="row">
				<div class="col-sm-12">
					<h2 class="title text-center">
						Contact <strong>Us</strong>
					</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-8">
					<div class="contact-form">
						<h2 class="title text-center">Get In Touch</h2>
						<div class="status alert alert-success" style="display: none"></div>
						<form id="main-contact-form" action="add" method="post" class="contact-form row"
							name="contact-form">
							<div class="form-group col-md-6">
								<input type="text" name="name" id="name" class="form-control"
									required="required" placeholder="Name">
							</div>
							<div class="form-group col-md-6">
								<input type="email" name="email" id="email" class="form-control"
									required="required" placeholder="Email">
							</div>
							<div class="form-group col-md-12">
								<input type="text" name="subject" id="subject" class="form-control"
									required="required" placeholder="Subject">
							</div>
							<div class="form-group col-md-12">
								<textarea name="message" id="message" required="required"
									class="form-control" rows="8"
									placeholder="Your Message Here (Query/Feedback)"></textarea>
							</div>
							<div class="form-group col-md-12">
								<input type="submit" name="submit"
									class="btn btn-primary pull-right" value="Submit">
									<h4 style="color: #008DDF; text-align: center">
			<%if(contact!=null) {%>
			<%=contact %>
			<%} %>
		</h4>
							</div>
						</form>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="contact-info">
						<h2 class="title text-center">Contact Info</h2>
						<address>
							<p>NayaPuranaa</p>
							<p>Email: admin@nayapuranaa.com</p>
						</address>
						<div class="social-networks">
							<h2 class="title text-center">Social Networking</h2>
							<ul>
								<li><a href="https://www.facebook.com/NayaPuranaa"><i
										class="fa fa-facebook"></i></a></li>
								<li><a href="https://twitter.com/NayaPuranaa"><i
										class="fa fa-twitter"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/#contact-page-->


	<div id="map" class="contact-map"></div>
	<jsp:include page="footer.jsp"/>

	<script type="text/javascript"
		src="http://maps.google.com/maps/api/js?sensor=true"></script>
	<script type="text/javascript" src="js/gmaps.js"></script>
	<script src="js/contact.js"></script>
</body>
</html>