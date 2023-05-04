/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Item;
import model.Product;

/**
 *
 * @author Bach
 */
public class UserCartCheckQuantity extends HttpServlet {
   
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
            out.println("<title>Servlet UserCartCheckQuantity</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserCartCheckQuantity at " + request.getContextPath () + "</h1>");
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
        Cookie[] cookies = request.getCookies();
        String cookieTxt = "";
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookieTxt += cookie.getValue();
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
        Cart cart = new Cart(cookieTxt);
        try {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            Product product = new ProductDAO().getByID(productId);
            int productQuantity = product.getQuantity();
            int number = Integer.parseInt(request.getParameter("number"));
            int itemQuantity = cart.getItemQuantityByProductId(productId);
            if (number == 1) {
                if (itemQuantity >= productQuantity) {
                    request.setAttribute("cart", cart);
                    cookieTxt = cart.getCookieTxt();
                    Cookie cookie = new Cookie("cart", cookieTxt);
                    cookie.setMaxAge(7 * 24 * 60 * 60);
                    response.addCookie(cookie);
                    request.setAttribute("outOfProduct", "khong du san pham");
                    request.getRequestDispatcher("views/user/cart.jsp").forward(request, response);
                } else {
                    Item item = new Item(product, product.getPrice_sale(), number);
                    cart.addItem(item);
                }
            } else if (number == -1) {
                if (itemQuantity <= 1) {
                    cart.removeItem(productId);
                } else {
                    Item item = new Item(product, product.getPrice_sale(), number);
                    cart.addItem(item);
                }
            } else if (number == 0) {
                cart.removeItem(productId);
            }
            cookieTxt = cart.getCookieTxt();
            Cookie cookie = new Cookie("cart", cookieTxt);
            cookie.setMaxAge(7 * 24 * 60 * 60);
            response.addCookie(cookie);
        } catch (NumberFormatException e) {
        } catch (SQLException ex) {
            Logger.getLogger(UserCartCheckQuantity.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("user_cart");
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
        processRequest(request, response);
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
