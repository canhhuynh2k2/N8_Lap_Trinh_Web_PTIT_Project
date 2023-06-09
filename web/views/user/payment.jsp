<%-- 
    Document   : payment
    Created on : May 23, 2023, 8:20:25 PM
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
        <title>Document</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <script src="https://kit.fontawesome.com/ddee20c3c8.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/header.css">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/footer.css">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/payment/css/payment.css">
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
                    <a href="home"><img src="./assets/user/home/images/header/logo.PNG" alt="" class="logo-img"></a>
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
                        <%
                            for(Category category: categories){
                        %>
                    <li class = "header__brand-appear"><a class = "header__nav-item" href = "allproduct?catid=<%=category.getId()%>"><%=category.getName()%></a>
                        <div class="header__brand">
                            <ul class="wine-list">
                                <%
                                    for(String branch:  branchesMap.get(category.getId())){
                                %>
                                <li><a href="allproduct?catid=<%=category.getId()%>&branchoption=<%=branch%>" class="wine-item"><%=branch%></a></li>
                                    <%
                                        }
                                    %>

                            </ul>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
                <ul class = "header__nav-btn">
                    <li class="header__nav-item user-btn -display-inline"><a href="user_profile"><i class="fa-solid fa-user"></i><span>${sessionScope.user.email}</span></a></li>
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
            <form action="checkout" id = "checkout-form" method = "POST">
                <div class="customer-details">
                    <h3>Thông tin thanh toán</h3>
                    <div class="woocommerce-billing-fields">
                        <div class="form-group">
                            <label for="customer-name">Tên *</label>
                            <input type="text" id = "customer-name" name = "customer-name" placeholder="Họ và tên">
                            <span class="form-message"></span>
                        </div>
                        <div class="form-group">
                            <label for="customer-address">Địa chỉ *</label>
                            <input type="text" id = "customer-address" name = "customer-address" placeholder="Nhập địa chỉ">
                            <p class="form-message"></p>
                        </div>
                        <div class="customer-contact">
                            <div class="form-group phonenumber-field">
                                <label for="customer-phonenumber">Số điện thoại *</label>
                                <input type="text" id = "customer-phonenumber" name = "customer-phonenumber" placeholder="Nhập số điện thoại">
                                <p class="form-message"></p>
                            </div>
                            <div class="form-group email-field">
                                <label for="customer-email">Địa chỉ email *</label>
                                <input type="text" id = "customer-email" name = "customer-email" placeholder="huynh@gmail.com">
                                <p class="form-message"></p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="order-comment" class = "order-comment-label">Ghi chú đơn hàng (Tùy chọn)</label>
                            <textarea name = "order-comment" id = "order-comment" name = "order-comment" placeholder="Ghi chú về đơn hàng, ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng chi tiết hơn."></textarea>

                        </div>

                    </div>
                </div>
                <div class="order-details">
                    <div class="checkout-sidebar">
                        <h3 class="order-review-heading">Đơn hàng của bạn</h3>
                        <table class="checkout-review-order-table">
                            <thead>
                            <th class = "product-name-heading">Sản phẩm</th>
                            <th class = "product-total-heading">Tạm tính</th>
                            </thead>
                            <tbody>
                                <%
                                    Pair<Product, Integer> buynow = (Pair<Product, Integer>) request.getAttribute("buynow");
                                    String totalPrice = "";
                                    if(buynow != null){
                                        String p = String.valueOf(buynow.getKey().getPrice_sale() * buynow.getValue());
                                    
                                        int k = 0;
                                        for(int j = p.length() - 1; j >= 0; j--){
                                            totalPrice = p.charAt(j) + totalPrice;
                                            k++;
                                            if(k == 3 && j != 0){
                                                totalPrice = "." + totalPrice;
                                                k = 0;
                                            }
                                        }
                                %>
                                <tr class="cart-item">
                                    <td class="product-name">
                                        <%= buynow.getKey().getName()%>
                                        <strong class = "product-quantity"> x <%= buynow.getValue()%></strong>
                                    </td>
                                    <td class="product-total">
                                        <p><%= totalPrice %> <span>VNĐ</span></p>
                                    </td>
                                </tr>
                                <%
                                    }
                                    else{
                                %>
                                <% 
                                int tong = 0;
                                ArrayList<Pair<Product, Integer> > cartItems = (ArrayList<Pair<Product, Integer> >)request.getAttribute("cart");
                                for(Pair<Product, Integer> item : cartItems){
                            
                                    String p = String.valueOf(item.getKey().getPrice_sale() * item.getValue());
                                    String totalPricePerProduct = "";
                                    int k = 0;
                                    for(int j = p.length() - 1; j >= 0; j--){
                                        totalPricePerProduct = p.charAt(j) + totalPricePerProduct;
                                        k++;
                                        if(k == 3 && j != 0){
                                            totalPricePerProduct = "." + totalPricePerProduct;
                                            k = 0;
                                        }
                                    }

                                %>
                                <tr class="cart-item">
                                    <td class="product-name">
                                        <%= item.getKey().getName()%>
                                        <strong class = "product-quantity"> x <%= item.getValue()%></strong>
                                    </td>
                                    <td class="product-total">
                                        <p><%= totalPricePerProduct %> <span>VNĐ</span></p>
                                    </td>
                                </tr>
                                <%
                                    tong += item.getValue() * item.getKey().getPrice_sale();
                                    }
                                    String p = String.valueOf(tong);
                                
                                    int k =0;
                                    for(int j = p.length() - 1; j >= 0; j--){
                                        totalPrice = p.charAt(j) + totalPrice;
                                        k++;
                                        if(k == 3 && j != 0){
                                            totalPrice = "." + totalPrice;
                                            k = 0;
                                        }
                                    }
                                }
                                %>
                            </tbody>
                            <tfoot>
                                <tr class="cart-subtotal">
                                    <th>Tạm tính</th>
                                    <td><%= totalPrice %> <span>VNĐ</span></td>
                                </tr>
                                <tr class="shipping">
                                    <th>Giao hàng</th>
                                    <td>Miễn phí phí vận chuyển</td>
                                </tr>
                                <tr class="order-total">
                                    <th>Tổng</th>
                                    <td><strong><span class = "amount"><%= totalPrice %></span><span> VNĐ</span></strong></td>
                                </tr>
                            </tfoot>
                        </table>
                        <p class = "customer-note">Vui lòng nhập đúng <span style = "color: blue">số điện thoại</span> của bạn, chúng tôi sẽ liên hệ với bạn để trao đổi về việc giao hàng</p>
                        <%
                            if(buynow != null){
                        %>
                        <input type ="number" readonly name ="product-id-buy-now" hidden value = "<%= buynow.getKey().getId() %>">
                        <input type ="number" readonly name ="quantity-buy-now" hidden value = "<%= buynow.getValue() %>">
                        <%
                          }  
                        %>
                        <input type="submit" id = "pay-btn" value = "ĐẶT HÀNG">
                    </div>
                </div>
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
                            <li><a href="home">Về chúng tôi</a></li>
                            <li><a href="#">Bài viết - Blog</a></li>
                        </ul>
                    </li>
                    <li class = "footer-content-item content__product-list"><h3>Danh mục sản phẩm</h3>
                        <ul>
                            <%
                                for(int i = 0; i < Math.min(4, categories.size()); i++){
                            %>
                            <li><a href="allproduct?catid=<%=categories.get(i).getId()%>"><%=categories.get(i).getName()%></a></li>
                                <%
                                    }
                                %>
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
        <script src = "./assets/user/payment/js/payment.js"></script>




    </body>
</html>
