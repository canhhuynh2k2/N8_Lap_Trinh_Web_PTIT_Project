var login = document.querySelector(".login-btn");
var register = document.querySelector(".register-btn");
var register_form = document.getElementById("register-form");
var login_form = document.getElementById("login-form");
login.onclick = function(){
    register_form.classList.add("disable");
    login_form.classList.remove("disable");
}
register.onclick = function(){
    login_form.classList.add("disable");
    register_form.classList.remove("disable");
}