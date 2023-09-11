package com.picky.auth.user.service;

import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import com.picky.auth.user.dto.UserResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final Logger LOGGER = LoggerFactory.getLogger(AuthService.class);
    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public UserResponse updateNickname(String preNickname, String postNickname) {
        if (userRepository.existsByNickname(postNickname)) {
            // [추가] 닉네임 중복 예외 처리 수정 필요
            throw new RuntimeException("이미 존재하는 닉네임입니다.");
        } else {
            User user = userRepository.findByNickname(preNickname);
            user.setNickname(postNickname);
            userRepository.save(user);
            return UserResponse.toResponse(user);
        }
    }

    public UserResponse updatePassword(String nickname, String prePassword, String postPassword) {
        User user = userRepository.findByNickname(nickname);
        if (passwordEncoder.matches(prePassword, user.getPassword())) { // 비밀번호 일치
            user.setPassword(postPassword);
            userRepository.save(user);
            return UserResponse.toResponse(user);
        } else { // 비밀번호 불일치
            // [추가] 비밀번호 불일치 예외 처리 수정 필요
            throw new RuntimeException("비밀번호가 틀립니다.");
        }
    }
}
