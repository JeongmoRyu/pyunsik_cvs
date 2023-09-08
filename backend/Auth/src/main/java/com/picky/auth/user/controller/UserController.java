package com.picky.auth.user.controller;

import com.picky.auth.user.dto.SignInRequest;
import com.picky.auth.user.dto.SignInResponse;
import com.picky.auth.user.dto.SignUpRequest;
import com.picky.auth.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.URI;

@RestController
@RequestMapping("/api/user")
public class UserController {

    private final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping(value = "/sign-up")
    public ResponseEntity<Void> signUp(@RequestBody SignUpRequest request) {
        userService.signUp(request);
        return ResponseEntity.created(URI.create("/api/member")).build();
    }

    @PostMapping(value = "/sign-in")
    public ResponseEntity<SignInResponse> signIn(@RequestBody SignInRequest request)
            throws RuntimeException {
        LOGGER.info("[signIn] 로그인을 시도하고 있습니다. nickname : {}, pw : ****", request.getNickname());
        SignInResponse signInResponse = userService.signIn(request.getNickname(), request.getPassword());

        LOGGER.info("[signIn] 정상적으로 로그인되었습니다. nickname : {}, token : {}", request.getNickname(),
                signInResponse.getAccessToken());
        return ResponseEntity.ok(signInResponse);
    }
}
