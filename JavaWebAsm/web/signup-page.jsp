<%-- 
    Document   : signup-page
    Created on : Mar 2, 2021, 3:33:42 PM
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
        <title>Đăng Ký</title>
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
                    <h1>Đăng Ký</h1>
                </div>
                <div class="form--content">
                    <form action="MainController" method="POST" onsubmit="return validateForm()">
                        <c:if test="${requestScope.INVALID != null}">
                            <span style="color: red;">Tên đăng nhập đã tồn tại</span>
                        </c:if>
                        <input type="text" class="field--form" name="txtUsername" placeholder="Tên đăng nhập" required >

                        <br>
                        <input type="password" id="input_password1" class="field--form" name="txtPassword" placeholder="Mật khẩu" required onkeyup="check()">
                        <br>
                        <input type="password" id="input_password2" class="field--form"  name="txtRepassword" placeholder="Nhập lại mật khẩu" required onkeyup="check()">
                        <span id="message"></span>
                        <br>
                        <input type="text" class="field--form" name="txtFullname" placeholder="Họ và tên" required>
                        <span style="color: red; " id="errorFullname"></span>
                        <br>
                        <button type="submit" class="button--form" name="action" value="CreateAccount">Đăng Ký</button>
                    </form>
                </div>
                <div class="form-seperator">
                    <span class="form-seperator-item">hoặc</span>
                </div>
                <div class="form--link">
                    <c:url var="linkLogin" value="MainController">
                        <c:param name="action" value="LoginPage" />
                    </c:url>
                    <a href="${linkLogin}">Đăng Nhập</a>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="./js/index.js"></script>
        <script>
                            function check() {
                                var password = document.getElementById('input_password1').value;
                                var rePassword = document.getElementById('input_password2').value;

                                if (password === rePassword) {
                                    document.getElementById('message').style.color = 'Green';
                                    document.getElementById('message').innerHTML = 'Khớp mật khẩu';
                                } else {
                                    document.getElementById('message').style.color = 'Red';
                                    document.getElementById('message').innerHTML = 'Mật khẩu chưa khớp';
                                }
                            }
                            function validateForm() {
                                let fullname = document.querySelector('[name="txtFullname"]').value;

                                let errorName = document.getElementById('errorFullname');
                                if (fullname.length > 30) {
                                    errorName.innerHTML = 'Tên Không được quá 30 kí tự';
                                    return false;
                                }
                                return true;
                            }
        </script>
    </body>
</html>
