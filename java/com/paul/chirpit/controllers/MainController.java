package com.paul.chirpit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.paul.chirpit.models.Chirp;
import com.paul.chirpit.models.Likes;
import com.paul.chirpit.models.LoginUser;
import com.paul.chirpit.models.User;
import com.paul.chirpit.services.ChirpService;
import com.paul.chirpit.services.LikeService;
import com.paul.chirpit.services.UserService;

@Controller
public class MainController {
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private ChirpService chirpServ;
	
	@Autowired
	private LikeService likeServ;
	
	// Routes
	// Route to main login/reg page
	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "loginReg.jsp";
	}
	
	// Methods
	// Register
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
		userServ.register(newUser, result);
		if (result.hasErrors()) {
			System.out.println(result);
			model.addAttribute("newLogin", new LoginUser());
			return "loginReg.jsp";
		}
		session.setAttribute("user_id", newUser.getId());
		return "redirect:/home";
	}
	
	// Login
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
		User user = userServ.login(newLogin, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "loginReg.jsp";
		}
		session.setAttribute("user_id", user.getId());
		return "redirect:/home";
	}
	
	// Logout
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// Logged in user info
	@GetMapping("/home")
	public String home(HttpSession session, Model model, @ModelAttribute("chirp") Chirp chirp) {
		Long userId = (Long) session.getAttribute("user_id");
		if (userId == null) {
			return "redirect:/";
		} else {
			User currentUser = userServ.showOne(userId);
			model.addAttribute("user", currentUser);
			List<Chirp> allChirps = chirpServ.allChirps();
			model.addAttribute("allChirps", allChirps);
			return "dashboard.jsp";
		}
	}
	
	
	// Create Chirp Method
	@RequestMapping(value="/createChirp", method=RequestMethod.POST)
	public String createChirp(@Valid @ModelAttribute("chirp") Chirp chirp, BindingResult result, Model model) {
		if (result.hasErrors()) {
			List<Chirp> allChirps = chirpServ.allChirps();
			model.addAttribute("allChirps", allChirps);
			return "dashboard.jsp";
		} else {
			chirpServ.createChirp(chirp);
			return "redirect:/home";
		}
	}
	
	// Show One Chirp
	@RequestMapping("/{id}/show")
	public String showChirp(HttpSession session, @PathVariable("id") Long id, Model model) {
		Long userId = (Long) session.getAttribute("user_id");
		User currentUser = userServ.showOne(userId);
		Chirp chirp = chirpServ.oneChirp(id);
		model.addAttribute("user", currentUser);
		model.addAttribute("chirp", chirp);
		return "showChirp.jsp";
	}
	
	// Show My Chirps for Profile
	@RequestMapping("/myChirps")
	public String myChirps(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("user_id");
		User currentUser = userServ.showOne(userId);
		List<Chirp> chirps = chirpServ.allChirps();
		
		model.addAttribute("user", currentUser);
		model.addAttribute("chirps", chirps);
		return "profile.jsp";
	}
	
	// Show ID User's chirps for Member Page
	@RequestMapping("/{id}/memberPage")
	public String memberPage(HttpSession session, @PathVariable("id") Long id, Model model) {
		Long userId = (Long) session.getAttribute("user_id");
		User member = userServ.showOne(id);
		System.out.println(member.getLikedChirps().size());
		User currentUser = userServ.showOne(userId);
		System.out.println(currentUser.getLikedChirps().size());
		List<Chirp> chirps = chirpServ.allChirps();
		model.addAttribute("user", currentUser);
		model.addAttribute("member", member);
		model.addAttribute("chirps", chirps);
		return "memberPage.jsp";
	}
	
	// Edit Chirp View
	@RequestMapping("/{id}/editChirp")
	public String edit(HttpSession session, @PathVariable("id") Long id, Model model) {
		Long userId = (Long) session.getAttribute("user_id");
		Chirp chirp = chirpServ.oneChirp(id);
		if (userId == null) {
			return "redirect:/home";
		} else {
			model.addAttribute("chirp", chirp);
			return "editChirp.jsp";
		}
	}
	
	// Edit Chirp Method
	@RequestMapping(value="/{id}/updateChirp", method=RequestMethod.PUT)
	public String editChirp(@Valid @ModelAttribute("chirp") Chirp chirp, BindingResult result) {
		if (result.hasErrors()) {
			return "editChirp.jsp";
		} else {
			chirpServ.updateChirp(chirp);
			return "redirect:/myChirps";
		}
	}
	
	// Delete Chirp
	@RequestMapping(value="/{id}/deleteChirp", method=RequestMethod.DELETE)
	public String delete(@PathVariable("id") Long id) {
		chirpServ.deleteChirp(id);
		return "redirect:/myChirps";
	}
	
	// Like Method
	@RequestMapping(value="/like", method=RequestMethod.POST)
	public String like(HttpSession session, @RequestParam(name="id", required = false) Long id, 
			@RequestParam(name="chirp")long chirpId,
			@RequestParam(name="source") String source) {
		Long userId = (Long) session.getAttribute("user_id");
		User currentUser = userServ.showOne(userId);
		Likes like = new Likes();
		like.setUser(currentUser);
		Chirp chirp = chirpServ.oneChirp(chirpId);
		like.setChirp(chirp);
		likeServ.likes(like);
		if (source.equals("dashboard.jsp")) {
			return "redirect:/home";
		} else if (source.equals("memberPage.jsp")) {
			return "redirect:/" + id + "/memberPage";
		}
		return "redirect:/home";
	}
	
	//Dislike Method
	@RequestMapping(value="/dislike", method=RequestMethod.POST)
	public String dislike(HttpSession session, @RequestParam(name="id", required = false) Long id, 
			@RequestParam(name="chirp")long chirpId,
			@RequestParam(name="source") String source) {
		Long userId = (Long) session.getAttribute("user_id");
		User currentUser = userServ.showOne(userId);		
		Chirp chirp = chirpServ.oneChirp(chirpId);
		Likes like = likeServ.getLikes(currentUser, chirp);
		likeServ.dislike(like.getId());
		if (source.equals("dashboard.jsp")) {
			return "redirect:/home";
		} else if (source.equals("memberPage.jsp")) {
			return "redirect:/" + id + "/memberPage";
		}
		return "redirect:/home";
	}

}

