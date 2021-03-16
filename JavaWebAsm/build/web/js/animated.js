function animate() {
    let x = document.getElementsByClassName("product--item");
    for (var i = 0; i < x.length; i++) {
        x[i].addEventListener("mouseenter", mouseOver);
        x[i].addEventListener("mouseleave", mouseOut);

    }
    function mouseOver(event) {
        var arr = [];
        var element = event.target.childNodes;
        const reg1 = /button--hover-addtocart/;
        const reg2 = /hover--product-add/;

        for (var i = 0; i < element.length; i++) {
            if (reg1.test(element[i].outerHTML) || reg2.test(element[i].outerHTML)){
                arr.push(i);
            }
        }
        for (var i = 0; i < arr.length - 1; i++) {
            event.target.childNodes[arr[i]].style.top = "0%";
            event.target.childNodes[arr[i+1]].style.top = "50%";
        }
    }
    function mouseOut(event) {
        var arr = [];
        var element = event.target.childNodes;
        const reg1 = /button--hover-addtocart/;
        const reg2 = /hover--product-add/;

        for (var i = 0; i < element.length; i++) {
            if (reg1.test(element[i].outerHTML) || reg2.test(element[i].outerHTML)){
                arr.push(i);
            }
        }
        for (var i = 0; i < arr.length - 1; i++) {
            event.target.childNodes[arr[i]].style.top = "100%";
            event.target.childNodes[arr[i+1]].style.top = "150%";
        }
    }
    
}
animate();
