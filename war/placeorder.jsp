<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cart Details | Apni Dukan Online</title>
	<script type='text/javascript'>
						function removeProduct(pro){
							//alert('sfjl');
							  var cook=readCookie().split(',');
							 eraseCookie();
							 	var ncook="";
							 	//alert(cook.length);

								//ncook+=cook[0];
							 	for(var i=0;i<cook.length-1;i++){
							 	//	alert(cook[i]);
									if(cook[i]!=pro){
										//alert('create');
										//if(i==0){
											//ncook+=cook[i];
										//}else{
											//ncook+=","+cook[i];
										//}
										createCookie1(cook[i]+",",7);
									} 
									
								}
							 	location.href="";
							//alert(pro+"  ,  "+ncook);
						}
	</script>
<script type="text/javascript">
function fillorder(){
	
	var cooky=readCookie();
     $.ajax({
	        url: "/cart/placeorder",
	        data: {
	            productid : cooky
	            }
	    })
	    .success (function(response) 
	    		{ 
	    			$(".order-details").html(response);
	    			getTotal();
	    		})
	    .error   (function()     {  });

getTotal();

//alert('sd');
}
</script>
<script type="text/javascript">
function getTotal(){
	var count=0;
	count=document.getElementById('counter').value;
	//alert(count);
	var total=0;
	var quant=0;
	var price=0;
	for(var i=1;i<=count;i++){
		//alert("sdfs");
		quant=document.getElementById(i+"quantity").value;
		price=document.getElementById(i+"price").value;
		total=total+(quant*price);
	//	alert(quant);
	}
var tot=	document.getElementById('total');
tot.value='Rs. '+total;




var grand=document.getElementById('gtotal');
var del=document.getElementById('delivery');
if(total>=500){
//	alert('500');
	del.value="Rs. 0";
	grand.value="Rs."+(total);
}else if(total>=250){
		//alert('250');
		del.value="Rs. 25";
		grand.value="Rs."+(total+25);
	}
else{
//	alert('0');
	del.value="Rs. 50";
	grand.value="Rs."+(total+50);
}

$('#fullhtml').html($('.order-details').html());
//alert($('#fullhtml').text());
}

</script>
</head>
<%
HttpSession hs=request.getSession(false);
if(hs.getAttribute("userid")!=null){
}
else{
	response.sendRedirect("/userlogin");
}
%>
<body onload="fillorder()">
<div class="wrap">
	<jsp:include page="header.jsp" />
 <div class="main">
    <div class="content">
<form action='confirmorder' method='post'>
    	<div class="order-details">
    	
    	</div>
    	  	<textarea style="display: none;" id="fullhtml" name="fullhtml" ></textarea>
  </form>  </div>
 </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>