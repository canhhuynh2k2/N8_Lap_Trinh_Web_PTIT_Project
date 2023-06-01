<%-- 
    Document   : showproduct2.jsp
    Created on : Mar 28, 2023, 8:36:19 PM
    Author     : chaum
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.util.List,java.util.ArrayList,model.Category,model.Product" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./assets/admin/css/showcategory.css">
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
                            <a href="#">
                                <div class="menu taikhoan">
                                    <i class="ti-user"></i>
                                    <p>Tài Khoản</p>
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
                            <a href="#">
                                <div class="menu phanhoi">
                                    <i class="ti-comments"></i>
                                    <p>Phản Hồi Khách Hàng</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <div class="menu donhang">
                                    <i class="ti-notepad"></i>
                                    <p>Đơn Hàng</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
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
                <div class="header-menu">
                    <i class="ti-menu"></i>
                </div>
                <div class="nav">
                   
                    <div class="user">
                        <img src="./assets/img/avt1.jpg" alt="">
                        <p>Nguyễn Văn A</p>
                        <i class="ti-angle-down"></i>
                    </div>
                </div>
            </div>
            <!--END HEADER-->

            <!--BEGIN INNERBLOCK-->
            <div class="content-wrapper">
                <div class="content-header">
                    
                    <h4>Quản lí loại rượu</h4>
                    <div class="breadcrumb">
                        <i class="ti-home"> Trang Chủ</i>
                        <i class="ti-angle-right"></i>
                        <a href="#"> Quản Lí Loại Rượu <i class="ti-angle-right"></i></a>
                        <!--<a href="#">Cập Nhật Sản Phẩm</a>-->
                    </div>
                </div>

                <div class = "addbtn-container" style="display: flex">
                    <div class = "addbtn">
                        <a href="add_category">Thêm Loại Rượu</a>
                    </div>
                </div>
                <div class="table-container">
                    <!-- BEGIN TABLE SẢN PHẨM -->
                    <table >
                        <thead>
                        <th>ID</th>
                        <th>Loại rượu</th>
                        <th>Sửa</th>
                        <th>Xóa</th>
                        </thead>
                        <tbody>
                            <%
                                    List<Category> categories  = (ArrayList<Category>) request.getAttribute("categories");
                                    Integer numberOfPage = (Integer)request.getAttribute("numberofpage");
                                    Integer currentpage = (Integer)request.getAttribute("page");
                                    for(Category category: categories){
                            %>
                            <tr>
                                <td><%=category.getId()%></td>
                                <td><%=category.getName()%></td>
                                <td ><a class ="ti-settings"  href="update_category?id=<%=category.getId()%>&page=<%=currentpage%>">Update</a></td>
                                <td><a class = "ti-trash" href="delete_category?id=<%=category.getId()%>&page=<%=currentpage%>">Delete</a></td>
                            </tr>
                            <%
                        }
                            %>

                        </tbody>
                    </table>
                    <!-- END TABLE SẢN PHẨM -->
                    <div class = "page-bar">
                        <% 
                         for(int i = 1; i <= numberOfPage; i++){
                            if(i != currentpage){
                        %>
                        <a class="page-box" href="categories?page=<%=i%>">
                            <%=i%>
                        </a>
                        <%
                            }
                            else{
                        %>
                        <a class="currentpage" href="categories?page=<%=i%> ">
                            <%=i%>
                        </a>
                        <%
                            }
                         }
                        %>
                    </div>
                </div>
            </div>
            
            <!--END INNERBLOCK-->
        </div>
        <% 
            String message = (String) request.getAttribute("message");
            if(message!=null){
            %>
            <script type="text/javascript">
            var msg = "<%=message%>";
            alert(msg);
            </script>
            <%
                }
            %>
    </body>
</html>
