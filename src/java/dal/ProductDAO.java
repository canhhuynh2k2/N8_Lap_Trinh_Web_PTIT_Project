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
import model.Product;

/**
 *
 * @author chaum
 */
public class ProductDAO extends ConnectDB {

    public List<Product> getAll() {
        String query = "select p.id, p.name as p_name, p.description, p.thumbnail, p.unit, p.branch, p.capacity, p.alcohol, p.price, p.price_sale, p.quantity ,p.thumbnail, p.category_id, c.name as c_name "
                + " from products p inner join categories c on p.category_id = c.id;";

        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();

            ResultSet resultSet = prepare.getResultSet();

            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                products.add(new Product(resultSet.getInt("id"), new Category(resultSet.getInt("category_id"), resultSet.getString("c_name"), new ArrayList<Product>()), resultSet.getString("p_name"), resultSet.getString("description"), resultSet.getString("thumbnail"), resultSet.getString("unit"), resultSet.getString("branch"), resultSet.getInt("capacity"), resultSet.getDouble("alcohol"),
                        resultSet.getInt("quantity"), resultSet.getInt("price"), resultSet.getInt("price_sale")));
            }
            return products;
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return null;
    }

    public List<String> getBranches(int category_id) {
        //category_id == 0 -> get all branch
        String query = "select distinct upper(branch) as branch from products where 1 = 1 ";
        if (category_id != 0) {
            query += " and category_id = " + category_id;
        }
        query += " ;";

        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            List<String> branches = new ArrayList<>();
            while (resultSet.next()) {
                branches.add(resultSet.getString("branch"));
            }
            return branches;
        } catch (SQLException ex) {

        }
        return null;
    }

    public List<Product> getByCatId(int category_id) {
        String query = "select * "
                + " from products WHERE category_id = " + category_id + " ;";
        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();

            ResultSet resultSet = prepare.getResultSet();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setThumbnail(resultSet.getString("thumbnail"));
                product.setUnit(resultSet.getString("unit"));
                product.setBranch(resultSet.getString("branch"));
                product.setCapacity(resultSet.getInt("capacity"));
                product.setAlcohol(resultSet.getDouble("alcohol"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setPrice(resultSet.getInt("price"));
                product.setPrice_sale(resultSet.getInt("price_sale"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return null;
    }

//   catId, priceOption, branchOption, alcoholOption, capacityOption
    public List<Product> search(int category_id, int priceOption, String branchOption, int alcoholOption, int capacityOption, int sortOption, String searchName) {

        String query = "Select p.id, p.name as p_name, p.description, p.thumbnail, p.unit, p.branch, p.capacity, p.alcohol, p.price, p.price_sale, p.quantity ,p.thumbnail, p.category_id, c.name as c_name from products p  ";
        query += " inner join categories c on p.category_id = c.id ";
        query += " where 1 = 1 ";
        //category_id = 0 -> all

        if (category_id != 0) {
            query += " and category_id = " + category_id;
        }

        //priceOption = 1 -> ALL
        //2->Duoi 2 tr
        //3 -> 2 - 5
        //4 -> 5-10
        //5 -> 10-20
        //6 -> >20
        switch (priceOption) {
            case 1:

                break;
            case 2:
                query += "and price_sale < 2000000 ";
                break;
            case 3:
                query += "and price_sale between 2000001 and 5000000 ";
                break;
            case 4:
                query += "and price_sale between 5000001 and 10000000 ";
                break;
            case 5:
                query += "and price_sale between 10000001 and 20000000 ";
                break;
            case 6:
                query += "and price_sale > 20000000 ";
                break;
            default:
                throw new AssertionError();
        }

        //branchOption = 0 -> all
        //else là name branch
        if (!branchOption.equals("0")) {
            query += " and UPPER(branch) like UPPER('" + branchOption + "') ";
        }
        //alcoholOption = 1 -> ALL
        //2-> <10
        //3 -> 10 - 20
        //4 -> 20-30
        //5 -> 30-40
        //6 -> >40
        switch (alcoholOption) {
            case 1:

                break;
            case 2:
                query += " and alcohol < 10 ";
                break;
            case 3:
                query += " and alcohol between 11 and 20 ";
                break;
            case 4:
                query += " and alcohol between 21 and 30 ";
                break;
            case 5:
                query += " and alcohol between 31 and 40 ";
                break;
            case 6:
                query += " and alcohol > 40 ";
                break;
            default:
                throw new AssertionError();
        }

        //capacityOption = 1 -> ALL
        //2-> <300
        //3 -> 300 - 500
        //4 -> 500-700
        //5 -> >700
        switch (capacityOption) {
            case 1:

                break;
            case 2:
                query += " and capacity < 300 ";
                break;
            case 3:
                query += " and capacity between 301 and 500 ";
                break;
            case 4:
                query += " and capacity between 501 and 700 ";
                break;
            case 5:
                query += " and capacity > 700 ";
                break;

            default:
                throw new AssertionError();
        }

        if (!searchName.equals("")) {
            query += " and p.name like N'%" + searchName + "%' ";
        }

        //sortOption = 1 -> name A->Z
        //2-> name Z -> A
        //3 -> price thap -> cao
        //4 -> price cao -> thap
        //5 -> capacity thap -> cao
        //6 -> capacity cao -> thap
        switch (sortOption) {
            case 1:
                query += " order by p_name ";
                break;
            case 2:
                query += " order by p_name desc ";
                break;
            case 3:
                query += " order by price_sale ";
                break;
            case 4:
                query += " order by price_sale desc";
                break;
            case 5:
                query += " order by capacity ";
                break;
            case 6:
                query += " order by capacity desc ";
                break;
            default:
                throw new AssertionError();
        }

        query += ";";

        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            System.out.println(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                products.add(new Product(resultSet.getInt("id"), new Category(resultSet.getInt("category_id"), resultSet.getString("c_name"), new ArrayList<Product>()), resultSet.getString("p_name"), resultSet.getString("description"), resultSet.getString("thumbnail"), resultSet.getString("unit"), resultSet.getString("branch"), resultSet.getInt("capacity"), resultSet.getDouble("alcohol"),
                        resultSet.getInt("quantity"), resultSet.getInt("price"), resultSet.getInt("price_sale")));
            }
            return products;
        } catch (SQLException ex) {

        }

        return null;
    }

    public void deleteByID(int id) throws SQLException {
        String query = "delete from products where id = " + id;
        PreparedStatement prepare = connection.prepareStatement(query);
        prepare.execute();

    }

    public Product getByID(int id) throws SQLException {
        String query = "select p.id, p.name as p_name, p.description, p.thumbnail, p.unit, p.branch, p.capacity, p.alcohol,p.quantity ,p.price, p.price_sale, p.thumbnail, p.category_id, c.name as c_name \n"
                + "               from  (select * from products where id = " + id + ") p \n"
                + "			   inner join categories c on p.category_id = c.id;";
        PreparedStatement prepare = connection.prepareStatement(query);
        prepare.execute();
        ResultSet resultSet = prepare.getResultSet();
        if (resultSet.next()) {

            return new Product(resultSet.getInt("id"), new Category(resultSet.getInt("category_id"), resultSet.getString("c_name"), new ArrayList<>()), resultSet.getString("p_name"), resultSet.getString("description"), resultSet.getString("thumbnail"), resultSet.getString("unit"), resultSet.getString("branch"), resultSet.getInt("capacity"), resultSet.getDouble("alcohol"),
                    resultSet.getInt("quantity"), resultSet.getInt("price"), resultSet.getInt("price_sale"));
        }
        return null;
    }

    public void update(Integer id, String name, String thumbnail, String description, String unit, String branch, int category_id, int capacity, Double alcohol, int quantity, int price, int price_sale) throws SQLException {
        String query = "update products set name = N'" + name + "', thumbnail = '" + thumbnail + "', description = N'" + description + "', unit = N'" + unit + "', branch = '" + branch + "', category_id = " + category_id
                + " , capacity = " + capacity + " , alcohol = " + alcohol + " , price = " + price + " , price_sale = " + price_sale + " , quantity = " + quantity
                + " where id = " + id + ";";
        PreparedStatement prepare = connection.prepareStatement(query);
        prepare.execute();
    }

    public void add(String name, String thumbnail, String description, String unit, String branch, int category_id, int capacity, Double alcohol, int quantity, int price, int price_sale) throws SQLException {
        String query = "insert into products "
                + "values ( " + category_id + " , N'" + name + "' , N'" + description + "' ,  '" + thumbnail + "' , N'" + unit + "' , N'" + branch + "' , " + capacity + " , "
                + alcohol + " , " + quantity + " , " + price + " , " + price_sale + "  );";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.execute();
    }

    public void deleteByCatID(int catid) {
        try {
            String query = "delete from products where category_id = " + catid + ";";
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void close() {
        try {
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
    
    public void updateQuantity(int productId, int quantity) throws SQLException{
        String query = "UPDATE products SET quantity = " + quantity + " WHERE id =" + productId + ";";
        PreparedStatement psm = connection.prepareStatement(query);
        psm.executeUpdate();
    }
    public static void main(String[] args) throws SQLException {
        ProductDAO db = new ProductDAO();
        
        List<Product> products = db.search(0, 1, "0", 1, 1, 1, "ruou");
        System.out.println(products.size());
        for(Product product: products){
            System.out.println(product.getName());
        }
    }

    
}
