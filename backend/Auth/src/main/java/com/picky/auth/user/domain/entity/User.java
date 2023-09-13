package com.picky.auth.user.domain.entity;

import com.picky.auth.user.dto.SignUpRequest;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false, unique = true)
    private String UUID;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, length = 20)
    private String nickname;

    @Column(nullable = false)
    private boolean isDeleted;

    private int height;

    private int weight;

    private int age;

    private int gender;

    private String fcmToken;

    @ElementCollection(fetch = FetchType.EAGER) // 엔티티가 검색될 때 해당 엔티티와 연결된 roles 리스트 데이터도 함께 가져옴
    private List<String> roles = new ArrayList<>();

    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.roles.stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList());
    }

    @Builder
    public User(long id, String password, String nickname, boolean isDeleted, int height, int weight, int age, int gender, String fcmToken, List<String> roles) {
        this.id = id;
        this.UUID = java.util.UUID.randomUUID().toString();
        this.password = password;
        this.nickname = nickname;
        this.isDeleted = isDeleted;
        this.height = height;
        this.weight = weight;
        this.age = age;
        this.gender = gender;
        this.fcmToken = fcmToken;
        this.roles = roles;
    }

    public static User toEntity(SignUpRequest request) {
        return User.builder()
                .password(request.getPassword())
                .nickname(request.getNickname())
                .isDeleted(request.isDeleted())
                .height(request.getHeight())
                .weight(request.getWeight())
                .age(request.getAge())
                .gender(request.getGender())
                .fcmToken(request.getFcmToken())
                .roles(request.getRoles())
                .build();
    }
}
