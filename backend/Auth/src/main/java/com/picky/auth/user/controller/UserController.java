package com.picky.auth.user.controller;

import com.picky.auth.user.dto.NicknameUpdateRequest;
import com.picky.auth.user.dto.PasswordUpdateRequest;
import com.picky.auth.user.dto.UserResponse;
import com.picky.auth.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {

    private final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    // 유저 상세 정보 조회
//    @GetMapping
//    public ResponseEntity<UserResponse> getUserDetails()

    @PatchMapping(value = "/update-nickname")
    public ResponseEntity<UserResponse> updateNickname(@RequestBody NicknameUpdateRequest request) {
        return ResponseEntity.ok(userService.updateNickname(request.getPreNickname(), request.getPostNickname()));
    }

    @PatchMapping(value = "/update-password")
    public ResponseEntity<UserResponse> updatePassword(@RequestBody PasswordUpdateRequest request) {
        return ResponseEntity.ok(userService.updatePassword(request.getNickname(), request.getPrePassword(), request.getPostPassword()));
    }
}
