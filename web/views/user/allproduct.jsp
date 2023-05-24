<%-- 
    Document   : allproduct
    Created on : Apr 4, 2023, 10:26:41 PM
    Author     : chaum
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
        %>
        <div class="container">
            <div class = "header" >
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
                        <li class="header__nav-item user-btn -display-inline"><i class="fa-solid fa-user"></i></li>
                        <li class = "header__nav-item -display-inline"><i class="fa-solid fa-cart-shopping"></i></li>

                    </ul>

                </div>
            </div>
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
                                <img src="./assets/admin/images/thumbnail/<%=product.getThumbnail()%>" alt="" class="img-product">
                                <h3 class = "product-name"><%=product.getName()%></h3>
                                <p class="initial-price">Giá gốc: <del><%=product.getPrice()%></del></p>
                                <p class="sale-price">Giá bán: <%=product.getPrice_sale()%></p>
                            </a>
                        </li>
                        <%
                            }
                        %>

                    </ul>
                </div>
            </div>
            <div class = "footer" >
                <%@include file="footer.jsp" %>
            </div>
        </div>
        <script src="./assets/user/js/general.js"></script>
    </body>
</html>