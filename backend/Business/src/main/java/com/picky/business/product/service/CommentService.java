package com.picky.business.product.service;

import com.picky.business.connect.service.ConnectAuthService;
import com.picky.business.exception.CommentNotFoundException;
import com.picky.business.exception.InvalidTokenException;
import com.picky.business.product.domain.entity.Comment;
import com.picky.business.product.domain.repository.CommentRepository;
import com.picky.business.product.dto.CommentUpdateRequest;
import com.picky.business.product.dto.CommentWriteRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.function.Consumer;
import java.util.function.Supplier;

@Service
@Slf4j
@RequiredArgsConstructor
public class CommentService {
    private final CommentRepository commentRepository;
    private final ProductService productService;
    private final ConnectAuthService connectAuthService;
    private static final String DELETED = "값을 가진 제품이 삭제되었습니다";
    private static final String NOT_FOUND = "값을 가진 데이터가 없습니다";

    @Transactional
    public void addComment(Long productId, CommentWriteRequest request, String accessToken) {
        log.info("{token:}" + accessToken);
        Comment comment = Comment.builder()
                .content(request.getContent())
                .userId(connectAuthService.getUserIdByAccessToken(accessToken))
                .userNickname(connectAuthService.getNicknameByAccessToken(accessToken))
                .productId(productId)
                .isDeleted(false)
                .build();
        commentRepository.save(comment);
    }

    public void updateComment(Long productId, Long commentId, CommentUpdateRequest request, String accessToken) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        productService.getProduct(productId);
        Comment comment = getComment(commentId);
        if (!userId.equals(comment.getUserId())) {
            throw new InvalidTokenException("일치하지 않는 사용자입니다");
        }
        updateIfNotNull(request::getContent, comment::setContent);
        commentRepository.save(comment);
    }

    public void deleteComment(Long commentId, String accessToken) {
        Long userId = connectAuthService.getUserIdByAccessToken(accessToken);
        Comment comment = getComment(commentId);
        if (!userId.equals(comment.getUserId())) {
            throw new InvalidTokenException("일치하지 않는 사용자입니다");
        }
        comment.setIsDeleted(true);
        commentRepository.save(comment);
    }

    private <T> void updateIfNotNull(Supplier<T> getter, Consumer<T> setter) {
        T value = getter.get();
        if (value != null) {
            setter.accept(value);
        }
    }

    public Comment getComment(Long id) {
        return commentRepository.findById(id)
                .map(comment -> {
                    if (comment.getIsDeleted() == null || comment.getIsDeleted()) {
                        throw new CommentNotFoundException(id + DELETED);
                    }
                    return comment;
                })
                .orElseThrow(() -> new CommentNotFoundException(id + NOT_FOUND));
    }
}
