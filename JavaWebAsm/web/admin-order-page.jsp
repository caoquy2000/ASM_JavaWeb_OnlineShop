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
        <title>Quản Lí Đơn Hàng</title>
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
        </style>
    </head>

    <body>
        <jsp:include page="navbar-admin.jsp" />

        <%
            String username = (String) session.getAttribute("USERNAME");
            List<ProductDTO> dtos = (List<ProductDTO>) request.getAttribute("RESULT");
            List<ProductDTO> listSearch = (List<ProductDTO>) request.getAttribute("RESULTSEARCH");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
                } else {
                    if (dtos == null && listSearch == null) {
                        response.sendRedirect("LoadOrderController");
                    }
                }
            }
        %>
        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div class="content--block-admin">
                <div class="btn--new-product">

                </div>

                <div class="table--product" style="height: 550px;">
                   
                    <table class="table" id="my-table">
                        <thead>
                            <tr>
                                <th scope="col">STT.</th>
                                <th scope="col">Mã Đơn Hàng</th>
                                <th scope="col">Người Đặt</th>
                                <th scope="col">Số Điện Thoại</th>
                                <th scope="col">Tổng Giá</th>
                                <th scope="col">Thời Gian</th>

                                <th scope="col">Trạng Thái</th>
                                <th scope="col">Action</th>
                         
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${requestScope.RESULT != null}">
                                <c:if test="${not empty requestScope.RESULT}" var="checkDTOs">
                                    <c:forEach var="dto" items="${requestScope.RESULT}" varStatus="counter">
                                        <tr>
                                            <th scope="row">${counter.count}</th>
                                            <td>${dto.getOrderID()}</td>
                                            <td>${dto.getFullName()}</td>
                                            <td>${dto.getPhone()}</td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.getTotal()}" />đ</td>
                                            <td>${dto.getTimeOfCreate()}</td>
                                            <c:if test="${dto.getStatus() == 1}">
                                                <td>Đang chờ</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 2}">
                                                <td>Đã xác nhận</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 0}">
                                                <td>Đã hủy</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 1}">
                                                <c:url var="linkChangeStatusOrder" value="MainController">
                                                    <c:param name="action" value="ConfirmOrder" />
                                                    <c:param name="id" value="${dto.getOrderID()}" />
                                                    <c:param name="status" value="2" />
                                                </c:url>
                                                <td><a href="${linkChangeStatusOrder}">Xác Nhận</a></td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 2}" >
                                                <td>Chờ Nhận Hàng</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 0}" >
                                                <td>#</td>
                                            </c:if>
                                   

                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${!checkDTOs}">
                                <h2>Không có đơn hàng nào.</h2>
                            </c:if>
                        </c:if>
                        </tbody>
                    </table>

                   
                </div>
                 <div class="pagination">
                        <ol id="numbers"></ol>
                    </div>
            </div>
        </div>
        <script src="./js/index.js"></script>
        <script src="./js/paging_table.js"></script>
    </body>

</html>