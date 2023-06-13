package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import model.Category;

import model.Product;
import model.OrderStatsitic;
import model.Product;

public class OrderDaoStatsitic extends ConnectDB {
    //Lay ra 10 san pham ban chay nhat

    public List<Product> get10MostSell() {
        String query = "SELECT TOP 10\n"
                + "    P.name AS product_name,\n"
                + "    SUM(OD.quantity) AS total_quantity\n"
                + "FROM\n"
                + "    Order_Details OD\n"
                + "JOIN\n"
                + "    Products P ON OD.product_id = P.id\n"
                + "GROUP BY\n"
                + "    P.name\n"
                + "ORDER BY\n"
                + "    total_quantity DESC;";
        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setName(resultSet.getString("product_name"));
                product.setQuantity(resultSet.getInt("total_quantity"));

                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public OrderStatsitic getTotalOrderToday() {
        String query = "	SELECT COUNT(id) AS total_paid_orders\n"
                + "	FROM Orders\n"
                + "	WHERE order_date >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0)\n"
                + "	  AND order_date < DATEADD(day, DATEDIFF(day, 0, GETDATE()) + 1, 0);";
        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            OrderStatsitic order = new OrderStatsitic();
            if (resultSet.next()) {
                order.setQuantity(resultSet.getInt(1));
            }
            return order;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public OrderStatsitic getTotalProductToday() {
        String query = "SELECT SUM(quantity) AS total_sold_quantity\n"
                + "FROM Order_Details od\n"
                + "JOIN Orders ON od.order_id = Orders.id\n"
                + "WHERE Orders.order_date >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0)\n"
                + "  AND Orders.order_date < DATEADD(day, DATEDIFF(day, 0, GETDATE()) + 1, 0);";

        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            OrderStatsitic order = new OrderStatsitic();
            if (resultSet.next()) {
                order.setQuantity(resultSet.getInt(1));
            }
            return order;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public OrderStatsitic getTotalMoneyToday() {
        String query = "SELECT SUM(total_money) AS total_amount\n"
                + "FROM Orders\n"
                + "WHERE order_date >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0)\n"
                + "  AND order_date < DATEADD(day, DATEDIFF(day, 0, GETDATE()) + 1, 0);";

        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            OrderStatsitic order = new OrderStatsitic();
            if (resultSet.next()) {
                order.setQuantity(resultSet.getInt(1));
            }
            return order;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<OrderStatsitic> getTotalMoney10LastestDay() {
        String query = "SELECT DATEADD(day, DATEDIFF(day, 0, order_date), 0) AS order_date, SUM(total_money) AS total_revenue\n"
                + "FROM Orders\n"
                + "WHERE order_date >= DATEADD(day, -10, GETDATE())\n"
                + "GROUP BY DATEADD(day, DATEDIFF(day, 0, order_date), 0)\n"
                + "ORDER BY DATEADD(day, DATEDIFF(day, 0, order_date), 0) DESC;";

        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            List<OrderStatsitic> orders = new ArrayList<>();
            while (resultSet.next()) {
                OrderStatsitic order = new OrderStatsitic();

                Date day = resultSet.getDate(1);
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM");

                order.setMonth(sdf.format(day));
                order.setTotal_money((Math.round(resultSet.getInt(2) / 1000000.0 * 100.0) / 100.0));
                orders.add(order);
            }

            //Neu chua du 10 hoa don thi them vao
            while (orders.size() < 10) {
                OrderStatsitic order = new OrderStatsitic();
                order.setTotal_money(0);

                orders.add(0, order);
            }
            return orders;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Product> getQuantityOfCategoriesThisMonth() {
        String query = "SELECT C.name AS category_name, COUNT(*) AS product_count\n"
                + "FROM Products P\n"
                + "JOIN Categories C ON P.category_id = C.id\n"
                + "JOIN Order_Details OD ON P.id = OD.product_id\n"
                + "JOIN Orders O ON OD.order_id = O.id\n"
                + "WHERE O.order_date >= DATEADD(month, -1, GETDATE())\n"
                + "GROUP BY C.name;";

        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setQuantity(resultSet.getInt(2));

                Category category = new Category();
                category.setName(resultSet.getString(1));
                product.setCategory(category);

                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<OrderStatsitic> getMoney6LastestMonths() {
        String query = "SELECT\n"
                + "    order_month,\n"
                + "    total_revenue,\n"
                + "    best_selling_product\n"
                + "FROM (\n"
                + "    SELECT\n"
                + "        DATEADD(month, DATEDIFF(month, 0, O.order_date), 0) AS order_month,\n"
                + "        SUM(O.total_money) AS total_revenue,\n"
                + "        P.name AS best_selling_product,\n"
                + "        ROW_NUMBER() OVER (PARTITION BY DATEADD(month, DATEDIFF(month, 0, O.order_date), 0) ORDER BY SUM(OD.quantity) DESC) AS rn\n"
                + "    FROM\n"
                + "        Orders O\n"
                + "    JOIN\n"
                + "        Order_Details OD ON O.id = OD.order_id\n"
                + "    JOIN\n"
                + "        Products P ON OD.product_id = P.id\n"
                + "    WHERE\n"
                + "        O.order_date >= DATEADD(month, -6, GETDATE())\n"
                + "    GROUP BY\n"
                + "        DATEADD(month, DATEDIFF(month, 0, O.order_date), 0),\n"
                + "        P.name\n"
                + ") AS subquery\n"
                + "WHERE rn = 1\n"
                + "ORDER BY order_month;\n"
                + "";
        try {
            PreparedStatement prepare = connection.prepareStatement(query);
            prepare.execute();
            ResultSet resultSet = prepare.getResultSet();
            List<OrderStatsitic> orders = new ArrayList<>();
            while (resultSet.next()) {
                OrderStatsitic order = new OrderStatsitic();

                Date month = resultSet.getDate(1);
                SimpleDateFormat sdf = new SimpleDateFormat("MM");

                order.setMonth(sdf.format(month));
                order.setQuantity(resultSet.getInt(2));
                order.setMostProduct(resultSet.getString(3));

                orders.add(order);
            }
            return orders;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
