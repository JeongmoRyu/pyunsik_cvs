package com.picky.auth.config.security;

import com.picky.auth.exception.CustomException;
import com.picky.auth.exception.ExceptionCode;
import com.picky.auth.user.domain.entity.User;
import com.picky.auth.user.domain.repository.UserRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * [JwtTokenProvider]
 * JWT 토큰을 생성하고 유효성을 검증하는 컴포넌트 클래스
 * - claim 정보에는 토큰에 부가적으로 정보를 추가할 수 있음
 * - claim 정보에 회원을 구분할 수 있는 값을 세팅하였다가 토큰이 들어오면 해당 값으로 회원을 구분하여 리소스 제공
 * - JWT 토큰에 expire time을 설정할 수 있음
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class JwtTokenProvider {

    private final UserRepository userRepository;

    @Value("${spring.jwt.secret}")
    private String secretKey;

    @Value("${spring.jwt.token.access-expire-time}")
    private long accessExpireTime; // 하루 토큰 유효

    @Value("${spring.jwt.token.refresh-expire-time}")
    private long refreshExpireTime; // 한 달 토큰 유효

    private final RedisTemplate<String, String> redisTemplate;

    /**
     * [init]
     * SecretKey 에 대해 인코딩 수행
     */
    @PostConstruct
    protected void init() {
        log.info("[init] JwtTokenProvider 내 secretKey 초기화 시작");
        secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes(StandardCharsets.UTF_8));
        log.info("[init] JwtTokenProvider 내 secretKey 초기화 완료");
    }

    /**
     * [createAccessToken]
     * JWT 토큰 생성
     */
    public String createAccessToken(String uuid, List<String> roles) {
        log.info("[createAccessToken] 토큰 생성 시작 uuid : {}", uuid);
        Claims claims = Jwts.claims().setSubject(uuid);
        claims.put("roles", roles);

        Date now = new Date();
        String accessToken = Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(new Date(now.getTime() + 1000L * accessExpireTime))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();

        log.info("[createAccessToken] 토큰 생성 완료");
        return accessToken;
    }

    /**
     * [createRefreshToken]
     * Refresh 토큰 생성
     * Redis 저장
     */
    public void createRefreshToken(User user, String accessToken) {
        log.info("[createRefreshToken] 리프레시 토큰 생성 시작");
        Claims claims = Jwts.claims().setSubject(user.getUuid());
        claims.put("roles", user.getRoles());

        Date now = new Date();
        String refreshToken = Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(new Date(now.getTime() + 1000L * refreshExpireTime))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
        try {
            // redis 저장
            saveTokenInRedis(accessToken, refreshToken);
            log.info("[createRefreshToken] 리프레시 토큰 생성 완료");
        } catch (Exception e) {
            // error
            log.info("[createRefreshToken] 리프레시 토큰 생성 실패 error:" + e);
        }
    }

    /**
     * [createNewToken]
     * JWT Token or Refresh 토큰 생성
     * 토큰이나 리프레시 토큰 만료 시 새로 생성
     */
    public String createNewToken(String accessToken) {
        String newAccessToken = "";

        // redis에서 accessToken : refreshToken 가져오기
        String refreshToken = redisTemplate.opsForValue().get("accessToken:" + accessToken);

        if (refreshToken != null) { // accessToken 만료, refreshToken 유효
            User user = getUserOfToken(accessToken);
            newAccessToken = createAccessToken(user.getUuid(), user.getRoles());

            // redis 저장
            saveTokenInRedis(accessToken, refreshToken);
        } else { // accessToken 만료, refreshToken 만료
            throw new CustomException(ExceptionCode.INVALID_EXPIRED_REFRESHTOKEN);
        }
        return newAccessToken;
    }

    /**
     * [getAuthentication]
     * JWT 토큰으로 인증 정보 조회
     * 필터에서 인증이 성공했을 때 SecurityContextHolder에 저장할 Authentication을 생성하는 역할
     */
    public Authentication getAuthentication(String token) {
        log.info("[getAuthentication] 토큰 인증 정보 조회 시작");
        User user = this.getUserOfToken(token);
        log.info("[getAuthentication] 토큰 인증 정보 조회 완료, uuid : {}",
                user.getUuid());

        // Authentication을 구현하는 방법 중 하나 -> UsernamePasswordAuthenticationToken
        return new UsernamePasswordAuthenticationToken(user, "", user.getAuthorities());
    }

    /**
     * [resolveToken]
     * HTTP Request Header 에 설정된 토큰 값을 가져옴
     */
    public String resolveToken(HttpServletRequest request) {
        log.info("[resolveToken] HTTP 헤더에서 Token 값 추출");
        return request.getHeader("Authorization");
    }

    /**
     * [validateToken]
     * JWT 토큰의 유효성 + 만료일 체크
     */
    public String validateToken(String accessToken) {
        log.info("[validateToken] 토큰 유효 체크 시작");
        try {
            Jwts.parser().setSigningKey(secretKey).parseClaimsJws(accessToken);
            log.info("[validateToken] 토큰 유효 체크 완료");
            return accessToken;
        } catch (Exception e) {
            log.info("[validateToken] 토큰 유효 체크 예외 발생");
            return createNewToken(accessToken);
        }
    }

    /**
     * [getUserOfToken]
     * JWT 토큰에서 회원 구별 정보 추출
     */
    public User getUserOfToken(String token) {
        log.info("[getUserOfToken] 토큰 유저 정보 추출 시작");
        String uuid = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody().getSubject();
        log.info("[getUsername] 토큰 기반 회원 구별 정보 추출 완료, uuid : {}", uuid);
        return userRepository.findByUuid(uuid).orElseThrow(() -> new CustomException(ExceptionCode.INVALID_MEMBER));
    }

    private void saveTokenInRedis(String accessToken, String refreshToken) {
        String redisAccessTokenKey = "accessToken:" + accessToken;
        redisTemplate.opsForValue().set(redisAccessTokenKey, refreshToken);
        redisTemplate.expire(redisAccessTokenKey, refreshExpireTime, TimeUnit.SECONDS);
        log.info("[saveTokenInRedis] savedRefreshToken, {} : {}", redisAccessTokenKey, redisTemplate.opsForValue().get(redisAccessTokenKey));
    }
}
