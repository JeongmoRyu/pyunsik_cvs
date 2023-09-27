package com.picky.business.log.domain.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "log_product")
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
//특정 상품 조회했을 때, 찍는 로그
public class LogProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "user_id")
    private Long userId;
    @Column(name = "product_id")
    private Long productId;

    @Column(name = "created_at")
    @CreatedDate
    private LocalDate createdAt;
}
