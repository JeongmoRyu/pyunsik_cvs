package com.picky.business.connect.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
@RequiredArgsConstructor
public class ConnectAuthService {
    private final RestTemplate restTemplate;
    //TODO 서버에 배포시 localhost -> auth server docker image name으로 변경 필요
    private static final String BASEURL = "http://localhost:8081/api/auth";

    public Long getUserIdByAccessToken(String accessToken) {
        String url = BASEURL + "/user-id/" + accessToken;
        return Long.parseLong(restTemplate.getForObject(url, String.class));
    }

    public String getNicknameByAccessToken(String accessToken) {
        String url = BASEURL + "/nickname/" + accessToken;
        log.info("url:-------------------"+url);
        return restTemplate.getForObject(url, String.class);
    }
}
