package model;

import java.util.Date;

public class User {

    private int userID;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String password;
    private Date Date;
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

    public User(int userID, String fullName, String email, String phoneNumber, String password, Date Date, int roleID, int statusID) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.Date = Date;
        this.roleID = roleID;
        this.statusID = statusID;
    }

    public User(int userID, String fullName, String email, String phoneNumber, Date Date, int statusID) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.Date = Date;
        this.roleID = roleID;
        this.statusID = statusID;
    }
//in staff
     public User(int userID, String fullName, String email, String phoneNumber) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }
    // Getters & Setters
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

    public Date getRegistrationDate() {
        return Date;
    }

    public void setRegistrationDate(Date Date) {
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
