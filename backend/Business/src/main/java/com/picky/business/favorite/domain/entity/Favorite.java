package com.picky.business.favorite.domain.entity;

import com.picky.business.product.domain.entity.Product;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "favorite")
@Getter
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "product_id")
    private Long productId;
    private Long userId;
    private boolean isDeleted = false;

    @Column
    @CreatedDate
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "product_id", insertable = false, updatable = false)
    private Product product;

    public void delete() {
        this.isDeleted = true;
    }

    public void add() {
        this.isDeleted = false;
    }

}
