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

    //update in profile  
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
//Linh: StaffList

    public List<User> getListStaff() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT UserID, FullName, Email, PhoneNumber, RegistrationDate, StatusID FROM Users where roleID = 2";

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
                        rs.getInt("StatusID")
                );
                list.add(U);
            }
        } catch (Exception e) {
            System.out.println("getListStaff" + e.getMessage());
        }

        return list;
    }

    //Linh: StaffDetail
    public User getStaffByIDForView(int userID) {
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
//Linh: StaffEditAccount

    public User getStaffByID(int userID) {
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
                user.setPhoneNumber(rs.getString("PhoneNumber"));

                user.setPassword(rs.getString("Password"));
                user.setStatusID(rs.getInt("StatusID"));
                user.setRoleID(rs.getInt("RoleID"));

                // add more fields if needed
            }
        } catch (SQLException e) {
            System.out.println("getUserByID: " + e.getMessage());
        }
        return user;
    }
//Linh: CreateAccountStaff

    public int createUser(User user) {

        String sql = "Insert into Users(FullName, Email, PhoneNumber, Password, RoleID, StatusID) values (?, ?, ?, ?, ?, ?)";
        int n = 0;
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhoneNumber());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getRoleID());
            ps.setInt(6, user.getStatusID());
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    // Tìm kiếm User theo FullName + StatusID
    public List<User> searchUser(String search, Integer statusID) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT UserID, FullName, Email, PhoneNumber, RegistrationDate, RoleID, StatusID FROM Users WHERE 1=1";

        // Bổ sung điều kiện nếu có input tìm kiếm hoặc lọc
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND FullName LIKE ?";
        }

        if (statusID != null) {
            sql += " AND StatusID = ?";
        }

        try {
            PreparedStatement ps = connect.prepareStatement(sql);

            // Gán giá trị cho các ? trong câu SQL
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search.trim() + "%");
            }

            if (statusID != null) {
                ps.setInt(index++, statusID);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getDate("RegistrationDate"),
                        rs.getInt("StatusID")
                );
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println("searchUsers: " + e.getMessage());
        }

        return list;
    }

    public boolean changeStatus(int userID, int statusID) {
        String sql = "UPDATE Users SET StatusID = ? WHERE UserID = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, statusID);
            ps.setInt(2, userID);
            int rowsAffected = ps.executeUpdate();
            ps.close(); // Đóng PreparedStatement
            return true;
        } catch (Exception e) {
            System.out.println("changeStatus error: " + e.getMessage());
            return false;
        }
    }
//Linh: UserList

    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT UserID, FullName, Email, PhoneNumber, RegistrationDate, StatusID FROM Users where roleID = 3";

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
                        rs.getInt("StatusID")
                );
                list.add(U);
            }
        } catch (Exception e) {
            System.out.println("getAllUser" + e.getMessage());
        }

        return list;
    }
    //Linh: UserDetail

    public User getUserById(int userId) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE UserID = ? AND RoleID = 3"; 
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, userId);
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
            System.out.println("getUserById: " + e.getMessage());
        }
        return user;
    }

    public int getUserIDByEmail(String email) {
        String sql = "select userID from Users where Email=?";
        int userID = 0;
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                userID = rs.getInt("userID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userID;
    }
}
