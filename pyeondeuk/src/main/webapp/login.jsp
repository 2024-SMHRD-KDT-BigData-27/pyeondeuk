<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <link rel="stylesheet" href="resources/css/login.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
</head>

<body>

    <div id="logo-container">
        <div id="logo">
            <a href="index.jsp"><img src="resources/images/logo.png" width="200px" alt="Logo"></a>
        </div>
    </div>

    <div class="container">
        <!-- Heading -->
        <h1>환영합니다</h1>

        <!-- Links -->
        <ul class="links">
            <li>
                <a href="#" id="signin">로그인</a>
            </li>
            <li>
                <a href="sign.jsp" id="signup">회원가입</a>
            </li>
        </ul>

        <!-- Form -->
        <form action="LoginService" method="post">
            <!-- email input -->
            <div class="first-input input__block first-input__block">
                <input type="email" placeholder="이메일" class="input" id="email" name="email" required />
            </div>
            <!-- password input -->
            <div class="input__block">
                <input type="password" placeholder="비밀번호" class="input" id="password" name="pw" required />
            </div>
            
            <!-- 로그인 sign in button -->
            <button class="signin__btn" type="submit">
                로그인
            </button>
        </form>
        <!-- separator -->
        <div class="separator">
            <p>OR</p>
        </div>
        <!-- 네이버 로그인 버튼 -->
        <a class="google__btn" href="https://nid.naver.com/nidlogin.login?mode=form&url=https://www.naver.com/" style="text-align: center; text-decoration: none;">
            <i class="fa fa-google"></i>
            네이버 아이디로 로그인
        </a>
        
 </div>

        <!-- 카카오 로그인 버튼 -->
        <a class="github__btn" href="https://accounts.kakao.com/login/?continue=https%3A%2F%2Faccounts.kakao.com%2Fweblogin%2Faccount#login" style="text-align: center; text-decoration: none;">
            <i class="fa fa-github"></i>
            카카오 아이디로 로그인
        </a>
    </div>
</body>

</html>
