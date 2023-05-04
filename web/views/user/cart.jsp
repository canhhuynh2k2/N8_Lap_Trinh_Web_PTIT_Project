<%-- 
    Document   : cart
    Created on : Apr 26, 2023, 9:51:13 PM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cart, model.Item"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết giỏ hàng</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <script src="https://kit.fontawesome.com/ddee20c3c8.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel = "stylesheet" href = "assets/user/common/header.css">
        <link rel = "stylesheet" href = "assets/user/common/footer.css">
        <link rel = "stylesheet" href = "assets/user/cart/cart.css">
    </head>
    <body>
        <!--Start header-->
        <%@include  file="header.jsp" %>
        <!--End header-->
        <div class="main">
            <table class="product-list-cart">
                <thead>
                    <tr class="product-list-subject">
                        <th class="title-subject product-subject">Sản phẩm</th>
                        <th class="price-subject product-subject">Giá</th>
                        <th class="quantity-subject product-subject">Số lượng</th>
                        <th class="temporary-price-subject product-subject">Tạm tính</th>
                    </tr>
                </thead>
                <tbody>
                    <% Cart cart = (Cart) request.getAttribute("cart");%>
                    <% for(Item item : cart.getItems()){
                    %>
                    <tr class = "product-item">
                        <td class = "product-title">
                            <a href="user_cart_check_quantity?product_id=<%= item.getProduct().getId() %>&number=0">
                                <i class="fa-sharp fa-solid fa-trash delete-btn"></i>
                            </a>
                            <a class = "product-link" href="#">
                                <img class = "product-image" src="assets/admin/images/thumbnail/<%= item.getProduct().getThumbnail() %>" alt="">
                                <p class = "product-name"><%= item.getProduct().getName() %></p>
                            </a>
                        </td>
                        <td class = "price-product"><%= item.getPrice() %></td>
                        <td class = "quantity-product">
                            <a class="minus" href = "user_cart_check_quantity?product_id=<%= item.getProduct().getId() %>&number=-1">-</a>
                            <input class="input-qty" max="10" min="1" name="" type="number" value="<%= item.getQuantity() %>" >
                            <a class="plus" href = "user_cart_check_quantity?product_id=<%= item.getProduct().getId() %>&number=1">+</a>
                        </td>
                        <td class = "temporary-price-product"><%= (item.getQuantity()*item.getPrice()) %></td>
                    </tr>
                    <%    
                        } %>

                </tbody>
            </table>
            <form action="" class = "payment-form">
                <strong class = "price-total">Tổng: <span>${cart.totalMoney}</span> ₫</strong>
                <input id = "payment-btn" type="submit" value = "THANH TOÁN">
            </form>
        </div>
        <!--Start header-->
        <%@include  file="footer.jsp" %>
        <!--End header-->  
    </body>
</html>