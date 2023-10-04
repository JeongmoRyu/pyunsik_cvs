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
    @Column(name = "user_id")
    private int userId;

    @Column(name = "product_id")
    private int productId;

    private float rating;
}
