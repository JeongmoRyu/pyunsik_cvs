package com.picky.auth.user.controller;

import com.picky.auth.user.dto.*;
import com.picky.auth.user.service.AuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
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
    public ResponseEntity<SignInResponse> login(@RequestBody SignInRequest request)
            throws RuntimeException {
        LOGGER.info("[login] 로그인을 시도하고 있습니다. nickname : {}, pw : ****", request.getNickname());
        SignInResponse signInResponse = authService.login(request.getNickname(), request.getPassword());

        LOGGER.info("[login] 정상적으로 로그인되었습니다. nickname : {}, token : {}", request.getNickname(),
                signInResponse.getAccessToken());
        return ResponseEntity.ok(signInResponse);
    }

    // 로그아웃
    @GetMapping(value = "/logout")
    public ResponseEntity<Void> logout(HttpServletRequest servletRequest) {
        LOGGER.info("[logout] 로그아웃을 시도하고 있습니다.");
        authService.logout(servletRequest);
        LOGGER.info("[logout] 정상적으로 로그아웃 되었습니다.");
        return ResponseEntity.ok().build();
    }

    // 회원탈퇴
    @DeleteMapping
    public ResponseEntity<Void> signout(HttpServletRequest servletRequest) {
        LOGGER.info("[signout] 회원탈퇴를 시도하고 있습니다.");
        authService.signout(servletRequest);
        LOGGER.info("[signout] 정상적으로 탈퇴 되었습니다.");
        return ResponseEntity.ok().build();
    }

    // getUuid by JWT
    @GetMapping("/uuid/{accessToken}")
    public String getUuidByJwt(@PathVariable("accessToken") String accessToken) {
        return authService.getUuidByJwt(accessToken);
    }

    // getFcmToken by JWT
    @GetMapping("/fcm-token/{accessToken}")
    public String getFcmTokenByJwt(@PathVariable("accessToken") String accessToken) {
        return authService.getFcmTokenByJwt(accessToken);
    }

    // getNickname by JWT
    @GetMapping("/nickname/{accessToken}")
    public String getNicknameByJwt(@PathVariable("accessToken") String accessToken) {
        return authService.getNicknameByJwt(accessToken);
    }
}
