<%-- 
    Document   : shoppingcart-page
    Created on : Mar 2, 2021, 3:38:07 PM
    Author     : caoho
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${requestScope.DTOVIEWDETAIL != null ? 'Chi Tiết Đơn Hàng' : 'Giỏ Hàng'}</title>
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
        <c:if test="${requestScope.DTOVIEWDETAIL == null}" var="checkView">
            <div class="shoppingcart--container" style="font-size: 1.6rem">
                <div class="cart--title">
                    <h1>Giỏ Hàng ${sessionScope.USERNAME}</h1>
                </div>
                <div class="wrapper--shopcart">

                    <ul class="shoppingcart--items" style="margin-right: 1rem;"> 
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
                                                <p><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.getpPrice()}" />đ</p>
                                            </div>
                                            <div class="cart--quantity-option">
                                                <p style="width: 13rem; text-align: center;"><span style="font-size: 1rem; color: rgb(1, 127, 255);">SL:</span> ${dto.getpQuantity()}</p>
                                            </div>
                                            <div style="width: 15rem; height: 100%; display: flex; align-items: center;">
                                                <form action="MainController" method="POST">
                                                    <div class="input-group mb-3">
                                                        <input type="hidden" name="cartIdUpdate" value="${dto.getProductID()}" />
                                                        <input type="text" class="form-control" name="txtCartQuantity" value="" placeholder="Cập nhật số lượng..." aria-describedby="basic-addon2" required="">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-outline-secondary" type="submit" name="action" value="ChangeQuantityInCart">Đổi</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </c:if>
                        <c:if test="${!checkShoppingCart}">
                            <div id="messageBlock" class="toast fade show" style="font-size: 1.6rem; height: 7rem">
                                <div class="toast-header">
                                    <strong class="mr-auto"><i class="fa fa-globe"></i> Message</strong>

                                </div>
                                <div class="toast-body">
                                    Không có sản phẩm nào trong giỏ hàng.
                                </div>
                            </div>
                        </c:if>

                    </ul>
                    <c:if test="${checkShoppingCart}">
                        <div class="cart--total-price">
                            <form action="MainController" method="POST" style="font-size: 1.6rem;" onsubmit="return validateForm()">
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Họ và Tên</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtUsernameOrder" required="">
                                    <span id="errorFull" style="color: red;"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Địa Chỉ</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtAddressOrder" required="">
                                    <span id="errorAddress" style="color: red;"></span>

                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Số Điện Thoại</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtPhoneOrder" required="">
                                    <span id="errorPhone" style="color: red;"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Email</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtEmailOrder" required="">
                                    <span id="errorEmail" style="color: red;"></span>
                                </div>
                                <div class="wrapper--total-cart">
                                    <p>Thành tiền</p>
                                    <h2><fmt:formatNumber type="number" maxFractionDigits="3" value="${sessionScope.CART.getTotal()}" />đ</h2>
                                </div>
                                <button type="submit" name="action" value="Order" class="order-button">Tiến hành đặt hàng</button>
                            </form>
                        </div> 
                    </c:if>
                </div>
            </div>
        </c:if>
        <c:if test="${!checkView}">
            <div class="shoppingcart--container" style="font-size: 1.6rem">
                <div class="cart--title">
                    <h1>Đơn Hàng ${requestScope.DTOVIEWDETAIL.getOrderID()}</h1>
                </div>
                <div class="wrapper--shopcart">

                    <ul class="shoppingcart--items" style="margin-right: 1rem;"> 
                        <c:forEach var="dto" items="${requestScope.RESULTVIEWDETAIL}">
                            <li class="shoppingcart--item">
                                <div class="cart--img">
                                    <img src="./img/sanpham/${dto.getpUrl()}" alt="">
                                </div>
                                <div class="cart--content">
                                    <div class="cart--product-name">
                                        ${dto.getpName()}
                                    </div>
                                    <div class="cart--remove-product">
                                    
                                    </div>
                                </div>
                                <div class="cart--price">
                                    <div class="cart--product-price">
                                        <p><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.getpPrice()}" />đ</p>
                                    </div>
                                    <div class="cart--quantity-option">
                                        <p style="width: 13rem; text-align: center;"><span style="font-size: 1rem; color: rgb(1, 127, 255);">SL:</span> ${dto.getQuantity()}</p>
                                    </div>
                                    <div style="width: 15rem; height: 100%; display: flex; align-items: center;">
                                      
                                    </div>
                                </div>
                            </li>
                        </c:forEach>


                    </ul>
            
                        <div class="cart--total-price">
                       
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Họ và Tên</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtUsernameOrder" required="" readonly="" value="${requestScope.DTOVIEWDETAIL.getFullName()}">
                                    <span id="errorFull" style="color: red;"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Địa Chỉ</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtAddressOrder" required="" readonly="" value="${requestScope.DTOVIEWDETAIL.getAddress()}">
                                    <span id="errorAddress" style="color: red;"></span>

                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Số Điện Thoại</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtPhoneOrder" required="" readonly="" value="${requestScope.DTOVIEWDETAIL.getPhone()}">
                                    <span id="errorPhone" style="color: red;"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Email</label>
                                    <input type="text" style="font-size: 1.6rem;" class="form-control" name="txtEmailOrder" required="" readonly="" value="${requestScope.DTOVIEWDETAIL.getEmail()}">
                                    <span id="errorEmail" style="color: red;"></span>
                                </div>
                                <div class="wrapper--total-cart">
                                    <p>Tổng Đơn Hàng</p>
                                    <h2><fmt:formatNumber type="number" maxFractionDigits="3" value="${requestScope.DTOVIEWDETAIL.getTotal()}" />đ</h2>
                                </div>
    
                          
                        </div> 
                    
                </div>
            </div>
        </c:if>
        <jsp:include page="footer.jsp" />

        <script src="./js/index.js"></script>
        <script>
                                function validateForm() {
                                    let fullname = document.querySelector('[name="txtUsernameOrder"]').value;
                                    let address = document.querySelector('[name="txtAddressOrder"]').value;
                                    let phone = document.querySelector('[name="txtPhoneOrder"]').value;
                                    let email = document.querySelector('[name="txtEmailOrder"]').value;

                                    let reEmail = new RegExp("/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+");
                                    let rePhone = new RegExp("[0-9]{10}$");

                                    if (fullname.length > 30) {
                                        document.getElementById('errorFull').innerHTML = 'Họ Và Tên không vượt quá 30 kí tự';
                                        return false;
                                    } else {
                                        document.getElementById('errorFull').innerHTML = '';
                                    }
                                    if (address.length > 100) {
                                        document.getElementById('errorAddress').innerHTML = 'Địa chỉ không vượt quá 100 kí tự';
                                        return false;
                                    } else {
                                        document.getElementById('errorAddress').innerHTML = '';
                                    }
                                    if (rePhone.test(phone) == false) {
                                        document.getElementById('errorPhone').innerHTML = 'Vui lòng nhập số điện thoại';
                                        return false;
                                    } else {
                                        document.getElementById('errorPhone').innerHTML = '';
                                    }
                                    if (reEmail.test(email) == false) {
                                        document.getElementById('errorEmail').innerHTML = 'Vui lòng nhập email';
                                        return false;
                                    } else {
                                        document.getElementById('errorEmail').innerHTML = '';
                                    }
                                    return true;
                                }
        </script>
    </body>
</html>