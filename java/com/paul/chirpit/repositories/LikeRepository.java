package com.paul.chirpit.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.paul.chirpit.models.Chirp;
import com.paul.chirpit.models.Likes;
import com.paul.chirpit.models.User;

@Repository
public interface LikeRepository extends CrudRepository<Likes, Long> {
	List<Likes> findAll();
	Likes findByUserAndChirp(User user, Chirp chirp);
}
