package com.picky.notificationproducer.producer.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@NoArgsConstructor
public class NotificationRequest {

    private HashMap<String, HashMap<String, List<String>>> message;

    @Builder
    public NotificationRequest(HashMap<String, HashMap<String, List<String>>> message) {
        this.message = message;
    }
}
