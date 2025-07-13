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

public class OrderDetail {
    private int orderID;
    private Laptop laptop;
    private int quantity;
    private BigDecimal unitPrice;
    private Review review;
    private Status orderDetailStatus;
    private String reasonReturn;
    private LocalDate returnDate;
    private boolean isSelect;
    private String imageReturn;

    public OrderDetail() {
    }

    public OrderDetail(int orderID, Laptop laptop, int quantity, BigDecimal unitPrice, Review review, Status orderDetailStatus, String reasonReturn, LocalDate returnDate) {
        this.orderID = orderID;
        this.laptop = laptop;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.review = review;
        this.orderDetailStatus = orderDetailStatus;
        this.reasonReturn = reasonReturn;
        this.returnDate = returnDate;
    }

    public OrderDetail(int orderID, Laptop laptop, int quantity, BigDecimal unitPrice, Review review, Status orderDetailStatus) {
        this.orderID = orderID;
        this.laptop = laptop;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.review = review;
        this.orderDetailStatus = orderDetailStatus;
    }

    public OrderDetail(int orderID, Laptop laptop, int quantity, BigDecimal unitPrice, Review review, Status orderDetailStatus, String reasonReturn, LocalDate returnDate, boolean isSelect) {
        this.orderID = orderID;
        this.laptop = laptop;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.review = review;
        this.orderDetailStatus = orderDetailStatus;
        this.reasonReturn = reasonReturn;
        this.returnDate = returnDate;
        this.isSelect = isSelect;
    }

    public OrderDetail(int orderID, Laptop laptop, int quantity, BigDecimal unitPrice, Review review, Status orderDetailStatus, String reasonReturn, LocalDate returnDate, boolean isSelect, String imageReturn) {
        this.orderID = orderID;
        this.laptop = laptop;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.review = review;
        this.orderDetailStatus = orderDetailStatus;
        this.reasonReturn = reasonReturn;
        this.returnDate = returnDate;
        this.isSelect = isSelect;
        this.imageReturn = imageReturn;
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

    public Status getOrderDetailStatus() {
        return orderDetailStatus;
    }

    public void setOrderDetailStatus(Status orderDetailStatus) {
        this.orderDetailStatus = orderDetailStatus;
    }

    public String getReasonReturn() {
        return reasonReturn;
    }

    public void setReasonReturn(String reasonReturn) {
        this.reasonReturn = reasonReturn;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public boolean isIsSelect() {
        return isSelect;
    }

    public void setIsSelect(boolean isSelect) {
        this.isSelect = isSelect;
    }

    public String getImageReturn() {
        return imageReturn;
    }

    public void setImageReturn(String imageReturn) {
        this.imageReturn = imageReturn;
    }

    
    
    

}

