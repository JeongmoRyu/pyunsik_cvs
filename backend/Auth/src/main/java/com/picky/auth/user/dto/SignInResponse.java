package com.picky.auth.user.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@ToString
public class SignInResponse { // 로그인 응답 DTO

    private String uuid;
    private String nickname;
    private String fcmToken;
    private String accessToken;

    @Builder
    public SignInResponse(String uuid, String nickname, String fcmToken, String accessToken) {
        this.uuid = uuid;
        this.nickname = nickname;
        this.fcmToken = fcmToken;
        this.accessToken = accessToken;
    }
}
