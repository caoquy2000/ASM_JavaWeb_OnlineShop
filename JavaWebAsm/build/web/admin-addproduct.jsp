<%-- 
    Document   : admin-addcategory
    Created on : Mar 3, 2021, 2:19:32 PM
    Author     : caoho
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <%
            String username = (String) session.getAttribute("USERNAME");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
                } else {

                }
            }
        %>
        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div class="content--block-admin">
                <div class="add-product-block">
                    <form id="addProduct" action="${requestScope.DTO != null ? 'MainController?action=UpdateProduct' : 'MainController?action=AddProduct'}" method="post" enctype="multipart/form-data">
                        <label class="title-add--product" for="">ProductID</label>
                        <input type="text" name="txtProductID" value="${requestScope.DTO.getProductID()}"/>

                        <label class="title-add--product" for="">Product Name</label>
                        <input type="text" name="txtProductName" value="${requestScope.DTO.getpName()}" />

                        <label  class="title-add--product" for="">Status</label>
                        <select name="txtStatusProduct" id="">

                            <option value="0" ${requestScope.DTO.getStatus() == 0 ? 'selected' : ''}>Draft</option>
                            <option value="1" ${requestScope.DTO.getStatus() == 1 ? 'selected' : ''}>Active</option>
                        </select>

                        <label  class="title-add--product" for="">Category</label>
                        <select name="txtCategoryName" id="">
                            <c:forEach var="dto" items="${requestScope.MANAGECATEGORY}">
                                <option value="${dto.getCategoryID()}">${dto.getCategoryName()}</option>

                            </c:forEach>
                        </select>

                        <label class="title-add--product" for="">Image</label>
                        <input type="file" name="imgProduct" value="${requestScope.DTO.getpUrl()}" />

                        <label class="title-add--product" for="">Price</label>
                        <input type="number" name="txtProductPrice" value="${requestScope.DTO.getpPrice()}"/>

                        <label class="title-add--product" for="">Quantity</label>
                        <input type="number" name="txtProductQuantity" value="${requestScope.DTO.getpQuantity()}" />

                        <label class="title-add--product" for="">Description</label>
                        <input type="text" name="txtDescription" value="${requestScope.DTO.getpDescription()}" />

                        <button type="submit" class="btn--addProduct"> Submit </button>
                    </form>

                </div>
            </div>
        </div>
        <script src="./js/index.js"></script>
    </body>

</html>