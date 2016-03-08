<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.College"%>
<%@page import="nayapuranaa.model.User"%>
<%@page import="java.util.List"%>
<%@page import="javax.jdo.Query"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile | NayaPuranaa</title>
<script type="text/javascript">
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : evt.keyCode
    return !(charCode > 31 && (charCode < 48 || charCode > 57));
}
</script>
<script type="text/javascript">
	function editProfile() {
		$("#heading").text("Edit Profile");
		window.location = '#heading'
		$("#userName").attr("readonly", false);
		$("#phoneno").attr("readonly", false);
		$("#city").attr("readonly", false);
		$("#fbprofile").attr("readonly", false);
		$("#address").attr("readonly", false);
		$("#pincode").attr("readonly", false);
		$("#college").attr("disabled", false);
		$("#submit").attr("value", "Save");
		$("#submit").attr("onclick", "toSave()");
		//console.log(1);
	}
</script>
<script type="text/javascript">
	function toSave() {
		$("#submit").attr("type", "submit");
		//	console.log(2);
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<%
		HttpSession hs = request.getSession(false);
	    String userid = (String) hs.getAttribute("userid");
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(User.class);
		q.setFilter("email==emailid");
		q.declareParameters("String emailid");
		List<User> user = (List<User>) q.execute(userid);
		User user1 = user.get(0);
	%>
	<div id="contact-page" class="container">
		<div class="bg">
			<div class="row">
				<div class="col-sm-8">
					<div class="contact-form">
						<h2 id="heading" class="title text-center">Profile</h2>
						<div class="status alert alert-success" style="display: none"></div>
						<form method="post" action="/user/editProfile"
							class="contact-form row">
							<div class="form-group col-md-12">
								<input type="hidden" name="userId" id="userId"
									value="<%=KeyFactory.keyToString(user1.getUserId())%>" /> <input
									type="text" name="userName" id="userName" class="form-control"
									required="required" value="<%=user1.getUserName()%>"
									placeholder="Full Name" readonly="readonly" />
							</div>
							<div class="form-group col-md-6">
								<input type="email" name="email" id="email" class="form-control"
									required="required" placeholder="Email" readonly="readonly"
									value="<%=user1.getEmail()%>" />
							</div>
							
							<div class="form-group col-md-6">
								<%
									if (user1.getMobile() != null) {
								%>
								<input type="text" name="phoneno" id="phoneno"
									class="form-control"  onkeypress="return isNumberKey(event)" pattern="\d{10}" maxlength="10" required="required"
									placeholder="Contact Number" readonly="readonly"
									value="<%=user1.getMobile()%>" />
								<%
									} else {
								%>
								<input type="text" name="phoneno" id="phoneno"
									class="form-control" required="required"  pattern="\d{10}" maxlength="10"  onblur="return isNumberKey(event)"
									placeholder="Contact Number" readonly="readonly" />
								<%
									}
								%>
							</div>
							
							<div class="form-group col-md-12">
								<select name="college" id="college" style="height:43px;" disabled="disabled">
									<option value="0">Select College</option>
									<%
										q = pm.newQuery(College.class);
										q.setOrdering("collegeName");
										List<College> results = null;
										try {
											results = (List<College>) q.execute();
											for (College col : results) {
												if ((user1.getCollege() != null)
														&& (user1.getCollege().equals(col.getCollegeName()))||(user1.getCollege() != null)
														&& (user1.getCollege()==col.getCollegeName())) {
									%>
									<option selected="selected" value="<%=col.getCollegeName()%>">
										<%=col.getCollegeName()%>
									</option>
									<%
										} else {
									%>

									<option value="<%=col.getCollegeName()%>">
										<%=col.getCollegeName()%>
									</option>
									<%
										}
											}
										} finally {
											q.closeAll();
											pm.close();
										}
									%>
								</select>
							</div>
							
							<div class="form-group col-md-12">
								<%
									if (user1.getFbprofile() != null) {
								%>
								<input type="text" name="fbprofile" id="fbprofile" class="form-control"
									 placeholder="Facebook Profile Link (https://www.facebook.com/USERNAME/)" readonly="readonly"
									value="<%=user1.getFbprofile()%>"  pattern="http://www\.facebook\.com\/(.+)|https://www\.facebook\.com\/(.+)"  />
								<%
									} else {
								%>
								<input type="text" name="fbprofile" id="fbprofile" class="form-control"
									 placeholder="Facebook Profile Link (https://www.facebook.com/USERNAME/)" readonly="readonly"  pattern="http://www\.facebook\.com\/(.+)|https://www\.facebook\.com\/(.+)"  />
								<%
									}
								%>
							</div>
							
							<div class="form-group col-md-12">
								<%
									if (user1.getCity() != null) {
								%>
								<input type="text" name="city" id="city" class="form-control"
									required="required" placeholder="City" readonly="readonly"
									value="<%=user1.getCity()%>" />
								<%
									} else {
								%>
								<input type="text" name="city" id="city" class="form-control"
									required="required" placeholder="City" readonly="readonly" />
								<%
									}
								%>
							</div>
							<div class="form-group col-md-12">
								<%
									if (user1.getAddress() != null) {
								%>
								<input type="text" name="address" id="address"
									class="form-control" 
									placeholder="Communication Address" readonly="readonly"
									value="<%=user1.getAddress()%>" />
								<%
									} else {
								%>
								<input type="text" name="address" id="address"
									class="form-control" 
									placeholder="Communication Address" readonly="readonly" />
								<%
									}
								%>
							</div>

							<div class="form-group col-md-12">
								<%
									if (user1.getPincode() != null) {
								%>
								<input type="text" name="pincode" id="pincode"
									class="form-control"  placeholder="Pincode"
									readonly="readonly"  pattern="\d{6}" maxlength="6"   onblur="return isNumberKey(event)" value="<%=user1.getPincode()%>" />
								<%
									} else {
								%>
								<input type="text" name="pincode" id="pincode"
									class="form-control"  pattern="\d{6}" maxlength="6"   onblur="return isNumberKey(event)"  placeholder="Pincode"
									readonly="readonly" />
								<%
									}
								%>
							</div>
							<div class="form-group col-md-12">
								<input type="button" onclick="editProfile()" name="submit"
									id="submit" class="btn btn-primary pull-right"
									value="Edit Profile">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>