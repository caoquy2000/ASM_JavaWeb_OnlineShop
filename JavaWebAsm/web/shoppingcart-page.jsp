<%-- 
    Document   : shoppingcart-page
    Created on : Mar 2, 2021, 3:38:07 PM
    Author     : caoho
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ Hàng</title>
        <link rel="stylesheet" href="./css/style1.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css"
              integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="navbar-client.jsp" />
        <%
            String username = (String) session.getAttribute("USERNAME");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (username.equals("admin")) {
                    response.sendRedirect("admin-product-page.jsp");
                }
            }
        %>

        <div class="shoppingcart--container" style="font-size: 1.6rem">
            <div class="cart--title">
                <h1>Giỏ Hàng ${sessionScope.CART.oustomerName}</h1>
            </div>
            <div class="wrapper--shopcart">

                <ul class="shoppingcart--items"> 
                    <h2>${requestScope.NOTENOUGNT}</h2>
                    <c:if test="${sessionScope.CART != null}" >
                        <c:if test="${sessionScope.CART.getCart().size() != 0}" var="checkShoppingCart" >
                            <c:forEach var="dto" items="${sessionScope.CART.getCart().values()}">
                                <li class="shoppingcart--item">
                                    <div class="cart--img">
                                        <img src="./img/sanpham/${dto.getpUrl()}" alt="">
                                    </div>
                                    <div class="cart--content">
                                        <div class="cart--product-name">
                                            ${dto.getpName()}
                                        </div>
                                        <div class="cart--remove-product">
                                            <c:url var="linkRemoveCart" value="MainController">
                                                <c:param name="action" value="RemoveAProductInCart" />
                                                <c:param name="id" value="${dto.getProductID()}" />

                                            </c:url>
                                            <a href="${linkRemoveCart}">Xóa</a>
                                        </div>
                                    </div>
                                    <div class="cart--price">
                                        <div class="cart--product-price">
                                            <p>${dto.getpPrice()}</p>
                                        </div>
                                        <div class="cart--quantity-option">
                                            <a href="#">-</a>
                                            <input type="number" class="quantity--cart" value="${dto.getpQuantity()}">
                                            <a href="#">+</a>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <c:if test="${!checkShoppingCart}">
                        <h2>Không có sản phẩm nào trong giỏ hàng</h2>
                    </c:if>

                </ul>
                <c:if test="${checkShoppingCart}">
                    <div class="cart--total-price">
                        <form action="MainController" method="POST" style="font-size: 1.6rem;">
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">Họ và Tên</label>
                                <input type="text" class="form-control" name="txtUsernameOrder" >
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Địa Chỉ</label>
                                <input type="text" class="form-control" name="txtAddressOrder">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">Số Điện Thoại</label>
                                <input type="text" class="form-control" name="txtPhoneOrder">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Email</label>
                                <input type="text" class="form-control" name="txtEmailOrder">
                            </div>
                            <div class="wrapper--total-cart">
                                <p>Thành tiền</p>
                                <h2>${sessionScope.CART.getTotal()}</h2>
                            </div>
                            <button type="submit" name="action" value="Order" class="order-button">Tiến hành đặt hàng</button>
                        </form>
                    </div> 
                </c:if>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="./js/index.js"></script>

    </body>
</html>