package nayapuranaa.dao;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import org.springframework.stereotype.Component;

import nayapuranaa.PMF;
import nayapuranaa.model.Product;

@Component
public class ProductDaoImpl implements ProductDao {

	@Override
	public Product getProductById(String productId) {
		PersistenceManager pm = null;
		Product object = null;
		try {
			pm = PMF.get().getPersistenceManager();
			object = pm.getObjectById(Product.class, productId);
			object = pm.detachCopy(object);
		} catch (JDOObjectNotFoundException e) {
			return null; // or whatever
		} finally {
			pm.close(); // close here
		}
		return object;
	}

	@Override
	public List<Product> getProductListByLocation(String location) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter");
		q.declareParameters("String nameParameter");
		q.setOrdering("date desc");
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<Product> getProductListByLocationByRange(String location,
			int pos, int quantity) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter");
		q.declareParameters("String nameParameter");
		q.setOrdering("date desc");
		q.setRange(pos, quantity);
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<Product> getProductListBySubCategoryByRange(String location,
			String category, int pos, int quantity) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter && subCategory==categoryParam");
		q.declareParameters("String nameParameter,String categoryParam");
		q.setOrdering("date desc");
		q.setRange(pos, quantity);
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location, category);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<Product> getProductListBySubCategory(String location,
			String category) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter && subCategory==categoryParam");
		q.declareParameters("String nameParameter,String categoryParam");
		q.setOrdering("date desc");
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location, category);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<Product> getProductListByInnerSubCategoryByRange(
			String location, String category, int pos, int quantity) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter && innerSubCategory==categoryParam");
		q.declareParameters("String nameParameter,String categoryParam");
		q.setOrdering("date desc");
		q.setRange(pos, quantity);
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location, category);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
		}
		return results;
	}

	@Override
	public List<Product> getProductListByInnerSubCategory(String location,
			String category) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter && innerSubCategory==categoryParam");
		q.declareParameters("String nameParameter,String categoryParam");
		q.setOrdering("date desc");
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location, category);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<Product> getProductListByCategoryByRange(String location,
			String category, int pos, int quantity) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter && category==categoryParam");
		q.declareParameters("String nameParameter,String categoryParam");
		q.setOrdering("date desc");
		q.setRange(pos, quantity);
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location, category);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<Product> getProductListByCategory(String location,
			String category) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		if (location != null && location != "")
			q.setFilter("location == nameParameter && category==categoryParam");
		q.declareParameters("String nameParameter,String categoryParam");
		q.setOrdering("date desc");
		List<Product> results = new ArrayList<Product>();
		try {
			results = (List<Product>) q.execute(location, category);
			results = (List<Product>) pm.detachCopyAll(results);
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

}
