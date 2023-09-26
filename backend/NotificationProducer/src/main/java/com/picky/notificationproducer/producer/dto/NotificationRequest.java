package com.picky.notificationproducer.producer.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class NotificationRequest {

    private List<String> message;

    @Builder
    public NotificationRequest(List<String> message) {
        this.message = message;
    }
}
