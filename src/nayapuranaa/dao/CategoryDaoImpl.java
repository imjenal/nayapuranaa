package nayapuranaa.dao;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import nayapuranaa.PMF;
import nayapuranaa.model.Category;
import nayapuranaa.model.Product;
import nayapuranaa.model.SubCategory;

@Component
public class CategoryDaoImpl implements CategoryDao {

	@Override
	public Category getCategoryById(String CategoryId) {
		PersistenceManager pm = null;
		Category object = null;
		try {
			pm = PMF.get().getPersistenceManager();
			object = pm.getObjectById(Category.class, CategoryId);
			object = pm.detachCopy(object);
		} catch (JDOObjectNotFoundException e) {
			return null; // or whatever
		} finally {
			pm.close(); // close here
		}
		return object;
	}

	@Override
	public List<Category> getCategoryList() {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		List<Category> results = new ArrayList<Category>();
		try {
			results = (List<Category>) q.execute();
			results = (List<Category>) pm.detachCopyAll(results);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<SubCategory> getSubCategoryListByCat(String category) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		q = pm.newQuery(SubCategory.class);
		List<SubCategory> results = null;
		try {
			q = pm.newQuery(SubCategory.class);
			q.setFilter("categoryId == nameParameter");
			q.setOrdering("name");
			q.declareParameters("String nameParameter");
			results = (List<SubCategory>) q.execute(category);
			results = (List<SubCategory>) pm.detachCopyAll(results);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

	@Override
	public List<SubCategory> getSubCategoryList() {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(Product.class);
		q = pm.newQuery(SubCategory.class);
		List<SubCategory> results = null;
		try {
			q = pm.newQuery(SubCategory.class);
			results = (List<SubCategory>) q.execute();
			results = (List<SubCategory>) pm.detachCopyAll(results);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			q.closeAll();
			pm.close();

		}
		return results;
	}

}
