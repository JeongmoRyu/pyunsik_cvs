package com.picky.auth.user.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class NicknameUpdateRequest { // 닉네임 수정 요청 DTO

    String preNickname;
    String postNickname;

    @Builder
    public NicknameUpdateRequest(String preNickname, String postNickname) {
        this.preNickname = preNickname;
        this.postNickname = postNickname;
    }
}
