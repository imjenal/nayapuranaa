package nayapuranaa.model;

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
public class OrderedItems {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key orderedItemId;
	
	@Persistent
	private String userMailId;

	@Persistent
	private String productId;

	@Persistent
	private Integer quantity;

	@Persistent
	private Integer price;
	
	@Persistent
	private Integer cancelledprice;

	@Persistent
	private boolean status;

	public Key getOrderedItemId() {
		return orderedItemId;
	}

	public void setOrderedItemId(Key orderedItemId) {
		this.orderedItemId = orderedItemId;
	}

	public String getUserMailId() {
		return userMailId;
	}

	public void setUserMailId(String userMailId) {
		this.userMailId = userMailId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Integer getCancelledprice() {
		return cancelledprice;
	}

	public void setCancelledprice(Integer cancelledprice) {
		this.cancelledprice = cancelledprice;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	
	
}
