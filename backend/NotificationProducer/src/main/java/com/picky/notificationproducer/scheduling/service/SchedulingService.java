package com.picky.notificationproducer.scheduling.service;

import com.picky.notificationproducer.producer.service.ProducerService;
import com.picky.notificationproducer.scheduling.domain.entiity.User;
import com.picky.notificationproducer.scheduling.domain.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@EnableScheduling
public class SchedulingService {

    private final UserRepository userRepository;
    private final ProducerService producerService;

    public SchedulingService(UserRepository userRepository, ProducerService producerService) {
        this.userRepository = userRepository;
        this.producerService = producerService;
    }

    @Scheduled(cron = "0 0/1 * * * ?") // Test용 1분에 1번씩
    public void getFCMTokenOfAll() {

        log.info("[getFCMTokenOfAll] 활성화 유저 목록 불러오기");
        List<String> userFCMTokenList = userRepository.findAllByIsDeletedFalse().stream()
                .map(User::getFcmToken)
                .collect(Collectors.toList());

        System.out.println("userList : " + userFCMTokenList);
        log.info("[getFCMTokenOfAll] 알람 발송 기능에 유저 목록 전달");
        producerService.sendMessage(userFCMTokenList, "Notification");
    }


}
