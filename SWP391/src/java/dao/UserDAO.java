/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Window 11
 */
public class UserDAO extends ConnectDB{
    public User GetUserID(String email){
        User user =new User();
        String sql="select * from User where email=?";
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
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
    }catch(SQLException e){
            System.out.println(e.getMessage());
    }
        return user;
}
}
