<%-- 
    Document   : admin-addcategory
    Created on : Mar 3, 2021, 2:20:34 PM
    Author     : caoho
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
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
        <%
            String username = (String) session.getAttribute("USERNAME");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
                }
            }
        %>
        <jsp:include page="navbar-admin.jsp" />
        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div class="content--block-admin">
                <div class="content--category">
                    <div class="add--category">
                        <h2>${requestScope.FAILED}</h2>
                        <form id="addCate" action="${requestScope.DTO != null ? 'MainController?action=UpdateCategory' : 'MainController?action=AddCategory'}" method="POST" enctype="multipart/form-data">
                            <label class="title-add--product" for="">CategoryID:</label>
                            <input type="text" name="txtCategoryID" value="${requestScope.DTO.getCategoryID()}" ${requestScope.DTO != null ? 'readonly' : ''}>
                            <br>
                            <label  class="title-add--product"  for="">Category Name:</label>
                            <input type="text" name="txtCategoryName" value="${requestScope.DTO.getCategoryName()}">
                            <br />
                            <label class="title-add--product" for="">Image:</label>

                            <input type="file" name="imgCategory" value="${requestScope.DTO.getcUrl()}">
                            <br>
                            <label for="">Status: </label>
                            <select name="txtStatus">
                                <option value="active">Active</option>
                                <option value="draft">Draft</option>
                            </select>
                            <br />
                            <button type="submit" class="button--form">Submit</button>

                        </form>
                        <c:if test="${not empty requestScope.FAILED}"> <h2>ADD CATEGORY FAILED</h2></c:if>
                    </div>
                </div>
            </div>
        </div>
        <script src="./js/index.js"></script>
    </body>

</html>