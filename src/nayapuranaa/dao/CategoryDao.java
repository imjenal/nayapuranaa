package nayapuranaa.dao;

import java.util.List;

import nayapuranaa.model.Category;
import nayapuranaa.model.SubCategory;

public interface CategoryDao {
	public Category getCategoryById(String CategoryId);

	public List<Category> getCategoryList();

	public List<SubCategory> getSubCategoryList();
	public List<SubCategory> getSubCategoryListByCat(String category);

	
}
