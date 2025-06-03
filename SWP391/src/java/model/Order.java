/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Window 11
 */
import java.math.BigDecimal;
import java.time.LocalDate;

public class Order {
    private int orderID;
    private int userID;
    private LocalDate orderDate;
    private int shipfeeID;
    private int voucherID;
    private int paymentmethodID;
    private String phoneNumber;
    private BigDecimal totalAmount;
    private String address;
    private String note;
    private int statusID;

    public Order() {
    }

    public Order(int orderID, int userID, LocalDate orderDate, int shipfeeID, int voucherID, int paymentmethodID, String phoneNumber, BigDecimal totalAmount, String address, String note, int statusID) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.shipfeeID = shipfeeID;
        this.voucherID = voucherID;
        this.paymentmethodID = paymentmethodID;
        this.phoneNumber = phoneNumber;
        this.totalAmount = totalAmount;
        this.address = address;
        this.note = note;
        this.statusID = statusID;
    }

    public Order(int userID, LocalDate orderDate, int shipfeeID, int voucherID, int paymentmethodID, String phoneNumber, BigDecimal totalAmount, String address, String note, int statusID) {
        this.userID = userID;
        this.orderDate = orderDate;
        this.shipfeeID = shipfeeID;
        this.voucherID = voucherID;
        this.paymentmethodID = paymentmethodID;
        this.phoneNumber = phoneNumber;
        this.totalAmount = totalAmount;
        this.address = address;
        this.note = note;
        this.statusID = statusID;
    }
    
    

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public int getShipfeeID() {
        return shipfeeID;
    }

    public void setShipfeeID(int shipfeeID) {
        this.shipfeeID = shipfeeID;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public int getPaymentmethodID() {
        return paymentmethodID;
    }

    public void setPaymentmethodID(int paymentmethodID) {
        this.paymentmethodID = paymentmethodID;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

   
    
    
    

    
}
