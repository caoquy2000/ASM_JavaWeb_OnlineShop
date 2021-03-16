<%-- 
    Document   : admin-category-page
    Created on : Mar 3, 2021, 2:16:05 PM
    Author     : caoho
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="quych.dtos.CategoryDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Category</title>
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
    </head>

    <body>
        <jsp:include page="navbar-admin.jsp" />
        <%
            String username = (String) session.getAttribute("USERNAME");
            List<CategoryDTO> dtos = (List<CategoryDTO>) request.getAttribute("MANAGECATEGORY");
            List<CategoryDTO> listSearchDTO = (List<CategoryDTO>) request.getAttribute("RESULTSEARCHCATEGORY");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
                } else {
                    if (dtos == null && listSearchDTO == null) {
                        response.sendRedirect("ManageCategoryController");
                    }
                }
            }
        %>
        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div class="content--block-admin">
                <div class="content--category">
                    <div class="btn--new-product">
                        <a href="./admin-addcategory.jsp">Add Category</a>
                    </div>
                    <form action="MainController" method="POST" style="margin-bottom: 15px; margin-left: 450px">
                        Search: <input type="text" name="txtValueSearchCategory" value="" placeholder="Tên danh mục..."/>
                        <button type="submit" name="action" value="SearchCategory">Tìm kiếm</button>
                    </form>
                    <div class="display--category">

                        <table id="category">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Category Name</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${requestScope.RESULTSEARCHCATEGORY == null}" var="checkListSearch">
                                    <c:if test="${requestScope.MANAGECATEGORY != null}" >
                                        <c:if test="${not empty requestScope.MANAGECATEGORY}" >
                                            <c:forEach var="dto" items="${requestScope.MANAGECATEGORY}" varStatus="counter">
                                                <tr>
                                                    <td>${counter.count}</td>
                                                    <td>${dto.categoryName}</td>
                                                    <c:if test="${dto.status == 1}" var="checkStatus">
                                                        <td>Active</td>
                                                    </c:if>  
                                                    <c:if test="${!checkStatus}">
                                                        <td>Draft</td>
                                                    </c:if>
                                                    <c:if test="${checkStatus}">
                                                        <c:url var="changToDisable" value="MainController">
                                                            <c:param name="id" value="${dto.categoryID}" />
                                                            <c:param name="action" value="ChangeStatusCategory" />
                                                            <c:param name="status" value="0"/>
                                                        </c:url>
                                                        <td><a href="${changToDisable}">Disable</a></td>
                                                    </c:if>
                                                    <c:if test="${!checkStatus}">
                                                        <c:url var="changToEnable" value="MainController">
                                                            <c:param name="id" value="${dto.categoryID}" />
                                                            <c:param name="action" value="ChangeStatusCategory" />
                                                            <c:param name="status" value="1"/>
                                                        </c:url>
                                                        <td><a href="${changToEnable}">Enable</a></td>
                                                    </c:if>
                                                    <c:url var="editQueryString" value="MainController">
                                                        <c:param name="action" value="EditCategory" />
                                                        <c:param name="id" value="${dto.getCategoryID()}" />

                                                    </c:url>
                                                    <td><a href="${editQueryString}">Edit</a></td>


                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </c:if>
                                </c:if>
                                <c:if test="${!checkListSearch}" >
                                    <c:if test="${not empty requestScope.RESULTSEARCHCATEGORY}" var="checkEmptyListSearch">
                                        <c:forEach var="dtoSearch" items="${requestScope.RESULTSEARCHCATEGORY}" varStatus="counter">
                                            <tr>
                                                <td>${counter.count}</td>
                                                <td>${dtoSearch.categoryName}</td>
                                                <c:if test="${dtoSearch.status == 1}" var="checkStatus">
                                                    <td>Active</td>
                                                </c:if>  
                                                <c:if test="${!checkStatus}">
                                                    <td>Draft</td>
                                                </c:if>
                                                <c:if test="${checkStatus}">
                                                    <c:url var="changToDisable" value="MainController">
                                                        <c:param name="id" value="${dtoSearch.categoryID}" />
                                                        <c:param name="action" value="ChangeStatusCategory" />
                                                        <c:param name="status" value="0"/>
                                                    </c:url>
                                                    <td><a href="${changToDisable}">Disable</a></td>
                                                </c:if>
                                                <c:if test="${!checkStatus}">
                                                    <c:url var="changToEnable" value="MainController">
                                                        <c:param name="id" value="${dtoSearch.categoryID}" />
                                                        <c:param name="action" value="ChangeStatusCategory" />
                                                        <c:param name="status" value="1"/>
                                                    </c:url>
                                                    <td><a href="${changToEnable}">Enable</a></td>
                                                </c:if>
                                                <c:url var="editQueryString" value="MainController">
                                                    <c:param name="action" value="EditCategory" />
                                                    <c:param name="id" value="${dtoSearch.getCategoryID()}" />

                                                </c:url>
                                                <td><a href="${editQueryString}">Edit</a></td>


                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    <%--<c:if test="${!checkEmptyListSearch}">--%>
                                    <!--<h2>Không có sản phẩm giống tên này!</h2>-->
                                    <%--</c:if>--%>
                                </c:if>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="./js/index.js"></script>
    </body>

</html>