package com.poly.dao;

import java.util.List;

import com.poly.entity.Users;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import com.poly.utils.XJPA;

public class UsersDAOImpl implements UsersDAO{
	EntityManager em = XJPA.getEntityManager();
	@Override
	protected void finalize() throws Throwable {
		em.close();
	}
	
	@Override
	public List<Users> findAll() {
		TypedQuery<Users> query = em.createNamedQuery("Users.findAll", Users.class);
	    return query.getResultList();
	}

	@Override
	public Users findById(String id) {
		return em.find(Users.class, id);
	}

	@Override
	public Users findByIdOrEmail(String idOrEmail) {
		TypedQuery<Users> query = em.createNamedQuery("Users.findByIdOrEmail", Users.class);
		 query.setParameter("idOrEmail", idOrEmail);
		 List<Users> results = query.getResultList();
		 return results.isEmpty() ? null : results.get(0);
	}

	@Override
	public void create(Users user) {
		try {
			em.getTransaction().begin();
			em.persist(user);
			em.getTransaction().commit();
			System.out.println("Add user successfull!");
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
			System.out.println("Error");
		}
	}

	@Override
	public void update(Users user) {
		try {
			em.getTransaction().begin();
			em.merge(user);
			em.getTransaction().commit();
			System.out.println("Update user successfull!");
		} catch (Exception e) {
			em.getTransaction().rollback();
			System.out.println("Error");
		}
	}

	@Override
	public void deleteById(String id) {
		Users entity = em.find(Users.class, id);
	    if (entity != null) {  // Kiểm tra xem đối tượng có tồn tại không
	        try {
	            em.getTransaction().begin();
	            em.remove(entity);
	            em.getTransaction().commit();
	            System.out.println("User with ID " + id + " delete.");
	        } catch (Exception e) {
	            em.getTransaction().rollback();
	            // Có thể thêm log lỗi ở đây nếu cần
	        }
	    } else {
	        // Xử lý trường hợp không tìm thấy đối tượng với id đã cho
	        System.out.println("User with ID " + id + " not found."); // Hoặc ném ngoại lệ
	    }
	}

}
