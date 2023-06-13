let pages = document.querySelectorAll(".page")
let pageOne = document.querySelector(".page-number-" + pages.length)

pageOne.classList.add("hightlight")
function nextPage(page){
    let curPage = document.querySelector("table.invalid")
    curPage.classList.remove("invalid")
    let nPage = document.querySelector(".page-" + page)
    nPage.classList.add("invalid")
    
    for(var i = 0; i < pages.length; i++){
        if(i + 1 == page){
            console.log(i,pages.length-i + 1)
            pages[pages.length-i - 1].classList.add("hightlight")
        }
        else{
            pages[pages.length-i - 1].classList.remove("hightlight")
        }
        
    }
    

}