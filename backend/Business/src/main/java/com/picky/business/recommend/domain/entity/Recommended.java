package com.picky.business.recommend.domain.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "recommended_product")
@Getter
@Setter
@AllArgsConstructor
@Builder
@NoArgsConstructor
@ToString
public class Recommended {
    @Id
    private Long id;

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "product_id")
    private Long productId;

    private float rating;
}


