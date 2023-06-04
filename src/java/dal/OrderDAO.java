/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import java.util.Calendar;
import java.util.List;

import model.Order;
import model.OrderDetail;

import model.User;

/**
 *
 * @author Huynh
 */
public class OrderDAO extends ConnectDB{
    public Order createOrder(User user, String name, String address, String phone, String email, String note) throws SQLException{
        String query = "INSERT INTO orders VALUES(N'" + user.getId() + "',N'" + name + "','" + phone + "','" + email + "',N'" + address + "',N'" + note + "', 0 , ? , 0 );";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        Calendar cal = Calendar.getInstance();
        Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
        preparedStatement.setTimestamp(1, timestamp);
        preparedStatement.execute();
        String querySelectOrder = "SELECT * FROM orders WHERE id = (SELECT MAX(id) FROM orders);";
        PreparedStatement preparedStatement2 = connection.prepareStatement(querySelectOrder);
        preparedStatement2.execute();
        ResultSet resultSet = preparedStatement2.getResultSet();
        Order order = new Order();
        if(resultSet.next()){
            
            order.setFullname(resultSet.getString("fullname"));
            order.setAddress(resultSet.getString("address"));
            order.setEmail(resultSet.getString("email"));
            order.setNote(resultSet.getString("note"));
            order.setOrderItems(null);
            order.setOrder_date(resultSet.getDate("order_date"));
            order.setPhone_number(resultSet.getString("phone_number"));
            order.setStatus(resultSet.getInt("status"));
            order.setTotal_money(resultSet.getInt("total_money"));
            order.setId(resultSet.getInt("id"));
        }
        return order;
    }
    
    public Order getById(int id) throws SQLException{
        String query = "SELECT * FROM orders WHERE id = " + id + ";";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.execute();
        ResultSet resultSet = preparedStatement.getResultSet();
        Order order = new Order();
        if(resultSet.next()){
            
            order.setFullname(resultSet.getString("fullname"));
            order.setAddress(resultSet.getString("address"));
            order.setEmail(resultSet.getString("email"));
            order.setNote(resultSet.getString("note"));
            order.setOrderItems(null);
            order.setOrder_date(resultSet.getDate("order_date"));
            order.setPhone_number(resultSet.getString("phone_number"));
            order.setStatus(resultSet.getInt("status"));
            order.setTotal_money(resultSet.getInt("total_money"));
            order.setId(resultSet.getInt("id"));
        }
        return order;
    }
    
    public List<Order> getAllByUserId(int id) throws SQLException{
        String query = "SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC;";
        PreparedStatement psm = connection.prepareStatement(query);
        psm.setInt(1, id);
        psm.execute();
        ResultSet resultSet = psm.getResultSet();
        List<Order> orders = new ArrayList<>();
        while(resultSet.next()){
            Order order = new Order();
            
            order.setFullname(resultSet.getString("fullname"));
            order.setAddress(resultSet.getString("address"));
            order.setEmail(resultSet.getString("email"));
            order.setNote(resultSet.getString("note"));
            order.setOrderItems(null);
            order.setOrder_date(resultSet.getDate("order_date"));
            order.setPhone_number(resultSet.getString("phone_number"));
            order.setStatus(resultSet.getInt("status"));
            order.setTotal_money(resultSet.getInt("total_money"));
            order.setId(resultSet.getInt("id"));
            
            orders.add(order);
        }
        return orders;
    }
    
    public void updateTotalMoney(int orderId, int total) throws SQLException{
        String query = "UPDATE orders SET total_money = " + total + "WHERE id = " + orderId + ";";
        PreparedStatement psm = connection.prepareStatement(query);
        psm.executeUpdate();
    }
    
    public void updateStatus(int orderId, int status) throws SQLException{
        String query = "UPDATE orders SET status = " + status + "WHERE id = " + orderId + ";";
        PreparedStatement psm = connection.prepareStatement(query);
        psm.executeUpdate();
    }
    
    public List<Order> getAll() throws SQLException{
        String query = "SELECT * FROM orders ORDER BY id DESC";
        PreparedStatement psm = connection.prepareStatement(query);
        psm.execute();
        ResultSet resultSet = psm.getResultSet();
        List<Order> orders = new ArrayList<>();
        while(resultSet.next()){
            Order order = new Order();
            
            order.setFullname(resultSet.getString("fullname"));
            order.setAddress(resultSet.getString("address"));
            order.setEmail(resultSet.getString("email"));
            order.setNote(resultSet.getString("note"));
            order.setOrderItems(null);
            order.setOrder_date(resultSet.getDate("order_date"));
            order.setPhone_number(resultSet.getString("phone_number"));
            order.setStatus(resultSet.getInt("status"));
            order.setTotal_money(resultSet.getInt("total_money"));
            order.setId(resultSet.getInt("id"));
            
            orders.add(order);
        }
        return orders;
    }
    
    public Order readById(int id) throws SQLException{
        String query = "SELECT orders.*, users.id AS account_id, users.fullname AS account_fullname, "
                + "users.email AS account_email, users.phone_number AS account_phone_number " 
                + "FROM orders INNER JOIN users on orders.user_id = users.id AND orders.id = " + id;
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.execute();
        ResultSet resultSet = preparedStatement.getResultSet();
        Order order = new Order();
        User user = new User();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        if(resultSet.next()){
            
            order.setFullname(resultSet.getString("fullname"));
            order.setAddress(resultSet.getString("address"));
            order.setEmail(resultSet.getString("email"));
            order.setNote(resultSet.getString("note"));
            order.setOrder_date(resultSet.getDate("order_date"));
            order.setPhone_number(resultSet.getString("phone_number"));
            order.setStatus(resultSet.getInt("status"));
            order.setTotal_money(resultSet.getInt("total_money"));
            order.setId(resultSet.getInt("id"));
            
            user.setId(resultSet.getInt("account_id"));
            user.setEmail(resultSet.getString("account_email"));
            user.setFullname(resultSet.getString("account_fullname"));
            user.setPhoneNumber(resultSet.getString("account_phone_number"));
            order.setUser(user);
            
            List<OrderDetail> listOrderDetails = orderDetailDAO.getAllById(order.getId(), user.getId());
            
            order.setOrderItems(listOrderDetails);
            
        }
        return order;
    }
    
    public List<Order> getByPhonenumber(String phonenumber) throws SQLException{
        String query = "SELECT * FROM orders WHERE phone_number LIKE '%" +phonenumber + "%' ORDER BY id DESC";
        PreparedStatement psm = connection.prepareStatement(query);
        psm.execute();
        ResultSet resultSet = psm.getResultSet();
        List<Order> orders = new ArrayList<>();
        while(resultSet.next()){
            Order order = new Order();
            
            order.setFullname(resultSet.getString("fullname"));
            order.setAddress(resultSet.getString("address"));
            order.setEmail(resultSet.getString("email"));
            order.setNote(resultSet.getString("note"));
            order.setOrderItems(null);
            order.setOrder_date(resultSet.getDate("order_date"));
            order.setPhone_number(resultSet.getString("phone_number"));
            order.setStatus(resultSet.getInt("status"));
            order.setTotal_money(resultSet.getInt("total_money"));
            order.setId(resultSet.getInt("id"));
            
            orders.add(order);
        }
        return orders;
    }
}
