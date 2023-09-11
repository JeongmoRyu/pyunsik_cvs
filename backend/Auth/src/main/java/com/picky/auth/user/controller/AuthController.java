package com.picky.auth.user.controller;

import com.picky.auth.user.dto.*;
import com.picky.auth.user.service.AuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);
    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping
    public ResponseEntity<Void> signUp(@RequestBody SignUpRequest request) {
        authService.signUp(request);
        return ResponseEntity.created(URI.create("/api/member")).build();
    }

    @PostMapping(value = "/login")
    public ResponseEntity<SignInResponse> signIn(@RequestBody SignInRequest request)
            throws RuntimeException {
        LOGGER.info("[signIn] 로그인을 시도하고 있습니다. nickname : {}, pw : ****", request.getNickname());
        SignInResponse signInResponse = authService.signIn(request.getNickname(), request.getPassword());

        LOGGER.info("[signIn] 정상적으로 로그인되었습니다. nickname : {}, token : {}", request.getNickname(),
                signInResponse.getAccessToken());
        return ResponseEntity.ok(signInResponse);
    }

    // 로그아웃


    // 회원탈퇴


    // getUuid by JWT

    // getFcmToken by JWT


    // getNickname by JWT

}
