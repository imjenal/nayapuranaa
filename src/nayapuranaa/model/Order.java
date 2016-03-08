package nayapuranaa.model;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
@PersistenceCapable(detachable="true")
public class Order {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key orderId;
	
	@Persistent
	private String userMailId;
	
	@Persistent
	private Date orderDate;
	
	@Persistent
	private String totalPrice;
	
@Persistent
private boolean paidStatus;

public Key getOrderId() {
	return orderId;
}

public void setOrderId(Key orderId) {
	this.orderId = orderId;
}

public String getUserMailId() {
	return userMailId;
}

public void setUserMailId(String userMailId) {
	this.userMailId = userMailId;
}

public Date getOrderDate() {
	return orderDate;
}

public void setOrderDate(Date orderDate) {
	this.orderDate = orderDate;
}

public String getTotalPrice() {
	return totalPrice;
}

public void setTotalPrice(String totalPrice) {
	this.totalPrice = totalPrice;
}

public boolean isPaidStatus() {
	return paidStatus;
}

public void setPaidStatus(boolean paidStatus) {
	this.paidStatus = paidStatus;
}
	
}
