package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    private final UserRepository repo;

    public HelloController(UserRepository repo) {
        this.repo = repo;
    }

    @GetMapping("/")
    public String hello() {
        long count = repo.count();
        return "Hello from Spring Boot with MySQL! Users in DB: " + count;
    }
}

