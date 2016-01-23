<%@page import="javax.jdo.Query"%>
<%@page import="nayapuranaa.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="nayapuranaa.model.InnerSubCategory"%>
<%@page import="java.security.KeyStore"%>
<%@page import="java.util.List"%>
<%@page import="nayapuranaa.model.SubCategory"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="nayapuranaa.model.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update InnerSubCategory</title>
</head>
<body>
	<h1>Update InnerSubCategory</h1>
	<%PersistenceManager pm = PMF.get().getPersistenceManager();
	Query q = pm.newQuery(SubCategory.class);
	List<SubCategory> catlist = null;
	try {
		catlist = (List<SubCategory>) q.execute();
		InnerSubCategory scat = new InnerSubCategory();
		if(request.getAttribute("innersubcategory")!=null){
			scat = (InnerSubCategory)request.getAttribute("innersubcategory");
		}
	%>
	<form method="post" action="../update">
		<input type="hidden" name="key" id="key"
			value="<%=KeyFactory.keyToString(scat.getInnerSubCategoryId()) %>" />
		<table>
			<tr>
				<td>Select Category :</td>
				<td><select style="width: 185px;" name="subcategory"
					id="subcategory">
						<%
					for(SubCategory cat:catlist){
					%>
						<option value="<%=cat.getName() %>"><%=cat.getName() %></option>
						<%} %>
				</select></td>
			</tr>
			<tr>
				<td>SubCategoryName :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="name" id="name" value="<%=scat.getName() %>" /></td>
			</tr>

		</table>
		<input type="submit" class="update" title="Update" value="Update" />
	</form>
	<%}catch(Exception e){}finally{
		pm.close();
		q.closeAll();
	} %>
</body>
</html>