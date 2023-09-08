package com.picky.business.product.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="product")
@Getter
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String productName;
    @Column(nullable = false)
    private int price;
    @Column(nullable = false)
    private String filename;
    @Column
    private Badge badge;
    @Column(nullable = false)
    private int category;
    @Column (nullable = false)
    private int favoriteCount = 0;
    @Column (nullable = false)
    private int weight;
    @Column
    private int kcal;
    @Column
    private double carb;
    @Column
    private double protein;
    @Column
    private double fat;
    @Column
    private double sodium;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    //편의점 코드
    @ElementCollection
    @CollectionTable(name="convenience_store")
    @Column(name="convenience_store_code")
    private List<Integer> logCombinationItem = new ArrayList<>();

}
