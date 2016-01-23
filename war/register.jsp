<!DOCTYPE HTML>
<head>
<title>Login | Apni Dukan Online</title>
<script type="text/javascript">
function checkExist(mail){
	//alert('dsgj');
	$.ajax({
	    url: "/user/checkexist",
	    data: {
	        email : mail,
	        }
	})
	.success (function(response) 
			{ 
				if(response=="1"){
					$('#existres').html('User already exist');
					$("#save").prop("disabled", true);
				}else{
					$('#existres').html('');
					$("#save").prop("disabled", false);
				}
				})
	.error   (function()     {  });
}
</script>
</head>
<body>
  <div class="wrap">
	<jsp:include page="header.jsp" />
 <div class="main">
    <div class="content">
    
					<form method="post" action="/user/addfororder">
		<table  class='table ' style="margin:0px auto;width:60%;">
			
			<tr>
				<td><label class="control-label">Email </label></td>
				<td><div class="controls"><input class="form-control" onblur='checkExist(this.value)'   type="email" required="required" style="width: 185px;" maxlength="30"
					name="email" id="email" /><label id='existres' style="color:red;"></label><br>(for eg. example@mail.com)</div></td>
			</tr>
			<tr>
				<td><label class="control-label">Mobile No </label></td>
				<td><div class="controls"><input class="form-control"    type="text" required="required" style="width: 185px;" maxlength="30"
					name="mobile" id="mobile" />(for eg. 9594658421,9895968746.)<label id='existres' ></label></div></td>
			</tr>
			<tr>
				<td><label class="control-label">Password </label></td>
				<td><div class="controls"><input class="form-control"   type="password" required="required" style="width: 185px;" maxlength="30" 
					name="password" id="password" /></div></td>
			</tr>
			<tr>
				<td><label class="control-label">Full Name </label></td>
				<td><div class="controls"><input class="form-control"  required="required" type="text" style="width: 185px;" maxlength="45"
					name="name" id="name" /></div></td>
			</tr>
			<tr>
				<td><label class="control-label">Address </label></td>
				<td><div class="controls"><textarea class="form-control"  required="required" style="width:300px;height: 80px;"
					name="address" id="address" ></textarea>
					</div></td>
			</tr>
			<tr>
				<td><label class="control-label">PinCode </label></td>
				<td><div class="controls"><input class="form-control"  required="required" type="text" style="width: 185px;" name="pincode" id="pincode" />
					</div>
					</td>
			</tr>
			<tr>
				<td><label class="control-label">Landmark</label></td>
				<td><div class="controls"><input class="form-control"  type="text" style="width: 185px;" maxlength="30"
					name="landmark" id="landmark" /></div></td>
			</tr>
			<tr>
				<td><label class="control-label">City </label></td>
				<td>
				<input  name="city" id="city" type="text" readonly="readonly" class="form-control"  style="width: 185px;" value="Lucknow" />
				<!-- <div class="controls">
					<select style="width: 185px;" name="city" id="city" >
					<option>Lucknow</option>
					</select></div> -->
				</td>
			</tr>
			<tr ><td colspan="2"><input class="btn btn-primary" type="submit" id="save"  title="Save" value="Save" />
			</td></tr>
		</table>
		
	</form>
				</div>	
				</div></div>
       <div class="clear"></div>

   <jsp:include page="footer.jsp" /></body>
</html>

