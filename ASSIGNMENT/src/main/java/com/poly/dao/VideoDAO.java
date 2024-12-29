package com.poly.dao;

import java.util.List;

import com.poly.entity.Video;

public interface VideoDAO {
	List<Video> findAll();
	List<Video> findAllActive();
	Video findById(String id);
	void create(Video video);
	void update(Video video);
	void deleteById(String id);
	List<Object[]> findAllWithLikeCount();
	List<Object[]> findByTitleWithLikeCount(String title);
	List<Video> findLikedVideosByUserId(String userId);

}
