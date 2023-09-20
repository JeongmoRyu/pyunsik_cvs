package com.picky.notificationproducer.producer.dto;

import com.picky.notificationproducer.producer.domain.entity.Notification;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class NotificationResponse {

    private String message;

    public static NotificationResponse toResponse(Notification notification) {
        return NotificationResponse.builder()
                .message(notification.getMessage())
                .build();
    }
}
