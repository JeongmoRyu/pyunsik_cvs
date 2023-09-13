package com.picky.auth.user.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@NoArgsConstructor
public class SignInRequest {

    @NotBlank
    private String password;
    @NotBlank
    private String nickname;

    @Builder
    public SignInRequest(String password, String nickname) {
        this.password = password;
        this.nickname = nickname;
    }
}
