package com.picky.auth.user.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SignInResponse extends SignUpResponse {

    private String accessToken;

    @Builder
    public SignInResponse(String uuid, String nickname, int height, int weight, int age, int gender, String fcmToken, String accessToken) {
        super(uuid, nickname, height, weight, age, gender, fcmToken);
        this.accessToken = accessToken;
    }
}
