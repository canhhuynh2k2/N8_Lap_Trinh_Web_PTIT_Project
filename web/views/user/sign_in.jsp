<%-- 
    Document   : sign_in
    Created on : Apr 1, 2023, 9:31:15 PM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
    integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <title>Đăng Nhập</title>
  <link rel="stylesheet" href="assets/user/sign_in/styles.css">
</head>

<body>
  <div class="back-to-home">
    <a href="home">Trang Chủ</a>
  </div>
  <div class="inner-wrap">
    <div class="header">
      <h1>Đăng Nhập</h1>
    </div>
    <form action="user_sign_in" method="post" id="form" class="form">
      <div class="form-group">
        <input type="text" placeholder="Email" id="email" name="email">
        <span class="success-icon">
          <i class="fa-solid fa-check"></i>
        </span>
        <span class="error-icon">
          <i class="fa-solid fa-xmark"></i>
        </span>
        <small id="wrong-user">Error</small>
      </div>
      <div class="form-group">
        <input type="password" placeholder="Nhập mật khẩu" id="password" name="password">
        <span class="success-icon">
          <i class="fa-solid fa-check"></i>
        </span>
        <span class="error-icon">
          <i class="fa-solid fa-xmark"></i>
        </span>
        <small>Error</small>
      </div>
      <div class="btn">
        <button type="submit">Đăng Nhập</button>
      </div>
    </form>
    <div class="sign-up">
      <a href="user_sign_up">Chưa Có Tài Khoản</a>
    </div>
  </div>

  <script src="assets/user/sign_in/main.js"></script>
  <script type="text/javascript">
    var wrongUser = "${requestScope.wrongUser}";
    if (wrongUser !== "") {
      const errorMessage = document.getElementById("wrong-user");
      errorMessage.innerText = wrongUser;
      errorMessage.classList.add("visible");
      email.focus();
    }
    
    var servletPath = "${sessionScope.servletPath}";
    if (servletPath !== "") {
        alert(servletPath);
    }
  </script>
</body>

</html>