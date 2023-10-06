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
    @Column
    private int convenienceCode;
    @Column
    private int promotionCode;

    @ManyToOne
    @JoinColumn(name = "product_id", insertable = false, updatable = false)
    private Product product;
}
