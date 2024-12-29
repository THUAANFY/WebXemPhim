package com.poly.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJPA {
//	private static EntityManager em = null;
//	private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("Lab3");
//
//	public static EntityManager instance() {
//		if(em == null) {
//			em 	= factory.createEntityManager();
//		}
//		return em;
//	}
//	public static void close() {
//		em.close();
//	}
	private static EntityManagerFactory factory;
	static {
		factory = Persistence.createEntityManagerFactory("ASSIGNMENT");
	}
	public static EntityManager getEntityManager() {
		return factory.createEntityManager();
	}
}