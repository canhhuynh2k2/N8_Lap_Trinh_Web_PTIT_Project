<%-- 
    Document   : cart
    Created on : May 24, 2023, 9:40:04 AM
    Author     : Huynh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*,model.Category,model.Product,java.util.Map,jakarta.servlet.http.Cookie,javafx.util.Pair" %>

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
    <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/header.css">
    <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/footer.css">
    <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/cart/css/cart.css">
</head>
<body>
    <%
            //for header
            
            List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
            Map<Integer, List<String>> branchesMap = (Map<Integer, List<String>>) request.getAttribute("branchesmap");
        
            //for main
            Product product = (Product) request.getAttribute("product"); 
        %>
        <header class="header">
            <div class="heading">
                <div class="logo">
                    <img src="assets/images/header/logo.PNG" alt="" class="logo-img">
                </div>
                <form action="allproduct" class = "search">
                    <input type="text" name ="searchname" class="search-bar" placeholder="Tìm kiếm...">
                    <button class="fa-solid fa-magnifying-glass icon-search"  onclick="form.submit()"></button>
                </form>
                <div class="contact">
                    <a href="#" class="hotline">Hotline: 190010001</a>
                </div>
            </div>
            <div class="header__nav">

                <ul class = "header__nav-list">
                    <li><a class = "header__nav-item" href = "home">Trang Chủ</a></li>
                    <li><a class = "header__nav-item" href = "allproduct?catid=0">Tất cả</a></li>
                        
                    <li><a class = "header__nav-item" href = "#">LIÊN HỆ</a></li>
                </ul>
                <ul class = "header__nav-btn">
                    <li class="header__nav-item user-btn -display-inline"><i class="fa-solid fa-user"></i></li>
                    <% Cookie[] cart = request.getCookies();
                        int num = 0;
                        for(Cookie cookie : cart){
                            if(cookie.getName().equals("cart")){
                                num = cookie.getValue().split("_").length;
                            }
                        }
                    %>
                    <li class = "header__nav-item -display-inline"><a href = "cart"><i class="fa-solid fa-cart-shopping"></i><div class="cart-count"><%= num%></div></a></li>

                </ul>

            </div>


        </header>
    <div class="main">
        <% ArrayList<Pair<Product, Integer> > cartItems = (ArrayList<Pair<Product, Integer> >)request.getAttribute("cart"); %>
        
        <table class="product-list-cart">
            <tr class="product-list-subject">
                <th class="title-subject product-subject">Sản phẩm</th>
                <th class="price-subject product-subject">Giá</th>
                <th class="quantity-subject product-subject">Số lượng</th>
                <th class="temporary-price-subject product-subject">Tạm tính</th>
            </tr>
            <% 
            int tong = 0;
            for(Pair<Product, Integer> item : cartItems){
             %>
            <tr class = "product-item">
                <td class = "product-title">
                    <a href = "updatecart?delete=<%= item.getKey().getId() %>" id = "delete-btn"><i class="fa-sharp fa-solid fa-trash delete-btn"></i></a>
                    <a class = "product-link" href="productdetail?pid=<%= item.getKey().getId() %>">
                        <img class = "product-image" src="./assets/admin/images/thumbnail/<%= item.getKey().getThumbnail() %>" alt="">
                        <p class = "product-name"><%= item.getKey().getName() %></p>
                    </a>
                    <p hidden class = "max-quantity"><%= item.getKey().getQuantity() %></p>
                </td>
                <td class = "price-product"><%= item.getKey().getPrice() %> VNĐ</td>
                <td class = "quantity-product">
                        <a class="minus" href = "updatecart?update=<%= item.getKey().getId() %>&quantity=<%= item.getValue() %>">-</a>
                        <input class="input-qty" max="<%= item.getKey().getQuantity() %>" min="1" readonly name="" type="number" value="<%= item.getValue() %>" >
                        <a class="plus" href = "updatecart?update=<%= item.getKey().getId() %>&quantity=<%= item.getValue() %>">+</a>
                    </td>
                <td class = "temporary-price-product"><%= item.getValue() * item.getKey().getPrice() %> VNĐ</td>
            </tr>
            <%
                tong += item.getValue() * item.getKey().getPrice();
            }
            %>
            
            
            
        </table>
        <form action="checkout" class = "payment-form" method = "POST">
            <strong class = "price-total">Tổng: <span><%= tong %></span> ₫</strong>
            <input id = "payment-btn" type="submit" value = "THANH TOÁN">
        </form>
    </div>
    <footer>
        <div class="footer__advantage">
            <div class="advantage-item advantage__genuine">
                <i class="fa-solid fa-shield-halved advantage-icon"></i>
                <h3>Cửa hàng rượu chính hãng</h3>
                <i>Phân phối và bán lẻ rượu chính hãng</i>
            </div>
            <div class="advantage-item advantage__freeship">
                <i class="fa-solid fa-truck advantage-icon"></i>
                <h3>Giao hàng toàn quốc</h3>
                <i>Freeship với hóa đơn từ 5 triệu</i>
            </div>
            <div class="advantage-item advantage__quality">
                <i class="fa-solid fa-thumbs-up advantage-icon"></i>
                <h3>Cam kết chất lượng</h3>
                <i>Cửa hàng uy tín trên 1 năm</i>
            </div>
        </div>
        <div class="footer__content">
            <ul class="footer-content-list">
                <li class = "footer-content-item content__about"><h3>Giới thiệu</h3>
                    <ul>
                        <li><a href="#">Về chúng tôi</a></li>
                        <li><a href="#">Bài viết - Blog</a></li>
                    </ul>
                </li>
                <li class = "footer-content-item content__product-list"><h3>Danh mục sản phẩm</h3>
                    <ul>
                        <li><a href="#">RƯỢU WHISKY</a></li>
                        <li><a href = "#">RƯỢU SINGLE MALT</a></li>
                        <li><a href="#">RƯỢU COGNAC</a></li>
                        <li><a href="#">RƯỢU NHẬT BẢN</a></li>
                        <li><a href="#">RƯỢU VANG</a></li>
                    </ul>
                </li>
                <li class = "footer-content-item content__policy"><h3>Chính sách</h3>
                    <ul>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Hướng dẫn mua hàng - Thanh toán</a></li>
                        <li><a href="#">Chính sách đổi trả</a></li>
                        <li><a href="#">Chính sách giao hàng</a></li>
                        <li><a href="#">Câu hỏi thường gặp</a></li>
                    </ul>
                </li>
                <li class ="footer-content-item content_shop-system"><h3>Hệ thống cửa hàng</h3>
                    <ul>
                        <li>
                            <i class="fa-solid fa-location-dot"></i>
                            <a href = "https://goo.gl/maps/bbo9MHvQguqnbwnMA">Km10 - Nguyễn Trãi - Hà Đông - HN</a>
                        </li>
                        <li>
                            <i class="fa-solid fa-location-dot"></i>
                            <a href = "https://goo.gl/maps/ZewHMCuUf2GR7r8u7">122 Hoàng Quốc Việt - Cầu Giấy - HN</a>
                        </li>
                        <li>
                            <i class="fa-solid fa-phone"></i>
                            <a href = "">19001018</a>
                        </li>
                        <li>
                            <h3>LIÊN HỆ VỚI CHÚNG TÔI</h3>
                            <a><i class="fa-brands fa-facebook icon-contact"></i></a>
                            <a><i class="fa-brands fa-facebook-messenger icon-contact"></i></a>
                            <a><i class="fa-brands fa-instagram icon-contact"></i></a>
    
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="copyright">
            <h3 class = "copyright-item">UỐNG RƯỢU CÓ TRÁCH NHIỆM</h3>
            <p class = "copyright-item">Các sản phẩm rượu không dành cho người dưới 18 tuổi và phụ nữ đang mang thai.</p>
            <p class = "copyright-item">©Copyright Nhóm 8 LTWeb PTIT 2023</p>
        </div>
    </footer>  
     <script src = "./assets/user/cart/js/cart.js"></script>
</body>
</html>
