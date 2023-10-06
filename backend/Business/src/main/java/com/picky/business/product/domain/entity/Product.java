package com.picky.business.product.domain.entity;

import com.picky.business.favorite.domain.entity.Favorite;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Entity
@Table(name = "product")
@Getter
@Setter
@AllArgsConstructor
@Builder
@NoArgsConstructor
@ToString
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "product_name")
    private String productName;
    @Column
    private int price;
    @Column
    private String filename;
    @Column
    private int category;
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
    @Column(columnDefinition = "boolean default false", name = "is_deleted")
    private Boolean isDeleted = false;

    @OneToMany(mappedBy = "product")
    @Fetch(FetchMode.SUBSELECT)
    private List<ConvenienceInfo> convenienceInfos;


    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
    private List<Comment> comments;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
    private List<Favorite> favorites;

    public static Specification<Product> filterProducts(
            String category,
            List<Integer> price, List<Integer> carb,
            List<Integer> protein, List<Integer> fat,
            List<Integer> sodium,
            List<Integer> convenienceCodes,
            List<Integer> promotionCodes
    ) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            List<Predicate> predicates = new ArrayList<>();

            if (category != null) {
                predicates.add(criteriaBuilder.equal(root.get("category"), category));
            }

            addBetweenFilter(predicates, root, criteriaBuilder, "price", price);
            addBetweenFilter(predicates, root, criteriaBuilder, "carb", carb);
            addBetweenFilter(predicates, root, criteriaBuilder, "protein", protein);
            addBetweenFilter(predicates, root, criteriaBuilder, "fat", fat);
            addBetweenFilter(predicates, root, criteriaBuilder, "sodium", sodium);

            addListFilter(predicates, root, "convenienceInfos", "convenienceCode", convenienceCodes);
            addListFilter(predicates, root, "convenienceInfos", "promotionCode", promotionCodes);

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
    }

    private static void addBetweenFilter(List<Predicate> predicates, Root<Product> root, CriteriaBuilder criteriaBuilder, String field, List<Integer> list) {
        int min = Optional.ofNullable(list)
                .filter(l -> !l.isEmpty())
                .map(l -> l.get(0))
                .orElse(0);
        int max = Optional.ofNullable(list)
                .filter(l -> !l.isEmpty())
                .map(l -> l.get(1))
                .orElse(Integer.MAX_VALUE);
        if (min != 0 || max != Integer.MAX_VALUE) {
            predicates.add(criteriaBuilder.between(root.get(field), min, max));
        }
    }

    private static <T> void addListFilter(List<Predicate> predicates, Root<Product> root, String joinField, String filterField, List<Integer> list) {
        if (list != null && !list.isEmpty()) {
            Join<Product, T> join = root.join(joinField);
            predicates.add(join.get(filterField).in(list));
        }
    }
}