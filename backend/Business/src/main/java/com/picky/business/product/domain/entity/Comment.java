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
    private String content;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column
    private Boolean isDeleted;

    @Column
    private LocalDateTime createdAt;
}