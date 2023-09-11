package com.picky.auth.user.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@ToString
public class SignInResponse {

    private String UUID;
    private String nickname;
    private String fcmToken;
    private String accessToken;

    @Builder
    public SignInResponse(String UUID, String nickname, String fcmToken, String accessToken) {
        this.UUID = UUID;
        this.nickname = nickname;
        this.fcmToken = fcmToken;
        this.accessToken = accessToken;
    }
}
