/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Window 11
 */
    import java.time.LocalDate;

public class User {
    private int userID;
    private String fullName;
    private String UserName;
    private String email;
    private String phoneNumber;
    private String password;
    private LocalDate registrationDate;
    private int roleID;
    private int statusID;

    // Constructors
    public User() {}

    public User(int userID, String fullName, String UserName,String email, String phoneNumber,
                String password, LocalDate registrationDate, int roleID, int statusID) {
        this.userID = userID;
        this.fullName = fullName;
        this.UserName= UserName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.registrationDate = registrationDate;
        this.roleID = roleID;
        this.statusID = statusID;
    }

    // Getters and Setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDate getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(LocalDate registrationDate) {
        this.registrationDate = registrationDate;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }
 
    
  
}