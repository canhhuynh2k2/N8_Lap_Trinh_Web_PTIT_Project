var quantity = document.querySelector(".input-qty");
var plus_btn = document.querySelector(".plus");
var minus_btn = document.querySelector(".minus");
var max_quantity = document.querySelector("#max-quantity");
let add_to_cart = document.querySelector(".add-to-card-btn");
let buy_now = document.querySelector(".buy-now-btn");

plus_btn.addEventListener("click", function(){
    if(quantity.value < parseInt(max_quantity.textContent)){
        quantity.value = parseInt(quantity.value) + 1;
        var hrefLinkAddToCart = add_to_cart.getAttribute("href").split("&");
        var hrefAddToCart = hrefLinkAddToCart[0] + "&quantity=" + quantity.value
        add_to_cart.setAttribute("href", hrefAddToCart);
		
		var hrefLinkBuyNow = buy_now.getAttribute("href").split("&");
		console.log(hrefLinkBuyNow)
        var hrefBuyNow = hrefLinkBuyNow[0] + "&quantity=" + quantity.value
        buy_now.setAttribute("href", hrefBuyNow);

    }
});
minus_btn.addEventListener("click", function(){
    if(quantity.value > 1){
        quantity.value = parseInt(quantity.value) - 1;
        var hrefLinkAddToCart = add_to_cart.getAttribute("href").split("&");
        var hrefAddToCart = hrefLinkAddToCart[0] + "&quantity=" + quantity.value
        add_to_cart.setAttribute("href", hrefAddToCart);
		
		var hrefLinkBuyNow = buy_now.getAttribute("href").split("&");
        var hrefBuyNow = hrefLinkBuyNow[0] + "&quantity=" + quantity.value
        buy_now.setAttribute("href", hrefBuyNow);
    }
});
