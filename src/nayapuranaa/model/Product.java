package nayapuranaa.model;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class Product {
	
	@PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key productId;
	
	@Persistent
    private String userId;
	
	@Persistent
    private String productName;

	@Persistent
    private String description;

	@Persistent
    private String collegeName;
	
	@Persistent
    private Date date;
	
	@Persistent
	private String productImage;
	
	@Persistent
	private Date modificatioDate;

	@Persistent
	private int cancelledPrice;

	@Persistent
	private int price;
	
	@Persistent
	private int quantity;
	
	@Persistent
	private String category;

	@Persistent
	private String subCategory;

	@Persistent
	private String innerSubCategory;
	
	@Persistent
	private String specialCategory;
	
	@Persistent
	private String productDetails;
	
	@Persistent 
	private String contactperson;
	
	@Persistent
    private String email;
	
	@Persistent 
	private String phoneno;
	
	@Persistent 
	private String fbprofile;
	@Persistent 
	private String condition;
	
	@Persistent 
	private String publications;
	
	@Persistent 
	private String author;
	
	@Persistent 
	private String edition;
	
	@Persistent 
	private String type;

	@Persistent 
	private String otherDetails;
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getFbprofile() {
		return fbprofile;
	}

	public void setFbprofile(String fbprofile) {
		this.fbprofile = fbprofile;
	}

	public String getPhoneno() {
		return phoneno;
	}

	public void setPhoneno(String phoneno) {
		this.phoneno = phoneno;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getCollegeName() {
		return collegeName;
	}

	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getEdition() {
		return edition;
	}

	public void setEdition(String edition) {
		this.edition = edition;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublications() {
		return publications;
	}

	public void setPublications(String publications) {
		this.publications = publications;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getContactperson() {
		return contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public String getInnerSubCategory() {
		return innerSubCategory;
	}

	public void setInnerSubCategory(String innerSubCategory) {
		this.innerSubCategory = innerSubCategory;
	}

	public String getProductDetails() {
	return productDetails;
	}
	
	public void setProductDetails(String productDetails) {
		this.productDetails = productDetails;
	}
	
	public String getOtherDetails() {
		return otherDetails;
	}
	
	public void setOtherDetails(String otherDetails) {
		this.otherDetails = otherDetails;
	}

	public int getCancelledPrice() {
		return cancelledPrice;
	}

	public void setCancelledPrice(int cancelledPrice) {
		this.cancelledPrice = cancelledPrice;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}

	public String getSpecialCategory() {
		return specialCategory;
	}

	public void setSpecialCategory(String specialCategory) {
		this.specialCategory = specialCategory;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public Date getModificatioDate() {
		return modificatioDate;
	}

	public void setModificatioDate(Date modificatioDate) {
		this.modificatioDate = modificatioDate;
	}

	public Key getProductId() {
		return productId;
	}

	public void setProductId(Key productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
