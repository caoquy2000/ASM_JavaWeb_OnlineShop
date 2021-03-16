<%-- 
    Document   : admin-product-page
    Created on : Mar 3, 2021, 2:10:32 PM
    Author     : caoho
--%>

<%@page import="quych.dtos.ProductDTO"%>
<%@page import="java.util.List"%>
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
    </head>

    <body>
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
                        response.sendRedirect("ManageProductController");
                    }
                }
            }
        %>
        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div class="content--block-admin">
                <div class="btn--new-product">
                    <c:url var="addPage" value="MainController">
                        <c:param name="action" value="LoadAddProduct" />
                    </c:url>
                    <a href="${addPage}">Thêm sản phẩm</a>
                </div>

                <div class="table--product">
                    <form action="MainController" method="POST" style="margin-bottom: 15px;">
                        Search: <input type="text" name="txtValueSearchProduct" value="" placeholder="Tên sản phẩm..."/>
                        <button type="submit" name="action" value="SearchProduct">Tìm kiếm</button>
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
                                                <td>${Math.round(dto.pPrice)}</td>
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

            </div>
        </div>
        <script src="./js/index.js"></script>
    </body>

</html>