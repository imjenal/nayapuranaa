package nayapuranaa.model;

import java.util.Date;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;
import com.google.appengine.api.datastore.Key;
@PersistenceCapable
public class Wishlist {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key wishlistId;
	
	@Persistent
	private String productId;
	
	@Persistent
	private String userId;
	
	@Persistent
	private Date date;
	
/*
	@Persistent
	@OneToMany(mappedBy="category")
	private List<SubCategory> subcategories;
*/

	public Key getWishlistId() {
		return wishlistId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public void setWishlistId(Key wishlistId) {
		this.wishlistId = wishlistId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}


	/*public List<SubCategory> getSubcategories() {
		return subcategories;
	}

	public void setSubcategories(List<SubCategory> subcategories) {
		this.subcategories = subcategories;
	}*/
	
}
