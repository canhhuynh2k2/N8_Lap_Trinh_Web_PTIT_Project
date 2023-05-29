/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javafx.util.Pair;
import model.Product;

/**
 *
 * @author DELL
 */
public class CartDAO extends ConnectDB{
    public List<Pair<Product, Integer> > getCartItems(String data){
        List<Pair<Product, Integer> > cart = new ArrayList<>();
        String[] items = data.split("_");
        ProductDAO productDAO = new ProductDAO();
        for(String item : items){
            String[] i = item.split(":");
            int j = Integer.parseInt(i[0]);
            int q = Integer.parseInt(i[1]);
            System.out.println(j + " " + q);
            try{
                Product product = productDAO.getByID(j);
//                quantity này là quantity thêm vào giỏ hàng
                if(product.getQuantity() < q){
                    q = product.getQuantity();
                }
                cart.add(new Pair<Product, Integer>(product, q));
            }catch(SQLException e){
                
            }
         
        }
        return cart;
    }
}
