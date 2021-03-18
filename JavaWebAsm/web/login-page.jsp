<%-- 
    Document   : login-page
    Created on : Mar 2, 2021, 3:31:10 PM
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
        <title>Đăng Nhập</title>
        <link rel="stylesheet" href="./css/style1.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css"
              integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="navbar-client.jsp" />
        <%
            String username = (String) session.getAttribute("USERNAME");

            if (username != null) {
                if (username.equals("admin")) {
                    response.sendRedirect("ManageProductController");
                } else {
                    response.sendRedirect("LoadDataController");
                }
            }
        %>

        <div class="form--container">
            <div class="wrapper--user-form">
                <div class="form--title">
                    <h1>Đăng Nhập</h1>
                </div>
                <div class="form--content">
                    <form action="MainController" method="POST">
                        <input type="text" name="txtUsername" value="${requestScope.USERNAME}" class="field--form" placeholder="Tên đăng nhập" required>
                        <br>
                        <input type="password" name="txtPassword" value="${requestScope.PASSWORD}" class="field--form" placeholder="Mật khẩu" required>
                        <br>
                        <c:if test="${INVAID != null}">
                            <span style="color: red;">Sai tên đăng nhập hoặc mật khẩu</span>
                        </c:if>
                        <button type="submit" class="button--form" name="action" value="Login">Đăng Nhập</button>
                    </form>
                </div>
                <div class="form-seperator">
                    <span class="form-seperator-item">hoặc</span>
                </div>
                <div class="form--link">
                    <c:url var="linkSignup" value="MainController">
                        <c:param name="action" value="CreateNewAccount" />
                    </c:url>
                    <a href="${linkSignup}">Đăng Ký</a>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="./js/index.js"></script>
    </body>
</html>
