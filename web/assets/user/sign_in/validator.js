// Đối tượng "Validator"
function Validator(options){
    function getParent(element, selector){
        while(element.parentElement){
            if(element.parentElement.matches(selector)){
                return element.parentElement;
            }
            element = element.parentElement;
        }
    }
    //khai báo object chứa các rule của các selector
    var selectorRules = {};
    // hàm thực hiện validate
    function validate(inputElement, rule){
        var errorElement = getParent(inputElement, options.formGroupSelector).querySelector(options.errorSelector);
        var errorMessage;

        var rules = selectorRules[rule.selector];
        for(var i = 0; i < rules.length; ++i){
            errorMessage = rules[i](inputElement.value);
            if(errorMessage) break;
        }
        if(errorMessage){
            errorElement.classList.add("invalid");
            errorElement.innerText = errorMessage;
        }
        else{
            errorElement.classList.remove("invalid");
            errorElement.innerText = '';
        }
        return !errorMessage;
    }
    // lấy element của form cần validate
    var formElement = document.querySelector(options.form);

    if(formElement){
        //Khi submit form
        formElement.onsubmit = function(e){
            e.preventDefault();

            var isFormValid = true;
            // lặp qua từng rule và validate
            options.rules.forEach(function(rule){
                var inputElement = formElement.querySelector(rule.selector);
                var isValid = validate(inputElement, rule);
                if(!isValid){
                    isFormValid = false;
                }
            });
            if(isFormValid){
                if(typeof options.onSubmit === 'function'){
                    var enableInputs = formElement.querySelectorAll('[name]');
                    var formValues = Array.from(enableInputs).reduce(function(values, input){
                        return (values[input.name] = input.value) && values;
                    }, {});
                    options.onSubmit(formValues);
                }
                console.log("Không có lỗi");
                formElement.submit();
            }
            else{
                console.log("Có lỗi");
            }
        
        }
        //lặp qua mỗi rule để xử lý ( lắng nghe sự kiện blur, input, ...)
        options.rules.forEach(function(rule){
            var inputElement = formElement.querySelector(rule.selector);
            // nếu mảng rule của selector khác rỗng thì đẩy các rule tiếp theo vào
            if(Array.isArray(selectorRules[rule.selector])){
                selectorRules[rule.selector].push(rule.test);
            }
            else{
                selectorRules[rule.selector] = [rule.test];
            }
            if(inputElement){
                // xử lý blur ra ngoài báo lỗi
                inputElement.onblur = function(){
                    validate(inputElement, rule);
                }
                // xử lý đang nhập input sẽ hết lỗi
                inputElement.oninput = function(){
                    var errorElement = getParent(inputElement, options.formGroupSelector).querySelector(".form-message");
                    errorElement.innerText = "";
                }
            }
            
        });
    }
}

// Định nghĩa rules
// Khi có lỗi  => trả ra message lỗi
// khi hợp lệ => không trả ra gì cả (undefined)
Validator.isRequired = function(selector, message){
    return {
        selector: selector,
        test: function(value){
            return value.trim() ? undefined : message || "Vui lòng nhập trường này";
        }
    };
}
Validator.isEmail = function(selector, message){
    return {
        selector: selector,
        test: function(value){
            var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            return regex.test(value) ? undefined : message || "Trường này phải là email";
        }
    };
}
Validator.minLength = function(selector, min, message){
    return {
        selector: selector,
        test: function(value){
            return value.length >= min ? undefined : message || `Vui lòng nhập tối thiểu ${min} ký tự`;
        }
    };
}
Validator.isConfirmed = function(selector, getConfirmValue, message){
    return{
        selector: selector,
        test: function(value){
            return value === getConfirmValue() ? undefined : message || 'Giá trị nhập vào không chính xác'; 
        }
    }
}