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
    private BigDecimal shippingFee;
    private BigDecimal totalAmount;
    private String address;
    private String note;
    private int statusID;

    // Constructors
    public Order() {}

    public Order(int orderID, int userID, LocalDate orderDate, BigDecimal shippingFee,
                 BigDecimal totalAmount, String address, String note, int statusID) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.shippingFee = shippingFee;
        this.totalAmount = totalAmount;
        this.address = address;
        this.note = note;
        this.statusID = statusID;
    }

    // Getters and Setters
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

    public BigDecimal getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(BigDecimal shippingFee) {
        this.shippingFee = shippingFee;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        if (totalAmount != null && totalAmount.compareTo(BigDecimal.ZERO) >= 0) {
            this.totalAmount = totalAmount;
        }
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

