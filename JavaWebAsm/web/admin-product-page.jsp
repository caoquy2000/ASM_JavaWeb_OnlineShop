<%-- 
    Document   : admin-product-page
    Created on : Mar 3, 2021, 2:10:32 PM
    Author     : caoho
--%>

<%@page import="quych.dtos.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/style.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css"
              integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/dataTables.bootstrap4.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
                integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
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
            #note {
                position: absolute;
                z-index: 101;
                top: 30%;

                left: 25%;
                right: 25%;
                background: rgb(1, 127, 255);
                text-align: center;
                color: #fff;
                line-height: 2.5;
                overflow: hidden; 
                -webkit-box-shadow: 0 0 5px black;
                -moz-box-shadow:    0 0 5px black;
                box-shadow:         0 0 5px black;
            }
            @-webkit-keyframes slideDown {
                0%, 100% { -webkit-transform: translateY(-50px); }
                10%, 90% { -webkit-transform: translateY(0px); }
            }
            @-moz-keyframes slideDown {
                0%, 100% { -moz-transform: translateY(-50px); }
                10%, 90% { -moz-transform: translateY(0px); }
            }
            .cssanimations.csstransforms #note {
                -webkit-transform: translateY(-50px);
                -webkit-animation: slideDown 2.5s 1.0s 1 ease forwards;
                -moz-transform:    translateY(-50px);
                -moz-animation:    slideDown 2.5s 1.0s 1 ease forwards;
            }
            .cssanimations.csstransforms #close {
                display: none;
            }
        </style>
    </head>

    <body>
        <c:if test="${requestScope.ADDPRODUCTSUCCESS != null}">
            <div>

            </div>
        </c:if>

        <jsp:include page="navbar-admin.jsp" />

        <%
            String username = (String) session.getAttribute("USERNAME");

            List<ProductDTO> dtos = (List<ProductDTO>) request.getAttribute("MANAGEPRODUCT");
            List<ProductDTO> listSearch = (List<ProductDTO>) request.getAttribute("RESULTSEARCH");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
                } else {
                    if (dtos == null && listSearch == null) {
                        request.getRequestDispatcher("ManageProductController").forward(request, response);
                    }
                }
            }
        %>
        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div class="content--block-admin">

                <div class="btn--new-product" style="display: flex; justify-content: space-around;">
                    <c:if test="${requestScope.ADDPRODUCTSUCCESS != null}" >
                        <div id="messageBlock" class="toast fade show">
                            <div class="toast-header">
                                <strong class="mr-auto"><i class="fa fa-globe"></i> Message</strong>
                                <small class="text-muted">Tạm thời</small>
                                <button id="closeMessage" type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                            <div class="toast-body">
                                Thêm sản phẩm thành công.
                            </div>
                        </div>
                        <script>
                            close = document.getElementById("closeMessage");
                            close.addEventListener('click', function () {
                                message = document.getElementById("messageBlock");
                                message.style.display = 'none';
                            }, false);
                        </script>
                    </c:if>
                    <c:url var="addPage" value="MainController">
                        <c:param name="action" value="LoadAddProduct" />
                    </c:url>
                    <a href="${addPage}" >Thêm sản phẩm</a>
                </div>

                <div class="table--product" style="height: 545px;">
                    <form action="MainController" method="POST" style="margin-bottom: 15px;">
                        Search: <input type="text" name="txtValueSearchProduct" value="" placeholder="Tên sản phẩm..." 
                                       style="border: 0.5px solid rgb(1, 127, 255);
                                       border-radius: 4px;
                                       padding:  0.2rem 2rem"
                                       />
                        <button type="submit" name="action" value="SearchProduct"
                                style="
                                border: none;
                                outline: none;
                                background: #FF4B2B;
                                color: #fff;
                                padding: 0.25rem 2rem;
                                border-radius: 4px;
                                "
                                >Tìm kiếm</button>
                    </form>
                    <table id="my-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Action</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${requestScope.RESULTSEARCH == null}" var="checkSearch">
                                <c:if test="${requestScope.MANAGEPRODUCT != null}">
                                    <c:if test="${not empty requestScope.MANAGEPRODUCT}">
                                        <c:forEach var="dto" items="${requestScope.MANAGEPRODUCT}">
                                            <tr>
                                                <td>${dto.pName}</td>
                                                <td>${dto.categoryName}</td>
                                                <td>${dto.pQuantity}</td>
                                                <td> <fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.pPrice}" />đ</td>
                                                <c:if test="${dto.status == 1}" var="checkStatus">
                                                    <td>Active</td>
                                                </c:if>  
                                                <c:if test="${!checkStatus}">
                                                    <td>Draft</td>
                                                </c:if>
                                                <c:if test="${checkStatus}">
                                                    <c:url var="changToDisable" value="MainController">
                                                        <c:param name="id" value="${dto.productID}" />
                                                        <c:param name="action" value="ChangeStatusProduct" />
                                                        <c:param name="status" value="0"/>
                                                    </c:url>
                                                    <td><a href="${changToDisable}">Disable</a></td>
                                                </c:if>
                                                <c:if test="${!checkStatus}">
                                                    <c:url var="changToEnable" value="MainController">
                                                        <c:param name="id" value="${dto.productID}" />
                                                        <c:param name="action" value="ChangeStatusProduct" />
                                                        <c:param name="status" value="1"/>
                                                    </c:url>
                                                    <td><a href="${changToEnable}">Enable</a></td>
                                                </c:if>
                                                <c:url var="linkEditProduct" value="MainController">
                                                    <c:param name="action" value="EditProduct" />
                                                    <c:param name="id" value="${dto.getProductID()}" />                                           
                                                </c:url>
                                                <td><a href="${linkEditProduct}">Edit</a></td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </c:if>


                            </c:if>
                            <c:if test="${!checkSearch}">
                                <c:if test="${not empty requestScope.RESULTSEARCH}">
                                    <c:forEach var="searchDTO" items="${requestScope.RESULTSEARCH}">
                                        <tr>
                                            <td>${searchDTO.pName}</td>
                                            <td>${searchDTO.categoryName}</td>
                                            <td>${searchDTO.pQuantity}</td>
                                            <td>${Math.round(searchDTO.pPrice)}</td>
                                            <c:if test="${searchDTO.status == 1}" var="checkStatus">
                                                <td>Active</td>
                                            </c:if>  
                                            <c:if test="${!checkStatus}">
                                                <td>Draft</td>
                                            </c:if>
                                            <c:if test="${checkStatus}">
                                                <c:url var="changToDisable" value="MainController">
                                                    <c:param name="id" value="${searchDTO.productID}" />
                                                    <c:param name="action" value="ChangeStatusProduct" />
                                                    <c:param name="status" value="0"/>
                                                </c:url>
                                                <td><a href="${changToDisable}">Disable</a></td>
                                            </c:if>
                                            <c:if test="${!checkStatus}">
                                                <c:url var="changToEnable" value="MainController">
                                                    <c:param name="id" value="${searchDTO.productID}" />
                                                    <c:param name="action" value="ChangeStatusProduct" />
                                                    <c:param name="status" value="1"/>
                                                </c:url>
                                                <td><a href="${changToEnable}">Enable</a></td>
                                            </c:if>
                                            <c:url var="linkEditProduct" value="MainController">
                                                <c:param name="action" value="EditProduct" />
                                                <c:param name="id" value="${searchDTO.getProductID()}" />                                           
                                            </c:url>
                                            <td><a href="${linkEditProduct}">Edit</a></td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </c:if>
                        </tbody>
                    </table>

                </div>
                <div class="pagination" style="margin-top: 2rem;">
                    <ol id="numbers"></ol>
                </div>
            </div>
        </div>
        <c:if test="${requestScope.NULL != null}">
            <div id="note" >
                Không có sản phẩm nào được tìm thấy! <a id="close">[x]</a>
                <script>
                    close = document.getElementById("close");
                    close.addEventListener('click', function () {
                        note = document.getElementById("note");
                        note.style.display = 'none';
                    }, false);
                </script>
            </div>
        </c:if>
        <script src="./js/index.js"></script>
        <script>

                    function paging() {
                        const rowsPerPage = 10;
                        const table = document.getElementById('my-table');
                        const tableBody = table.getElementsByTagName("tbody")[0];
                        const rows = tableBody.getElementsByTagName("tr");
                        const rowsCount = rows.length - 1;
                        const pageCount = Math.ceil(rowsCount / rowsPerPage);
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
                            var start = (index - 1) * rowsPerPage;
                            var end = start + rowsPerPage;
                            for (var i = 0; i < rows.length; i++) {
                                rows[i].style.display = "none";
                            }
                            if (index == pageCount) {
                                for (var i = start; i <= rowsCount; i++) {
                                    rows[i].style.display = null;
                                }
                            } else {
                                for (var i = start; i < end; i++) {
                                    rows[i].style.display = null;
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