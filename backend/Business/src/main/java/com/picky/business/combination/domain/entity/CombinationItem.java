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
    private Boolean isDeleted = false;

    @ManyToOne
    @JoinColumn(name = "combination_id")
    private Combination combination;
}
