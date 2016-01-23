<html>
<body>
	<h1>Add Customer</h1>

	<form method="post" action="add">
		<table>
			<tr>
				<td>UserName :</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="name" id="name" /></span></td>
			</tr>
			<tr>
				<td>Email :</td>
				<td><input type="email" required="required" style="width: 185px;" maxlength="30"
					name="email" id="email" /></span></td>
			</tr><tr>
				<td>Address :</td>
				<td><textarea 
					name="address" id="address" ></textarea></td>
			</tr>
			<tr>
				<td>PinCode :</td>
				<td><textarea 
					name="pincode" id="pincode" ></textarea></td>
			</tr>
			<tr>
				<td>Landmark</td>
				<td><input type="text" style="width: 185px;" maxlength="30"
					name="landmark" id="landmark" /></td>
			</tr>
			<tr>
				<td>City :</td>
				<td>
					<select style="width: 185px;" name="city" id="city" >
					<option>Lucknow</option>
					</select>
				</td>
			</tr>
		</table>
		<input type="submit" class="save" title="Save" value="Save" />
	</form>

</body>
</html>