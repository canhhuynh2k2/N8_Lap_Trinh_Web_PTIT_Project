<%-- 
    Document   : list_user
    Created on : May 31, 2023, 1:17:19 PM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./assets/admin/css/update_user.css">
        <link rel="stylesheet" href="./assets/admin/icon/themify-icons/themify-icons.css">
        <title>Ruoungoai</title>
    </head>

    <body>

        <div id="main">
            <!--BEGIN SIDEBAR-->
            <div class="sidebar">
                <div class="logo">
                    <i class="ti-crown"></i>
                    <p>Ruoungoai</p>
                </div>
                <div class="sidebar-menu">
                    <ul>
                        <li>
                            <a href="list_user">
                                <div class="menu taikhoan sidebar-menu--active">
                                    <i class="ti-user"></i>
                                    <p>Quản Lí Tài Khoản</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="categories">
                                <div class="menu qlloairuou">
                                    <i class="ti-stats-up"></i>
                                    <p>Quản Lí Loại Rượu</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="products">
                                <div class="menu qlwine">
                                    <i class="ti-clipboard"></i>
                                    <p>Quản Lí Rượu</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="manageorders">
                                <div class="menu donhang">
                                    <i class="ti-notepad"></i>
                                    <p>Đơn Hàng</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="admin-statsitic-servlet">
                                <div class="menu thongke">
                                    <i class="ti-bar-chart"></i>
                                    <p>Thống Kê</p>
                                </div> 
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <!--END SIDEBAR-->

            <!--BEGIN HEADER-->
            <div class="header">
                <c:set value="${sessionScope.user}" var="user"/>
                <a href="user_profile">${user.email}</a>
            </div>
            <!--END HEADER-->

            <!--BEGIN INNERBLOCK-->
            <div class="content-wrapper">
                <div class="content-header">
                    <h4>Quản lí tài khoản</h4>
                    <div class="breadcrumb">
                        <a href="#">Quản lí tài khoản<i class="ti-angle-right"></i></a>
                        <a href="#">Sua tài khoản<i class="ti-angle-right"></i></a>
                    </div>
                </div>
                <div class="user-info">
                    <c:set var="user" value="${requestScope.user}"/>
                    <form action="update_user" method="post">
                        <div class="form-input id">
                            <label for="user_id">ID:</label>
                            <input name="user_id" id="user_id" type="text" readonly value="${user.id}">
                        </div>
                        <div class="form-input role">
                            <label for="role_id">Chuc Vu:</label>
                            <select name="role_id" id="role_id">
                                <c:forEach items="${requestScope.listRole}" var="role">
                                    <option value="${role.id}" ${(role.id==user.role.id)?"selected":""}>${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-input fullname">
                            <label for="fullname">Ho Va Ten:</label>
                            <input id="fullname" type="text" readonly value="${user.fullname}">
                        </div>
                        <div class="form-input phone-number">
                            <label for="phone-number">So Dien Thoai:</label>
                            <input id="phone-number" type="text" readonly value="${user.phoneNumber}">
                        </div>
                        <div class="form-input email">
                            <label for="email">Email:</label>
                            <input id="email" type="text" readonly value="${user.email}">
                        </div>
                        <div class="form-input password">
                            <label for="password">Mat Khau:</label>
                            <input id="password" type="text" readonly value="${user.password}">
                        </div>
                        <div class="form-input">
                            <button type="submit" class="btn">Xac Nhan</button>
                        </div>
                    </form>
                </div>
            </div>

            <!--END INNERBLOCK-->
        </div>
        
    </body>
</html>
