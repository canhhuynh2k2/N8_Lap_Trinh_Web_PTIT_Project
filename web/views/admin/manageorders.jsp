<%-- 
    Document   : manageorder
    Created on : Jun 2, 2023, 10:05:32 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*,model.Product,model.Order" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/css/manageorder.css">
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
                <c:set value="${sessionScope.user}" var="user"/>
                <a href="user_profile">${user.email}</a>
            </div>
            <!--END HEADER-->
            <!--BEGIN INNERBLOCK-->

            <div class="content-wrapper">
                <%
                    String search_input = (String)request.getAttribute("search_input");
                    if(search_input == null){
                        search_input = "";
                    }

                %>
                <form action ="manageorders" class="form-search" method = "POST">
                    <input id = "search-input" type="text" name = "search-input" value = "<%= search_input %>" placeholder="Nhập số điện thoại nhận hàng">
                    <input id = "search-btn" type="submit" value = "Tìm kiếm">
                </form>
                <%
                  List<Order> orders = (List<Order>)request.getAttribute("orders");  
                %>
                <i class = "message">Có <span><%= orders.size() %></span> kết quả phù hợp</i>
                <a href="manageorders" class = "view-all"><input id = "view-all-btn" type="button" value="Xem tất cả"></a>
                <table id="list-orders">
                    <tr class = "theader">
                        <th class = "order-id">Mã hóa đơn</th>
                        <th class = "customer-name">Khách hàng</th>
                        <th class = "phonenumber">Số điện thoại</th>
                        <th class = "address">Địa chỉ nhận hàng</th>
                        <th class = "total-money">Tổng tiền</th>
                        <th class ="order-date">Ngày đặt hàng</th>
                        <th class ="note">Ghi chú</th>
                        <th class ="status">Trạng thái</th>
                        
                    </tr>
                    <%
                      
                      for(Order order : orders){
                        
                    %>
                    <tr class = "tbody">
                        <td class = "tbody__order-id"><a href="manageorderdetail?orderid=<%= order.getId() %>"><%= order.getId() %></a></td>
                        <td class = "tbody__customer-name"><%= order.getFullname() %></td>
                        <td class = "tbody__phonenumber"><%= order.getPhone_number() %></td>
                        <td class = "tbody__address"><%= order.getAddress() %></td>
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
                        <td class = "tbody__total-money"><%= totalPrice %><span> VNĐ</span></td>
                        <td class ="tbody__order-date"><%= order.getOrder_date() %></td>
                        <td class = "tbody__note"><%= order.getNote() %></td>
                        <td class ="tbody__status"><%= status %></td>
                        
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
            <!--END INNERBLOCK-->
        <!-- </div> -->

    </body>

</html>
