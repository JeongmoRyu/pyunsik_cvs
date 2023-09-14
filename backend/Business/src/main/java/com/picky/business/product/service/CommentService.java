package com.picky.business.product.service;

import com.picky.business.exception.CommentNotFoundException;
import com.picky.business.exception.ProductNotFoundException;
import com.picky.business.product.domain.entity.Comment;
import com.picky.business.product.domain.repository.CommentRepository;
import com.picky.business.product.domain.repository.ProductRepository;
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
    private final ProductRepository productRepository;
    private final ProductService productService;
    private static final String NOT_FOUND = "값을 가진 데이터가 없습니다";

    //TODO Token 정보로 userId, userNickname 가져오기 해야함
    @Transactional
    public void addComment(Long productId, CommentWriteRequest request) {
        Comment comment = Comment.builder()
                .content(request.getContent())
                .userId(0L)
                .userNickname("TestNickName")
                .productId(productId)
                .build();
        comment.setIsDeleted(false);
        commentRepository.save(comment);
    }

    public void updateComment(Long productId, Long commentId, CommentUpdateRequest request) {
        productService.findProductByProductId(productId);
        Comment currentComment = commentRepository.findById(commentId)
                .orElseThrow(() -> new CommentNotFoundException("Comment:" + commentId + NOT_FOUND));
        log.info("바꿀 내용: "+request.getContent());
        updateIfNotNull(request::getContent, currentComment::setContent);
        log.info("변경 후 내용:" + currentComment.getContent());
        commentRepository.save(currentComment);
    }
    public void deleteComment(Long commentId){
        commentRepository.findById(commentId)
                .ifPresentOrElse(
                        comment -> commentRepository.deleteById(commentId),
                        () -> {
                            throw new CommentNotFoundException(commentId + " NOT FOUND");
                        }
                );
    }

    private <T> void updateIfNotNull(Supplier<T> getter, Consumer<T> setter) {
        T value = getter.get();
        if (value != null) {
            setter.accept(value);
        }
    }
}
