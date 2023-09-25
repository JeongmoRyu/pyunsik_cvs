package com.picky.business.combination.domain.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "combination_item")
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class CombinationItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private int amount;
    private Long productId;
    private String productName;
    private int price;
    private String filename;
    private Boolean isDeleted = false;

    @Column(name = "combination_id")
    private Long combinationId;

    @ManyToOne
    @JoinColumn(name = "combination_id", insertable = false, updatable = false)
    private Combination combination;

}
