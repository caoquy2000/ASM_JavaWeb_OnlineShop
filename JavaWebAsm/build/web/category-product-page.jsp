<%-- 
    Document   : category-product-page
    Created on : Mar 3, 2021, 2:07:36 PM
    Author     : caoho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chợ Tết</title>
    <link rel="stylesheet" href="./css/style1.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css"
        integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">

</head>

<body>
    <jsp:include page="navbar-client.jsp" />

    <div class="container">
        <div class="category--page">
            <h1>Giày Convert</h1>
        </div>

        <div class="wrapper--product">
            <div class="product--container">
                <h2>Sản Phẩm</h2>
                <div class="product--content">
                    <div class="product--item" onmouseenter="hovered()" onmouseleave="hover()">
                        <a href="#">
                            <div class="img--home-product">
                                <img src="./img/sanpham/giay-conserve.jpg" alt=""> 
                            </div>
                            <div class="product--title-home">
                                <h3>Giày Sneaker Unisex Converse Chuck Taylor All Star 1970s Low 2018 - Black/w (Size 42.5)</h3>
                            </div>
                            <div class="product--price-home">
                                <h2>1.000.000đ</h2>
                            </div>
                        </a>
                        <div class="hover--product-add">
                      
                        </div>
                        <div class="button--hover-addtocart">
                            <a href="#">Thêm Vào Giỏ</a>
                        </div>
                    </div>
    
                
                </div>
            </div>
        </div>
    </div>
   
    
    <jsp:include page="footer.jsp" />
	
    <script src="./js/animated.js"></script>
    <script src="./js/index.js"></script>

</body>

</html>