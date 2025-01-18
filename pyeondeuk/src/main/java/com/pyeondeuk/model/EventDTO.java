package com.pyeondeuk.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data // 모든 게터 세터 기본생성자 추가
@AllArgsConstructor // 모든 항목이 들어있는 생성자 추가
@NoArgsConstructor // 위에거 추가해서 사라진 기본생성자 추가
@ToString

public class EventDTO {
    private int EVENT_SEQ;
    private int BRAND_SEQ;
    private String EVENT_URL;
    private String EVENT_SRC;
    private String EVENT_NAME;


}
