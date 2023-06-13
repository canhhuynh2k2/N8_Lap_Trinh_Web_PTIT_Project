
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectDB {
    protected Connection connection;
    public ConnectDB()
    {
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName= webn8";
            String username = "sa";
            String password = "12345";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
            System.out.println("huynh");
        }
    }
}
