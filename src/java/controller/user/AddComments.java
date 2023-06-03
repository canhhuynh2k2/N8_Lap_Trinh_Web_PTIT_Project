
package controller.user;

import dal.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import java.io.IOException;
import java.io.PrintWriter;
import model.User;


@WebServlet(name = "AddComments", urlPatterns = {"/AddComments"})
public class AddComments extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // làm phần user_id;
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int user_id = user.getId();
         // String user_id = request.getParameter("user_id");
        
        // làm phần product_id;
        String product_id = request.getParameter("productId");
        
        // làm phần content;
        String content = request.getParameter("CommentsOfCustomer");
        
        // làm phần rate;
        String rate = request.getParameter("point");
        
        CommentDAO dao = new CommentDAO();
        dao.insertComment(user_id, Integer.parseInt(product_id), content, Integer.parseInt(rate));
        response.sendRedirect("productdetail?pid=" + product_id);
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
