/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import dal.CartDAO;
import dal.CategoryDAO;
import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.util.Pair;
import model.Category;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author DELL
 */
@WebServlet(name="UserCheckout", urlPatterns={"/checkout"})
public class UserCheckout extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserCheckout</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserCheckout at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        List<Category> categories = new ArrayList<>();
        Map<Integer, List<String>> branchesMap = new HashMap<>();
        CategoryDAO catDB = new CategoryDAO();
        ProductDAO productDB = new ProductDAO();

        categories = catDB.getAll();
        for (Category category : categories) {
            branchesMap.put(category.getId(), productDB.getBranches(category.getId()));
        }
        request.setAttribute("categories", categories);
        request.setAttribute("branchesmap", branchesMap);
        
        String pid = request.getParameter("id");
        String pquantity = request.getParameter("quantity");
        if(pid != null && pquantity != null && pid != "" && pquantity != ""){
            int id = Integer.parseInt(pid);
            int quantity = Integer.parseInt(pquantity);
            ProductDAO productDAO = new ProductDAO();
            Pair<Product, Integer> buynow;
            try {
                buynow = new Pair<>(productDAO.getByID(id), quantity);
                request.setAttribute("buynow", buynow);
                request.getRequestDispatcher("/views/user/payment.jsp").forward(request, response);
            } catch (SQLException ex) {
                response.sendRedirect("views/user/error_404.jsp");
                Logger.getLogger(UserCheckout.class.getName()).log(Level.SEVERE, null, ex);
            }
            return;
        }
        else if(pid == "" || pquantity == ""){
            request.getRequestDispatcher("views/user/error_404.jsp").forward(request, response);
        }
        else if(pid == null && pquantity == null){
            CartDAO cartDAO = new CartDAO();
            Cookie[] cookies = request.getCookies();
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("cart")){
                    List<Pair<Product, Integer> >list = cartDAO.getCartItems(cookie.getValue());
                    request.setAttribute("cart", list);
                    request.getRequestDispatcher("/views/user/payment.jsp").forward(request, response);
                }
            }
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        List<Category> categories = new ArrayList<>();
        Map<Integer, List<String>> branchesMap = new HashMap<>();
        CategoryDAO catDB = new CategoryDAO();
        ProductDAO productDB = new ProductDAO();

        categories = catDB.getAll();
        for (Category category : categories) {
            branchesMap.put(category.getId(), productDB.getBranches(category.getId()));
        }
        request.setAttribute("categories", categories);
        request.setAttribute("branchesmap", branchesMap);
        
        String name = request.getParameter("customer-name");
        String address = request.getParameter("customer-address");
        String phone = request.getParameter("customer-phonenumber");
        String email = request.getParameter("customer-email");
        String note = request.getParameter("order-comment");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if(user == null){
            request.getRequestDispatcher("user_sign_in").forward(request, response);
        }
        
        String pid = request.getParameter("product-id-buy-now");
        String pquantity = request.getParameter("quantity-buy-now");
        if(pid != null && pquantity != null && pid != "" && pquantity != ""){
            
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            ProductDAO productDAO = new ProductDAO();
            try {
                int id = Integer.parseInt(pid);
                int quantity = Integer.parseInt(pquantity);
                Order newOrder = orderDAO.createOrder(user, name, address, phone, email, note);
                
                Product product = productDAO.getByID(id);
                if(product.getQuantity() < quantity){
                    quantity = product.getQuantity();
                }

                orderDetailDAO.createItem(newOrder, product, product.getPrice_sale(), quantity);
                productDAO.updateQuantity(product.getId(), product.getQuantity() - quantity);
                        
                orderDAO.updateTotalMoney(newOrder.getId(), quantity * product.getPrice_sale());
                request.setAttribute("order", orderDAO.getById(newOrder.getId()));
            } catch (SQLException ex) {
                request.getRequestDispatcher("views/user/error_404.jsp").forward(request, response);
                Logger.getLogger(UserCheckout.class.getName()).log(Level.SEVERE, null, ex);
            }
                
        }
        else if(pid == "" || pquantity == ""){
            request.getRequestDispatcher("views/user/error_404.jsp").forward(request, response);
        }
        else if(pid == null && pquantity == null){
            Cookie[] cookies = request.getCookies();

            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            ProductDAO productDAO = new ProductDAO();
            try {
                Order newOrder = orderDAO.createOrder(user, name, address, phone, email, note);
                for(Cookie cookie : cookies){
                    if(cookie.getName().equals("cart")){
                        int sum = 0;
                        String[] cart = cookie.getValue().split("_");
                        for(String item : cart){
                            String[] tmp = item.split(":");
                            int q = Integer.parseInt(tmp[1]);
                            Product product = productDAO.getByID(Integer.parseInt(tmp[0]));
                            if(product.getQuantity() < q){
                                q = product.getQuantity();
                            }
                            sum += q * product.getPrice();
                            orderDetailDAO.createItem(newOrder, product, product.getPrice_sale(), q);
                            productDAO.updateQuantity(product.getId(), product.getQuantity() - q);
                        }
                        orderDAO.updateTotalMoney(newOrder.getId(), sum);
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                }
                request.setAttribute("order", orderDAO.getById(newOrder.getId()));
            } catch (SQLException ex) {

                Logger.getLogger(UserCheckout.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        request.getRequestDispatcher("views/user/ordersuccess.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
