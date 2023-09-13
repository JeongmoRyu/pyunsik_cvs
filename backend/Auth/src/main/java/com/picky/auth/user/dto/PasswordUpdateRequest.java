package com.picky.auth.user.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class PasswordUpdateRequest {

    String nickname;
    String prePassword;
    String postPassword;

    @Builder
    public PasswordUpdateRequest(String nickname, String prePassword, String postPassword) {
        this.nickname = nickname;
        this.prePassword = prePassword;
        this.postPassword = postPassword;
    }
}
