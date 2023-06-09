/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.CategoryDAO;
import dal.ProductDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.User;

/**
 *
 * @author Bach
 */
public class UserUpdateProfile extends HttpServlet {

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
            out.println("<title>Servlet UserUpdateProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserUpdateProfile at " + request.getContextPath() + "</h1>");
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
        List<Category> categories = new ArrayList<>();
        Map<Integer, List<String>> branchesMap = new HashMap<>();
        CategoryDAO catDB = new CategoryDAO();
        ProductDAO productDB = new ProductDAO();

        categories = catDB.getAll();
        for (Category category : categories) {
            branchesMap.put(category.getId(), productDB.getBranches(category.getId()));
            category.setProducts(productDB.getByCatId(category.getId()));
        }

        productDB.close();
        catDB.close();
        request.setAttribute("categories", categories);
        request.setAttribute("branchesmap", branchesMap);
        request.getRequestDispatcher("views/user/update_profile.jsp").forward(request, response);
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
        String fullName = request.getParameter("full_name");
        String phoneNumber = request.getParameter("phone_number");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        user.setFullname(fullName);
        user.setPhoneNumber(phoneNumber);

        UserDAO userDB = new UserDAO();
        if (userDB.updateUser(user) == 1) {
            session.removeAttribute("user");
            session.setAttribute("user", user);
            request.setAttribute("updateProfileSuccess", "Chỉnh Sửa Thông Tin Thành Công");
            request.getRequestDispatcher("views/user/profile.jsp").forward(request, response);
        } else {
            List<Category> categories = new ArrayList<>();
            Map<Integer, List<String>> branchesMap = new HashMap<>();
            CategoryDAO catDB = new CategoryDAO();
            ProductDAO productDB = new ProductDAO();

            categories = catDB.getAll();
            for (Category category : categories) {
                branchesMap.put(category.getId(), productDB.getBranches(category.getId()));
                category.setProducts(productDB.getByCatId(category.getId()));
            }

            productDB.close();
            catDB.close();
            request.setAttribute("categories", categories);
            request.setAttribute("branchesmap", branchesMap);
            request.setAttribute("updateProfileError", "Đã Xảy Ra Lỗi");
            request.getRequestDispatcher("views/user/update_profile.jsp").forward(request, response);
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
