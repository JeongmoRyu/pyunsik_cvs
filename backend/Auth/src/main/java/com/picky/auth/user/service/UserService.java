package com.picky.auth.user.service;

import com.picky.auth.config.security.JwtTokenProvider;
import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import com.picky.auth.user.dto.SignInResponse;
import com.picky.auth.user.dto.SignUpRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class UserService {

    private final Logger LOGGER = LoggerFactory.getLogger(UserService.class);
    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, JwtTokenProvider jwtTokenProvider, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
        this.passwordEncoder = passwordEncoder;
    }

    public void signUp(SignUpRequest request) {

        User savedUser = userRepository.save(User.builder()
                .nickname(request.getNickname())
                .password(passwordEncoder.encode(request.getPassword()))
                .roles(Collections.singletonList("ROLE_CONSUMER"))
                .build());
    }

    public SignInResponse signIn(String nickname, String password) throws RuntimeException {
        LOGGER.info("[getSignInResponse] signDataHandler 로 회원 정보 요청");
        User user = userRepository.getByNickname(nickname);
        LOGGER.info("[getSignInResponse] nickname : {}", nickname);

        LOGGER.info("[getSignInResponse] 패스워드 비교 수행");
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException();
        }
        LOGGER.info("[getSignInResponse] 패스워드 일치");

        LOGGER.info("[getSignInResponse] SignInResponse 객체 생성");
        SignInResponse signInResponse = SignInResponse.builder()
                .accessToken(jwtTokenProvider.createToken(String.valueOf(user.getUUID())))
                .build();

        LOGGER.info("[getSignInResponse] SignInResponse 객체에 값 주입");

        return signInResponse;
    }
}
