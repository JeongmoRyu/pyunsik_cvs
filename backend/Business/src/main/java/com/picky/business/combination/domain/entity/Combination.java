package com.picky.business.combination.domain.entity;

import lombok.*;
import org.hibernate.annotations.BatchSize;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "combination")
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Setter
@ToString
public class Combination {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false, name = "user_id")
    private Long userId;
    @Column(name = "total_kcal")
    private int totalKcal;
    @Column(name = "total_price")
    private int totalPrice;
    @Column(name = "total_carb")
    private double totalCarb;
    @Column(name = "total_protein")
    private double totalProtein;
    @Column(name = "total_fat")
    private double totalFat;
    @Column(name = "total_sodium")
    private double totalSodium;
    @Column(name = "combination_name")
    private String combinationName;
    @Column(nullable = false, name = "is_deleted")
    private Boolean isDeleted;

    @Column(name = "created_at")
    @CreatedDate
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "combination", cascade = CascadeType.ALL)
    @BatchSize(size = 100)
    private List<CombinationItem> items;

}
