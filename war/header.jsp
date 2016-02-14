<%@page import="nayapuranaa.model.Location"%>
<%@page import="nayapuranaa.model.College"%>
<%@page import="nayapuranaa.model.Wishlist"%>
<%@page import="javax.jdo.Query"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/font-awesome.min.css" rel="stylesheet">
<link href="/css/prettyPhoto.css" rel="stylesheet">
<link href="/css/price-range.css" rel="stylesheet">
<link href="/css/animate.css" rel="stylesheet">
<link href="/css/main.css" rel="stylesheet">
<link href="/css/responsive.css" rel="stylesheet">
<link rel="shortcut icon" href="/images/finallogo1.png">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="/images/ico/apple-touch-icon-57-precomposed.png">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery.scrollUp.min.js"></script>
<script src="/js/price-range.js"></script>
<script src="/js/jquery.prettyPhoto.js"></script>
<script src="/js/main.js"></script>
<!-- Google Analytics -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js
','ga');

  ga('create', 'UA-72178081-1', 'auto');
  ga('send', 'pageview');

</script>

<script>
$(document).ready(function()
{
    $("img").error(function(){
        $(this).attr('src', '/images/default.png');
    });
});
</script>

<link rel="stylesheet" href="/css/jquery-ui.css">
<script src="/js/jquery-1.10.2.js"></script>
<script src="/js/jquery-ui.js"></script>
<link rel="stylesheet" href="/css/style.css">
<script type="text/javascript">
function setLocation(){
var location=	$("#enterLocation").val();
	setCookie('location',location,30);
}
</script>


<script type="text/javascript">
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
    }
    return "";
}

function checkCookie() {
    var user = getCookie("username");
    if (user != "") {
        alert("Welcome again " + user);
    } else {
        user = prompt("Please enter your name:", "");
        if (user != "" && user != null) {
            setCookie("username", user, 365);
        }
    }
}
</script>
<script>
  $(function() {
    var availableTags = [
<%PersistenceManager pm = PMF.get().getPersistenceManager();
Query q = pm.newQuery(College.class);
q.setOrdering("collegeName");
List<College> colList = (List<College>) q.execute();
	for(College col:colList){%>
      "<%=col.getCollegeName()%>",
      <%}%> 
    ];
    $( "#selectcollege" ).autocomplete({
      source: availableTags
    });
  });
  </script> 




<script type="text/javascript">
	function addToWishlist(productId) {
		$.ajax({
			url : "/wishlist/add",
			data : {
				productId : productId
			}
		}).done(function(data) {
			if(data=="false"){
				location.href="/login";
			}else{
			$("#bluestar").addClass("bluestar");
			$('#bluestar').stop().animate({"font-size":"22px"},1500,function() {
			  
				$('#bluestar').stop().animate({"font-size":"14px"},1500);
			  });
$('#addWishlist'+productId).html("Added to Wishlist");
			}
		});
	}
</script>
<script>
	function getSubCategory(category) {
		$.ajax({
			url : "/getSubCategory",
			data : {
				category : category
			}
		}).done(
				function(data) {
					$('#subcategory option').remove();
					$('#innersubcategory option').remove();
					$('#subcategory').append(
							$("<option></option>").attr("value", "0").text(
									"Select SubCategory"));
					$('#innersubcategory').append(
							$("<option></option>").attr("value", "0").text(
									"Select Inner SubCategory"));
					var data1 = data.split(",");
					for (var i = 0; i < data1.length; i++) {
						$('#subcategory').append(
								$("<option></option>").attr("value", data1[i])
										.text(data1[i]));
					}
				});
	}
</script>

