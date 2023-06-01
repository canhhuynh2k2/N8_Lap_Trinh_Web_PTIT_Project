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
import model.User;

/**
 *
 * @author Bach
 */
public class UserDAO extends ConnectDB {

    //kiem tra user co trong db khong
    public boolean isExisted(User user) {
        String sql = "select * from users where email = ?";
        System.out.println(sql);
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getEmail());
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }

    //kiem tra co dung tai khoan khong
    public boolean isValid(User user) {
        String sql = "select * from users where email = ? and password = ?";
        System.out.println(sql);
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPassword());
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }

    //them tai khoan
    public int addUser(User user) {
        String sql = "insert into users (fullname, email, password, phone_number) values (?, ?, ?, ?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getFullname());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getPhoneNumber());
            return statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    //lay tai khoan theo email
    public User getUserByEmail(String email) {
        User user = null;
        String sql = "select * from users where email = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setRole(new RoleDAO().getRoleById(rs.getInt("role_id")));
                user.setFullname(rs.getString("fullname"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setEmail(email);
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    //lay tai khoan theo id
    public User getUserById(int id) {
        User user = null;
        String sql = "select * from users where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setRole(new RoleDAO().getRoleById(rs.getInt("role_id")));
                user.setFullname(rs.getString("fullname"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    //sua tai khoan
    public int updateUser(User user) {
        String sql = "update users set role_id = ? , fullname = ? , phone_number = ?, password = ? where id = ?";
        System.out.println(sql);
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, user.getRole().getId());
            statement.setString(2, user.getFullname());
            statement.setString(3, user.getPhoneNumber());
            statement.setString(4, user.getPassword());
            statement.setInt(5, user.getId());
            return statement.executeUpdate();
        } catch (SQLException e) {
            return 0;
        }
    }
    
    //xoa tai khoan
    public int deleteUser(int id) {
        String sql = "delete users where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            return statement.executeUpdate();
        } catch (SQLException e) {
            return 0;
        }
    }

    //lay toan bo tai khoan
    public List<User> getAllUsers() {
        List<User> listUser = new ArrayList<>();
        String sql = "select * from users";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setRole(new RoleDAO().getRoleById(rs.getInt("role_id")));
                user.setFullname(rs.getString("fullname"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                listUser.add(user);
            }
        } catch (SQLException ex) {
        }
        return listUser;
    }

    //phan trang
    public List<User> getListUserByPage(List<User> listUser, int start, int end) {
        List<User> listUserResult = new ArrayList<>();
        for (int i = start; i < end; i++) {
            listUserResult.add(listUser.get(i));
        }
        return listUserResult;
    }
    
    

}
