package nayapuranaa.model;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
@PersistenceCapable
public class CartItem {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key cartId;
	
	@Persistent
	private String userMailId;

	@Persistent
	private String productId;

	@Persistent
	private Integer quantity;
	
	@Persistent
	private Integer price;

	@Persistent
	private boolean status;
	
	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Key getCartId() {
		return cartId;
	}

	public void setCartId(Key cartId) {
		this.cartId = cartId;
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

	
}
