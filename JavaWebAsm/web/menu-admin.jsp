<%-- 
    Document   : menu-admin
    Created on : Mar 5, 2021, 12:31:15 PM
    Author     : caoho
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="menu--admin">
    <ul class="nav--menu-profile">
        <li class="nav--menu-item ${requestScope.CLASS4}">
            <c:url var="linkToAdminStatictisPage" value="MainController">
                <c:param name="action" value="ViewAdminStatictis" />
            </c:url>
            <a href="${linkToAdminStatictisPage}"><i class="fas fa-clipboard"></i>Thống Kê</a>
        </li>
        <li class="nav--menu-item ${requestScope.CLASS1}">
            <c:url var="linkToAdminProductPage" value="MainController">
                <c:param name="action" value="ViewAdminProduct" />
            </c:url>
            <a href="./admin-product-page.jsp"><i class="fas fa-clipboard"></i>Sản Phẩm</a>
        </li>
        <li class="nav--menu-item ${requestScope.CLASS2}"><a href="./admin-category-page.jsp"><i class="fas fa-receipt"></i>Danh Mục</a></li>
        <li class="nav--menu-item ${requestScope.CLASS3}">
            <c:url var="linkManageOrder" value="MainController">
                <c:param name="action" value="ManageOrderPage" />
            </c:url>
            <a href="${linkManageOrder}"><i class="fas fa-archive"></i>Đơn Hàng</a>
        </li>
    </ul>
</div>
