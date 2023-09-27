package com.picky.business.log.domain.entity;

import lombok.*;
import org.hibernate.annotations.BatchSize;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "log_combination")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
//조합 생성, 수정, 변경했을 때, 조합 내용을 저장하는 로그
public class LogCombination {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "user_id")
    private Long userId;
    @Column(name = "created_at")
    @CreatedDate
    private LocalDateTime createdAt;
    //Combination Item 리스트
    @OneToMany(mappedBy = "logCombination", cascade = CascadeType.ALL)
    @BatchSize(size = 100)
    private List<LogCombinationItem> items;

}
