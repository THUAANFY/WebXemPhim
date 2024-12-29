package com.poly.dao;

import java.util.List;

import com.poly.entity.Favorite;

public interface FavoriteDAO {
	List<Favorite> findAll();
	Favorite findById(Long id);
	void create(Favorite favorite);
	void update(Favorite favorite);
	void deleteById(Long id);
	List<Object[]> findUsersByVideoId(String videoId);
	Favorite findFavoriteByUserAndVideo(String userId, String videoId);
}
