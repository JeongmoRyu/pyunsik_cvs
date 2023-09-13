package com.picky.auth.user.service;

import com.picky.auth.config.security.JwtTokenProvider;
import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import com.picky.auth.user.dto.UserResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
public class UserService {

    private final Logger LOGGER = LoggerFactory.getLogger(AuthService.class);
    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    private final JwtTokenProvider jwtTokenProvider;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtTokenProvider jwtTokenProvider) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    // 유저 상세 정보 조회
    @Transactional(readOnly = true)
    public UserResponse getUserDetails(HttpServletRequest servletRequest) {
        String accessToken = jwtTokenProvider.resolveToken(servletRequest);
        User user = jwtTokenProvider.getUserOfToken(accessToken);
        return UserResponse.toResponse(user);
    }

    // 닉네임 변경
    @Transactional
    public UserResponse updateNickname(String preNickname, String postNickname) {
        if (userRepository.existsByNickname(postNickname)) {
            // [추가] 닉네임 중복 예외 처리 수정 필요
            throw new RuntimeException("이미 존재하는 닉네임입니다.");
        } else {
            User user = userRepository.findByNickname(preNickname); // 예외 처리 필요
            user.setNickname(postNickname);
            userRepository.save(user);
            return UserResponse.toResponse(user);
        }
    }

    // 비밀번호 변경
    @Transactional
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
