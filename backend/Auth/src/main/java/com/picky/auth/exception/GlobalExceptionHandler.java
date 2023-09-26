package com.picky.auth.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.UNAUTHORIZED;

@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 잘못된 요청 예외
     */
    @ExceptionHandler(CustomException.class)
    @ResponseStatus(BAD_REQUEST)
    private ErrorResponse handleCustomException(CustomException customException) {
        return ErrorResponse.of(customException.getExceptionCode());
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseStatus(UNAUTHORIZED)
    private ErrorResponse handleIllegalArgumentException(IllegalArgumentException e) {
        if (e.getMessage().contains("JWT String argument cannot be null or empty")) {
            return ErrorResponse.of(ExceptionCode.EMPTY_TOKEN);
        }
        // 다른 IllegalArgumentException이 발생했을 때의 처리, 필요하다면
        return ErrorResponse.of(ExceptionCode.INVALID_TOKEN); // or 다른 적절한 ExceptionCode
    }
}
