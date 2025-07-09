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
    private FeeShip shipfee;
    private Voucher voucher;
    private PaymentMethod paymentmethod;
    private String phoneNumber;
    private BigDecimal totalAmount;
    private String address;
    private String note;
    private Status orderstatus;
    private Status paymentstatus;
    private LocalDate returnDate;
    private String reasonReturn;

    public Order() {
    }

    public Order(int orderID, int userID, LocalDate orderDate, FeeShip shipfee, Voucher voucher, PaymentMethod paymentmethod, String phoneNumber, BigDecimal totalAmount, String address, String note, Status orderstatus, Status paymentstatus) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.shipfee = shipfee;
        this.voucher = voucher;
        this.paymentmethod = paymentmethod;
        this.phoneNumber = phoneNumber;
        this.totalAmount = totalAmount;
        this.address = address;
        this.note = note;
        this.orderstatus = orderstatus;
        this.paymentstatus = paymentstatus;
    }

    public Order(int userID, LocalDate orderDate, FeeShip shipfee, Voucher voucher, PaymentMethod paymentmethod, String phoneNumber, BigDecimal totalAmount, String address, String note, Status orderstatus, Status paymentstatus) {
        this.userID = userID;
        this.orderDate = orderDate;
        this.shipfee = shipfee;
        this.voucher = voucher;
        this.paymentmethod = paymentmethod;
        this.phoneNumber = phoneNumber;
        this.totalAmount = totalAmount;
        this.address = address;
        this.note = note;
        this.orderstatus = orderstatus;
        this.paymentstatus = paymentstatus;

    }

    public Order(int orderID, int userID, LocalDate orderDate, FeeShip shipfee, Voucher voucher, PaymentMethod paymentmethod, String phoneNumber, BigDecimal totalAmount, String address, String note, Status orderstatus, Status paymentstatus, LocalDate returnDate, String reasonReturn) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.shipfee = shipfee;
        this.voucher = voucher;
        this.paymentmethod = paymentmethod;
        this.phoneNumber = phoneNumber;
        this.totalAmount = totalAmount;
        this.address = address;
        this.note = note;
        this.orderstatus = orderstatus;
        this.paymentstatus = paymentstatus;
        this.returnDate = returnDate;
        this.reasonReturn = reasonReturn;
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

    public FeeShip getShipfee() {
        return shipfee;
    }

    public void setShipfee(FeeShip shipfee) {
        this.shipfee = shipfee;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public PaymentMethod getPaymentmethod() {
        return paymentmethod;
    }

    public void setPaymentmethod(PaymentMethod paymentmethod) {
        this.paymentmethod = paymentmethod;
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

    public Status getOrderstatus() {
        return orderstatus;
    }

    public void setOrderstatus(Status orderstatus) {
        this.orderstatus = orderstatus;
    }

    public Status getPaymentstatus() {
        return paymentstatus;
    }

    public void setPaymentstatus(Status paymentstatus) {
        this.paymentstatus = paymentstatus;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getReasonReturn() {
        return reasonReturn;
    }

    public void setReasonReturn(String reasonReturn) {
        this.reasonReturn = reasonReturn;
    }

    
    }

    

   
    
    
    

    

