package nayapuranaa.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import nayapuranaa.PMF;
import nayapuranaa.model.User;

@Service
@Component
public class UserDaoImpl implements UserDao {

	@Override
	public User getUserByEmail(String email) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery(User.class);
		q.setFilter("email == nameParameter");
		q.declareParameters("String nameParameter");
		List<User> results =null;
		try {
			results= (List<User>) q.execute(email);
		} finally {
		}
		return results.get(0);
	}

}
