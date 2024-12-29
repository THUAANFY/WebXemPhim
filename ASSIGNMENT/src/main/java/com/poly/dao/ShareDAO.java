package com.poly.dao;

import java.util.List;

import com.poly.entity.Share;

public interface ShareDAO {
	List<Share> findAll();
    Share findById(Long id);
    void create(Share share);
    void update(Share share);
    void deleteById(Long id);
    List<Object[]> findShareDetailsByVideoId(String videoId);
}
