package com.grgr.service;

import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.grgr.dto.UserVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class OAuthServiceImpl implements OAuthService {

    private final RestTemplate restTemplate; 

    private final String clientId = "843097710124-bjfh1r074vs540jiot9vnd1b0rabhu0h.apps.googleusercontent.com"; 
    private final String clientSecret = "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"; 
    private final String redirectUri = "http://localhost:80/main"; // 구글 OAuth 콜백 URL

    @Override
    public String getGoogleAuthorizationUrl() {
        String googleAuthUrl = "https://accounts.google.com/o/oauth2/auth?"
                + "client_id=" + clientId
                + "&redirect_uri=" + redirectUri
                + "&scope=openid profile email"
                + "&response_type=code";

        return googleAuthUrl;
    }

    @Override
    public UserVO getUserInfoFromGoogle(String code) {
        // 구글 OAuth 2.0 토큰 엔드포인트에 요청하여 액세스 토큰 및 사용자 정보 가져오기
        String tokenUrl = "https://accounts.google.com/o/oauth2/token";
        MultiValueMap<String, String> tokenParams = new LinkedMultiValueMap<>();
        tokenParams.add("code", code);
        tokenParams.add("client_id", clientId);
        tokenParams.add("client_secret", clientSecret);
        tokenParams.add("redirect_uri", redirectUri);
        tokenParams.add("grant_type", "authorization_code");

        ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, tokenParams, Map.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            String accessToken = (String) response.getBody().get("access_token");

            // 액세스 토큰을 사용하여 사용자 정보 가져오기
            String userInfoUrl = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken;
            ResponseEntity<UserVO> userInfoResponse = restTemplate.exchange(userInfoUrl, HttpMethod.GET, null, UserVO.class);

            if (userInfoResponse.getStatusCode() == HttpStatus.OK) {
                return userInfoResponse.getBody();
            }
        }

        return null;
    }
}