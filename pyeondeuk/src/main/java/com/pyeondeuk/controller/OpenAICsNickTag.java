package com.pyeondeuk.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import okhttp3.*;

import java.io.IOException;
import java.util.List;

public class OpenAICsNickTag {
	
	 private static final String API_URL = "https://api.openai.com/v1/completions";
	    private static final String API_KEY = "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";

	    /**
	     * 리뷰 데이터를 기반으로 별명과 태그를 생성합니다.
	     * @param reviews 리뷰 목록
	     * @return 생성된 별명과 태그를 포함한 JSON 객체
	     * @throws IOException API 호출 중 오류가 발생한 경우
	     */
	    public static JsonObject generateNickAndTag(List<String> reviews) throws IOException {
	        OkHttpClient client = new OkHttpClient();

	        // 리뷰를 하나의 텍스트로 합칩니다.
	        String reviewText = String.join("\n", reviews);

	        // OpenAI API 요청 본문 생성
	        JsonObject requestBody = new JsonObject();
	        requestBody.addProperty("model", "text-davinci-003");
	        requestBody.addProperty("prompt", "다음 리뷰를 기반으로 편의점의 귀엽고 재미있 별명(cs_nick)과 태그(cs_tag)를 생성하세요:\n" + reviewText + "\n별명과 태그를 JSON 형식으로 반환하세요.");
	        requestBody.addProperty("max_tokens", 1000);
	        requestBody.addProperty("temperature", 0.7);

	        RequestBody body = RequestBody.create(
	                MediaType.parse("application/json"),
	                requestBody.toString()
	        );

	        // OpenAI API 요청
	        Request request = new Request.Builder()
	                .url(API_URL)
	                .post(body)
	                .addHeader("Authorization", "Bearer " + API_KEY)
	                .addHeader("Content-Type", "application/json")
	                .build();

	        Response response = client.newCall(request).execute();

	        if (response.isSuccessful() && response.body() != null) {
	            // 응답 데이터를 JSON으로 변환
	            String responseBody = response.body().string();
	            JsonObject jsonResponse = JsonParser.parseString(responseBody).getAsJsonObject();
	            String result = jsonResponse.getAsJsonArray("choices").get(0).getAsJsonObject().get("text").getAsString();

	            // 결과를 JSON으로 파싱하여 반환
	            return JsonParser.parseString(result).getAsJsonObject();
	        } else {
	            throw new IOException("OpenAI API 요청 실패: " + response.message());
	        }
	    }
}
