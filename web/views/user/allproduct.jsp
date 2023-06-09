<%-- 
    Document   : allproduct
    Created on : Apr 4, 2023, 10:26:41 PM
    Author     : chaum
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.util.List,java.util.ArrayList,model.Category,model.Product,java.util.Map, model.User" %>

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
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/all_products/allproduct.css">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/header.css">
        <link rel = "stylesheet" href = "${pageContext.request.contextPath}/assets/user/common/footer.css">
    </head>
    <body>
        <%
            //for header
            List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
            Map<Integer, List<String>> branchesMap = (Map<Integer, List<String>>) request.getAttribute("branchesmap");
            String catId = (String) request.getAttribute("catid");
            
            Category currentCategory = (Category) request.getAttribute("currentcategory");
            
            List<String> priceRange = (ArrayList<String>) request.getAttribute("pricerange");
            String priceOption = (String)request.getAttribute("priceoption");
        
            List<String> branches = (ArrayList<String>) request.getAttribute("branches");
            String branchOption = (String)request.getAttribute("branchoption");
        
            List<String> alcoholRange = (ArrayList<String>) request.getAttribute("alcoholrange");
            String alcoholOption = (String)request.getAttribute("alcoholoption");
        
            List<String> capacityRange = (ArrayList<String>) request.getAttribute("capacityrange");
            String capacityOption = (String)request.getAttribute("capacityoption");
            
            List<String> sortList = (ArrayList<String>) request.getAttribute("sortlist");
            String sortOption = (String)request.getAttribute("sortoption");
            
            List<Product> products = (ArrayList<Product>) request.getAttribute("products");
            Integer numberOfPage = (Integer)request.getAttribute("numberofpage");
            Integer currentpage = (Integer)request.getAttribute("page");
        %>
        <div class="container">
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
            <div class="nav-bar">
                <%
                if(catId.equals("0")){
                %>
                Tất cả
                <%
                }
                else{
                %><%=currentCategory.getName()%><%
                    if(!branchOption.equals("0")){
                %>
                <%=" > " +branchOption %>
                <%
                    }
                }
                %>    
            </div>
            <div class="main">
                <div class="inside">
                    <!-- Tìm kiếm -->
                    <div class="product-search">
                        <p class = "filter-heading">Tìm kiếm sản phẩm</p>
                        <form action="allproduct" class = "product-search-form">
                            <input name ="searchname" type="text" class="product-search-content" placeholder="Tìm kiếm...">
                            <button onclick="form.submit()"><i class="fa-solid fa-magnifying-glass icon-product-search"></i></button>
                        </form>
                    </div>
                    <!-- Lọc theo giá -->
                    <div class="filter-by-price">
                        <p class = "filter-heading">Lọc theo khoảng giá</p>
                        <form action="allproduct" class = "filter-by-price-form">
                            <%
                                for(int i = 0; i < priceRange.size(); i++){
                            %>
                            <div class="circlecheck">
                                <input onchange="form.submit()" type="radio" id="option-<%=i+1%>" class="circle-<%=i+1%>"
                                       <%
                                       if(priceOption.equals(i + 1 +"")){
                                       %>
                                       checked
                                       <%
                                       }
                                       %>
                                       name="priceoption" value="<%=i+1%>">
                                <label for="option-1"><%=priceRange.get(i)%></label>
                            </div>
                            <%
                                }
                            %>
                            <input type="hidden" value="<%=catId%>" name="catid">
                            <input type="hidden" value="<%=branchOption%>" name="branchoption">
                            <input type="hidden" value="<%=alcoholOption%>" name="alcoholoption">
                            <input type="hidden" value="<%=capacityOption%>" name="capacityoption">
                        </form>
                    </div>
                    <!-- Lọc theo thương hiệu -->
                    <div class="filter-by-branch">
                        <p class = "filter-heading">Lọc theo thương hiệu</p>
                        <form action="allproduct" class = "filter-by-branch-form">
                            <select onchange="form.submit()" name="branchoption" id="branch">
                                <option value="0" <%
                                            if(branchOption.equals("0")){
                                        %>
                                        selected
                                        <%
                                        }
                                        %>>Tất cả</option>
                                <%
                                    for(int i =0; i < branches.size(); i++){
                                %>
                                <option value="<%=branches.get(i)%>"
                                        <% if(branches.get(i).equals(branchOption)){
                                        %>
                                        selected
                                        <%
                                            }%>
                                        ><%=branches.get(i)%></option>
                                <%
                                    }
                                %>

                                <!-- Lấy các thương hiệu từ database để hiển thị option
                                    - Số lượng option phụ thuộc vào navigation hiện tại -->
                            </select>
                            <input type="hidden" value="<%=catId%>" name="catid">
                            <input type="hidden" value="<%=priceOption%>" name="priceoption">
                            <input type="hidden" value="<%=alcoholOption%>" name="alcoholoption">
                            <input type="hidden" value="<%=capacityOption%>" name="capacityoption">
                        </form>
                    </div>
                    <div class="filter-by-alcohol-level">
                        <p class = "filter-heading">Lọc theo nồng độ</p>
                        <form action="allproduct" class = "filter-by-alcohol-level-form">
                            <select onchange="form.submit()" name="alcoholoption" id="alcohol-level">
                                <%
                                for(int i = 0; i < alcoholRange.size(); i++){
                                %>
                                <option value="<%=i+1%>"
                                        <%if(alcoholOption.equals(i+1+"")){
                                        %> selected<%
                                        }%>
                                        ><%=alcoholRange.get(i)%></option>
                                <%
                                    }
                                %>
                            </select>
                            <input type="hidden" value="<%=catId%>" name="catid">
                            <input type="hidden" value="<%=priceOption%>" name="priceoption">
                            <input type="hidden" value="<%=branchOption%>" name="branchoption">
                            <input type="hidden" value="<%=capacityOption%>" name="capacityoption">
                        </form>
                    </div>
                    <div class="filter-by-capacity">
                        <p class = "filter-heading">Lọc theo dung tích</p>
                        <form action="allproduct" class = "filter-by-capacity-form">
                            <select onchange="form.submit()" name="capacityoption" id="capacity">
                                <%
                                    for(int i = 0; i < capacityRange.size(); i++){
                                %>
                                <option value="<%=i+1%>"
                                        <%if(capacityOption.equals(i+1+"")){
                                        %>
                                        selected
                                        <%
                                            }%>
                                        ><%=capacityRange.get(i)%></option>
                                <%
                                    }
                                %>

                                <!-- Lấy các tất cả các dung tích từ database để hiển thị option
                                    - Số lượng option phụ thuộc vào navigation hiện tại -->
                            </select>
                            <input type="hidden" value="<%=catId%>" name="catid">
                            <input type="hidden" value="<%=priceOption%>" name="priceoption">
                            <input type="hidden" value="<%=branchOption%>" name="branchoption">
                            <input type="hidden" value="<%=alcoholOption%>" name="alcoholoption">
                        </form>
                    </div>
                    <div class="filter">
                        <form action="allproduct" >
                            <button onclick="form.submit()" class="clear-btn">Reset</button>
                        </form>

                        <!--<button class="filter-btn">Lọc</button>-->
                    </div>
                </div>
                <div class="content">
                    <header><h2 class ="heading-product">
                            <%if(catId.equals("0")){%>Tất cả<%}else{%><%=currentCategory.getName()%><% }%>
                            <!--Đây là Tên loại rượu click theo đường dẫn-->
                        </h2></header>
                    <div class="product-sort">
                        <form action="allproduct" class="product-sort__form">
                            <label for="">Sắp xếp:</label>
                            <select onchange="form.submit()" name="sortoption" id="sorted-list">
                                <%
                                    for(int i = 0; i < sortList.size(); i++){
                                %>
                                <option value="<%=i+1%>" class=""
                                        <%
                                            if(sortOption.equals(i+1+"")){
                                        %>
                                        selected
                                        <%
                                            }
                                        %>
                                        ><%=sortList.get(i)%></option>
                                <%
                                    }
                                %>

                            </select>
                            <input type="hidden" value="<%=catId%>" name="catid">
                            <input type="hidden" value="<%=branchOption%>" name="branchoption">
                            <input type="hidden" value="<%=priceOption%>" name="priceoption">
                            <input type="hidden" value="<%=alcoholOption%>" name="alcoholoption">
                            <input type="hidden" value="<%=capacityOption%>" name="capacityoption">
                        </form>
                    </div>
                    <ul class="product-list">
                        <%
                            for(Product product: products){
                        %>
                        <li class="product-item">
                            <a href="productdetail?pid=<%=product.getId()%>">
                                <div class = "img-container">
                                    <img src="./assets/admin/images/thumbnail/<%=product.getThumbnail()%>" alt="" class="img-product">
                                </div>
                                <h3 class = "product-name"><%=product.getName()%></h3>
                                <p class="initial-price">Giá gốc: <del><%=product.getPrice()%></del></p>
                                <p class="sale-price">Giá bán: <%=product.getPrice_sale()%></p>
                            </a>
                        </li>
                        <%
                            }
                        %>

                    </ul>
                    <div class ="page-bar">

                        <% 
                         for(int i = 1; i <= numberOfPage; i++){
                            if(i != currentpage){
                        %>
                        <form  action="allproduct">
                            <input type="hidden" value="<%=catId%>" name="catid">
                            <input type="hidden" value="<%=branchOption%>" name="branchoption">
                            <input type="hidden" value="<%=priceOption%>" name="priceoption">
                            <input type="hidden" value="<%=alcoholOption%>" name="alcoholoption">
                            <input type="hidden" value="<%=capacityOption%>" name="capacityoption">
                            <input type="hidden" value="<%=i%>" name ="page">
                            <button class="page-box" onclick="form.submit()"><%=i%></button>
                        </form>
                        <%
                            }
                            else{
                        %>
                        <form  action="allproduct">
                            <input type="hidden" value="<%=catId%>" name="catid">
                            <input type="hidden" value="<%=branchOption%>" name="branchoption">
                            <input type="hidden" value="<%=priceOption%>" name="priceoption">
                            <input type="hidden" value="<%=alcoholOption%>" name="alcoholoption">
                            <input type="hidden" value="<%=capacityOption%>" name="capacityoption">
                            <input type="hidden" value="<%=i%>" name ="page">
                            <button class="currentpage" onclick="form.submit()"><%=i%></button>
                        </form>
                        <%
                            }
                         }
                        %>
                    </div>
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
        <script src="./assets/user/home/js/general.js"></script>
    </body>
</html>