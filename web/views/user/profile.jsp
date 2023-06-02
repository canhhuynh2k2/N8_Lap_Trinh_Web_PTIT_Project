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
        <link rel = "stylesheet" href = "assets/user/profile/styles.css">
        <link rel = "stylesheet" href = "assets/user/common/header.css">
        <link rel = "stylesheet" href = "assets/user/common/footer.css">
    </head>
    <body>
        <div class="container">
            <!--Start header-->
            <%@include  file="header.jsp" %>
            <!--End header-->
            <div class="main">
                <div class="main-heading"><p>Thông Tin Tài khoản</p></div>
                <div class="user-info">
                    <div class="form">
                        <c:set var="user" value="${sessionScope.user}"/>
                        <div class="form-group">
                            <label for="role_id">Chuc Vu:</label>
                            <input readonly value="${user.role.name}" id="role_id">
                        </div>
                        <div class="form-group">
                            <label for="fullname">Ho Va Ten:</label>
                            <input id="fullname" type="text" readonly value="${user.fullname}">
                        </div>
                        <div class="form-group">
                            <label for="phone-number">So Dien Thoai:</label>
                            <input id="phone-number" type="text" readonly value="${user.phoneNumber}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input id="email" type="text" readonly value="${user.email}">
                        </div>
                    </div>
                </div>
                <div class="link">
                    <div class="link-btn">
                        <a class="btn" href="user_update_profile">Chỉnh Sửa</a>
                        <a class="btn" href="user_change_password">Đổi Mật Khẩu</a>
                        <a class="btn" href="sign_out">Đăng Xuất</a>
                    </div>
                </div>
            </div>
            <!--Start footer-->
            <%@include  file="footer.jsp" %>
            <!--End footer-->
            
            <script>
                var changePasswordSuccess = "${requestScope.changePasswordSuccess}";
                var updateProfileSuccess = "${requestScope.updateProfileSuccess}";
                if (changePasswordSuccess !== "") {
                    alert(changePasswordSuccess);
                } else if (updateProfileSuccess !== "") {
                    alert(updateProfileSuccess);
                }
            </script>
            
        </div>
    </body>
</html>