<%-- 
    Document   : thongke
    Created on : Jun 9, 2023, 12:15:44 AM
    Author     : hn573984
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./assets/admin/css/thongke.css">
    <link rel="stylesheet" href="./assets/admin/icon/themify-icons/themify-icons.css">
    <title>RuouNgoai</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
                            <div class="menu taikhoan">
                                <i class="ti-user"></i>
                                <p> Quản Lí Tài Khoản</p>
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

<!--                    <li>
                        <a href="#">
                            <div class="menu phanhoi">
                                <i class="ti-comments"></i>
                                <p>Phản Hồi Khách Hàng</p>
                            </div>
                        </a>
                    </li>-->

                    <li>
                        <a href="manageorders">
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
              <a href="user_profile"><i class="fa-solid fa-user"></i>${user.email}</a>
        </div>
        
        <!--END HEADER-->

        <!--BEGIN INNERBLOCK-->
        <div class="content">
            <div class="massage">
              <h4>THỐNG KÊ</h4>
              <hr />
              <div class="massage-product">
                <h3 style="color: #5F5D5D">Top 10 sản phẩm bán chạy</h3>
                <hr />
                <table>
                    <c:forEach var="product" items="${most10sell}">
                        <tr>
                        <td style="text-align: left; border-right: 1px #198754 dashed">
                        ${product.name}
                        </td>
                        <td style="text-align: right">${product.quantity}</td>
                      </tr>
                    </c:forEach>
                </table>
              </div>
            </div>
    
            <div class="report">
              <div class="report-today">
                <h4 style="color: #5F5D5D">KẾT QUẢ BÁN HÀNG HÔM NAY</h4>
                <table>
                  <tr>
                    <td>
                      <div class="box-circle" style="display: inline-flex">
                        <div class="circle">
                          <i class="ti-layout-width-default-alt"></i>
                        </div>
                        <h4 style="margin-left: 8px">Hóa Đơn</h4>
                      </div>
                    </td>
    
                    <td>
                      <div class="box-circle" style="display: inline-flex">
                        <div class="circle">
                          <i class="ti-shopping-cart"></i>
                        </div>
                        <h4 style="margin-left: 8px">Số Lượng Sản Phẩm</h4>
                      </div>
                    </td>
    
                    <td>
                      <div class="box-circle" style="display: inline-flex">
                        <div class="circle">
                          <i class="ti-money"></i>
                        </div>
                        <h4 style="margin-left: 8px">Tổng Tiền</h4>
                      </div>
                    </td>
                  </tr>
    
                  <tr>
                    <td><h3>${totalOrderToday.quantity}</h3></td>
                    <td><h3>${totalProductToday.quantity}</h3></td>
                    <td><h3>${totalMoneyToday.getQuantity()}</h3></td>
                  </tr>
                </table>
              </div>

              <div class="report-week">
                <h4 style="color: #5F5D5D">DOANH THU BÁN HÀNG 10 NGÀY GẦN NHẤT (Triệu VND) </h4>
    
                <div id="chart"></div>
              </div>
              
              <div class="report-model" >
                <h4 style="color: #5F5D5D">LƯỢNG SẢN PHẨM BÁN RA TRONG THÁNG PHÂN THEO NHÓM HÀNG</h4>
                <div class="char-pie" >
                  <canvas id="myChart2" width="200" height="200"></canvas>
                </div>
              </div>

              <div class="report-week">
                <h4 style="color: #5F5D5D">DOANH THU 6 THÁNG GẦN ĐÂY NHẤT</h4>
    
                <!-- <div id="chart"></div>  -->

                <table id="revenue-table">
                  <thead>
                    <tr>
                      <th>Tháng</th>
                      <th>Doanh thu</th>
                      <th>Sản phẩm bán chạy nhất tháng</th>
                    </tr>
                  </thead>
                  <tbody>
                      <c:forEach var="order" items = "${totalMoney6LastestMonth}">
                          <tr>
                            <td>Tháng ${order.month}</td>
                             <td >${order.quantity}</td>
                            <td >${order.mostProduct}</td> 
                        </tr>
                      </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
        </div>
         <!-- END INNERBLOCK-->

   </div>
   
   <script>
    // Dữ liệu doanh thu 
    var revenueData = [
        { label: '${totalMoney10LastestDays.get(0).month}', value: ${totalMoney10LastestDays.get(0).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(1).month}', value: ${totalMoney10LastestDays.get(1).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(2).month}', value: ${totalMoney10LastestDays.get(2).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(3).month}', value: ${totalMoney10LastestDays.get(3).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(4).month}', value: ${totalMoney10LastestDays.get(4).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(5).month}', value: ${totalMoney10LastestDays.get(5).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(6).month}', value: ${totalMoney10LastestDays.get(6).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(7).month}', value: ${totalMoney10LastestDays.get(7).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(8).month}', value: ${totalMoney10LastestDays.get(8).getTotal_money()} },
        { label: '${totalMoney10LastestDays.get(9).month}',value: ${totalMoney10LastestDays.get(9).getTotal_money()} }
    ];

    // Tạo biểu đồ
    var chart = document.getElementById('chart');
    var maxRevenue = Math.max(...revenueData.map(item => item.value));

    for (var i = 0; i < revenueData.length; i++) {

        var bar = document.createElement('div');
        bar.className = 'bar';
        bar.style.height = (revenueData[i].value / maxRevenue * 80) + '%';
        bar.style.left = (i * 10) + '%';
        chart.appendChild(bar);

        var label = document.createElement('div');
        label.className = 'label';
        label.style.left = (0.75 + i * 10) + '%';
        label.textContent = revenueData[i].label;
        chart.appendChild(label);

        var value = document.createElement('div');
        value.className = 'value';
        value.style.left = (1 + i * 10) + '%';
        value.textContent = revenueData[i].value;
        chart.appendChild(value);
    }
    </script>

    <script>
     
        var ctx = document.getElementById("myChart2").getContext("2d");
        var myChart = new Chart(ctx, {
        type: "pie",
        data: {
            labels: [
                ${titleArray}
            ],
            datasets: [
            {
                label: "Số sản phẩm bán ra",
                data: [${dataArray}],
                backgroundColor: ["#2ca02c", "#2c13f8",  "#d62728", "#FC8213","#9467bd"],
            },
            ],
        },
        options: {
            responsive: true,
            legend: 
            {
            position: 'bottom'
            }
        },
        });
    </script>

</body>
</html>
