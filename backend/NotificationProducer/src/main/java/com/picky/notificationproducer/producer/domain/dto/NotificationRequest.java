package com.picky.notificationproducer.producer.domain.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class NotificationRequest {

    private String message;

}
