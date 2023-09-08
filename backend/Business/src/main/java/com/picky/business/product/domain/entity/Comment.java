package com.picky.business.product.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "comment")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column
    private Long userId;
    @Column
    private String userNickname;
    @Column
    private Long productId;
    @Column
    private String content;
    @Column
    private LocalDateTime createdAt;
    @Column
    private Boolean isDeleted = false;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
}
