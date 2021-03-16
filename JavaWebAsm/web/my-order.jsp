<%-- 
    Document   : history
    Created on : Mar 3, 2021, 1:49:39 PM
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
        <title>Đơn Hàng Của Tôi</title>
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

        <div class="history--container">
            <div class="wrapper--history">
                <div class="table--history">
                    <c:if test="${requestScope.RESULT != null}">
                        <c:if test="${not empty requestScope.RESULT}" var="checkDTOs">
                            <table class="table" style="font-size: 1.4rem;">
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
                                        <th scope="col">Chi Tiết Đơn Hàng</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <c:forEach var="dto" items="${requestScope.RESULT}" varStatus="counter">
                                        <tr>
                                            <th scope="row">${counter.count}</th>
                                            <td>${dto.getOrderID()}</td>
                                            <td>${dto.getFullName()}</td>
                                            <td>${dto.getPhone()}</td>
                                            <td>${dto.getTotal()}</td>
                                            <td>${dto.getTimeOfCreate()}</td>
                                            <c:if test="${dto.getStatus() == 1}">
                                                <td>Đang chờ</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 2}">
                                                <td>Đang Giao Hàng</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 0}">
                                                <td>Đã hủy</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 1}">
                                                <c:url var="linkChangeStatusOrder" value="MainController">
                                                    <c:param name="action" value="CancelOrder" />
                                                    <c:param name="id" value="${dto.getOrderID()}" />
                                                    <c:param name="status" value="0" />
                                                </c:url>
                                                <td><a href="${linkChangeStatusOrder}">Hủy Đơn Hàng</a></td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 2}" >
                                                <td>Chờ Nhận Hàng</td>
                                            </c:if>
                                            <c:if test="${dto.getStatus() == 0}" >
                                                <td>Đơn Hàng Đã Hủy</td>
                                            </c:if>
                                            <td>Xem</td>

                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${!checkDTOs}">
                            <h2>Không có đơn hàng nào.</h2>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>


        <jsp:include page="footer.jsp" />


        <script src="./js/index.js"></script>
    </body>
</html>