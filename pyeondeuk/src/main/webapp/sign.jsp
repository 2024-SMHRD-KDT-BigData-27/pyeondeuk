<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">

<head>
    <link rel="stylesheet" href="resources/css/sign.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
    <div id="logo-container">
        <div id="logo">
            <a href="index.jsp"><img src="resources/images/logo.png" width="200px" alt="Logo"></a>
        </div>
    </div>
   
   <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <p style="color: red; text-align: center;"><%= error %></p>
    <% } %>

    <div class="container">
        <!-- Heading -->
        <h1>회원가입</h1>
        <!-- Form -->
        <form action="JoinService" method="post" onsubmit="return validateForm();">
            <!-- email input -->
            <div class="first-input input__block first-input__block">
                <input type="email" placeholder="이메일" class="input" id="email" name="email" required />
            </div>
            <!-- password input -->
            <div class="input__block">
                <input type="password" placeholder="비밀번호" class="input" id="password" name="pw" required />
            </div>
            <!-- confirm password input -->
            <div class="input__block">
                <input type="password" placeholder="비밀번호 재확인" class="input" id="confirmPassword" required />
            </div>
            <!-- nick input -->
            <div class="input__block">
                <input type="text" placeholder="닉네임" class="input" name="nick" required />
            </div>
            <!-- 로그인 sign in button -->
            <button class="signin__btn" type="submit">
                회원가입
            </button>
            <br>
        </form>
    </div>
    
    
   
</body>
</html>

