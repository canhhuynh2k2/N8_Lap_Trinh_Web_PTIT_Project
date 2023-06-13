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
                        <div class = "form-row">
                            <div class = "form-label">ID</div>
                            <input class = "form-input" type="text" value ="<%=product.getId()%>" readonly name ="id" >
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <div class = "form-label">Tên rượu</div>
                            <input id ="name" class = "form-input" type="text" value ="<%=product.getName()%>" name ="name" >
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <label class = "form-label">Ảnh</label>
                            <input accept="image/*" type="file" id="thumbnail" onchange="preview()" value = "./assets/admin/images/thumbnail/<%=product.getThumbnail()%>"  name ="thumbnail"/>
                            <img id="frame" src="./assets/admin/images/thumbnail/<%=product.getThumbnail()%>" width="150px" height="150px" value = "<%=product.getThumbnail()%>" />
                            <input type="hidden" name="oldthumbnail" value = "<%=product.getThumbnail()%>" >
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <div class = "form-label">Mô tả</div>
                            <input  id = "description" class = "form-input" type="textarea" value = "<%=product.getDescription()%>" name = "description">
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <div class = "form-label">Hãng</div>
                            <input  id = "branch" class = "form-input" type="text" value = "<%=product.getBranch()%>" name = "branch">
                            <small></small>
                        </div>
                        <div class = "form-row"> 
                            <label class = "form-label">Quy cách</label>
                            <input id ="unit" class = "form-input" type="text" value = "<%=product.getUnit()%>" name = "unit">
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <label class = "form-label">Loại rượu</label>
                            <select id ="category_id" class = "form-input" name = "category_id">
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
                        <div class = "form-row">
                            <label class = "form-label">Dung tích</label>
                            <input id ="capacity" class = "form-input" type="number" value = "<%=product.getCapacity()%>" name ="capacity" >
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <label class = "form-label">Nồng độ cồn</label>
                            <input id ="alcohol" class = "form-input" type="number" value = "<%=product.getAlcohol()%>" name = "alcohol">
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <label class = "form-label">Số lượng</label>
                            <input id ="quantity" class = "form-input" type="number" value = "<%=product.getQuantity()%>" name = "quantity">
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <label class = "form-label">Giá</label>
                            <input id ="price" class = "form-input" type="number" value = "<%=product.getPrice()%>" name = "price">
                            <small></small>
                        </div>
                        <div class = "form-row">
                            <label class = "form-label">Giá khuyến mãi</label>
                            <input id ="price_sale" class = "form-input" type="number" value = "<%=product.getPrice_sale()%>" name = "price_sale"> 
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