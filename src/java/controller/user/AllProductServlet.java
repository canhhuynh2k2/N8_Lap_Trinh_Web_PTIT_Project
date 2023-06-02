/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.user;

import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.Product;

/**
 *
 * @author chaum
 */
@WebServlet(name="AllProductServlet", urlPatterns={"/allproduct"})
public class AllProductServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AllProductServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AllProductServlet at " + request.getContextPath () + "</h1>");
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

        //for header
        List<Category> categories = new ArrayList<>();
        Map<Integer, List<String>> branchesMap = new HashMap<>();
        CategoryDAO catDB = new CategoryDAO();
        ProductDAO productDB = new ProductDAO();
        
        categories = catDB.getAll();
        for(Category category: categories){
            branchesMap.put(category.getId(), productDB.getBranches(category.getId()));
        }   
       
        productDB.close();
        catDB.close();

        String catIdRaw = (String)request.getParameter("catid");
        Category currentCategory = null;
        //catid = 0 -> all
        if(catIdRaw == null){
            catIdRaw = "0";
        }
        int catId = Integer.parseInt(catIdRaw);
        if(catId != 0){
            catDB = new CategoryDAO();
            currentCategory = catDB.getById(catId);
            catDB.close();
        }
        
        
        String searchName = (String) request.getParameter("searchname");
        if(searchName==null){
            searchName = "";
        }
        
        
        List<String> priceRange = new ArrayList<>();
        priceRange.add("Tất cả");
        priceRange.add("Dưới 2 triệu");
        priceRange.add("Từ 2 triệu - 5 triệu");
        priceRange.add("Từ 5 triệu - 10 triệu");
        priceRange.add("Từ 10 triệu - 20 triệu");
        priceRange.add("Trên 20 triệu");
        String priceOption = (String)request.getParameter("priceoption");
        //priceOption = 1 -> ALL
        //2->Duoi 2 tr
        //3 -> 2 - 5
        //4 -> 5-10
        //5 -> 10-20
        //6 -> >20
        if(priceOption == null){
            priceOption = "1";//All
        }
        
        ProductDAO db = new ProductDAO();
        List<String> branches = db.getBranches(catId);
        String branchOption = (String)request.getParameter("branchoption");
        //branchOption = 0 -> all
        //else là name branch
        if(branchOption == null){
            branchOption = "0";//All
        }
        db.close();
        
        List<String> alcoholRange = new ArrayList<>();
        alcoholRange.add("Tất cả");
        alcoholRange.add("Dưới 10%");
        alcoholRange.add("Từ 10% - 20%");
        alcoholRange.add("Từ 20% - 30%");
        alcoholRange.add("Từ 30% - 40%");
        alcoholRange.add("Trên 40%");
        String alcoholOption = (String)request.getParameter("alcoholoption");
        //alcoholOption = 1 -> ALL
        //2-> <10
        //3 -> 10 - 20
        //4 -> 20-30
        //5 -> 30-40
        //6 -> >40
        if(alcoholOption == null){
            alcoholOption = "1";
        }
        
        List<String> capacityRange = new ArrayList<>();
        capacityRange.add("Tất cả");
        capacityRange.add("Dưới 300ml");
        capacityRange.add("Từ 300ml - 500ml");
        capacityRange.add("Từ 500ml - 700ml");
        capacityRange.add("Trên 700ml");
        String capacityOption = (String)request.getParameter("capacityoption");
        //capacityOption = 1 -> ALL
        //2-> <300
        //3 -> 300 - 500
        //4 -> 500-700
        //5 -> >700
        if(capacityOption == null){
            capacityOption = "1";
        }
        
        List<String> sortList = new ArrayList<>();
        sortList.add("Theo tên sản phẩm A-Z");
        sortList.add("Theo tên sản phẩm Z-A");
        sortList.add("Theo giá từ thấp đến cao");
        sortList.add("Theo giá từ cao đến thấp");
        sortList.add("Theo dung tích từ thấp đến cao");
        sortList.add("Theo dung tích từ cao đến thấp");
        String sortOption = (String) request.getParameter("sortoption");
        //sortOption = 1 -> name A->Z
        //2-> name Z -> A
        //3 -> price thap -> cao
        //4 -> price cao -> thap
        //5 -> capacity thap -> cao
        //6 -> capacity cao -> thap
        if(sortOption == null){
            sortOption = "1";
        }
        
        
        
        
        productDB = new ProductDAO();
        List<Product> products = productDB.search(catId, Integer.parseInt(priceOption), branchOption, Integer.parseInt(alcoholOption), Integer.parseInt(capacityOption), Integer.parseInt(sortOption), searchName.trim());
        productDB.close();
        
        Integer currentpage,nummberperpage = 6;
        String page_raw = (String)request.getParameter("page");
        if(page_raw == null){
            currentpage = 1;
        }
        else{
            currentpage = Integer.parseInt(page_raw);
        }
        int start = (currentpage-1)*nummberperpage;
        int end = Math.min((currentpage)*nummberperpage, products.size());
        
        int amountofproducts = products.size();
        int numberofpage = (amountofproducts%nummberperpage==0)?(products.size()/nummberperpage):(products.size()/nummberperpage+1);
        List<Product> productPage = new ArrayList<>();
        for(int i = start; i < end; i++) productPage.add(products.get(i));

        request.setAttribute("products", productPage);
        request.setAttribute("page", currentpage);
        request.setAttribute("numberofpage", numberofpage);
        
        request.setAttribute("categories", categories);
        request.setAttribute("branchesmap", branchesMap);
        
        request.setAttribute("catid", catId+"");
        request.setAttribute("currentcategory", currentCategory);
        
        request.setAttribute("pricerange", priceRange);
        request.setAttribute("priceoption", priceOption);
        
        request.setAttribute("branches", branches);
        request.setAttribute("branchoption", branchOption);
        
        request.setAttribute("alcoholrange", alcoholRange);
        request.setAttribute("alcoholoption", alcoholOption);
        
        request.setAttribute("capacityrange", capacityRange);
        request.setAttribute("capacityoption", capacityOption);
        
        request.setAttribute("sortlist", sortList);
        request.setAttribute("sortoption", sortOption);
        
        request.getRequestDispatcher("./views/user/allproduct.jsp").forward(request, response);
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
