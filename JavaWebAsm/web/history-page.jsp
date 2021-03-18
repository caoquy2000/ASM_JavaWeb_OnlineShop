<%-- 
    Document   : history
    Created on : Mar 3, 2021, 1:49:39 PM
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
        <title>Lịch sử mua hàng</title>
        <link rel="stylesheet" href="./css/style1.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css"
              integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
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
            String username = (String) session.getAttribute("USERNAME");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (username.equals("admin")) {
                    response.sendRedirect("admin-product-page.jsp");
                }
            }
        %>

        <div class="history--container">
            <div class="wrapper--history">
                <div class="table--history" style="display: flex; justify-content: center; ">
                    <c:if test="${requestScope.RESULT != null}">
                        <c:if test="${not empty requestScope.RESULT}" var="checkDTOs">
                            <table id="my-table" class="table" style="font-size: 1.6rem;">
                                <thead>
                                    <tr>
                                        <th scope="col">STT.</th>
                                        <th scope="col">Mã Đơn Hàng</th>
                                        <th scope="col">Tên Người Nhận</th>
                                        <th scope="col">Số Điện Thoại</th>
                                        <th scope="col">Tổng Giá</th>
                                        <th scope="col">Thời Gian Đặt Hàng</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <c:forEach var="dto" items="${requestScope.RESULT}" varStatus="counter">
                                        <tr>
                                            <th scope="row">${counter.count}</th>
                                            <td>${dto.getOrderID()}</td>
                                            <td>${dto.getFullName()}</td>
                                            <td>${dto.getPhone()}</td>
                                            <td>  <fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.getTotal()}" />đ</td>
                                            <td>${dto.getTimeOfCreate()}</td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${!checkDTOs}">
                            <div id="messageBlock" class="toast fade show" style="font-size: 1.6rem; height: 7rem;">
                                <div class="toast-header">
                                    <strong class="mr-auto"><i class="fa fa-globe"></i> Message</strong>

                                </div>
                                <div class="toast-body">
                                    Bạn chưa mua sản phẩm nào.
                                </div>
                            </div>
                        
                        </c:if>
                    </c:if>
                </div>
                <div class="pagination">
                    <ol id="numbers"></ol>
                </div>
            </div>
        </div>


        <jsp:include page="footer.jsp" />


        <script src="./js/index.js"></script>
        <script src="./js/paging_table.js"></script>
    </body>
</html>