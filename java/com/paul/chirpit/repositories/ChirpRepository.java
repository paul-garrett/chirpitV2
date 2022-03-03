package com.paul.chirpit.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.paul.chirpit.models.Chirp;

@Repository
public interface ChirpRepository extends CrudRepository<Chirp, Long> {
	List<Chirp> findAllByOrderByIdDesc(); 
	long countByUserId(long userId);
}
