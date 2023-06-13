<%-- 
    Document   : updateproduct
    Created on : Mar 28, 2023, 8:16:50 PM
    Author     : chaum
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.util.List,java.util.ArrayList,model.Category,model.Product" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./assets/admin/css/updatecategory.css">
        <link rel="stylesheet" href="./assets/admin/icon/themify-icons/themify-icons.css">
        <script src = "./assets/admin/js/updateproduct.js"></script>
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
                    <h4>Quản lí loại rượu</h4>
                    <div class="breadcrumb">
                        <i class="ti-home"> Trang Chủ</i>
                        <i class="ti-angle-right"></i>
                        <a href="products"> Quản Lí Loại Rượu <i class="ti-angle-right"></i></a>
                        <a href="#"> Sửa </a>
                    </div>
                </div>
                <%
                    
                    Category category = (Category) request.getAttribute("category");
                %>

                <div class="content">
                    <form action ="update_category" method="post">
                        <div class = "form-row">
                            <div class = "form-label">ID</div>
                            <input class = "form-input" type="text" value ="<%=category.getId()%>" readonly name ="id" >
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <div class = "form-label">Tên loại rượu</div>
                            <input id ="name" class = "form-input" type="text" value ="<%=category.getName()%>" name ="name" >
                            <small></small>
                        </div>
                        
                        <div class = "form-row">
                            <button id = "btnsave">Save</button>
                        </div>
                    </form>
                </div>
            </div>
            <!--END INNERBLOCK-->
        </div>

    </body>

</html>