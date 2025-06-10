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

public class OrderDetail {
    private int orderID;
    private Laptop laptop;
    private int quantity;
    private BigDecimal unitPrice;
    private Review review;

    public OrderDetail() {
    }

    public OrderDetail(int orderID, Laptop laptop, int quantity, BigDecimal unitPrice, Review review) {
        this.orderID = orderID;
        this.laptop = laptop;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.review = review;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Laptop getLaptop() {
        return laptop;
    }

    public void setLaptop(Laptop laptop) {
        this.laptop = laptop;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Review getReview() {
        return review;
    }

    public void setReview(Review review) {
        this.review = review;
    }

    
    

}

