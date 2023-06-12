<%-- 
    Document   : sign_up
    Created on : Apr 27, 2023, 7:13:12 AM
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
  <title>Đăng Ký</title>
  <link rel="stylesheet" href="assets/user/sign_up/styles.css">
</head>

<body>
  <div class="back-to-home">
    <a href="home">Trang Chủ</a>
  </div>
  <div class="inner-wrap">
    <div class="header">
      <h1>Tạo Tài Khoản Mới</h1>
    </div>
    <form action="user_sign_up" method="post" id="form" class="form">
      <div class="form-group">
        <input type="text" placeholder="Họ Và Tên" id="full-name" name="full_name" value="${requestScope.fullName}">
        <span class="success-icon">
          <i class="fa-solid fa-check"></i>
        </span>
        <span class="error-icon">
          <i class="fa-solid fa-xmark"></i>
        </span>
        <small>Error</small>
      </div>
      <div class="form-group">
        <input type="text" placeholder="Số điện thoại" id="phone-number" maxlength="11" name="phone_number"
          value="${requestScope.phoneNumber}">
        <span class="success-icon">
          <i class="fa-solid fa-check"></i>
        </span>
        <span class="error-icon">
          <i class="fa-solid fa-xmark"></i>
        </span>
        <small>Error</small>
      </div>
      <div class="form-group">
        <input type="text" placeholder="Email" id="email" name="email">
        <span class="success-icon">
          <i class="fa-solid fa-check"></i>
        </span>
        <span class="error-icon">
          <i class="fa-solid fa-xmark"></i>
        </span>
        <small id="email-existed">Error</small>
      </div>
      <div class="form-group">
        <input type="password" placeholder="Mật khẩu mới" id="password" name="password">
        <span class="success-icon">
          <i class="fa-solid fa-check"></i>
        </span>
        <span class="error-icon">
          <i class="fa-solid fa-xmark"></i>
        </span>
        <small>Error</small>
      </div>
      <div class="form-group">
        <input type="password" placeholder="Nhập lại mật khẩu mới" id="confirm-password">
        <span class="success-icon">
          <i class="fa-solid fa-check"></i>
        </span>
        <span class="error-icon">
          <i class="fa-solid fa-xmark"></i>
        </span>
        <small>Error</small>
      </div>
      <div class="btn">
        <button type="submit">Đăng ký</button>
      </div>
    </form>
    <div class="sign-in">
      <a href="user_sign_in">Đã Có Tài Khoản</a>
    </div>
  </div>

  <script src="assets/user/sign_up/main.js"></script>
  <script type="text/javascript">
    var isExisted = "${requestScope.isExisted}";
    if (isExisted !== "") {
      const errorMessage = document.getElementById("email-existed");
      errorMessage.innerText = isExisted;
      errorMessage.classList.add("visible");
      email.focus();
    }
  </script>
</body>

</html>