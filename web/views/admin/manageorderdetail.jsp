<%-- 
    Document   : manageorderdetail
    Created on : Jun 3, 2023, 6:00:18 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*,model.Product,model.Order,model.OrderDetail" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/manageorderdetail.css">
        <link rel="stylesheet" href="./assets/admin/icon/themify-icons/themify-icons.css">
      
        <title>Ruoungoai</title>
    </head>

    <body>
        <!-- <div id="main"> -->
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
                <%
                    Order order = (Order)request.getAttribute("orderdetail");
                %>

                <div class="account-info">
                    <h3>THÔNG TIN TÀI KHOẢN ĐẶT HÀNG</h3>
                    <div class="group account-name">
                        <label for="account-name">Tên tài khoản: </label>
                        <input type="text" readonly id = "account-name" value = "<%= order.getUser().getFullname() %>">
                    </div>
                    
                    <div class="group account-email">
                        <label for="account-email">Email tài khoản: </label>
                        <input type="email" readonly id = "account-email" value = "<%= order.getUser().getEmail() %>">
                    </div>
                    
                    <div class="group account-phonenumber">
                        <label for="account-phonenumber">Số điện thoại: </label>
                        <input type="text" readonly id = "account-phonenumber" value = "<%= order.getUser().getPhoneNumber() %>">
                    </div>
                    
                </div>

                <div class="order-info">
                    <h3>THÔNG TIN TÀI ĐƠN HÀNG</h3>
                    <div class="group receiver-name">
                        <label for="receiver-name">Tên người nhận: </label>
                        <input type="text" readonly id = "receiver-name" value = "<%= order.getFullname() %>">
                    </div>
                    
                    <div class="group receiver-email">
                        <label for="receiver-email">Email người nhận: </label>
                        <input type="email" readonly id = "receiver-email" value = "<%= order.getEmail() %>">
                    </div>
                    
                    <div class="group receiver-phonenumber">
                        <label for="receiver-phonenumber">Số điện thoại người nhận: </label>
                        <input type="text" readonly id = "receiver-phonenumber" value = "<%= order.getPhone_number() %>">
                    </div>
                    <div class="group receiver-address">
                        <label for="receiver-address">Địa chỉ nhận hàng: </label>
                        <input type="text" readonly id = "receiver-address" value = "<%= order.getAddress() %>">
                    </div>
                    <div class="group receiver-note">
                        <label for="receiver-note">Ghi chú đơn hàng: </label>
                        <textarea name="" id="" cols="30" rows="8" id = "receiver-note" readonly><%= order.getNote() %></textarea>
                    
                    </div>
                    <%
                        String tmp = String.valueOf(order.getTotal_money());
                        int k = 0;
                        String totalPrice = "";
                        for(int j = tmp.length() - 1; j >= 0; j--){
                            totalPrice = tmp.charAt(j) + totalPrice;
                            k++;
                            if(k == 3 && j != 0){
                                totalPrice = "." + totalPrice;
                                k = 0;
                            }
                        }
                    %>
                    <div class="group order-total-money">
                        <label for="order-total-money">Tổng tiền: </label>
                        <input type="text" readonly id = "order-total-money" value = "<%= totalPrice %> VNĐ">
                    </div>

                    <div class="group order-date">
                        <label for="order-date">Ngày đặt hàng: </label>
                        <input type="text" readonly id = "order-total-money" value = "<%= order.getOrder_date() %>">
                    </div>
                    <%
                        String status = "";
                        if(order.getStatus() == 0){
                            status = "Đang chờ xác nhận";
                        }
                        else if(order.getStatus() == -1){
                            status = "Đã hủy";
                        }
                        else if(order.getStatus() == 1){
                            status = "Đã xác nhận";
                        }
                        else if(order.getStatus() == 2){
                            status = "Đã giao";
                        }
                    %>
                    <div class="group order-status">
                        <label for="order-status">Trạng thái đơn hàng: </label>
                        <input type="text" readonly id = "order-status" value = "<%= status %>">
                    
                    </div>

                    <div class="group-btn">
                        <form action="manageorderdetail" method = "POST">
                            <input type="number" hidden name = "value" value = "-1">
                            <input type="number" hidden name = "orderid" value = "<%= order.getId() %>">
                            <input type="submit" value = "Hủy" class = "cancel-btn">
                        </form>
                        <form action="manageorderdetail" method = "POST">
                            <input type="number" hidden name = "value" value = "1">
                            <input type="number" hidden name = "orderid" value = "<%= order.getId() %>">
                            <input type="submit" value = "Xác nhận" class = "confirm-btn">
                        </form>
                        <form action="manageorderdetail" method = "POST">
                            <input type="number" hidden name = "value" value = "2" >
                            <input type="number" hidden name = "orderid" value = "<%= order.getId() %>">
                            <input type="submit" value = "Hoàn thành" class = "success-btn">
                        </form>
                    </div>
                </div>
                <h2 class = "your-orders">DANH SÁCH SẢN PHẨM ĐẶT HÀNG</h2>
                <table id="list-orderdetail">
                    <tr class = "theader">
                        <th class = "orderdetail-id">Mã chi tiết đơn hàng</th>
                        <th class = "product-name">Tên sản phẩm</th>
                        <th class = "product-unit">Đơn vị tính</th>
                        <th class = "quantity">Số lượng</th>
                        <th class = "price">Đơn giá</th>
                        <th class = "total-price">Thành tiền</th>

                    </tr>
                    <%
                        System.out.println(order.getOrderItems().size());
                        for(OrderDetail item : order.getOrderItems()){
                    %>
                    <tr class = "tbody">
                        <td class = "tbody__orderdetail-id"><%= item.getId() %></td>
                        <td class = "tbody__product-name">
                            <a class = "product-link" href="productdetail?pid=<%= item.getProduct().getId() %>">
                                <img class = "product-image" src="./assets/admin/images/thumbnail/<%= item.getProduct().getThumbnail() %>" alt="">
                                <p class = "tbody__product-name"><%= item.getProduct().getName() %> </p>
                            </a>
                        </td>
                        <td class = "tbody__product-unit"><%= item.getProduct().getUnit() %></td>
                        <td class = "tbody__quantity"><%= item.getQuantity() %></td>
                        <% 
                            tmp = String.valueOf(item.getPrice());
                            k = 0;
                            String price = "";
                            for(int j = tmp.length() - 1; j >= 0; j--){
                                price = tmp.charAt(j) + price;
                                k++;
                                if(k == 3 && j != 0){
                                    price = "." + price;
                                    k = 0;
                                }
                            }

                            String p = String.valueOf(item.getPrice() * item.getQuantity());
                            String totalPricePerItem = "";
                            k =0;
                            for(int j = p.length() - 1; j >= 0; j--){
                                totalPricePerItem = p.charAt(j) + totalPricePerItem;
                                k++;
                                if(k == 3 && j != 0){
                                    totalPricePerItem = "." + totalPricePerItem;
                                    k = 0;
                                }
                            }
                        %>
                        <td class = "tbody__price"><%= price %> <span> VNĐ</span></td>
                        <td class = "tbody__total-price"><%= totalPricePerItem %> <span> VNĐ</span></td>
                    </tr>
                    <%
                      }  
                    %>
                </tr>
                
                </table>
            <!--END INNERBLOCK-->
        <!-- </div> -->

    </body>

</html>