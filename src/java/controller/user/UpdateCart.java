/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author Huynh
 */
@WebServlet(name="UpdateCart", urlPatterns={"/updatecart"})
public class UpdateCart extends HttpServlet {
   
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
            out.println("<title>Servlet EditCart</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCart at " + request.getContextPath () + "</h1>");
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
        String delete = request.getParameter("delete");
        String update = request.getParameter("update");
        Cookie[] cookies = request.getCookies();
        String value = "";
        ProductDAO productDao = new ProductDAO();
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("cart")){

                    String[] cart = cookie.getValue().split("_");
                    for(String item : cart){
                        String[] tmp = item.split(":");
                        if(!tmp[0].equals(delete)){
                            if(update != null){
                                int quantity = Integer.parseInt(request.getParameter("quantity"));

                                try {
                                    Product product = productDao.getByID(Integer.parseInt(update));
                                    
                                    if(tmp[0].equals(update)){
                                        if(product.getQuantity() < quantity){
                                            quantity = product.getQuantity();
                                        }
                                        value += "_" + tmp[0] + ":" + quantity;
                                        System.out.println("update" + product.getId());
                                    }
                                    else value += "_" + item;
                                } catch (SQLException ex) {
                                    response.sendRedirect("views/user/error_404.jsp");
                                    Logger.getLogger(UpdateCart.class.getName()).log(Level.SEVERE, null, ex);
                                }  
                            }
                            else value += "_" + item;
                        }
                    }
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    if(!value.equals("") && value.charAt(0) == '_') value = value.substring(1);
                    if(!value.equals("")){
                        Cookie newCookie = new Cookie("cart", value);
                        newCookie.setMaxAge(60 * 60 * 24 * 7);
                        response.addCookie(newCookie);
                    }
                    
                }
            }  
        }
        response.sendRedirect("/webn8/cart");
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
