package com.picky.notificationproducer.producer.controller;

import com.picky.notificationproducer.producer.dto.NotificationRequest;
import com.picky.notificationproducer.producer.service.ProducerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/producer")
@Slf4j
public class ProducerController {

    private final ProducerService producerService;

    public ProducerController(ProducerService producerService) {
        this.producerService = producerService;
    }

    @PostMapping("/send")
    public ResponseEntity<Void> sendMessage(@RequestBody NotificationRequest request) {
        producerService.sendMessage(request.getMessage(), "Notification");
        return ResponseEntity.ok().build();
    }
}
