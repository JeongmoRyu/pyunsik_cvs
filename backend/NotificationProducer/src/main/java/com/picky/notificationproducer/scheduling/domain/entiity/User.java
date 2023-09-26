package com.picky.notificationproducer.scheduling.domain.entiity;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@RequiredArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false, unique = true)
    private String uuid;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, length = 20)
    private String nickname;

    @Column(nullable = false)
    private boolean isDeleted = false;

    private int height;

    private int weight;

    private int age;

    private int gender;

    @Column(nullable = false)
    private String fcmToken;

    @ElementCollection(fetch = FetchType.EAGER) // 엔티티가 검색될 때 해당 엔티티와 연결된 roles 리스트 데이터도 함께 가져옴
    private List<String> roles = new ArrayList<>();

}
