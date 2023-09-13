package com.picky.auth.user.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@NoArgsConstructor
public class SignUpRequest {

    @NotBlank
    private String password;
    @NotBlank
    private String nickname;
    @NotNull
    private boolean isDeleted;
    private int height;
    private int weight;
    private int age;
    private int gender;
    private String fcmToken;
    private List<String> roles;

    @Builder
    public SignUpRequest(String password, String nickname, boolean isDeleted, int height, int weight, int age, int gender, String fcmToken, List<String> roles) {
        this.password = password;
        this.nickname = nickname;
        this.isDeleted = isDeleted;
        this.height = height;
        this.weight = weight;
        this.age = age;
        this.gender = gender;
        this.fcmToken = fcmToken;
        this.roles = roles;
    }
}
