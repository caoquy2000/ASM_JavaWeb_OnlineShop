
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="navbar" 
     style="
     font-size: 1.6rem;
     position: sticky;
     top: 0;
     z-index: 999;
     "
     >
    <div class="navbar-container">
        <div class="nav--menu">
            <div class="nav--logo">
                <h1><a class="hyper__link__logo" href="MainController">Chợ Tết</a></h1>
            </div>
            <div class="nav--list-menu">
                <ul>
                    <li class="nav-items"><a class="hyper__link" href="MainController"><i
                                class="fas fa-house-user img--icon-header"></i>Trang Chủ</a></li>
                    <li class="nav-items"><a class="hyper__link" href="#"><i
                                class="far fa-bell img--icon-header"></i>Thông Báo</a></li>
                            <c:if test="${empty sessionScope.USERNAME}" var="checkUsername" >
                                <c:url var="linkSignup" value="MainController">
                                    <c:param name="action" value="CreateNewAccount" />
                                </c:url>
                        <li class="nav-items"><a class="hyper__link" href="${linkSignup}"><i class="fas fa-user-plus img--icon-header"></i>Đăng Ký</a></li>
                        </c:if>
                        <c:if test="${!checkUsername}" >
                            
                            <li class="nav-items" style="margin-right: 2rem;">
                                <c:url var="linkToHistory" value="MainController">
                                    <c:param name="action" value="HistoryPage" />
                                </c:url>
                                <a class="hyper__link" href="${linkToHistory}"><i class="fas fa-history img--icon-header"></i>Lịch Sử</a>
                            </li>
                        </c:if>
                        <c:if test="${!checkUsername}" >
                            <div class="dropdown" >
                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" style="font-size: 1.6rem;">
                                    Xem Thêm
                                </button>
                                <div class="dropdown-menu">
                                    <c:url var="linkToMyOrder" value="MainController">
                                        <c:param name="action" value="LoadMyOrder" />
                                    </c:url>
                                    <a class="dropdown-item" href="${linkToMyOrder}" style="font-size: 1.4rem;">Đơn Hàng Của Tôi</a>
                                

                                </div>
                            </div>
                    </c:if>

                </ul>

            </div>
        </div>
        <div class="nav--wrapper">
            <div class="nav--search-form">
                <form action="">
                    <input type="text" required placeholder="Tìm kiếm trên Chợ Tết">
                    <button type="submit"><i class="fas fa-search main-color"></i></button>
                </form>
            </div>
            <div class="nav--login">
                <c:if test="${checkUsername}" >
                    <a class="hyper__link" href="login-page.jsp">
                        <i class="far fa-user-circle img--icon-header"></i> Đăng Nhập
                    </a>
                </c:if>
                <c:if test="${!checkUsername}" >
                    <c:url var="logout" value="MainController">
                        <c:param name="action" value="Logout" />
                    </c:url>
                    <a class="hyper__link" href="${logout}">
                        <i class="fas fa-sign-out-alt img--icon-header"></i> Đăng Xuất
                    </a>
                </c:if>
                <c:url var="linkShoppingCart" value="MainController">
                    <c:param name="action" value="ViewShoppingCart" />

                </c:url>
                <a href="${linkShoppingCart}" style="position: relative;" class="hyper__link"><i class="fas fa-shopping-bag img--icon-header"></i>
                    <p 
                        style="
                        width: 2rem; 
                        height: 2rem; 
                        color: rgb(1, 127, 255); 
                        font-size: 1.4rem;
                        border-radius: 50%;
                        text-align: center;
                        font-weight: 600;
                        position: absolute;
                        top: 34%;
                        left: 55%;"
                        >
                        <c:if test="${sessionScope.CART.getCart().values().size() != 0}">
                            ${sessionScope.CART.getCart().values().size()}
                        </c:if>
                    </p></a>
            </div>
        </div>
    </div>
</div>