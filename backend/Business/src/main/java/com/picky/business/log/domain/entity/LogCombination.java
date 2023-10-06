package com.picky.business.log.domain.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "log_combination")
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
//조합 생성, 수정, 변경했을 때, 조합 내용을 저장하는 로그
public class LogCombination {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long userId;
    @Column
    @CreatedDate
    private LocalDateTime createdAt;
    //Combination Item 리스트
    @Column(name="log_combination_item")
    @ElementCollection
    @CollectionTable(name="log_combination_item")
    private List<Long> logCombinationItem = new ArrayList<>();
}
