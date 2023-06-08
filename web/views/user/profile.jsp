<%-- 
    Document   : profile
    Created on : Apr 27, 2023, 7:31:47 AM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.util.List,java.util.ArrayList,model.Category,model.Product,java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rượu ngoại</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <script src="https://kit.fontawesome.com/ddee20c3c8.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel = "stylesheet" href = "assets/user/profile/styles.css">
        <link rel = "stylesheet" href = "assets/user/common/header.css">
        <link rel = "stylesheet" href = "assets/user/common/footer.css">
    </head>
    <body>
        <div class="container">
            <%
           List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
           Map<Integer, List<String>> branchesMap = (Map<Integer, List<String>>) request.getAttribute("branchesmap");
            %>
            <header class="header">
                <div class="heading">
                    <div class="logo">
                        <img src="./assets/user/home/images/header/logo.PNG" alt="" class="logo-img">
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
                        <li><a class = "header__nav-item" href = "#">LIÊN HỆ</a></li>
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
                <div class="main-heading"><p>Thông Tin Tài khoản</p></div>
                <div class="user-info">
                    <div class="form">
                        <c:set var="user" value="${sessionScope.user}"/>
                        <div class="form-group">
                            <label for="role_id">Chuc Vu:</label>
                            <input readonly value="${user.role.name}" id="role_id">
                        </div>
                        <div class="form-group">
                            <label for="fullname">Ho Va Ten:</label>
                            <input id="fullname" type="text" readonly value="${user.fullname}">
                        </div>
                        <div class="form-group">
                            <label for="phone-number">So Dien Thoai:</label>
                            <input id="phone-number" type="text" readonly value="${user.phoneNumber}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input id="email" type="text" readonly value="${user.email}">
                        </div>
                    </div>
                </div>
                <div class="link">
                    <div class="link-btn">
                        <a class="btn" href="user_update_profile">Chỉnh Sửa</a>
                        <a class="btn" href="user_change_password">Đổi Mật Khẩu</a>
                        <a class="btn" href="sign_out">Đăng Xuất</a>
                    </div>
                </div>
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
            <script>
                var changePasswordSuccess = "${requestScope.changePasswordSuccess}";
                var updateProfileSuccess = "${requestScope.updateProfileSuccess}";
                if (changePasswordSuccess !== "") {
                    alert(changePasswordSuccess);
                } else if (updateProfileSuccess !== "") {
                    alert(updateProfileSuccess);
                }
            </script>

        </div>
    </body>
</html>