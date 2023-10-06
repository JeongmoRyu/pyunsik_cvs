package com.picky.auth.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

@Getter
@AllArgsConstructor
public enum ExceptionCode {

    // 200 OK : 성공
    SUCCESS(OK, "", 200),

    // 400 BAD_REQUEST : 잘못된 요청
    INVALID_MEMBER(BAD_REQUEST, "잘못된 사용자 입니다.", 400),
    DUPLICATE_NICKNAME(BAD_REQUEST, "중복된 닉네임 입니다.", 400),
    INVALID_PASSWORD(BAD_REQUEST, "비밀번호가 틀립니다.", 400),
    DELETED_MEMBER(BAD_REQUEST, "탈퇴한 사용자 입니다.", 400),

    // 401 UNAUTHORIZED : 인증되지 않은 사용자
    EMPTY_TOKEN(UNAUTHORIZED, "로그인하세요.", 401),
    INVALID_TOKEN(UNAUTHORIZED, "잘못된 토큰입니다", 401),
    INVALID_EXPIRED_TOKEN(UNAUTHORIZED, "만료된 토큰입니다", 401),
    INVALID_DELETED_MEMBER(UNAUTHORIZED, "탈퇴한 회원입니다", 401),
    INVALID_EXPIRED_REFRESHTOKEN(UNAUTHORIZED, "다시 로그인하세요.", 401);

    private final HttpStatus httpStatus;
    private final String message;
    private final int code;
}
