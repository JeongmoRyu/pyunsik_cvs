package com.picky.auth.user.service;

import com.picky.auth.config.security.JwtTokenProvider;
import com.picky.auth.exception.CustomException;
import com.picky.auth.exception.ExceptionCode;
import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import com.picky.auth.user.dto.SignInResponse;
import com.picky.auth.user.dto.SignUpRequest;
import com.picky.auth.user.dto.UserResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;

@Service
@Slf4j
public class AuthService {

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    private final RedisTemplate<String, String> redisTemplate;

    public AuthService(UserRepository userRepository, JwtTokenProvider jwtTokenProvider, PasswordEncoder passwordEncoder, RedisTemplate<String, String> redisTemplate) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
        this.passwordEncoder = passwordEncoder;
        this.redisTemplate = redisTemplate;
    }

    @Transactional
    public void signUp(SignUpRequest request) {
        if (userRepository.existsByNickname(request.getNickname())) {
            throw new CustomException(ExceptionCode.DUPLICATE_NICKNAME);
        } else {
            userRepository.save(User.builder()
                    .nickname(request.getNickname())
                    .password(passwordEncoder.encode(request.getPassword()))
                    .fcmToken(request.getFcmToken())
                    .roles(Collections.singletonList("ROLE_CONSUMER"))
                    .build());
        }
    }

    @Transactional(readOnly = true)
    public SignInResponse login(String nickname, String password) throws RuntimeException {
        log.info("[getSignInResponse] signDataHandler 로 회원 정보 요청");
        User user = userRepository.findByNickname(nickname).orElseThrow(() -> new CustomException(ExceptionCode.INVALID_MEMBER));
        log.info("[getSignInResponse] nickname : {}", nickname);

        log.info("[getSignInResponse] 탈퇴 여부 파악");
        if (user.isDeleted()) {
            throw new CustomException(ExceptionCode.DELETED_MEMBER);
        }

        log.info("[getSignInResponse] 패스워드 비교 수행");
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new CustomException(ExceptionCode.INVALID_PASSWORD);
        }
        log.info("[getSignInResponse] 패스워드 일치");

        log.info("[getSignInResponse] 토큰 생성");
        String accessToken = jwtTokenProvider.createAccessToken(user.getUuid(), user.getRoles());
        log.info("[getSignInResponse] 토큰 생성 성공 accessToken : " + accessToken);
        log.info("[getSignInResponse] SignInResponse 객체 생성");
        SignInResponse signInResponse = SignInResponse.builder()
                .uuid(user.getUuid())
                .nickname(user.getNickname())
                .fcmToken(user.getFcmToken())
                .accessToken(accessToken)
                .build();
        jwtTokenProvider.createRefreshToken(user, accessToken);
        log.info("[getSignInResponse] SignInResponse 객체에 값 주입");

        return signInResponse;
    }

    // 로그아웃
    public void logout(HttpServletRequest servletRequest) {
        String accessToken = jwtTokenProvider.resolveToken(servletRequest);
        if (accessToken != null) {
            // redis에서 토큰, 리프레시 토큰 삭제 (값이 있으면 삭제, 없으면 예외처리)
            redisTemplate.delete("accessToken:" + accessToken);
        } else {
            throw new CustomException(ExceptionCode.EMPTY_TOKEN);
        }
    }

    // 회원탈퇴
    @Transactional
    public void signout(HttpServletRequest servletRequest) {
       String accessToken = jwtTokenProvider.resolveToken(servletRequest);
        if (accessToken != null) {
            User user = jwtTokenProvider.getUserOfToken(accessToken);
            log.info("[signout] 회원 탈퇴 요청 유저 : {}", UserResponse.toResponse(user));
            user.setDeleted(true);
            userRepository.save(user);
            this.logout(servletRequest);
        } else {
            throw new CustomException(ExceptionCode.EMPTY_TOKEN);
        }
    }


    // getUuid by JWT
    public String getUuidByJwt(String accessToken) {
        return jwtTokenProvider.getUserOfToken(accessToken).getUuid();
    }

    // getFcmToken by JWT
    public String getFcmTokenByJwt(String accessToken) {
        return jwtTokenProvider.getUserOfToken(accessToken).getFcmToken();
    }

    // getNickname by JWT
    public String getNicknameByJwt(String accessToken) {
        return jwtTokenProvider.getUserOfToken(accessToken).getNickname();
    }

    // getId by JWT
    public Long getIdByJwt(String accessToken) {
        return jwtTokenProvider.getUserOfToken(accessToken).getId();
    }
}
