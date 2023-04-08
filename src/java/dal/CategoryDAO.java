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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author chaum
 */
public class CategoryDAO extends ConnectDB{
    
    public List<Category> getAll(){
        String query = "select * from categories;";
        try{
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            List<Category> categories = new ArrayList<>();
            while(resultSet.next()){
               Category category = new Category();
               category.setId(resultSet.getInt("id"));
               category.setName(resultSet.getString("name"));
               categories.add(category);
            }
            return categories;
        }
        catch(SQLException ex){
            
        }
        return null;
    }
    
    public Category getById(int id){
        String query = "select * from categories where id = " + id +" ;";
        
        try{
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            if(resultSet.next()){
                Category category = new  Category();
                category.setId(resultSet.getInt("id"));
                category.setName(resultSet.getString("name"));
                return category;
            }
        }catch(SQLException e){
            
        }
        return  null;
    }
    
    public void close(){
        try {
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
