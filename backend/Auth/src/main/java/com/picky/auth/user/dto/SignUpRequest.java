package com.picky.auth.user.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.util.List;

@Getter
@NoArgsConstructor
public class SignUpRequest { // 회원가입 요청 DTO

    @NotBlank
    private String password;
    @NotBlank
    private String nickname;
    private int height;
    private int weight;
    private int age;
    private int gender;
    @NotBlank
    private String fcmToken;
    private List<String> roles;

    @Builder
    public SignUpRequest(String password, String nickname, int height, int weight, int age, int gender, String fcmToken, List<String> roles) {
        this.password = password;
        this.nickname = nickname;
        this.height = height;
        this.weight = weight;
        this.age = age;
        this.gender = gender;
        this.fcmToken = fcmToken;
        this.roles = roles;
    }
}
