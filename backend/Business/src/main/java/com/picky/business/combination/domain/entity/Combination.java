package com.picky.business.combination.domain.entity;

import com.picky.business.product.domain.entity.Comment;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "combination")
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class Combination {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private Long userId;
    private int totalKcal;
    private int totalPrice;
    private double totalCarb;
    private double totalProtein;
    private double totalFat;
    private double totalSodium;
    private String combinationName;
    @Column(nullable = false)
    private Boolean isDeleted;
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "combination", cascade = CascadeType.ALL)
    private List<CombinationItem> items = new ArrayList<>();

}
