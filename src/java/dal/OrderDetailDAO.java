/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Product;

/**
 *
 * @author DELL
 */
public class OrderDetailDAO extends ConnectDB{
    public void createItem(Order order, Product product, int price, int quantity) throws SQLException{
        String query = "insert into order_details "
                + "values ( " + order.getId() + " , " + product.getId() +" , "+ price +" , "+ quantity + " );";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.execute();
    }
    
    public List<OrderDetail> getAllById(int orderId, int userId) throws SQLException{
        String query = "SELECT order_details.id as order_detail_id, products.id AS product_id, products.name AS product_name, products.thumbnail AS product_thumbnail, products.unit AS product_unit, orders.id AS order_id, order_details.quantity, order_details.price" +
                        " FROM order_details INNER JOIN orders ON order_details.order_id = orders.id AND orders.id = ? " +
                            "INNER JOIN products ON products.id = order_details.product_id INNER JOIN users ON users.id = ? ;";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, orderId);
        preparedStatement.setInt(2, userId);
        preparedStatement.execute();
        ResultSet rs = preparedStatement.getResultSet();
        List<OrderDetail> orderDetails = new ArrayList<>();
        while(rs.next()){
            
            Product product = new Product();
            product.setId(rs.getInt("product_id"));
            product.setName(rs.getString("product_name"));
            product.setThumbnail(rs.getString("product_thumbnail"));
            product.setUnit(rs.getString("product_unit"));
            
            Order order = new Order();
            order.setId(rs.getInt("order_id"));
            
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setId(rs.getInt("order_detail_id"));
            orderDetail.setOrder(order);
            orderDetail.setProduct(product);
            orderDetail.setQuantity(rs.getInt("quantity"));
            orderDetail.setPrice(rs.getInt("price"));
            
            orderDetails.add(orderDetail);
        }
        return orderDetails;
    }
    
}
