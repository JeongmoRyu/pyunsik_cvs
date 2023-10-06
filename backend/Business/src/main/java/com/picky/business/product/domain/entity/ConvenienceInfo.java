package com.picky.business.product.domain.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "convenience_info")
@Getter
@Setter
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class ConvenienceInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "product_id")
    private Long productId;
    @Column(name = "convenience_code")
    private int convenienceCode;
    @Column(name = "promotion_code")
    private int promotionCode;

    @ManyToOne
    @JoinColumn(name = "product_id", insertable = false, updatable = false)
    private Product product;
}
