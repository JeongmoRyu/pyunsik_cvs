package com.picky.auth.user.service;

import com.picky.auth.config.security.JwtTokenProvider;
import com.picky.auth.exception.CustomException;
import com.picky.auth.exception.ExceptionCode;
import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import com.picky.auth.user.dto.UserResponse;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;

@Service
public class UserService {

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
            throw new CustomException(ExceptionCode.DUPLICATE_NICKNAME);
        } else {
            User user = userRepository.findByNickname(preNickname).orElseThrow(() -> new CustomException(ExceptionCode.INVALID_MEMBER)); // 예외 처리 필요
            user.setNickname(postNickname);
            userRepository.save(user);
            return UserResponse.toResponse(user);
        }
    }

    // 비밀번호 변경
    @Transactional
    public UserResponse updatePassword(String nickname, String prePassword, String postPassword) {
        User user = userRepository.findByNickname(nickname).orElseThrow(() -> new CustomException(ExceptionCode.INVALID_MEMBER));
        if (passwordEncoder.matches(prePassword, user.getPassword())) { // 비밀번호 일치
            user.setPassword(passwordEncoder.encode(postPassword));
            userRepository.save(user);
            return UserResponse.toResponse(user);
        } else { // 비밀번호 불일치
            throw new CustomException(ExceptionCode.INVALID_PASSWORD);
        }
    }
}
