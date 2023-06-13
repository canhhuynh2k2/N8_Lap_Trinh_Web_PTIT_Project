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
                <%
                    int numPage = 0;
                    for(int i = 0; i < orders.size(); i+=5){
                        numPage++;
                        if(numPage == 1){
                %>
                <table id="list-orders" class = "page-<%= numPage %>">
                <%
                    }else{
                %>
                <table id="list-orders" class = "page-<%= numPage %> invalid">
                <% } %>
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
                    <tr class = "tbody">
                <%
                        for(int j = 0; j < Math.min(5, orders.size()-i); j++){
                        
                        
                %>
                  
                
                        <td class = "tbody__order-id"><a href="manageorderdetail?orderid=<%= orders.get(i+j).getId() %>"><%= orders.get(i+j).getId() %></a></td>
                        <td class = "tbody__customer-name"><%= orders.get(i+j).getFullname() %></td>
                        <td class = "tbody__phonenumber"><%= orders.get(i+j).getPhone_number() %></td>
                        <td class = "tbody__address"><%= orders.get(i+j).getAddress() %></td>
                        <%
                            String tmp = String.valueOf(orders.get(i+j).getTotal_money());
                            int k = 0;
                            String totalPrice = "";
                            for(int p = tmp.length() - 1; p >= 0; p--){
                                totalPrice = tmp.charAt(p) + totalPrice;
                                k++;
                                if(k == 3 && p != 0){
                                    totalPrice = "." + totalPrice;
                                    k = 0;
                                }
                            }
                            
                            String status = "";
                            if(orders.get(i+j).getStatus() == 0){
                                status = "Đang chờ xác nhận";
                            }
                            else if(orders.get(i+j).getStatus() == -1){
                                status = "Đã hủy";
                            }
                            else if(orders.get(i+j).getStatus() == 1){
                                status = "Đã xác nhận";
                            }
                            else if(orders.get(i+j).getStatus() == 2){
                                status = "Đã giao";
                            }
                        %>
                        <td class = "tbody__total-money"><%= totalPrice %><span> VNĐ</span></td>
                        <td class ="tbody__order-date"><%= orders.get(i+j).getOrder_date() %></td>
                        <td class = "tbody__note"><%= orders.get(i+j).getNote() %></td>
                        <td class ="tbody__status"><%= status %></td>
                        
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <%
 
                    }
                        
                %>
                <div class ="page-bar">
                    <%
                        for(int h = 0; h < numPage; h++){
                    %>
                    <input type="button" value ="<%= h+1 %>" class = "page page-number-<%= numPage - h %>" onclick="nextPage(<%= numPage - h %>)">
                    <% } %>

                </div>
            </div>
            <!--END INNERBLOCK-->
        <!-- </div> -->
        <script src = "./assets/admin/js/manageorder.js"></script>
    </body>

</html>
