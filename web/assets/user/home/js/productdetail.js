var quantity = document.querySelector(".input-qty");
var plus_btn = document.querySelector(".plus");
var minus_btn = document.querySelector(".minus");
var max_quantity = document.querySelector("#max-quantity");
plus_btn.addEventListener("click", function(){
    if(quantity.value < parseInt(max_quantity.textContent)){
        quantity.value = parseInt(quantity.value) + 1;
    }
});
minus_btn.addEventListener("click", function(){
    if(quantity.value > 1){
        quantity.value = parseInt(quantity.value) - 1;
    }
});
