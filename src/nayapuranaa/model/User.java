package nayapuranaa.model;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;
import javax.jdo.annotations.Unique;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class User {
	@PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key userId;

	@Persistent
    private String userName;
	
	@Persistent
	@Unique(name="email")
    private String email;
	
	@Persistent
	private String password;
	
	@Persistent
    private String address;
	
	@Persistent
    private String pincode;

	@Persistent
    private String landmark;
	
	public String getFbprofile() {
		return fbprofile;
	}

	public void setFbprofile(String fbprofile) {
		this.fbprofile = fbprofile;
	}

	@Persistent
    private String mobile;
	
	@Persistent
    private String fbprofile;
	
	@Persistent
    private String city;
	
	@Persistent
    private Date date;

	@Persistent
	private String college;
	
	@Persistent
    private String referral;
	
	@Persistent
	private String passwordResetCode;
	
	
	public String getPasswordResetCode() {
		return passwordResetCode;
	}

	public void setPasswordResetCode(String passwordResetCode) {
		this.passwordResetCode = passwordResetCode;
	}

	public String getReferral() {
		return referral;
	}

	public void setReferral(String referral) {
		this.referral = referral;
	}

	public String getCollege() {
		return college;
	}

	public void setCollege(String college) {
		this.college = college;
	}
	
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getLandmark() {
		return landmark;
	}

	public void setLandmark(String landmark) {
		this.landmark = landmark;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Key getUserId() {
		return userId;
	}

	public void setUserId(Key userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}


}
