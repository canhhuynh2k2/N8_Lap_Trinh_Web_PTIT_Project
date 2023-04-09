window.addEventListener("load", function(){
  var sliderWrapper = document.querySelector(".slider-wrapper");
  var sliderMain = document.querySelector(".slider-main");
  var sliderItems = document.querySelectorAll(".slider-item");
  var nextBtn = document.querySelector(".next-btn");
  var prevBtn = document.querySelector(".prev-btn");
  var dotItems = document.querySelectorAll(".slider-dot-item");
  var sliderItemWidth = sliderItems[0].offsetWidth;
  var positionX = 0;
  let index = 0;
  nextBtn.addEventListener("click", function(){
    handleChangeSlide(1);
  });

  prevBtn.addEventListener("click", function(){
    handleChangeSlide(-1);
    
  });
  [...dotItems].forEach((item) => 
  item.addEventListener("click", function(e){
    
    [...dotItems].forEach((el) => el.classList.remove("active"));
    e.target.classList.add("active");
    const slideIndex = parseInt(e.target.dataset.index);
    index = slideIndex;
    positionX = -1 * index * sliderItemWidth;
    sliderMain.style = `transform: translateX(${positionX}px)`;
  }));
  function handleChangeSlide(direction){
    if(direction === 1){
      if(index >= sliderItems.length - 1){
        index = sliderItems.length - 1;
        return;
      }
      positionX -= sliderItemWidth;
      sliderMain.style = `transform: translateX(${positionX}px)`;
      index++;
    }
    else if(direction === -1){
      if(index <= 0){
        index = 0;
        return;
      }
      positionX += sliderItemWidth;
      sliderMain.style = `transform: translateX(${positionX}px)`;
      index--;
    }
    
    [...dotItems].forEach((el) => el.classList.remove("active"));
    dotItems[index].classList.add("active");
  }
})