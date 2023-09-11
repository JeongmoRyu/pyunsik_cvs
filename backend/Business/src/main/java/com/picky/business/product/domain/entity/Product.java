package com.picky.business.product.domain.entity;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "product")
@Getter
@Setter
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column
    private String productName;
    @Column
    private int price;
    @Column
    private String filename;
    @Column
    private String badge;
    @Column
    private int category;
    @Column
    private int favoriteCount;
    @Column
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

    @ElementCollection
    @CollectionTable(name = "convenience_store")
    @Column(name = "convenience_store_code")
    private List<Integer> convenienceCode = new ArrayList<>();

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
    private List<Comment> comments;
}