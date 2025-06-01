package model;

import java.time.LocalDate;

public class User {

    private int userID;
    private String userName;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String password;
    private LocalDate Date;
    private int roleID;
    private int statusID;

    public User() {
    }

    public User(String fullName, String email, String phoneNumber, String password, int roleID, int statusID) {
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.roleID = roleID;
        this.statusID = statusID;
    }

    public User(int userID, String userName, String fullName, String email, String phoneNumber,
            String password, LocalDate Date, int roleID, int statusID) {
        this.userID = userID;
        this.userName = userName;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.Date = Date;
        this.roleID = roleID;
        this.statusID = statusID;
    }
// Constructor rút gọn cho danh sách
    public User(int userID, String userName, String fullName, int roleID, int statusID) {
        this.userID = userID;
        this.userName = userName;
        this.fullName = fullName;
        this.roleID = roleID;
        this.statusID = statusID;
    }

    // Getters & Setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
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
        return Date;
    }

    public void setRegistrationDate(LocalDate Date) {
        this.Date = Date;
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
}
