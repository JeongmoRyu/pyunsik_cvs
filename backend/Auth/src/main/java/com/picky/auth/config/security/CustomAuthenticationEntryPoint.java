package com.picky.auth.config.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {


    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException)
            throws IOException {

        Exception exception = (Exception) request.getAttribute("exception");
        log.info("[commence] 인증 실패로 {} 발생", exception.toString());

        // 응답값을 설정해야 할 필요가 없을 경우
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
    }
}
