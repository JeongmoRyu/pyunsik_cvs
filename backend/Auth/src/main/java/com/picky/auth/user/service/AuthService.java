package com.picky.auth.user.service;

import com.picky.auth.config.security.JwtTokenProvider;
import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import com.picky.auth.user.dto.SignInResponse;
import com.picky.auth.user.dto.SignUpRequest;
import com.picky.auth.user.dto.UserResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;

@Service
public class AuthService {

    private final Logger LOGGER = LoggerFactory.getLogger(AuthService.class);
    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    public AuthService(UserRepository userRepository, JwtTokenProvider jwtTokenProvider, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public void signUp(SignUpRequest request) {
        if (userRepository.existsByNickname(request.getNickname())) {
            // [추가] 닉네임 중복 예외 처리 수정 필요
            throw new RuntimeException("이미 존재하는 닉네임입니다.");
        } else {
            User savedUser = userRepository.save(User.builder()
                    .nickname(request.getNickname())
                    .password(passwordEncoder.encode(request.getPassword()))
                    .roles(Collections.singletonList("ROLE_CONSUMER"))
                    .build());
        }
    }

    @Transactional(readOnly = true)
    public SignInResponse login(String nickname, String password) throws RuntimeException {
        LOGGER.info("[getSignInResponse] signDataHandler 로 회원 정보 요청");
        User user = userRepository.findByNickname(nickname);
        LOGGER.info("[getSignInResponse] nickname : {}", nickname);

        LOGGER.info("[getSignInResponse] 패스워드 비교 수행");
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException();
        }
        LOGGER.info("[getSignInResponse] 패스워드 일치");

        LOGGER.info("[getSignInResponse] SignInResponse 객체 생성");
        SignInResponse signInResponse = SignInResponse.builder()
                .UUID(user.getUUID())
                .nickname(user.getNickname())
                .fcmToken(user.getFcmToken())
                .accessToken(jwtTokenProvider.createAccessToken(user.getUUID(), user.getRoles()))
                .build();
        jwtTokenProvider.createRefreshToken(user.getUUID(), user.getRoles());
        LOGGER.info("[getSignInResponse] SignInResponse 객체에 값 주입");

        return signInResponse;
    }

    // 로그아웃
    public void logout(HttpServletRequest servletRequest) {
        String accessToken = jwtTokenProvider.resolveToken(servletRequest);

        // redis에서 토큰, 리프레시 토큰 삭제 (값이 있으면 삭제, 없으면 예외처리)
    }

    // 회원탈퇴
    @Transactional
    public void signout(HttpServletRequest servletRequest) {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        LOGGER.info("[signout] 회원 탈퇴 요청 유저 : {}", UserResponse.toResponse(user));
        userRepository.delete(user);
        this.logout(servletRequest);
    }

    // getUuid by JWT
    public String getUuidByJwt(String accessToken) {
        return jwtTokenProvider.getUserOfToken(accessToken).getUUID();
    }

    // getFcmToken by JWT
    public String getFcmTokenByJwt(String accessToken) {
        return jwtTokenProvider.getUserOfToken(accessToken).getFcmToken();
    }

    // getNickname by JWT
    public String getNicknameByJwt(String accessToken) {
        return jwtTokenProvider.getUserOfToken(accessToken).getNickname();
    }

}
