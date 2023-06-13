/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dal.OrderDaoStatsitic;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;
import model.OrderStatsitic;

@WebServlet(name="AdminStatsiticServlet", urlPatterns={"/admin-statsitic-servlet"})
public class AdminStatsiticServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        OrderDaoStatsitic od = new OrderDaoStatsitic();
        
        //Lay san pham ban chay
        List<Product> get10mostSell = od.get10MostSell();
        
        //Lay ra so hoa don da thanh toan hom nay
        OrderStatsitic totalOrderToday = od.getTotalOrderToday();
        
        //Lay ra tong so san pham da ban trong hom nay
        OrderStatsitic totalProductToday = od.getTotalProductToday();
        
        //LLay ra tong so tien hom nay
        OrderStatsitic totalMoneyToday = od.getTotalMoneyToday();
        
        //Tong doanh thu moi ngay cua 10 ngay gan day nhat
        List<OrderStatsitic> totalMoney10LastestDays = od.getTotalMoney10LastestDay();
        
        //Lay ra doanh thu tung the loai trong thang nay
        List<Product> quantityCategoriesThisMonth = od.getQuantityOfCategoriesThisMonth();
        //Lay ra chuoi ten the loai
        String titleArray = "";
        String dataArray = "";
        for(Product product: quantityCategoriesThisMonth)
        {
          titleArray += "\"" + product.getCategory().getName() + "\",";
          
          dataArray += "\"" + product.getQuantity() + "\",";
        }
        //bo dau phay o cuoi
        if(titleArray.length() > 1)
            titleArray = titleArray.substring(0, titleArray.length() - 1); 
        if(dataArray.length() > 1)
            dataArray = dataArray.substring(0, dataArray.length() - 1);
        request.setAttribute("titleArray", titleArray);
        request.setAttribute("dataArray", dataArray);
        
        //Lay ra doanh thu cua 6 thang gan day nhat
        List<OrderStatsitic> totalMoney6LastestMonth = od.getMoney6LastestMonths();
        
        request.setAttribute("most10sell", get10mostSell);
        request.setAttribute("totalOrderToday", totalOrderToday);
        request.setAttribute("totalProductToday", totalProductToday);
        request.setAttribute("totalMoneyToday", totalMoneyToday);
        request.setAttribute("totalMoney10LastestDays", totalMoney10LastestDays);
        request.setAttribute("quantityCategoriesThisMonth", quantityCategoriesThisMonth);
        request.setAttribute("totalMoney6LastestMonth", totalMoney6LastestMonth);
        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/thongke.jsp");
        rd.forward(request, response);
    } 
}