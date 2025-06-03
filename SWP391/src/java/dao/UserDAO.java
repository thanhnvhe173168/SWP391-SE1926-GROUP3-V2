/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    // Lấy danh sách User( chỉ những cột hiển thị trong danh sách) 

    public List<User> getListUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT UserID, FullName, Email, PhoneNumber, RegistrationDate, RoleID, StatusID FROM Users";

        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User U = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getDate("RegistrationDate"),
                        rs.getInt("RoleID"),
                        rs.getInt("StatusID")
                );
                list.add(U);
            }
        } catch (Exception e) {
            System.out.println("getAllUsers" + e.getMessage());
        }

        return list;
    }

    public User getUserByID(int userID) {
    User user = null;
    String sql = "SELECT * FROM Users WHERE UserID = ?";
    try {
        PreparedStatement ps = connect.prepareStatement(sql);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            user = new User();
            user.setUserID(rs.getInt("UserID"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setRoleID(rs.getInt("RoleID"));
            user.setStatusID(rs.getInt("StatusID"));
            // add more fields if needed
        }
    } catch (SQLException e) {
        System.out.println("getUserByID: " + e.getMessage());
    }
    return user;
}
    

    public int createUser(User u) {

        String sql = "Insert into Users(FullName, Email, PhoneNumber, Password, RoleID, StatusID) values (?, ?, ?, ?, ?, ?)";
        int n = 0;
        try {

            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhoneNumber());
            ps.setString(4, u.getPassword());
            ps.setInt(5, u.getRoleID());
            ps.setInt(6, u.getStatusID());
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int deleteUser(int uid) {
        int n = 0;
        String sql = "Delete from Users where UserID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, uid);
            n = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("deleteUser" + e.getMessage());
        }
        return n;
    }

    public int updateUser(User u) {
        int n = 0;
        String sql = "update Users set FullName = ?, PhoneNumber = ?, Password = ?, StatusID = ? where UserID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, u.getFullName());
            pre.setString(2, u.getPhoneNumber());
            pre.setString(3, u.getPassword());
            pre.setInt(4, u.getStatusID());
            pre.setInt(5, u.getUserID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;

    }

    public int updateUserAd(int userID, int roleID, int statusID) {
        int n = 0;
        String sql = "UPDATE Users SET RoleID = ?, StatusID = ? WHERE UserID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, roleID);
            ps.setInt(2, statusID);
            ps.setInt(3, userID);
            n = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateUserAd: " + e.getMessage());
        }
        return n;
    }

    public User getUserByIDForView(int userID) {
    User user = null;
    String sql = "SELECT * FROM Users WHERE UserID = ?";
    try {
        PreparedStatement ps = connect.prepareStatement(sql);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            user = new User();
            user.setUserID(rs.getInt("UserID"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setPhoneNumber(rs.getString("PhoneNumber")); 
            user.setPassword(rs.getString("Password"));      
            user.setRegistrationDate(rs.getDate("RegistrationDate")); 
            user.setRoleID(rs.getInt("RoleID"));
            user.setStatusID(rs.getInt("StatusID"));
        }
    } catch (SQLException e) {
        System.out.println("getUserByID: " + e.getMessage());
    }
    return user;
}

}
