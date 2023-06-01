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
import model.Role;

/**
 *
 * @author Bach
 */
public class RoleDAO extends ConnectDB{
    
    //lay role theo role_id
    public Role getRoleById(int role_id){
        Role role = null;
        String sql = "select * from roles where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, role_id);
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                role = new Role();
                role.setId(role_id);
                role.setName(rs.getString("name"));
                
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return role;
    }
    
    //lay tat ca role
    public List<Role> getAllRoles() {
        List<Role> listRole = new ArrayList<>();
        String sql = "select * from roles";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Role role = new Role();
                role.setId(rs.getInt("id"));
                role.setName(rs.getString("name"));
                listRole.add(role);
            }
        } catch (SQLException e) {
        }
        return listRole;
    }
    
}
