var customer_name = document.getElementById("customer-name")
var customer_email = document.querySelector("#customer-email")
var customer_phonenumber = document.querySelector("#customer-phonenumber")
var customer_address = document.querySelector("#customer-address")

customer_name.addEventListener("blur", handleNameBlur)
customer_phonenumber.addEventListener("blur", handlePhoneNumberBlur)
customer_email.addEventListener("blur", handleEmailBlur)
customer_address.addEventListener("blur", handleAddressBlur)
customer_name.addEventListener("input", handleNameInput)
customer_email.addEventListener("input", handleEmailInput)
customer_phonenumber.addEventListener("input", handlePhoneNumberInput)
customer_address.addEventListener("input", handleAddressInput)

 function handleNameBlur(){
    var form_message = customer_name.parentElement.querySelector('.form-message')
    if(customer_name.value.trim() == ''){       
        form_message.textContent = "Vui lòng nhập tên đầy đủ của bạn"
    }
    else{
        form_message.textContent = ''
    }
}

function handlePhoneNumberBlur(){
    var form_message = customer_phonenumber.parentElement.querySelector('.form-message')
    if(customer_phonenumber.value.trim() == ''){       
        form_message.textContent = "Vui lòng nhập chính xác số điện thoại của bạn"
    }
    else{
        form_message.textContent = ''
    }
}

function handleEmailBlur(){
    var form_message = customer_email.parentElement.querySelector('.form-message')
    var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if(customer_email.value.trim() == ''){      
        form_message.textContent = "Vui lòng nhập địa chỉ email"
    }
    else if(!regex.test(customer_email.value)){
        form_message.textContent = "Trường này phải là email"
    }
    else{
        form_message.textContent = ''
    }
}

function handleAddressBlur(){
    var form_message = customer_address.parentElement.querySelector('.form-message')
    if(customer_address.value.trim() == ''){       
        form_message.textContent = "Vui lòng nhập địa chỉ của bạn"
    }
    else{
        form_message.textContent = ''
    }
}


function handleNameInput(){
    var form_message = customer_name.parentElement.querySelector('.form-message')
    form_message.textContent = ''
}

function handlePhoneNumberInput(){
    var form_message = customer_phonenumber.parentElement.querySelector('.form-message')
    form_message.textContent = ''
}

function handleAddressInput(){
    var form_message = customer_address.parentElement.querySelector('.form-message')
    form_message.textContent = ''
}
function handleEmailInput(){
    var form_message = customer_email.parentElement.querySelector('.form-message')
    form_message.textContent = ''
}