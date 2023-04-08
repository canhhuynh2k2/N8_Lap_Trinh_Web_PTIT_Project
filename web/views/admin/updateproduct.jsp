<%-- 
    Document   : updateproduct
    Created on : Mar 28, 2023, 8:16:50 PM
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
        <link rel="stylesheet" href="./assets/admin/css/updateproduct.css">
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
                            <a href="#">
                                <div class="menu taikhoan">
                                    <i class="ti-user"></i>
                                    <p>Tài Khoản</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <div class="menu qlloairuou">
                                    <i class="ti-stats-up"></i>
                                    <p>Quản Lí Loại Rượu</p>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
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
                    <div class="navbar">
                        <ul>
                            <li>
                                <a href="#"><i class="ti-search"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="ti-bell"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="ti-email"></i></a>
                            </li>
                        </ul>
                    </div>
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
                    <h4>Quản lí rượu</h4>
                    <div class="breadcrumb">
                        <i class="ti-home"> Trang Chủ</i>
                        <i class="ti-angle-right"></i>
                        <a href="products"> Quản Lí Rượu <i class="ti-angle-right"></i></a>
                        <a href="#"> Sửa </a>
                    </div>
                </div>
                <%
                    
                    Product product = (Product) request.getAttribute("product");
                    List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
                %>

                <div class="content">
                    <form action ="updateproduct" method="post">
                        <div class = "form_row">
                            <div class = "form_label">ID</div>
                            <input class = "form_input" type="text" value ="<%=product.getId()%>" readonly name ="id" >
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <div class = "form_label">Tên rượu</div>
                            <input id ="name" class = "form_input" type="text" value ="<%=product.getName()%>" name ="name" >
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <label class = "form_label">Ảnh</label>
                            <input accept="image/*" type="file" id="thumbnail" onchange="preview()" value = "./assets/admin/images/thumbnail/<%=product.getThumbnail()%>"  name ="thumbnail"/>
                            <img id="frame" src="./assets/admin/images/thumbnail/<%=product.getThumbnail()%>" width="150px" height="150px" value = "<%=product.getThumbnail()%>" />
                            <input type="hidden" name="oldthumbnail" value = "<%=product.getThumbnail()%>" >
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <div class = "form_label">Mô tả</div>
                            <input  id = "description" class = "form_input" type="textarea" value = "<%=product.getDescription()%>" name = "description">
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <div class = "form_label">Hãng</div>
                            <input  id = "branch" class = "form_input" type="text" value = "<%=product.getBranch()%>" name = "branch">
                            <small></small>
                        </div>
                        <div class = "form_row"> 
                            <label class = "form_label">Quy cách</label>
                            <input id ="unit" class = "form_input" type="text" value = "<%=product.getUnit()%>" name = "unit">
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <label class = "form_label">Loại rượu</label>
                            <select id ="category_id" class = "form_input" name = "category_id">
                                <%
                                    for(Category category: categories){
                                %>
                                <a href = "updateproduct/?catid=<%=category.getId()%>">
                                    <%
                                    if(category.getId()+"" == request.getAttribute("catid")){
                                    %>
                                    <option value="<%=category.getId()%>" selected>
                                        <%= category.getName()%>
                                    </option>
                                    <%
                                    }
                                    else{
                                    %>
                                    <option  value="<%=category.getId()%>">
                                        <%=category.getName()%>
                                    </option>
                                    <%
                                    }
                                    %>
                                </a>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class = "form_row">
                            <label class = "form_label">Dung tích</label>
                            <input id ="capacity" class = "form_input" type="number" value = "<%=product.getCapacity()%>" name ="capacity" >
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <label class = "form_label">Nồng độ cồn</label>
                            <input id ="alcohol" class = "form_input" type="number" value = "<%=product.getAlcohol()%>" name = "alcohol">
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <label class = "form_label">Số lượng</label>
                            <input id ="quantity" class = "form_input" type="number" value = "<%=product.getQuantity()%>" name = "quantity">
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <label class = "form_label">Giá</label>
                            <input id ="price" class = "form_input" type="number" value = "<%=product.getPrice()%>" name = "price">
                            <small></small>
                        </div>
                        <div class = "form_row">
                            <label class = "form_label">Giá khuyến mãi</label>
                            <input id ="price_sale" class = "form_input" type="number" value = "<%=product.getPrice_sale()%>" name = "price_sale"> 
                            <small></small>
                        </div>

                        <div class = "form_row">
                            <button id = "btnsave">Save</button>
                        </div>
                    </form>
                </div>
            </div>
            <!--END INNERBLOCK-->
        </div>

    </body>

</html>