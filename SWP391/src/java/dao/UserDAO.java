/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 *
 * @author Window 11
 */
public class UserDAO extends ConnectDB {

    public User checkExistUser(String email) {
        ResultSet rs = null;
        String sql = "Select Top 1 * from Users where Email = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, email);
            rs = pre.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getDate("RegistrationDate"),
                        rs.getInt("RoleID"),
                        rs.getInt("StatusID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int createUser(User u) {
        int n = 0;
        String sql = "Insert into Users(FullName, Email, PhoneNumber, Password, RoleID, StatusID) values (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, u.getFullName());
            pre.setString(2, u.getEmail());
            pre.setString(3, u.getPhoneNumber());
            pre.setString(4, u.getPassword());
            pre.setInt(5, u.getRoleID());
            pre.setInt(6, u.getStatusID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
}
