var listMinus = document.querySelectorAll(".minus");

listMinus.forEach(function(minus){
	minus.onclick = function(){
		var quantity = minus.parentElement.querySelector(".input-qty")
		if(parseInt(quantity.value) > 1){
			quantity.value = parseInt(quantity.value) - 1
			let link = minus.getAttribute("href").split("&")
			minus.setAttribute("href", link[0] + "&quantity=" + quantity.value)
			console.log(minus.getAttribute("href"));
		}
	}
});

var listPlus = document.querySelectorAll(".plus");
listPlus.forEach(function(plus){
	var max_quantity = document.querySelector(".max-quantity");
	plus.onclick = function(){
		var quantity = plus.parentElement.querySelector(".input-qty")
		if(quantity.value < parseInt(max_quantity.textContent)){
			quantity.value = parseInt(quantity.value) + 1
			let link = plus.getAttribute("href").split("&")
			plus.setAttribute("href", link[0] + "&quantity=" + quantity.value)
			console.log(plus.getAttribute("href"));
		}
	}
});

var minusTagA = document.querySelector(".minus");
