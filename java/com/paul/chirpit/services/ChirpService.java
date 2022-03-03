package com.paul.chirpit.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.paul.chirpit.models.Chirp;
import com.paul.chirpit.repositories.ChirpRepository;

@Service
public class ChirpService {
	// Dependency Injection
	private final ChirpRepository chirpRepository;
	
	public ChirpService(ChirpRepository chirpRepository) {
		this.chirpRepository = chirpRepository;
	}
	
	// Create Chirp
	public Chirp createChirp(Chirp chirp) {
		return chirpRepository.save(chirp);
	}
	
	// Return all Chirps
	public List<Chirp> allChirps() {
		return chirpRepository.findAllByOrderByIdDesc();
	}
	
	// Get Chirp Count By User
	public long getChirpCountByUser(long userId) {
		return chirpRepository.countByUserId(userId);
	}
	
	// Return one chirp
	public Chirp oneChirp(Long id) {
		Optional<Chirp> optionalChirp = chirpRepository.findById(id);
		if (optionalChirp.isPresent()) {
			return optionalChirp.get();
		} else {
			return null;
		}
	}
	
	// Update Chirp
	public Chirp updateChirp(Chirp chirp) {
		return chirpRepository.save(chirp);
	}
	
	// Delete Chirp
	public void deleteChirp(Long id) {
		chirpRepository.deleteById(id);
	}

}
