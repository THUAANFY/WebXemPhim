package com.poly.dao;

import java.util.List;

import com.poly.entity.Share;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import com.poly.utils.XJPA;

public class ShareDAOImpl implements ShareDAO{
	EntityManager em = XJPA.getEntityManager();
	@Override
	protected void finalize() throws Throwable {
		em.close();
	}
	
	@Override
	public List<Share> findAll() {
		TypedQuery<Share> query = em.createNamedQuery("Share.findAll", Share.class);
	    return query.getResultList();
	}

	@Override
	public Share findById(Long id) {
		return em.find(Share.class, id);
	}

	@Override
	public void create(Share share) {
		try {
            em.getTransaction().begin();
            em.persist(share);
            em.getTransaction().commit();
            System.out.println("Add share successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("Error");
        }
	}

	@Override
	public void update(Share share) {
		try {
            em.getTransaction().begin();
            em.merge(share);
            em.getTransaction().commit();
            System.out.println("Update share successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.out.println("Error");
        }
	}

	@Override
	public void deleteById(Long id) {
		Share entity = em.find(Share.class, id);
        if (entity != null) {
            try {
                em.getTransaction().begin();
                em.remove(entity);
                em.getTransaction().commit();
                System.out.println("Share with ID " + id + " deleted.");
            } catch (Exception e) {
                em.getTransaction().rollback();
            }
        } else {
            System.out.println("Share with ID " + id + " not found.");
        }
	}

	@Override
	public List<Object[]> findShareDetailsByVideoId(String videoId) {
		TypedQuery<Object[]> query = em.createNamedQuery("Share.findShareDetailsByVideoId", Object[].class);
        query.setParameter("videoId", videoId); // Truyền videoId vào query
        return query.getResultList();
	}

}
