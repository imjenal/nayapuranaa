package nayapuranaa.dao;

import java.util.List;

import nayapuranaa.model.Product;

public interface ProductDao {
	public Product getProductById(String productId);

	public List<Product> getProductListByLocation(String location);

	public List<Product> getProductListByLocationByRange(String location,
			int pos, int quantity);

	public List<Product> getProductListByCategoryByRange(String location,
			String category, int pos, int quantity);

	public List<Product> getProductListByCategory(String location,
			String category);

	public List<Product> getProductListBySubCategoryByRange(String location,
			String category, int pos, int quantity);

	public List<Product> getProductListBySubCategory(String location,
			String category);

	public List<Product> getProductListByInnerSubCategoryByRange(
			String location, String category, int pos, int quantity);

	public List<Product> getProductListByInnerSubCategory(String location,
			String category);

}
