package com.poly.dao;

import java.util.List;

import com.poly.entity.Users;

public interface UsersDAO {
	List<Users> findAll();
    Users findById(String id);
    Users findByIdOrEmail(String idOrEmail);
    void create(Users user);
    void update(Users user);
    void deleteById(String id);
}
