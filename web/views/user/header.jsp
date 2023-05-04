<%-- 
    Document   : header
    Created on : Apr 27, 2023, 7:38:55 AM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="header">
    <div class="heading">
        <div class="logo">
            <img src="assets/images/header/logo.PNG" alt="" class="logo-img">
        </div>
        <form action="#" class = "search">
            <input type="text" class="search-bar" placeholder="Tìm kiếm...">
            <i class="fa-solid fa-magnifying-glass icon-search"></i>
        </form>

        <div class="contact">
            <a href="#" class="hotline">Hotline: 190010001</a>
        </div>
    </div>
    <div class="header__nav">

        <ul class = "header__nav-list">
            <li><a class = "header__nav-item" href = "#">Trang Chủ</a></li>
            <li class = "header__brand-appear"><a class = "header__nav-item" href = "#">RƯỢU WHISKY</a>
                <div class="header__brand">
                    <ul class="wine-list">
                        <li><a href="#" class="wine-item">Chivas</a></li>
                        <li><a href="#" class="wine-item">Ballantines</a></li>
                        <li><a href="#" class="wine-item">Dewars</a></li>
                        <li><a href="#" class="wine-item">Highland Queen</a></li>
                        <li><a href="#" class="wine-item">Jack Daniels</a></li>
                        <li><a href="#" class="wine-item">Label 5</a></li>
                        <li><a href="#" class="wine-item">Johnnie Walker</a></li>
                    </ul>
                </div>
            </li>
            <li class = "header__brand-appear"><a class = "header__nav-item" href = "#">RƯỢU SINGLE MALT</a>
                <div class="header__brand">
                    <ul class="wine-list">
                        <li><a href="#" class="wine-item">Macallan</a></li>
                        <li><a href="#" class="wine-item">Glenlivet</a></li>
                        <li><a href="#" class="wine-item">Lagavulin</a></li>
                        <li><a href="#" class="wine-item">Singleton</a></li>
                        <li><a href="#" class="wine-item">Glenfiddich</a></li>
                        <li><a href="#" class="wine-item">Bowmore</a></li>
                        <li><a href="#" class="wine-item">Balvenie</a></li>
                        <li><a href="#" class="wine-item">Teacher’s</a></li>
                        <li><a href="#" class="wine-item">Glen Moray</a></li>
                        <li><a href="#" class="wine-item">Laphroaig</a></li>
                        <li><a href="#" class="wine-item">Mortlach</a></li>
                    </ul>
                </div>

            </li>
            <li class = "header__brand-appear"><a class = "header__nav-item" href = "#">RƯỢU COGNAC</a>
                <div class="header__brand">
                    <ul class="wine-list">
                        <li><a href="#" class="wine-item">Hennessy</a></li>
                        <li><a href="#" class="wine-item">Remy Martin</a></li>
                        <li><a href="#" class="wine-item">Martell</a></li>
                        <li><a href="#" class="wine-item">Camus</a></li>
                    </ul>
                </div>
            </li>
            <li class = "header__brand-appear"><a class = "header__nav-item" href = "#">RƯỢU NHẬT BẢN</a>
                <div class="header__brand">
                    <ul class="wine-list">
                        <li><a href="#" class="wine-item">Rượu Hibiki</a></li>
                        <li><a href="#" class="wine-item">Rượu Mơ Nhật</a></li>
                        <li><a href="#" class="wine-item">Rượu Sake</a></li>
                        <li><a href="#" class="wine-item">Camus</a></li>
                        <li><a href="#" class="wine-item">Rượu Shochu</a></li>
                    </ul>
                </div>
            </li>
            <li class = "header__brand-appear"><a class = "header__nav-item" href = "#">RƯỢU VANG</a>
                <div class="header__brand">
                    <ul class="wine-list">
                        <li><a href="#" class="wine-item">Rượu Vang Ý</a></li>
                        <li><a href="#" class="wine-item">Rượu Vang Pháp</a></li>
                        <li><a href="#" class="wine-item">Rượu Vang Chile</a></li>
                        <li><a href="#" class="wine-item">Rượu Vang Argentina</a></li>
                        <li><a href="#" class="wine-item">Rượu Vang Tây Ban Nha</a></li>
                        <li><a href="#" class="wine-item">Rượu Vang Đức</a></li>
                        <li><a href="#" class="wine-item">Rượu Vang Úc</a></li>
                    </ul>
                </div>
            </li>
            <li><a class = "header__nav-item" href = "#">LIÊN HỆ</a></li>
        </ul>
        <ul class = "header__nav-btn">
            <li class="header__nav-item user-btn -display-inline"><i class="fa-solid fa-user"></i></li>
            <li class = "header__nav-item -display-inline"><a href="user_cart"><i class="fa-solid fa-cart-shopping"></i></a><div class="cart-count">${cart.totalItems}</div></li>
        </ul>
    </div>
</header>