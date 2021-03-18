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
                    <c:if test="${requestScope.FAILED != null}" >
                        <div id="messageBlock" class="toast fade show">
                            <div class="toast-header">
                                <strong class="mr-auto"><i class="fa fa-globe"></i> Message</strong>
                                <small class="text-muted">Tạm thời</small>
                                <button id="closeMessage" type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                            <div class="toast-body">
                                Thêm danh mục thất bại.
                            </div>
                        </div>
                        <script>
                            close = document.getElementById("closeMessage");
                            close.addEventListener('click', function () {
                                message = document.getElementById("messageBlock");
                                message.style.display = 'none';
                            }, false);
                        </script>
                    </c:if>
                    <div class="add--category">

                        <form id="addCate" 
                              action="${requestScope.DTO != null ? 'MainController?action=UpdateCategory' : 'MainController?action=AddCategory'}" 
                              method="POST" 
                              enctype="multipart/form-data"
                              onsubmit="return validateForm()"
                              >
                            <label class="title-add--product" for="">CategoryID:</label>
                            <div>
                                <input type="text" id="categoryID" name="txtCategoryID" value="${requestScope.DTO.getCategoryID()}" ${requestScope.DTO != null ? 'readonly' : ''} readonly="">
                                <c:if test="${requestScope.DTO == null}">
                                    <button type="button" id="generateID" style="padding: 0rem 2rem; margin-left: 1rem;" class="btn btn-primary" >Tạo ID</button>
                                </c:if>
                            </div>
                            <br>
                            <label  class="title-add--product"  for="">Category Name:</label> <br />
                            <input type="text" name="txtCategoryName" value="${requestScope.DTO.getCategoryName()}" required="">
                            <br/>
                            <span id="errorFullname" style="color: red;"></span>
                            <br />
                            <label class="title-add--product" for="">Image:</label>
                            <br />
                            <input type="file" name="imgCategory" value="${requestScope.DTO.getcUrl()}" required="">
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
        <script>
                                  let generateID = document.getElementById('generateID');
                                  let idCategory = document.getElementById('categoryID');
                                  generateID.addEventListener('click', function () {
                                      let id = 'DM' + new Date().getTime();
                                      idCategory.value = id;
                                  })
                                  function validateForm() {
                                      let categoryName = document.querySelector('[name="txtCategoryName"]').value;

                                      let errorName = document.getElementById('errorFullname');
                                      if (categoryName.length > 30) {
                                          errorName.innerHTML = 'Tên danh mục không được quá 30 kí tự';
                                          return false;
                                      }
                                      return true;
                                  }
        </script>

    </body>

</html>