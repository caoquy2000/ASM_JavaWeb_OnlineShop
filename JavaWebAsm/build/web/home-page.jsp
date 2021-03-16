<%-- 
    Document   : home-page
    Created on : Mar 2, 2021, 3:13:46 PM
    Author     : caoho
--%>


<%@page import="quych.dtos.CategoryDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="quych.dtos.ProductDTO"%>
<%@page import="java.util.List"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <link rel="stylesheet" href="./js/slick/slick.css">
        <link rel="stylesheet" href="./js/slick/slick-theme.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            #numbers {
                padding: 0;
                margin: 0 2rem;
                list-style-type: none;
                display: flex;
            }

            #numbers li a {
                color: black;
                padding: .5rem 1rem;
                text-decoration: none;
                opacity: .7;
            }

            #numbers li a:hover {
                opacity: 1;
            }

            #numbers li a.active {
                opacity: 1;
                background: black;
                color: #fff;
            }
        </style>

    </head>

    <body>
        <jsp:include page="navbar-client.jsp" />
        <%
            List<CategoryDTO> checkCategory = (List<CategoryDTO>) request.getAttribute("LISTCATEGORY");
            List<ProductDTO> checkProduct = (List<ProductDTO>) request.getAttribute("LISTPRODUCT");
            if (checkCategory == null || checkProduct == null) {
//                request.getRequestDispatcher("MainController").forward(request, response);
                response.sendRedirect("LoadDataController");
            }
        %>
        <div class="container">
            <!--  -->
            <div class="wrapper--img">
                <div class="img--content">
                    <img src="./img/hinh-web-1.png" alt="">
                </div>
            </div>
            <!--  -->

            <div class="wrapper--category" style="font-size: 1.8rem">
                <div class="category--list">
                    <h2>Danh Mục</h2>
                    <div class="category--content">
                        <c:if test="${requestScope.LISTCATEGORY != null}" >
                            <c:if test="${not empty requestScope.LISTCATEGORY}" var="checkListCategory">
                                <c:forEach var="categoryDTO" items="${requestScope.LISTCATEGORY}">
                                    <c:if test="${categoryDTO.status == 1}">
                                        <div class="category--item">
                                            <a href="#">
                                                <img src="img/danhmuc/${categoryDTO.cUrl}" alt="">
                                                <p>${categoryDTO.categoryName}</p>
                                            </a>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:if>

                    </div>
                </div>
            </div>

            <!--  -->
            <%
                List<ProductDTO> productDTOs = (List<ProductDTO>) request.getAttribute("LISTPRODUCT");
            %>
            <div class="wrapper--product">
                <div class="product--container">
                    <h2>Sản Phẩm</h2>
                    <div class="product--content">
                        <c:if test="${requestScope.LISTPRODUCT != null}">
                            <c:if test="${not empty requestScope.LISTPRODUCT}" var="checkEmptyProduct">
                                <c:forEach var="dtoProducts" items="${requestScope.LISTPRODUCT}">
                                    <div class="product--item">
                                        <a href="#">
                                            <div class="img--home-product">
                                                <img src="img/sanpham/${dtoProducts.getpUrl()}" alt="">
                                            </div>
                                            <div class="product--title-home">
                                                <h3>${dtoProducts.getpName()}</h3>
                                            </div>
                                            <div class="product--price-home">
                                                <h2><fmt:formatNumber pattern="0.00" type="number" value="${dtoProducts.getpPrice()}đ" maxFractionDigits="0"/></h2>
                                            </div>
                                        </a>
                                        <div class="hover--product-add">

                                        </div>
                                        <div class="button--hover-addtocart">
                                            <c:url var="linkAddToCart" value="MainController">
                                                <c:param name="action" value="AddToCart" />
                                                <c:param name="productID" value="${dtoProducts.getProductID()}"/>
                                                <c:param name="quantity" value="1" />
                                            </c:url>
                                            <a href="${linkAddToCart}">Thêm Vào Giỏ</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:if>

                    </div>
                    <div class="pagination" style="font-size: 1.6rem; margin-top: 1rem;">
                        <ol id="numbers"></ol>
                    </div>
                </div>
            </div>

        </div>

        <jsp:include page="footer.jsp" />

        <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
        <script src="./js/slick/slick.js"></script>			
        <script src="./js/animated.js"></script>
        <script src="./js/index.js"></script>
        <script>

            function paging() {
                const itemPerPage = 8;
                const items = document.getElementsByClassName("product--item");
                const itemsCount = items.length;
                console.log(itemsCount + 'ahihi');
                const pageCount = Math.ceil(itemsCount / itemPerPage);
                console.log(pageCount + 'ahuhu');
                const numbers = document.getElementById('numbers');
                const itemPaging = document.getElementsByClassName("item-paging");
                for (var i = 0; i < pageCount; i++) {
                    numbers.innerHTML += '<li><a class="item-paging" href="#">' + (i + 1) + "</a></li>";
                }
                let currentActive = 0;
                activeClass(currentActive);
                displayRows(1);
                for (let i = 0; i < itemPaging.length; i++) {
                    itemPaging[i].addEventListener("click", function (e) {
                        e.preventDefault();
                        document.getElementsByClassName("item-paging")[currentActive].classList.remove("active");
                        currentActive = parseInt(itemPaging[i].text) - 1;
                        document.getElementsByClassName("item-paging")[currentActive].className = "active item-paging";
                        displayRows(parseInt(itemPaging[i].text));
                    });
                }
                function displayRows(index) {
                    var start = (index - 1) * itemPerPage;
                    var end = start + itemPerPage;
                    for (var i = 0; i < items.length; i++) {
                        items[i].style.display = "none";
                    }
                    if (index == pageCount) {
                        for (var i = start; i <= itemsCount; i++) {
                            items[i].style.display = null;
                        }
                    } else {
                        for (var i = start; i < end; i++) {
                            items[i].style.display = null;
                        }
                    }
                }
            }
            const activeClass = k => {
                const active = document.getElementsByClassName("item-paging")[k].className = "item-paging active";
            }
            paging();

        </script>
    </body>

</html>
