package com.picky.auth.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.CsrfConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * [SecurityConfig]
 * 스프링 시큐리티 설정
 * - 리소스 접근 권한 설정
 * - 인증 실패 시 발생하는 예외 처리
 * - 인증 로직 커스터마이징
 * - csrf, cors 등의 스프링 시큐리티 설정
 */
@Configuration
@EnableWebSecurity // Spring Security를 활성화하고 웹 애플리케이션의 보안을 설정 가능
public class SecurityConfig {

    private final JwtTokenProvider jwtTokenProvider;
    @Autowired
    public SecurityConfig(JwtTokenProvider jwtTokenProvider) {
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .httpBasic().disable() // Rest api 사용을 위해 기본설정 해제
                .formLogin().disable() // jwt 인증방식 사용하므로 Form기반 로그인 비활성화
                .csrf(CsrfConfigurer::disable) // REST API는 csrf 보안이 필요 없으므로 비활성화
                .sessionManagement(configurer -> configurer.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // 세션은 사용하지 않기 때문에 STATELESS로 설정
                .authorizeHttpRequests(authorize -> authorize
                        .antMatchers("api/user/**").authenticated()
                        .antMatchers("api/auth/**").authenticated()
                        .anyRequest().permitAll())
                .exceptionHandling(exception -> {
                    exception.accessDeniedHandler(new CustomAccessDeniedHandler()); // 권한이 없는 예외(인가 예외)가 발생했을 경우 핸들링
                    exception.authenticationEntryPoint(new CustomAuthenticationEntryPoint()); // 인증 실패 시(인증 예외) 결과 처리
                })
                .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider),
                        UsernamePasswordAuthenticationFilter.class) // 필터들은 체인 형태로 구성돼 순서대로 동작, 어느 필터 앞에 추가할 것인지 설정
                .build();
    }
}
