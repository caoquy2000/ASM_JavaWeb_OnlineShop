$(document).ready(function () {

    $('.category--content').slick({
        slidesToShow: 5,
        slidesToScroll: 2,
        rows: 2,
        autoplay: false,
        autoplaySpeed: 2000,
    });
});
function showMenu() {
    document.getElementById("dropdownMenu").classList.toggle("show");
}
