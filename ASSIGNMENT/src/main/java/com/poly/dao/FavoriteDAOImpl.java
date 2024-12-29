package com.poly.dao;

import java.util.List;

import com.poly.entity.Favorite;
import com.poly.entity.Users;
import com.poly.entity.Video;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import com.poly.utils.XJPA;

public class FavoriteDAOImpl implements FavoriteDAO{
	EntityManager em = XJPA.getEntityManager();
	@Override
	protected void finalize() throws Throwable {
		em.close();
	}
	
	@Override
	public List<Favorite> findAll() {
		String jpql = "SELECT f FROM Favorite f";
		TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
		return query.getResultList();
	}

	@Override
	public Favorite findById(Long id) {
		return em.find(Favorite.class, id);
	}

	@Override
	public void create(Favorite favorite) {
		try {
			em.getTransaction().begin();
			em.persist(favorite);
			em.getTransaction().commit();
			System.out.println("Add favorite video successfull!");
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
			System.out.println("Error while adding favorite video");
		}
	}

	@Override
	public void update(Favorite favorite) {
		try {
			em.getTransaction().begin();
			em.merge(favorite);
			em.getTransaction().commit();
			System.out.println("Update favorite video successfull!");
		} catch (Exception e) {
			em.getTransaction().rollback();
			System.out.println("Error while updating favorite video");
		}
	}

	@Override
	public void deleteById(Long id) {
		Favorite entity = em.find(Favorite.class, id);
	    if (entity != null) {
	        try {
	            em.getTransaction().begin();
	            em.remove(entity);
	            em.getTransaction().commit();
	            System.out.println("Favorite video with ID " + id + " delete.");
	        } catch (Exception e) {
	            em.getTransaction().rollback();
	            e.printStackTrace();
                System.out.println("Error while deleting favorite video");
	        }
	    } else {
	        System.out.println("Favorite video with ID " + id + " not found.");
	    }
	}

	@Override
	public List<Object[]> findUsersByVideoId(String videoId) {
		// Truy vấn người dùng đã thích video
		String sql = "SELECT u.id, u.fullname, u.email, f.likeDate " +
	             "FROM Favorite f " +
	             "JOIN f.user u " +
	             "WHERE f.video.id = :videoId";
	   TypedQuery<Object[]> query = em.createQuery(sql, Object[].class);
	   query.setParameter("videoId", videoId);
	   return query.getResultList();
	}

	@Override
	public Favorite findFavoriteByUserAndVideo(String userId, String videoId) {
		String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId AND f.video.id = :videoId";
	    try {
	        return em.createQuery(jpql, Favorite.class)
	                 .setParameter("userId", userId)
	                 .setParameter("videoId", videoId)
	                 .getSingleResult();
	    } catch (Exception e) {
	        return null; // Trả về null nếu không tìm thấy
	    }	
	}
}
