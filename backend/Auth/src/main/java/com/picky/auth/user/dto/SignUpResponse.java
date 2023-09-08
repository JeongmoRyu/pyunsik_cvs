package com.picky.auth.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SignUpResponse {

    private String uuid;
    private String nickname;
    private int height;
    private int weight;
    private int age;
    private int gender;
    private String fcmToken;
}
