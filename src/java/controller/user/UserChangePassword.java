/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.UserDAO;
import extension.Encrypt;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;
import model.Item;
import model.User;

/**
 *
 * @author Bach
 */
public class UserChangePassword extends HttpServlet {

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
            out.println("<title>Servlet UserChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserChangePassword at " + request.getContextPath() + "</h1>");
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
        //cookie
        Cookie[] cookies = request.getCookies();
        String cookieTxt = "";
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookieTxt += cookie.getValue();
                }
            }
        }
        Cart cart = new Cart(cookieTxt);
        List<Item> items = cart.getItems();

        request.setAttribute("cart", cart);
        request.setAttribute("items", items);

        request.getRequestDispatcher("views/user/change_password.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String oldPassword = request.getParameter("old_password");
        String newPassword = request.getParameter("password");
        String oldPasswordEncrypt = Encrypt.toSHA1(oldPassword);
        String newPasswordEncrypt = Encrypt.toSHA1(newPassword);
        if (user.getPassword().equals(oldPasswordEncrypt)) {
            user.setPassword(newPasswordEncrypt);
            UserDAO userDB = new UserDAO();
            int result = userDB.updateUser(user);
            if (result == 1) {
                session.removeAttribute("user");
                session.setAttribute("user", user);
                request.setAttribute("changePasswordSuccess", "Thay Đổi Mật Khẩu Thành Công");
                request.getRequestDispatcher("views/user/profile.jsp").forward(request, response);
            } else {
                request.setAttribute("changePasswordError", "Đã Xảy Ra Lỗi Vui Lòng Thử Lại");
                request.getRequestDispatcher("views/user/change_password.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("wrongOldPassword", "Mật Khẩu Cũ Không Đúng");
            request.getRequestDispatcher("views/user/change_password.jsp").forward(request, response);
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
