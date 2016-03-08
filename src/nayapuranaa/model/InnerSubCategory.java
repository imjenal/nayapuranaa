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
public class InnerSubCategory {


	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key InnerSubCategoryId;
	
	@Persistent
	private String name;

	@Persistent
	private String subCategoryId;

	public Key getInnerSubCategoryId() {
		return InnerSubCategoryId;
	}

	public void setInnerSubCategoryId(Key innerSubCategoryId) {
		InnerSubCategoryId = innerSubCategoryId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubCategoryId() {
		return subCategoryId;
	}

	public void setSubCategoryId(String subCategoryId) {
		this.subCategoryId = subCategoryId;
	}
	
	

	
}
