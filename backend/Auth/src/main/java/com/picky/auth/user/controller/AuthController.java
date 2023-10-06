package com.picky.auth.user.controller;

import com.picky.auth.user.dto.SignInRequest;
import com.picky.auth.user.dto.SignInResponse;
import com.picky.auth.user.dto.SignUpRequest;
import com.picky.auth.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api/auth")
@Slf4j
@CrossOrigin(origins = "*")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping
    public ResponseEntity<Void> signUp(@RequestBody SignUpRequest request) {
        authService.signUp(request);
        return ResponseEntity.ok().build();
    }

    @PostMapping(value = "/login")
    public ResponseEntity<SignInResponse> login(@RequestBody SignInRequest request)
            throws RuntimeException {
        log.info("[login] 로그인을 시도하고 있습니다. nickname : {}, pw : ****", request.getNickname());
        SignInResponse signInResponse = authService.login(request.getNickname(), request.getPassword());

        log.info("[login] 정상적으로 로그인되었습니다. nickname : {}, token : {}", request.getNickname(),
                signInResponse.getAccessToken());
        return ResponseEntity.ok(signInResponse);
    }

    // 로그아웃
    @GetMapping(value = "/logout")
    public ResponseEntity<Void> logout(HttpServletRequest servletRequest) {
        log.info("[logout] 로그아웃을 시도하고 있습니다.");
        authService.logout(servletRequest);
        log.info("[logout] 정상적으로 로그아웃 되었습니다.");
        return ResponseEntity.ok().build();
    }

    // 회원탈퇴
    @DeleteMapping
    public ResponseEntity<Void> signout(HttpServletRequest servletRequest) {
        log.info("[signout] 회원탈퇴를 시도하고 있습니다.");
        authService.signout(servletRequest);
        log.info("[signout] 정상적으로 탈퇴 되었습니다.");
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

    // getId by JWT
    @GetMapping("/id/{accessToken}")
    public Long getIdByJwt(@PathVariable("accessToken") String accessToken) {
        return authService.getIdByJwt(accessToken);
    }
}
