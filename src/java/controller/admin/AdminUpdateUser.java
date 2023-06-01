/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.RoleDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Role;
import model.User;

/**
 *
 * @author Bach
 */
public class AdminUpdateUser extends HttpServlet {

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
            out.println("<title>Servlet AdminUpdateUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUpdateUser at " + request.getContextPath() + "</h1>");
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
        String userIdRaw = request.getParameter("id");
        try {
            int userId = Integer.parseInt(userIdRaw);
            User user = new UserDAO().getUserById(userId);
            List<Role> listRole = new RoleDAO().getAllRoles();
            request.setAttribute("listRole", listRole);
            request.setAttribute("user", user);
            request.getRequestDispatcher("views/admin/update_user.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Da Xay Ra Loi");
            request.getRequestDispatcher("list_user").forward(request, response);
        }
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
        String userIdRaw = request.getParameter("user_id");
        String roleIdRaw = request.getParameter("role_id");
        try {
            int userId = Integer.parseInt(userIdRaw);
            int roleId = Integer.parseInt(roleIdRaw);
            User user = new UserDAO().getUserById(userId);
            user.getRole().setId(roleId);
            int result = new UserDAO().updateUser(user);
            if (result == 1) {
                request.setAttribute("success", "Thanh Cong");
                request.getRequestDispatcher("list_user").forward(request, response);
            } else {
                request.setAttribute("error", "Da Xay Ra Loi");
                request.getRequestDispatcher("list_user").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Da Xay Ra Loi");
            request.getRequestDispatcher("list_user").forward(request, response);
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
