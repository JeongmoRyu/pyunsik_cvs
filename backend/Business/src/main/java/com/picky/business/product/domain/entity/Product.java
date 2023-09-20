package com.picky.business.product.domain.entity;

import com.picky.business.favorite.domain.entity.Favorite;
import lombok.*;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.*;
import javax.persistence.criteria.Predicate;
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
    @Column(columnDefinition = "boolean default false")
    private Boolean isDeleted = false;

    @Column(name="convenience_code")
    private int convenienceCode;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
    private List<Comment> comments;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
    private List<Favorite> favorites;

        public static Specification<Product> filterProducts(
            String productName,
            String category,
            int minPrice, int maxPrice,
            int minCarb, int maxCarb,
            int minProtein, int maxProtein,
            int minFat, int maxFat,
            int minSodium, int maxSodium) {

        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (productName != null) {
                predicates.add(criteriaBuilder.like(root.get("productName"), "%" + productName + "%"));
            }

            if (category != null) {
                predicates.add(criteriaBuilder.equal(root.get("category"), category));
            }
            predicates.add(criteriaBuilder.between(root.get("price"), minPrice, maxPrice));
            predicates.add(criteriaBuilder.between(root.get("carb"), minCarb, maxCarb));
            predicates.add(criteriaBuilder.between(root.get("protein"), minProtein, maxProtein));
            predicates.add(criteriaBuilder.between(root.get("fat"), minFat, maxFat));
            predicates.add(criteriaBuilder.between(root.get("sodium"), minSodium, maxSodium));
            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
    }
}