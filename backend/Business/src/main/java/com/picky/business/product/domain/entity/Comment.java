package com.picky.business.product.domain.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "comment")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EntityListeners(AuditingEntityListener.class)
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column
    private Long userId;
    @Column
    private String userNickname;
    @Column
    private String content;


    // 댓글과 제품 간의 ManyToOne 관계 설정
    @ManyToOne
    @JoinColumn(name = "product_id", insertable = false, updatable = false)
    private Product product;

    // productId 필드 추가
    @Column(name = "product_id")
    private Long productId;

    @Column(columnDefinition = "boolean default false")
    private Boolean isDeleted = false;

    @Column
    @CreatedDate
    private LocalDateTime createdAt;

}