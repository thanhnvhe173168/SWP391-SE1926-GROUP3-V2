/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author admin
 */
public class ConnectDB {

    public Connection connect = null;

    public ConnectDB(String URL, String userName, String password) {
        try {
            //URL: connection string: address, port, database of server
            //call drivers
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            //connection
            connect = DriverManager.getConnection(URL, userName, password);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public ConnectDB() {
        this("jdbc:sqlserver://LINHDO\\SQLEXPRESS:1433;databaseName=LapWeb", "sa", "123");
        //this("jdbc:sqlserver://localhost\\DESKTOP-3SCD3SC\\SQLEXPRESS01:1433;databaseName= LapWeb", "sa", "123");
    }

    public ResultSet getData(String sql) {
        ResultSet rs = null;
        try {
            Statement state = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = state.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }

    public int getTotalRecord(String sql) {
        int countPage = 0;
        ResultSet rs = this.getData(sql);
        try {
            while (rs.next()) {
                countPage++;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return countPage;
    }

    public static void main(String[] args) {
        new ConnectDB();
    }
}
