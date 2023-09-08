package com.picky.business.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
//댓글 가져오기
public class CommentResponse {
    private String nickname;
    private String content;
    private String createdAt;
}
