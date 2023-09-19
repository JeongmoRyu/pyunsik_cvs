package com.picky.notificationproducer.producer.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class NotificationRequest {

    private String message;

    @Builder
    public NotificationRequest(String message) {
        this.message = message;
    }
}
