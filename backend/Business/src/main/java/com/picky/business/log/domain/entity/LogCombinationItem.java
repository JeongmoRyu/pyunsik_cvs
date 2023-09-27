package com.picky.business.log.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LogCombinationItem {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "product_id")
    private Long productId;

    @Column(name="combination_id")
    private Long combinationId;

    @ManyToOne
    @JoinColumn(name = "log_combination_id", insertable = false, updatable = false)
    private LogCombination logCombination;



}
