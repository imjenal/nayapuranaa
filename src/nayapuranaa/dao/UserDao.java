package nayapuranaa.dao;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import nayapuranaa.model.User;

public interface UserDao {

	public User getUserByEmail(String email);
}
