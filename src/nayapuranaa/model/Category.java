package nayapuranaa.model;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;
import com.google.appengine.api.datastore.Key;
@PersistenceCapable
public class Category {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key categoryId;
	
	@Persistent
	private String name;
/*
	@Persistent
	@OneToMany(mappedBy="category")
	private List<SubCategory> subcategories;
*/
	public Key getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Key categoryId) {
		this.categoryId = categoryId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	/*public List<SubCategory> getSubcategories() {
		return subcategories;
	}

	public void setSubcategories(List<SubCategory> subcategories) {
		this.subcategories = subcategories;
	}*/
	
}
