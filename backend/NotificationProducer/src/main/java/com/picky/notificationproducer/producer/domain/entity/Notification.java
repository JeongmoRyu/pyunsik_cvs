package com.picky.notificationproducer.producer.domain.entity;

import com.picky.notificationproducer.producer.dto.NotificationRequest;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Getter
@Setter
@NoArgsConstructor
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String message;

    @Builder
    public Notification(String message) {
        this.message = message;
    }

    public static Notification toEntity(NotificationRequest request) {
        return Notification.builder()
                .message(request.getMessage())
                .build();
    }
}
