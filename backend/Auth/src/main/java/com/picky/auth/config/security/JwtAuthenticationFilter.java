package com.picky.auth.config.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * [JwtAuthenticationFilter]
 * JWT 토큰으로 인증하고 SecurityContextHolder에 추가하는 필터를 설정하는 클래스
 * OncePerRequestFilter 상속
 * - 스프링 부트에서 필터를 구현하는 가장 편한 방법은 필터를 상속받아 사용하는 것
 */
@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenProvider jwtTokenProvider;

    public JwtAuthenticationFilter(JwtTokenProvider jwtTokenProvider) {
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest servletRequest, HttpServletResponse servletResponse, FilterChain filterChain) throws ServletException, IOException {
        // jwtTokenProvider를 통해 servletRequest에서 토큰을 추출하고, 토큰에 대한 유효성 검사
        String token = jwtTokenProvider.resolveToken(servletRequest);
        log.info("[doFilterInternal] token 값 추출 완료. token : {}", token);

        log.info("[doFilterInternal] token 값 유효성 체크 시작");
        if (token != null && jwtTokenProvider.validateToken(token) != null) {
            Authentication authentication = jwtTokenProvider.getAuthentication(token);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            log.info("[doFilterInternal] token 값 유효성 체크 완료");
        }

        // 서블릿을 실행하는 메서드 - 이를 기준으로 앞선 코드는 서블릿 실행 전 실행, 뒷 코드는 서블릿 실행 후 실행
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
