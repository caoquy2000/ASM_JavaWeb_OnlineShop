<%-- 
    Document   : admin-addcategory
    Created on : Mar 3, 2021, 2:19:32 PM
    Author     : caoho
--%>

<%@page import="quych.dtos.CategoryDTO"%>
<%@page import="java.util.List"%>
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
            List<CategoryDTO> listDTOs = (List<CategoryDTO>) request.getAttribute("MANAGECATEGORY");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
                } else {
                    if (listDTOs == null) {
                        request.getRequestDispatcher("LoadAddProductController").forward(request, response);
                    }
                }
            }
        %>
        <jsp:include page="navbar-admin.jsp" />
        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div class="content--block-admin">
                <c:if test="${requestScope.FAILED != null}" >
                    <div id="messageBlock" class="toast fade show">
                        <div class="toast-header">
                            <strong class="mr-auto"><i class="fa fa-globe"></i> Message</strong>
                            <small class="text-muted">Tạm thời</small>
                            <button id="closeMessage" type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                        </div>
                        <div class="toast-body">
                            Thêm sản phẩm thất bại.
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
                <div class="add-product-block">

                    <form id="addProduct" 
                          action="${requestScope.DTOEDIT != null ? 'MainController?action=UpdateProduct' : 'MainController?action=AddProduct'}" 
                          method="post" 
                          enctype="multipart/form-data"
                          style="width: 500px; height: 700px;"
                          onsubmit="return validateForm()"
                          >
                        <label class="title-add--product" for="">ProductID</label>
                        <div style="display: flex;">
                            <input type="text" id="idProduct" name="txtProductID" value="${requestScope.DTOEDIT.getProductID()}" readonly="" required=""/>
                            <c:if test="${requestScope.DTOEDIT == null}">
                                <button type="button" id="generateID" style="padding: 0rem 2rem; margin-left: 1rem;" class="btn btn-primary" >Tạo ID</button>
                            </c:if>
                        </div>

                        <label class="title-add--product" for="">Product Name</label>
                        <input id="productName" type="text" name="txtProductName" value="${requestScope.DTOEDIT.getpName()}" required="" />
                        <span id="errorFullname" style="color: red;"></span>
                        <br />
                        <label  class="title-add--product" for="">Status</label>
                        <select name="txtStatusProduct" id="">

                            <option value="0" ${requestScope.DTOEDIT.getStatus() == 0 ? 'selected' : ''}>Draft</option>
                            <option value="1" ${requestScope.DTOEDIT.getStatus() == 1 ? 'selected' : ''}>Active</option>
                        </select>

                        <label  class="title-add--product" for="">Category</label>
                        <select name="txtCategoryName" id="">
                            <c:forEach var="dto" items="${requestScope.MANAGECATEGORY}">
                                <c:if test="${dto.getStatus() != 0}">
                                    <option value="${dto.getCategoryID()}">${dto.getCategoryName()}</option>
                                </c:if>
                            </c:forEach>
                        </select>

                        <label class="title-add--product" for="">Image</label>
                        <input type="file" name="imgProduct" value="${requestScope.DTOEDIT.getpUrl()}" required=""/>

                        <label class="title-add--product" for="">Price</label>
                        <input type="number" name="txtProductPrice" value="${requestScope.DTOEDIT.getpPrice()}" required=""/>

                        <label class="title-add--product" for="">Quantity</label>
                        <input type="number" name="txtProductQuantity" value="${requestScope.DTOEDIT.getpQuantity()}"  required=""/>

                        <label class="title-add--product" for="">Description</label>
                        <input type="text" name="txtDescription" value="${requestScope.DTOEDIT.getpDescription()}"  required=""/>
                        <div style="display: flex; justify-content: center; margin-top: 0.5rem;">
                            <button type="submit" class="btn--addProduct btn btn-primary" style=""> Submit </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <script src="./js/index.js"></script>
        <script>
                              let generateID = document.getElementById('generateID');
                              let idProduct = document.getElementById('idProduct');
                              generateID.addEventListener('click', function () {
                                  let id = 'SP' + new Date().getTime();
                                  idProduct.value = id;
                              })

        </script>
        <script>
            function validateForm() {
                let productName = document.querySelector('[name="txtProductName"]').value;

                let errorName = document.getElementById('errorFullname');
                if (productName.length > 30) {
                    errorName.innerHTML = 'Tên sản phẩm không được quá 30 kí tự';
                    return false;
                }
                return true;
            }
        </script>
    </body>

</html>