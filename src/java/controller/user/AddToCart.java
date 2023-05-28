/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
@WebServlet(name="AddToCart", urlPatterns={"/addtocart"})
public class AddToCart extends HttpServlet {
   
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
            out.println("<title>Servlet AddToCard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCard at " + request.getContextPath () + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int ok = 0;
        boolean addedItem = false;
        ArrayList<Integer> listIds = new ArrayList<>();
        Cookie[] cookies = request.getCookies();
        String  value = "";
        if(cookies != null){
            for(Cookie c : cookies){
            if(c.getName().equals("cart")){
                ok = 1;
                String[] listItems = c.getValue().split("_");
                for(String item : listItems){
                    String[] i = item.split(":");
                    int j = Integer.parseInt(i[0]);
                    int q = Integer.parseInt(i[1]);
                    if(j == id){
                        q += quantity;
                        addedItem = true;
                    }
                    value += "_" + j + ":" + q;
                }
                if(addedItem == false){
                    value += "_" + id + ":" + quantity;
                }
                c.setMaxAge(0);
                response.addCookie(c);
                if(value.charAt(0) == '_') value = value.substring(1);
                Cookie newCookie = new Cookie("cart", value);
                newCookie.setMaxAge(60 * 60 * 24 * 7);
                response.addCookie(newCookie);
            }
        }
        if(ok == 0){
            value = ("" + id + ":" + quantity);
            Cookie newCookie = new Cookie("cart", value);
            newCookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(newCookie);
        }
        }
        response.sendRedirect("productdetail" + "?pid=" + id);
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
