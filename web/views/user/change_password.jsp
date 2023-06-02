<%-- 
    Document   : profile
    Created on : Apr 27, 2023, 7:31:47 AM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rượu ngoại</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <script src="https://kit.fontawesome.com/ddee20c3c8.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel = "stylesheet" href = "assets/user/change_password/styles.css">
        <link rel = "stylesheet" href = "assets/user/common/header.css">
        <link rel = "stylesheet" href = "assets/user/common/footer.css">
    </head>
    <body>
        <div class="container">
            <!--Start header-->
            <%@include  file="header.jsp" %>
            <!--End header-->
            <c:set var="user" value="${sessionScope.user}"/>
            <div class="main">
                <div class="main-heading"><p>Đổi Mật Khẩu</p></div>
                <div class="user-info">
                    <form action="user_change_password" method="post" id="form" class="form">
                        <div class="form-group">
                            <input type="password" placeholder="Mật khẩu cũ" id="old-password" name="old_password">
                            <span class="success-icon">
                                <i class="fa-solid fa-check"></i>
                            </span>
                            <span class="error-icon">
                                <i class="fa-solid fa-xmark"></i>
                            </span>
                            <small id="wrong-old-password">Error</small>
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
                            <button type="submit">Xác Nhận</button>
                        </div>
                        <div class="link">
                            <a href="user_profile">Quay Lại</a>
                        </div>
                    </form>
                </div>
            </div>
            <!--Start footer-->
            <%@include  file="footer.jsp" %>
            <!--End footer-->

            <script src="assets/user/change_password/main.js"></script>
            <script>
                var wrongOldPassword = "${requestScope.wrongOldPassword}";
                if (wrongOldPassword !== "") {
                  const errorMessage = document.getElementById("wrong-old-password");
                  errorMessage.innerText = wrongOldPassword;
                  errorMessage.classList.add("visible");
                  oldPassword.focus();
                }
                
                var changePasswordError = "${requestScope.changePasswordError}";
                if (changePasswordError !== "") {
                    alert(changePasswordError);
                }
            </script>
        </div>
    </body>
</html>