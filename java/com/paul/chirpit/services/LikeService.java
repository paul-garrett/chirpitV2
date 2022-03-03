package com.paul.chirpit.services;

import java.util.List;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import com.paul.chirpit.models.Chirp;
import com.paul.chirpit.models.Likes;
import com.paul.chirpit.models.User;
import com.paul.chirpit.repositories.LikeRepository;

@Service
public class LikeService {
	// Dependency Injection
	private final LikeRepository likeRepository;
	
	public LikeService(LikeRepository likeRepository) {
		this.likeRepository = likeRepository;
	}
	
	// Return All Chirps
	public List<Likes> allLikes() {
		return likeRepository.findAll();
	}
	
	// Like
	public Likes likes(Likes like) {
		try {
			likeRepository.save(like);
		}	catch(DataIntegrityViolationException e) {
			System.out.println("Chirp Already Liked");
		}
		return like;
	}
	
	// Dislike
	public void dislike(Long id) {
		likeRepository.deleteById(id);
	}
	
	public Likes getLikes(User user, Chirp chirp) {
		return likeRepository.findByUserAndChirp(user, chirp);
	}

}
