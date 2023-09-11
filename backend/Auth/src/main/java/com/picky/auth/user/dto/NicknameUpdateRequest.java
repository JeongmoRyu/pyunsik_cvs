package com.picky.auth.user.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class NicknameUpdateRequest {

    String preNickname;
    String postNickname;

    @Builder
    public NicknameUpdateRequest(String preNickname, String postNickname) {
        this.preNickname = preNickname;
        this.postNickname = postNickname;
    }
}
