<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Category | NayaPuranaa</title>
</head>
<body>
	Category :
	<a target="_blank" href="/category/add">Add</a> | |
	<a target="_blank" href="/category/list">List</a>
	 <br>
	SubCategory :
	<a target="_blank" href="/subcategory/add">Add</a> | |
	<a target="_blank" href="/subcategory/list">List</a>
	 <br>
	InnerSubCategory :
	<a target="_blank" href="/innersub/add">Add</a> | |
	<a target="_blank" href="/innersub/list">List</a>
	 <br><br>
	College :
	<a target="_blank" href="/college/add">Add</a> | |
	<a target="_blank" href="/college/list">List</a>
	<br>
	<hr>
	<h1> Add Category</h1>
	<form method="post" action="add">
		<table>
			<tr>
				<td>Category :</td>
				<td><input type="text" style="width: 185px;" name="name" id="name" />
				</td>
			</tr>
		</table>
		<input type="submit" class="save" title="Save" value="Add" />
	</form>
</body>
</html>