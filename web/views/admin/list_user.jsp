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
        <link rel="stylesheet" href="./assets/admin/css/list_user.css">
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
                <a href="user_profile"><i class="fa-solid fa-user"></i>${user.email}</a>
            </div>
            <!--END HEADER-->

            <!--BEGIN INNERBLOCK-->
            <div class="content-wrapper">
                <div class="content-header">
                    <h4>Quản lí tài khoản</h4>
                    <div class="breadcrumb">
                        <a href="#">Quản lí tài khoản<i class="ti-angle-right"></i></a>
                    </div>
                </div>
                <div class="list-user">
                    <!-- BEGIN TABLE SẢN PHẨM -->
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Chức Vụ</th>
                                <th>Họ Và Tên</th>
                                <th>Số Điện Thoại</th>
                                <th>Email</th>
                                <th>Mật Khẩu</th>
                                <th>Xoa</th>
                                <th>Sua</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.listUser}" var="user">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.role.name}</td>
                                    <td>${user.fullname}</td>
                                    <td>${user.phoneNumber}</td>
                                    <td>${user.email}</td>
                                    <td>${user.password}</td>
                                    <td><a class ="ti-settings"  href="update_user?id=${user.id}">Sua</a></td>
                                    <td><a class = "ti-trash" href="#" onclick="deleteUser(${user.id})">Xoa</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- END TABLE SẢN PHẨM -->
                    <div class = "page_bar">
                        <ul>
                            <c:forEach begin="${1}" end="${requestScope.totalPages}" var="page" step="${1}">
                                <li><a href="list_user?page=${page}" class="${(page==requestScope.page)?"page--active":""}">${page}</a></li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>

            <!--END INNERBLOCK-->
        </div>
        <script>
            const deleteUser = (id) => {
                console.log(window.location);
                if(confirm("Ban Co Muon Xoa Tai Khoan Nay?")) {
                    window.location = "delete_user?id=" + id;
                }
            }

            var error = "${requestScope.error}";
            var success = "${requestScope.success}";
            if (error !== "") {
                alert(error);
            } else if (success !== "") {
                alert(success);
            }
        </script>
    </body>
</html>
