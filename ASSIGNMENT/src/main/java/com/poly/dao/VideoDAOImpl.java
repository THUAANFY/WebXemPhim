package com.poly.dao;

import java.util.List;

import com.poly.entity.Video;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import com.poly.utils.XJPA;

public class VideoDAOImpl implements VideoDAO{
	EntityManager em = XJPA.getEntityManager();
	@Override
	protected void finalize() throws Throwable {
		em.close();
	}
	
	@Override
	public List<Video> findAll() {
		TypedQuery<Video> query = em.createNamedQuery("Video.findAll", Video.class);
        return query.getResultList();
	}

	@Override
	public Video findById(String id) {
		return em.find(Video.class, id);
	}

	@Override
	public void create(Video video) {
		try {
			em.getTransaction().begin();
			em.persist(video);
			em.getTransaction().commit();
			System.out.println("Add video successfull!");
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
			System.out.println("Error");
		}
	}

	@Override
	public void update(Video video) {
		try {
			em.getTransaction().begin();
			em.merge(video);
			em.getTransaction().commit();
			System.out.println("Update video successfull!");
		} catch (Exception e) {
			em.getTransaction().rollback();
			System.out.println("Error");
		}
	}

	@Override
	public void deleteById(String id) {
		Video entity = em.find(Video.class, id);
	    if (entity != null) {
	        try {
	            em.getTransaction().begin();
	            em.remove(entity);
	            em.getTransaction().commit();
	            System.out.println("Video with ID " + id + " delete.");
	        } catch (Exception e) {
	            em.getTransaction().rollback();
	        }
	    } else {
	        System.out.println("Video with ID " + id + " not found.");
	    }
	}

	@Override
	public List<Object[]> findAllWithLikeCount() {
		TypedQuery<Object[]> query = em.createNamedQuery("Video.findAllWithLikeCount", Object[].class);
        return query.getResultList();
	}

	@Override
	public List<Object[]> findByTitleWithLikeCount(String title) {
		TypedQuery<Object[]> query = em.createNamedQuery("Video.findByTitleWithLikeCount", Object[].class);
        query.setParameter("title", "%" + title + "%");
        return query.getResultList();
	}

	@Override
	public List<Video> findAllActive() {
		TypedQuery<Video> query = em.createNamedQuery("Video.findAllActive", Video.class);
        return query.getResultList();
	}

	@Override
	public List<Video> findLikedVideosByUserId(String userId) {
		TypedQuery<Video> query = em.createNamedQuery("Video.findLikedVideosByUserId", Video.class);
	    query.setParameter("userId", userId);
	    return query.getResultList();
	}

}
