package com.picky.business.log.domain.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name="log_product")
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
    private Long userId;
    private Long productId;

    @Column
    @CreatedDate
    private LocalDateTime createdAt;
}
