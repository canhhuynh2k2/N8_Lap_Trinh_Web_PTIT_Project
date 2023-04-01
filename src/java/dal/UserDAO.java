/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 *
 * @author Bach
 */
public class UserDAO extends ConnectDB{
    
    //kiem tra user co trong db khong
    public boolean isExisted(User user){
        String sql = "select * from users where email = ?";
        System.out.println(sql);
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getEmail());
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }
    
    //kiem tra co dung tai khoan khong
    public boolean isValid(User user){
        String sql = "select * from users where email = ? and password = ?";
        System.out.println(sql);
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPassword());
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }
    
    //them tai khoan
    public int addUser(User user){
        String sql = "insert into users (fullname, phone_number, email, password) values (?, ?, ?, ?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getFullname());
            statement.setString(2, user.getPhoneNumber());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getPassword());
            return statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
    
    //lay tai khoan theo email
    public User getUserByEmail(String email){
        User user = null;
        String sql = "select * from users where email = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setRole(new RoleDAO().getRoleById(rs.getInt("role_id")));
                user.setFullname(rs.getString("fullname"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setEmail(email);
                user.setPassword(rs.getString("password"));
                //user.setComments(Comments);
                //user.setOrders(oders);
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }
    
    //sua tai khoan
    public int updateUser(User user){
        String sql = "update users set fullname = ? , phone_number = ?, password = ? where id = ?";
        System.out.println(sql);
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getFullname());
            statement.setString(2, user.getPhoneNumber());
            statement.setString(3, user.getPassword());
            statement.setInt(4, user.getId());
            return statement.executeUpdate();
        } catch (SQLException e) {
            return 0;
        }
    }
    
    public static void main(String[] args) {
        User user = new UserDAO().getUserByEmail("123@a.bc");
        System.out.println(user.getFullname());
    }
    
}
