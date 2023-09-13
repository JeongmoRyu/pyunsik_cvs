package com.picky.auth.config.security;

import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.List;

/**
 * JWT 토큰을 생성하고 유효성을 검증하는 컴포넌트 클래스 JWT 는 여러 암호화 알고리즘을 제공하고 알고리즘과 비밀키를 가지고 토큰을 생성
 * - claim 정보에는 토큰에 부가적으로 정보를 추가할 수 있음
 * - claim 정보에 회원을 구분할 수 있는 값을 세팅하였다가 토큰이 들어오면 해당 값으로 회원을 구분하여 리소스 제공
 * JWT 토큰에 expire time을 설정할 수 있음
 */
@Component
@RequiredArgsConstructor
public class JwtTokenProvider {

    private final Logger LOGGER = LoggerFactory.getLogger(JwtTokenProvider.class);
    private final UserRepository userRepository;

    @Value("${spring.jwt.secret}")
    private String secretKey = "secretKey";

    @Value("${spring.jwt.token.access-expire-time}")
    private long accessExpireTime = 60 * 60 * 24; // 하루 토큰 유효

    @Value("${spring.jwt.token.refresh-expire-time}")
    private long refreshExpireTime = 60 * 60 * 24 * 30; // 한 달 토큰 유효

    /**
     * SecretKey 에 대해 인코딩 수행
     */
    @PostConstruct
    protected void init() {
        LOGGER.info("[init] JwtTokenProvider 내 secretKey 초기화 시작");
        secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes(StandardCharsets.UTF_8));
        LOGGER.info("[init] JwtTokenProvider 내 secretKey 초기화 완료");
    }

    /**
     * JWT 토큰 생성
     */
    public String createAccessToken(String uuid, List<String> roles) {
        LOGGER.info("[createAccessToken] 토큰 생성 시작 UUID : {}", uuid);
        Claims claims = Jwts.claims().setSubject(uuid);
        claims.put("roles", roles);

        Date now = new Date();
        String accessToken = Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(new Date(now.getTime() + 1000L * accessExpireTime))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();

        LOGGER.info("[createAccessToken] 토큰 생성 완료");
        return accessToken;
    }

    /**
     * Refresh 토큰 생성
     * Redis 저장
     */
    public void createRefreshToken(String uuid, List<String> roles) {
        LOGGER.info("[createRefreshToken] 리프레시 토큰 생성 시작");
        Claims claims = Jwts.claims().setSubject(uuid);
        claims.put("roles", roles);

        Date now = new Date();
        String refreshToken = Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(new Date(now.getTime() + 1000L * refreshExpireTime))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
        try {
            // [추가] redis 저장
            LOGGER.info("[createToken] 리프레시 토큰 생성 완료");
        } catch (Exception e) {
            // error
        }
    }

    /**
     * JWT Token or Refresh 토큰 생성
     * 토큰이나 리프레시 토큰 만료 시 새로 생성
     */
    public String createNewToken(String accessToken, HttpServletRequest request) {
        // redis에서 accessToken : refreshToken 가져오기
        String refreshToken = "";
        String newAccessToken;
        if (refreshToken != null) { // accessToken 만료, refreshToken 유효
            User user = getUserOfToken(accessToken);
            newAccessToken = createAccessToken(user.getUUID(), user.getRoles());

            // [추가] redis 저장
        } else { // accessToken 만료, refreshToken 만료
            User user = getUserOfToken(accessToken);
            newAccessToken = createAccessToken(user.getUUID(), user.getRoles());
            String newRefreshToken = createAccessToken(user.getUUID(), user.getRoles());

            // [추가] redis 저장
        }
        return newAccessToken;
    }

    /**
     * JWT 토큰으로 인증 정보 조회
     *
     * 필터에서 인증이 성공했을 때 SecurityContextHolder에 저장할 Authentication을 생성하는 역할
     */
    public Authentication getAuthentication(String token) {
        LOGGER.info("[getAuthentication] 토큰 인증 정보 조회 시작");
        User user = this.getUserOfToken(token);
        LOGGER.info("[getAuthentication] 토큰 인증 정보 조회 완료, UUID : {}",
                user.getUUID());

        // Authentication을 구현하는 방법 중 하나 -> UsernamePasswordAuthenticationToken
        return new UsernamePasswordAuthenticationToken(user, "", user.getAuthorities());
    }

    /**
     * HTTP Request Header 에 설정된 토큰 값을 가져옴
     *
     * @param request Http Request Header
     * @return String type Token 값
     */
    public String resolveToken(HttpServletRequest request) {
        LOGGER.info("[resolveToken] HTTP 헤더에서 Token 값 추출");
        return request.getHeader("X-AUTH-TOKEN");
    }

    /**
     * JWT 토큰의 유효성 + 만료일 체크
     */
    public String validateToken(String accessToken, HttpServletRequest request) {
        LOGGER.info("[validateToken] 토큰 유효 체크 시작");
        try {
            Jws<Claims> claims = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(accessToken);
            LOGGER.info("[validateToken] 토큰 유효 체크 완료");
            return accessToken;
        } catch (Exception e) {
            LOGGER.info("[validateToken] 토큰 유효 체크 예외 발생");
            return createNewToken(accessToken, request);
        }
    }

    /**
     * JWT 토큰에서 회원 구별 정보 추출
     */
    public User getUserOfToken(String token) {
        LOGGER.info("[getUserOfToken] 토큰 유저 정보 추출 시작");
        String UUID = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody().getSubject();
        LOGGER.info("[getUsername] 토큰 기반 회원 구별 정보 추출 완료, UUID : {}", UUID);
        return userRepository.findByUUID(UUID);
    }
}
