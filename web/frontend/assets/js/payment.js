var payment_method_bacs = document.querySelector("#payment-method-bacs")
var payment_method_cod = document.querySelector("#payment-method-cod")
var show_payment_method_bacs_box = payment_method_bacs.parentElement.querySelector(".payment-box")
var show_payment_method_cod_box = payment_method_cod.parentElement.querySelector(".payment-box")
payment_method_bacs.onchange  = function(){
    if(payment_method_bacs.checked){
        show_payment_method_bacs_box.classList.remove("invalid")
        show_payment_method_cod_box.classList.add("invalid")
    }
    else{
        show_payment_method_bacs_box.classList.add("invalid")
        show_payment_method_cod_box.classList.remove("invalid")
    }
}
payment_method_cod.onchange = function(){
    if(payment_method_bacs.checked){
        show_payment_method_bacs_box.classList.remove("invalid")
        show_payment_method_cod_box.classList.add("invalid")
    }
    else{
        show_payment_method_bacs_box.classList.add("invalid")
        show_payment_method_cod_box.classList.remove("invalid")
    }
}