package com.picky.auth.config.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final Logger LOGGER = LoggerFactory.getLogger(CustomAuthenticationEntryPoint.class);

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException)
            throws IOException {

        Exception exception = (Exception) request.getAttribute("exception");
        LOGGER.info("[commence] 인증 실패로 {} 발생", exception.toString());

        // 응답값을 설정해야 할 필요가 없을 경우
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
    }
}
