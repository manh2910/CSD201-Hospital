package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    private static final String SERVER = "DESKTOP-OB6A1VN\\SQLEXPRESS";          
    private static final String DATABASE = "HospitalDB";
    private static final String USER = "sa";                 
    private static final String PASSWORD = "12345";            

    private static final String URL = "jdbc:sqlserver://" + SERVER 
            + ";databaseName=" + DATABASE 
            + ";encrypt=true;trustServerCertificate=true;";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}