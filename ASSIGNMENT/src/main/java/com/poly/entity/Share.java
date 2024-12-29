package com.poly.entity;



import java.util.Date;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import com.poly.entity.Users;
import com.poly.entity.Video;

@Entity
@Table(name = "Share")
@NamedQueries({
    @NamedQuery(name = "Share.findAll", query = "SELECT s FROM Share s"),
    @NamedQuery(
    	    name = "Share.findShareDetailsByVideoId",
    	    query = "SELECT u.fullname AS userName, u.email AS senderEmail, s.emails AS receiverEmail, s.shareDate AS shareDate " +
    	            "FROM Share s JOIN s.user u " +
    	            "WHERE s.video.id = :videoId"
    	)

})
public class Share {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;
	
	@ManyToOne
    @JoinColumn(name = "UserId", referencedColumnName = "Id", nullable = false)
    private Users user;  // Liên kết với entity User
	
	@ManyToOne
    @JoinColumn(name = "VideoId", referencedColumnName = "Id", nullable = false)
    private Video video;  // Liên kết với entity Video
	
	@Column(name = "Emails", length = 50)
    private String emails;
	
	 @Column(name = "ShareDate")
	 @Temporal(TemporalType.DATE)
	 private Date shareDate;

	public Share() {
		super();
	}

	public Share(Long id, Users user, Video video, String emails, Date shareDate) {
		super();
		this.id = id;
		this.user = user;
		this.video = video;
		this.emails = emails;
		this.shareDate = shareDate;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}

	public String getEmails() {
		return emails;
	}

	public void setEmails(String emails) {
		this.emails = emails;
	}

	public Date getShareDate() {
		return shareDate;
	}

	public void setShareDate(Date shareDate) {
		this.shareDate = shareDate;
	}
}
