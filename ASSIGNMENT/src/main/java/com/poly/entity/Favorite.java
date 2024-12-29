package com.poly.entity;

import java.util.Date;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.UniqueConstraint;
import com.poly.entity.Users;
import com.poly.entity.Video;

@Entity
@Table(name = "Favorite", 
uniqueConstraints = {@UniqueConstraint(columnNames = {"videoId", "userId"})})
public class Favorite {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "videoId")
	private Video video;
	
	@ManyToOne
	@JoinColumn(name = "userId")
	private Users user;
	
	@Temporal(TemporalType.DATE)
	private Date likeDate;

	public Favorite() {
		super();
	}

	public Favorite(Long id, Video video, Users user, Date likeDate) {
		super();
		this.id = id;
		this.video = video;
		this.user = user;
		this.likeDate = likeDate;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public Date getLikeDate() {
		return likeDate;
	}

	public void setLikeDate(Date likeDate) {
		this.likeDate = likeDate;
	}

}
