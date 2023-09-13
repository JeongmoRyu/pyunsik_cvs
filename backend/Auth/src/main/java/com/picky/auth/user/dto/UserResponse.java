package com.picky.auth.user.dto;

import com.picky.auth.user.domain.entity.User;
import lombok.*;

@Getter
@NoArgsConstructor
@ToString
public class UserResponse { // 회원가입 응답 DTO

    private String uuid;
    private String nickname;
    private int height;
    private int weight;
    private int age;
    private int gender;
    private String fcmToken;

    @Builder
    public UserResponse(String uuid, String nickname, int height, int weight, int age, int gender, String fcmToken) {
        this.uuid = uuid;
        this.nickname = nickname;
        this.height = height;
        this.weight = weight;
        this.age = age;
        this.gender = gender;
        this.fcmToken = fcmToken;
    }

    public static UserResponse toResponse(User user) {
        return UserResponse.builder()
                .uuid(user.getUuid())
                .nickname(user.getNickname())
                .height(user.getHeight())
                .weight(user.getWeight())
                .age(user.getAge())
                .gender(user.getGender())
                .fcmToken(user.getFcmToken())
                .build();
    }
}
