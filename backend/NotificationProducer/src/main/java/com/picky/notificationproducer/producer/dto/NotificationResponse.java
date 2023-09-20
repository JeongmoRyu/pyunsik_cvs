package com.picky.notificationproducer.producer.dto;

import com.picky.notificationproducer.producer.domain.entity.Notification;
import lombok.Builder;
import lombok.Getter;

import java.util.HashMap;
import java.util.List;

@Getter
@Builder
public class NotificationResponse {

    private HashMap<String, HashMap<String, List<String>>> message;

    public static NotificationResponse toResponse(Notification notification) {
        return NotificationResponse.builder()
                .message(notification.getMessage())
                .build();
    }
}
