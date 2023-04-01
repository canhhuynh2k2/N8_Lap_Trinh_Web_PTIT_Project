<%-- 
    Document   : sign_in
    Created on : Apr 1, 2023, 9:31:15 PM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel = "stylesheet" href = "/webn8/assets/user/css/sign_in/login.css">
</head>
<body>
    <div class="container">
        <div class="login-register">
            <button class="login-btn login-register-btn">Đăng nhập</button>
            <button class="register-btn login-register-btn">Đăng ký</button>

        </div>
        <form action="user_sign_up" method  = "POST" class = "form disable" id = "register-form">
            <h3 class = "heading">Thành viên đăng ký</h3>
            <p class = "heading">Chào mừng bạn đến với cửa hàng của chúng tôi!</p>
            <div class="spacer"></div>
            <div class="form-group">
                <label for="fullname" class = "form-label">Tên đầy đủ</label></br>
                <input type="text" id="fullname" name = "fullname" placeholder="VD: Huỳnh Nguyễn">
                <span class = "form-message"></span>
            </div>
            <div class="form-group">
                <label for="email" class = "form-label">Email</label></br>
                <input type="text" id="email" name = "email" placeholder="VD: huynh@domain.com">
                <span class = "form-message"></span>
            </div>
            <div class="form-group">
                <label for="password" class = "form-label">Mật khẩu</label></br>
                <input type="password" id="password" name = "password" placeholder="Nhập mật khẩu">
                <span class = "form-message"></span>
            </div>
            <div class="form-group">
                <label for="password-confirmation" class = "form-label">Nhập lại mật khẩu</label></br>
                <input type="password" id="password-confirmation" name = "password-confirmation" placeholder="Nhập lại mật khẩu">
                <span class = "form-message"></span>
            </div>
            <button class="form-submit">Đăng ký</button>
        </form>

        <form action="user_sign_in" method  = "POST" class = "form" id = "login-form">
            <h3 class = "heading">Thành viên đăng nhập</h3>
            <p class = "heading">Chào mừng bạn quay trở lại cửa hàng của chúng tôi!</p>
            <div class="spacer"></div>
            
            <div class="form-group">
                <label for="email" class = "form-label">Email đăng nhập</label></br>
                <input type="text" id="email" name = "email" placeholder="VD: huynh@domain.com">
                <span class = "form-message"></span>
            </div>
            <div class="form-group">
                <label for="password" class = "form-label">Mật khẩu</label></br>
                <input type="password" id="password" name = "password" placeholder="Nhập mật khẩu">
                <span class = "form-message"></span>
            </div>
            <a href = "#" id = "password-forgot"><i class = "password-forgot">Quên mật khẩu?</i></a>
            <button class="form-submit">Đăng nhập</button>
        </form>
    </div>
<script src="/webn8/assets/js/sign_in/validator.js"></script>
<script src = "/webn8/assets/js/sign_in/loginform.js"></script>
<script>
    Validator({
        form : "#register-form", 
        formGroupSelector: '.form-group',
        errorSelector: ".form-message",
        rules: [
            Validator.isRequired('#fullname', "Vui lòng nhập tên đầy đủ của bạn"),
            Validator.isRequired('#email', "Vui lòng nhập email"),
            Validator.isEmail('#email'),
            Validator.minLength('#password', 6),
            Validator.isRequired('#password-confirmation'),
            Validator.isConfirmed("#password-confirmation", function(){
                return document.querySelector('#register-form #password').value;
            }, 'Mật khẩu nhập lại không chính xác')
        ],
        onSubmit: function(data){
            //Call API
                console.log(data);
            }
    });
</script>
<script>
    var wrongUser = "${requestScope.wrongUser}"
    if(wrongUser !== ""){
        alert(wrongUser);
    }
</script>
</body>
</html>