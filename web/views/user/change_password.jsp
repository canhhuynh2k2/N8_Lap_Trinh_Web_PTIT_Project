<%-- 
    Document   : change_password
    Created on : Apr 27, 2023, 7:46:44 AM
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
        <link rel = "stylesheet" href = "assets/user/profile/changepassword.css">
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
                <div class="main-content">
                        <p class = "form-contact__heading">Thay Đổi Mật Khẩu</p>
                        <form action="user_changer_password" method="post">
                            <div class="form-group">
                                <label for="password">Mật Khẩu Hiện Tại *</label>
                                <input type="password" placeholder="Nhập Mật Khẩu Hiện tại" id = "password" name="old_password">
                                <span class = "form-message"></span>
                            </div><br>
                            <div class="form-group">
                                <label for="new-password">Mật Khẩu Mới *</label>
                                <input type="password" placeholder="Nhập Mật Khẩu Mới" id = "new-password" name="password">
                                <span class = "form-message"></span>
                            </div><br>
                            <div class="form-group">
                                <label for="new-password-again">Nhập Lại Mật Khẩu Mới *</label>
                                <input type="password" placeholder="Nhập Lại Mật Khẩu Mới" id = "new-password-again">
                                <span class = "form-message"></span>
                            </div><br>
                            <div class="sub-btn">
                                <button id="changepassword-btn" >Đổi Mật Khẩu</button>
                                <a id="logout-btn">Đăng Xuất</a>
                            </div>
                        </form>
                    <div class="information-contact">
                        <div class="contact-web">
                            <h3>Liên hệ:</h3>
                            <a href="index.html">https://www.ruoungoai.com</a>
                        </div>

                        <div class="address">
                            <h3>Địa chỉ:</h3>
                            <ul class = "contact-address">
                                <li><strong>Địa chỉ 1: </strong>Km10 Nguyễn Trãi - Hà Đông - HN</li>
                                <li><strong>Địa chỉ 2: </strong>122 Hoàng Quốc Việt - Cầu Giấy - HN</li>
                                <li><strong>Hotline: </strong>19001018</li>
                                <li><strong>Email: </strong>Lienhe@ruoungoai.com</li>
                            </ul>
                        </div>

                    </div>
                </div>

            </div>
            <!--Start footer-->
            <%@include  file="footer.jsp" %>
            <!--End footer-->
        </div>
        <script src="assets/user/profile/general.js"></script>
        <script src = "assets/user/profile/validator.js"></script>
        <script>
            Validator({
                form: "#form-contact",
                formGroupSelector: '.form-group',
                errorSelector: ".form-message",
                rules: [
                    Validator.isRequired('#name', "Vui lòng nhập tên đầy đủ của bạn"),
                    Validator.isRequired('#email', "Vui lòng nhập email"),
                    Validator.isRequired('#phonenumber', "Vui lòng nhập số điện thoại"),
                    Validator.isEmail('#email'),
                    Validator.isRequired('#subject-name', "Vui lòng nhập tiêu đề liên hệ"),
                ]

            });
        </script>
    </body>
</html>