<%-- 
    Document   : navbar-admin
    Created on : Mar 3, 2021, 2:11:04 PM
    Author     : caoho
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="nav--bar">
    <div class="profile--admin">
        <div class="logo--img">
            <h1><a class="hyper__link__logo" href="#">Chợ Tết</a></h1>
        </div>

    </div>
    <div class="welcome--admin">
        <div class="admin--profile-content">
            <button onclick="showMenu()" class="btn-profile" >
                <div class="icon--profile-admin"><i class="fas fa-user icon--profile"></i></div><span
                    class="admin-name" style="display: inline;">${sessionScope.USERNAME}</span>
            </button>
            <div id="dropdownMenu" class="dropdownMenu-content">
                  <c:url var="logout" value="MainController">
                        <c:param name="action" value="Logout" />
                    </c:url>
                <a href="${logout}">Đăng Xuất</a>
            </div>
        </div>
    </div>
</div>