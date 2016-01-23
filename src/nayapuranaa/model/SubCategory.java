package nayapuranaa.model;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;
import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class SubCategory {


	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key subCategoryId;
	
	@Persistent
	private String name;

	@Persistent
	private String categoryId;
	
	
	/*@Persistent
	@ManyToOne
	@JoinColumn(name="categoryId")
	private Category category;
	*/

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public Key getSubCategoryId() {
		return subCategoryId;
	}

	public void setSubCategoryId(Key subCategoryId) {
		this.subCategoryId = subCategoryId;
	}

	/*public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}*/

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
