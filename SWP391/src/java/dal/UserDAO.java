/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.sun.jdi.connect.spi.Connection;
import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class UserDAO extends DBContext {

    PreparedStatement stm; // Thực hiện câu lệnh SQL
    ResultSet rs; // Lưu trữ và xử lý dữ liệu

    public User GetUserID(String email) {
        User user = new User();
        String sql = "select * from User where email=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                user.setEmail(email);
                user.setFullName(rs.getString("FullName"));
                user.setPassword(rs.getString("password"));
                user.setPhoneNumber(rs.getString("phonenumber"));
                user.setRegistrationDate(rs.getDate("RegistrationDate").toLocalDate());
                user.setRoleID(rs.getInt("roleID"));
                user.setStatusID(rs.getInt("statusID"));
                user.setUserID(rs.getInt("userID"));
                user.setUserName(rs.getString("username"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return user;
    }
    // Lấy tất cả User có trong DB

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(
                        rs.getInt(1), // user_id
                        rs.getString(2), // username
                        rs.getString(3), // password
                        rs.getString(4), // full_name
                        rs.getString(5), // email
                        rs.getString(6), // phone
                        rs.getDate(7).toLocalDate(),
                        rs.getInt(8), // status_id
                        rs.getInt(9) // role_id
                );
                list.add(user); // chỉ add một lần
            }
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi để dễ debug
        }

        return list;
    }
    
   

}

