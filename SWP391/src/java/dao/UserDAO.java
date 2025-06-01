/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
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
                        rs.getString("userName"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Password"),
                        rs.getDate("RegistrationDate").toLocalDate(),
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

    // Lấy danh sách User( chỉ những cột hiển thị trong danh sách) 
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT UserID, UserName, FullName, RoleID, StatusID FROM Users";

        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User U = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)
                );
                list.add(U);
            }
        } catch (Exception e) {
            System.out.println("getAllUsers" + e.getMessage());
        }

        return list;
    }
    public List<User> getViewAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User viewU = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getDate(7).toLocalDate(),
                        rs.getInt(8),
                        rs.getInt(9)
                );
                list.add(viewU);
            }
        } catch (Exception e) {
            System.out.println("getViewAllUsers" + e.getMessage());
        }

        return list;
    }
    
  

    public void addUser(User user) throws Exception {
        String sql = "INSERT INTO Users(UserID, UserName, FullName, Email, PhoneNumber, Password, RegistrationDate, RoleID, StatusID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connect.prepareStatement(sql);

            ps.setInt(1, user.getUserID());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getPassword());
            ps.setDate(7, java.sql.Date.valueOf(user.getRegistrationDate()));
            ps.setInt(8, user.getRoleID());
            ps.setInt(9, user.getStatusID());

        } catch (Exception e) {
            System.out.println("addUser" + e.getMessage());
        }

    }

    

    public static void main(String[] args) {
        UserDAO da = new UserDAO();
        System.out.println(da.getAllUsers().size());
    }
}
