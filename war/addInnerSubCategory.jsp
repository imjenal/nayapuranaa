<%@page import="nayapuranaa.model.InnerSubCategory"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.SpecialCategory"%>
<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@page import="java.util.List"%>
<%@ page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add InnerSubCategory| NayaPuranaa</title>
</head>
<body>
<%
List<SubCategory> catlist=(List<SubCategory>)request.getAttribute("listCategory");
%>
	<jsp:include page="header.jsp"/>
	<div id="contact-page" class="container">
		<div class="bg">
			<div class="row">
			<jsp:include page="leftsidebar.jsp"/>
				<div class="col-sm-8">
					<div class="contact-form">`
						<h2 class="title text-center">Add InnerSubCategory</h2>
						<form
							action="add" method="post" 
							id="main-contact-form" class="contact-form row">
							<div class="form-group col-md-6">
								<select name="subcategory" id="subcategory">
									<option value="0">Select SubCategory</option>
									<%
										for (SubCategory cat : catlist) {
									%>
									<option value="<%=cat.getName()%>"><%=cat.getName()%></option>
									<%
										}
									%>
								</select>
							</div>
							<div class="form-group col-md-6">
								<input type="text" name="name" id="name"
									class="form-control" required="required"
									placeholder="InnerSubCategory" />
							</div>
							<div class="form-group col-md-12">
								<input type="submit" name="submit"
									class="btn btn-primary pull-right" value="Add">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp"/>
</body>
</html>