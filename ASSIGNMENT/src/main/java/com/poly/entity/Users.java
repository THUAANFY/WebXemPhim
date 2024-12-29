package com.poly.entity;

import java.util.List;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//@Data
//@NoArgsConstructor
//@AllArgsConstructor
//@Builder

@Entity
@Table(name = "Users")
@NamedQueries({
    @NamedQuery(name = "Users.findAll", query = "SELECT u FROM Users u"),
    @NamedQuery(name = "Users.findByIdOrEmail", query = "SELECT u FROM Users u WHERE u.id = :idOrEmail OR u.email = :idOrEmail")
})
public class Users {
	@Id
	private String id;
	private String password;
	private String email;
	private String fullname;
	private Boolean admin;
//	@OneToMany(mappedBy = "user")
//	private List<Favorite>favorite;
	
	public Users() {
		super();
	}

//	public Users(String id, String password, String email, String fullname, Boolean admin, List<Favorite> favorite) {
	public Users(String id, String password, String email, String fullname, Boolean admin) {
		super();
		this.id = id;
		this.password = password;
		this.email = email;
		this.fullname = fullname;
		this.admin = admin;
//		this.favorite = favorite;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}

//	public List<Favorite> getFavorite() {
//		return favorite;
//	}
//
//	public void setFavorite(List<Favorite> favorite) {
//		this.favorite = favorite;
//	}
	
	
}
