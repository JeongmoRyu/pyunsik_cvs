package com.picky.notificationproducer.producer.domain.entity;

import com.picky.notificationproducer.producer.dto.NotificationRequest;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class Notification {

    @Id
    private String date;
    private List<String> message;

    @Builder
    public Notification(String date, List<String> message) {
        this.date = date;
        this.message = message;
    }

    public static Notification toEntity(NotificationRequest request) {
        return Notification.builder()
                .date(LocalDateTime.now().toString())
                .message(request.getMessage())
                .build();
    }
}