<script>
	function getInnerSubCategory(subCategory) {
		$.ajax({
			url : "/getInnerSubCategory",
			data : {
				subCategory : subCategory
			}
		}).done(
				function(data) {
					$('#innersubcategory option').remove();
					$('#innersubcategory').append(
							$("<option></option>").attr("value", "0").text(
									"Select Inner SubCategory"));
					var data1 = data.split(",");
					for (var i = 0; i < data1.length; i++) {
						$('#innersubcategory').append(
								$("<option></option>").attr("value", data1[i])
										.text(data1[i]));
					}
				});
	}
</script>
<script type="text/javascript">
	function redirectPost() {
		location.href = "/postyourbook";
	}
</script>
<style type="text/css">
.bluestar {
	color: #008DDF;
	background: #fff;
}
</style>
</head>
<body>

	<!-- Google Tag Manager -->
	<noscript>
		<iframe src="//www.googletagmanager.com/ns.html?id=GTM-WBMHXT
"
			height="0" width="0" style="display: none; visibility: hidden"></iframe>
	</noscript>
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f)
;
})(window,document,'script','dataLayer','GTM-WBMHXT');</script>
	<!-- End Google Tag Manager -->


	<%
		HttpSession hs = request.getSession(false);
		String userid = (String) hs.getAttribute("userid");
		String username = (String) hs.getAttribute("username");

		List<Category> catList = (List<Category>) request
				.getAttribute("listCategory");

		 pm = PMF.get().getPersistenceManager();
		 q = pm.newQuery(Location.class);
		q.setOrdering("locationName");
		List<Location> locList = (List<Location>) q.execute();
	%>
	<header id="header"><!--header-->
	<div class="header_top">
		<!--header_top-->
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<div class="contactinfo">
						<ul class="nav nav-pills">
							<li><a href="/index"> <i class="fa fa-home fa-fw"
									aria-hidden="true"></i> Home
							</a></li>
							<li><a href="#selectLocation" data-toggle="modal"> <i
									class="fa fa-map-marker fa-fw" aria-hidden="true"></i> Select
									City
							</a></li>
						</ul>



					</div>
				</div>
				<div class="col-sm-6">
					<div class="social-icons pull-right">
						<ul class="nav navbar-nav">
							<li><a target="_blank"
								href="https://www.facebook.com/NayaPuranaa"><i
									class="fa fa-facebook"></i></a></li>
							<li><a target="_blank"
								href="https://twitter.com/NayaPuranaa"><i
									class="fa fa-twitter"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/header_top-->

	<div class="header-middle">
		<!--header-middle-->
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
					<div class="logo pull-left">
						<a href="/index"><img src="/images/logoedit.png" alt="" /></a>
					</div>

					<!--BUTTON GROUP CSS Same  <div class="btn-group pull-right">
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle usa"
								data-toggle="dropdown">
								yo <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
							<li><a href="/profile"> Profile </a></li>
								<li><a href="/yourposts"> Your Posts </a></li>
							</ul>
						</div>
					</div> -->
				</div>
				<div class="col-sm-8">
					<div class="shop-menu pull-right">
						<ul class="nav navbar-nav">
							<li><a href="/wishlist"> <%
 	if (userid != null) {
 		pm = PMF.get().getPersistenceManager();
 		q = pm.newQuery(Wishlist.class);
 		q.setFilter("userId==userid");
 		q.declareParameters("String userid");
 		List<Wishlist> res = (List<Wishlist>) q.execute(userid);
 		if (res.size() < 1) {
 %> <i id="bluestar" class="fa fa-star"></i>Wishlist <%
 	} else {
 %> <span class="fa-stack fa-1x"> <i id="bluestar"
										class="fa fa-fw fa-star bluestar fa-stack-1x"></i> <strong
										class="fa-stack-1x star bluestar-text-info"
										style="font-width: 8px; color: white; font-size: 8px;"><%=res.size()%></strong>
								</span> Wishlist <%
									}
									} else {
								%> <i id="bluestar" class="fa fa-star"></i>Wishlist <%
 	}
 %></a></li>
							<li><a href="/contact-us/add"><i class="fa fa-phone"></i>
									Contact Us</a></li>
							<li><a href="/postyourbook"><i
									class="fa fa-arrow-circle-o-right"></i> Post Your Book</a></li>

							<li>
								<%
									if (userid != null) {
								%> <!-- Split button -->
								<div class="btn-group">
									<button type="button" class="btn btn-info">
										<i class="fa fa-user"></i> &nbsp;
										<%=username%></button>
									<button type="button" class="btn btn-info dropdown-toggle"
										data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false">
										<span class="caret"></span> <span class="sr-only">Toggle
											Dropdown</span>
									</button>
									<ul class="dropdown-menu">
										<li><a href="/profile"><i
												class="glyphicon glyphicon-user"></i> Profile</a></li>
										<li><a href="/yourposts"> <i
												class="glyphicon glyphicon-list"></i> Your Posts
										</a></li>
										<li><a href="/resetpassword"><i
												class="glyphicon glyphicon-refresh"></i> Reset Password </a></li>
										<li role="separator" class="divider"></li>
										<li><a href="/logout"><i
												class="glyphicon glyphicon-off"></i> Logout</a></li>
									</ul>
								</div> <%
 	} else {
 %> <a href="/login"><i class="fa fa-lock"></i> Login / SignUp</a> <%
 	}
 %>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/header-middle-->

	<div class="header-bottom">
		<!--header-bottom-->
		<div class="container">
			<div class="row">
				<div class="col-sm-9">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
					</div>
					<div class="mainmenu pull-left">
						<ul class="nav navbar-nav collapse navbar-collapse">
							<%
								pm = PMF.get().getPersistenceManager();
								q = pm.newQuery(Category.class);
								List<Category> results = null;
								try {
									results = (List<Category>) q.execute();
									q = pm.newQuery(SubCategory.class);
									q.setFilter("categoryId == nameParameter");
									q.setOrdering("name");
									q.declareParameters("String nameParameter");
									for (Category cat : results) {
							%>
							<li class="dropdown"><a
								href="catlist?name=<%=cat.getName()%>"><%=cat.getName()%> <i
									class="fa fa-angle-down"></i></a>
								<ul role="menu" class="sub-menu">
									<%
										List<SubCategory> subcatList = (List<SubCategory>) q
														.execute(cat.getName());
												for (SubCategory subcat : subcatList) {
									%>
									<li><a href="subcatlist?name=<%=subcat.getName()%>"><%=subcat.getName()%></a></li>
									<%
										}
									%>
								</ul></li>
							<%
								}
								} finally {
									q.closeAll();
									//pm.close();
								}
							%>
						</ul>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="search_box pull-right">
						<form action="search" method="get">
							<input type="text" id="hint" name="hint" placeholder="Search" />
						</form>
					</div>
				</div>


				<div id="selectLocation" class="modal fade" role="dialog">
					<div class="modal-dialog modal-sm">
						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 align="center" class="modal-title">Select Your City</h4>
							</div>
							<div class="modal-body">
								<div class="status alert alert-success" style="display: none"></div>
								<form action="#" method="post" id="main-contact-form"
									class="contact-form row">
									<div class="ui-widget form-group col-md-12">
										<select name="enterLocation" id="enterLocation"
											class="form-control">
											<option value="0">Select Your City</option>
											<option value="">All</option>
											<%
												for (Location loc : locList) {
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
													if(loc.getLocationName().equals(location)){%>
												<option selected="selected" value="<%=loc.getLocationName()%>">
												<%=loc.getLocationName()%></option>
												
												<%		System.out.println(location);
													}else{
											%>



											<option value="<%=loc.getLocationName()%>">
												<%=loc.getLocationName()%></option>
											<%
												}}
											%>
										</select>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-info" onclick="setLocation()">Save changes</button>
							</div>
						</div>

					</div>
				</div>

			</div>
		</div>
	</div>
	<!--/header-bottom--> </header>
	<!--/header-->

</body>
</html>