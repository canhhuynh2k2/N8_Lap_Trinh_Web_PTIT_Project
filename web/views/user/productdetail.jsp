<%-- 
    Document   : productdetail.jsp
    Created on : Apr 10, 2023, 10:16:03 PM
    Author     : chaum
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*,model.Category,model.Product,java.util.Map,jakarta.servlet.http.Cookie" %>
<%@page import="java.util.*,java.util.List,java.util.ArrayList,model.Comment,model.User " %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết sản phẩm</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <script src="https://kit.fontawesome.com/ddee20c3c8.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/product_detail/productdetail.css">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/header.css">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/footer.css">
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
        <div class = "header-nav"><%=product.getCategory().getName() + " > " + product.getBranch() + " > " + product.getName() %></div>
        <div class = "main">
            <div class = "detail">

                <div class = "detail-img">
                    <img id = "product-img" src="./assets/admin/images/thumbnail/<%=product.getThumbnail()%>" alt="ảnh sản phẩm">
                </div>
                <div class = "product-detail-content">

                    <h1><%=product.getName()%></h1>
                    <p id = "price">Giá gốc: <del><%=product.getPrice()%> đ</del></p>
                    <p id = "sale">Giá khuyến mãi: <%=product.getPrice_sale()%> đ</p>
                    <div class = "is-devider"></div>
                    <h3>Thông tin chi tiết sản phẩm</h3>
                    <table id = "detail-table">
                        <tr>
                            <td><strong>Thương hiệu</strong></td>
                            <td><%=product.getBranch()%></td>
                        </tr>
                        <tr>
                            <td><strong>Đơn vị</strong></td>
                            <td><%=product.getUnit()%></td>
                        </tr>
                        <tr>
                            <td><strong>Dung tích</strong></td>
                            <td><%=product.getCapacity()%>ml</td>
                        </tr>
                        <tr>
                            <td><strong>Nồng độ</strong></td>
                            <td><%=product.getAlcohol()%></td>
                        </tr>
                        <tr>
                            <td><strong>Mô tả chi tiết</strong></td>
                            <td><%=product.getDescription()%></td>
                        </tr>
                    </table>
                    <div>
                        <div class = "remain-quantity">
                            <strong>Số lượng còn lại: <span id = "max-quantity"><%=product.getQuantity()%></span></strong>
                        </div>
                        <div class="buttons_added">
                            <label for="" id = "quantity">Số lượng: </label>
                            <input class="minus" type="button" value="-">
                            <input class="input-qty" max="" min="1" name="quantity" type="number" value="1" >
                            <input class="plus" type="button" value="+">
                        </div>
                        <a href ="addtocart?id=<%=product.getId()%>&quantity=1" class = "add-to-card-btn"><button id = "add-to-cart"><strong>Thêm vào giỏ hàng</strong></button><br/></a>

                        <a href ="checkout?id=<%=product.getId()%>&quantity=1" class = "buy-now-btn"><input type ="submit" id = "buy-now" value = "Mua ngay"></a>

                    </div>


                </div>
            </div>
        </div>

        <div class="tblComment">
            <table>
                <thead>
                <th>STT</th>
                <th>Tên khách hàng</th>
                <th>Nội dung bình luận</th>
                <th>Số sao đánh giá</th>
                <th>Xoá comment</th>
                </thead>
                <tbody>
                    <%
                        ArrayList<Comment> listComment = (ArrayList<Comment>) request.getAttribute("listcomments");
                        User user = (User) request.getAttribute("user");
                        for(int i = 0; i < listComment.size(); i++) {
                    %>

                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= listComment.get(i).getUser().getFullname()%></td>
                        <td><%= listComment.get(i).getContent()%></td>
                        <td><%= listComment.get(i).getRate()%></td> 
                        <td>    
                            <% if (user != null && listComment.get(i).getUser().getId() == user.getId()) {
                        
                            %> 
                            <a href="DeleteComments?cid=<%=listComment.get(i).getId() %>&productId=<%=product.getId() %>">Xoá Comment</a>


                            <%
                        }
                            %>
                        </td> 
                    </tr>

                    <%
                    }                      
                    %>
                </tbody>
            </table>
            <div class="commentAndRate">
                <form action="AddComments" method="post">
                    <h1>Nhập và gửi comment của bạn vào ô dưới đây</h1>
                    <input type="text" class="comment-input" placeholder="Nhập comment của bạn" name="CommentsOfCustomer">     
                    <input type="hidden" name="productId" value = <%= product.getId()%>>     
                    <div class="star">
                        <h2 class="selectStar">Chọn số sao đánh giá cho sản phẩm này:          </h2>
                        <select name="point">
                            <option value="1">1*</option>
                            <option value="2">2*</option>
                            <option value="3">3*</option>
                            <option value="4">4*</option>
                            <option value="5">5*</option>
                        </select>
                    </div>
                    <button class="addComments" onclick="form.submit()">Gửi comment</button>
                </form>
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
        <script src = "./assets/user/product_detail/productdetail.js"></script>

    </body>
</html>
