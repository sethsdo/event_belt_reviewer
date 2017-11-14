package com.project.EventScheduler.services;

import com.project.EventScheduler.models.User;
import com.project.EventScheduler.repositories.UserRepository;
import java.util.List;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private UserRepository userRepo;
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserService(UserRepository userRepo, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepo = userRepo;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    public List<User> allUsers() {
        return userRepo.findAll();
    }

    public void destroyUser(Long id) {
        userRepo.delete(id);
    }

    public void saveUser(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepo.save(user);
    }

    public User findUserById(Long id) {
        return userRepo.findOne(id);
    }

    public User findByUsername(String username) {
        return userRepo.findByUsername(username);
    }
}