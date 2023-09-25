package com.picky.auth.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

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

}
