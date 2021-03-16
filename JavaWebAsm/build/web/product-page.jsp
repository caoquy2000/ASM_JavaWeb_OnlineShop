<%-- 
    Document   : product
    Created on : Mar 2, 2021, 3:41:56 PM
    Author     : caoho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản Phẩm</title>
    <link rel="stylesheet" href="./css/style1.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css"
        integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
</head>
<body>
    <jsp:include page="navbar-client.jsp" />

    <div class="information--product--container">

        <div class="wrapper--product">
            <div class="img--info-product">
                <img src="./img/sanpham/giay-conserve.jpg" alt="">
            </div>
            <div class="content--info-product">
                <h1>Giày Sneaker Unisex Converse Chuck Taylor All Star 1970s Low 2018 - Black/w</h1>
                <h2>1.900.000đ</h2>
                <div class="cart--quantity-option">
                    <a href="#">-</a>
                    <input type="text" class="quantity--cart">
                    <a href="#">+</a>
                    
                </div>
                <div class="add--to-cart">
                    <button class="order-button">Thêm vào giỏ hàng</button>
                </div>
                
            </div>
        </div>
        <div class="product--description">
            <h2>Mô tả</h2>
            <div class="product--detail">
                <p> Là dòng giày tiêu biểu và đặc trưng cho phong cách cổ điển của Converse
                    Chất vải canvas nhẹ, tạo cảm giác thoải mái
                    Lớp lót dày tạo cảm giác êm ái khi vận động
                    Phiên bản mới lớp lót được cải tiến êm hơn & có thể tháo rời giúp bạn dễ dàng vệ sinh
                    Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài
                    Chất liệu vải cao cấp
                    Giày Sneaker Unisex Converse Chuck Taylor All Star 1970s Black/w Low 2018 được thiết kế từ chất liệu vải canvas nhẹ, dày dặn, cứng form hơn. Thiết kế kiểu dáng cùng gam màu thời trang, mang đến cho bạn sự trẻ trung, năng động nhưng cũng không kém phần sành điệu khi phối cùng các trang phục.</p>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script src="./js/index.js"></script>
</body>
</html>