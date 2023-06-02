/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.UserDAO;
import extension.Encrypt;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Bach
 */
public class AdminSignIn extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminSignIn</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminSignIn at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("views/admin/sign_in.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String passwordEncrypt = Encrypt.toSHA1(password);
        User user = new User();
        user.setEmail(email);
        user.setPassword(passwordEncrypt);
        UserDAO userDB = new UserDAO();
        if (userDB.isValid(user)) {
            user = userDB.getUserByEmail(email);
            if (user.getRole().getId() == 1) {
                HttpSession session = request.getSession();
                session.removeAttribute("user");
                session.setAttribute("user", user);
                String previousUri = (String) session.getAttribute("previousUri");
                if (previousUri != null) {
                    response.sendRedirect(previousUri);
                } else {
                    response.sendRedirect("list_user");
                }
            } else {
                request.setAttribute("wrongUser", "Email Hoặc Mật Khẩu Không Đúng!");
                request.getRequestDispatcher("views/admin/sign_in.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("wrongUser", "Email Hoặc Mật Khẩu Không Đúng!");
            request.getRequestDispatcher("views/admin/sign_in.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
