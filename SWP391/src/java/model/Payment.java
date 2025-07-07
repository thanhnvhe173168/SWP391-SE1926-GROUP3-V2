/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author Window 11
 */
public class Payment {
    private int paymentId;
    private int orderId;
    private BigDecimal transactionNo;
    private BigDecimal amount;
    private LocalDateTime payDate;
    private int transactionStatus;
    private String bankCode;

    public Payment(int paymentId, int orderId, BigDecimal transactionNo, BigDecimal amount, LocalDateTime payDate, int transactionStatus, String bankCode) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.transactionNo = transactionNo;
        this.amount = amount;
        this.payDate = payDate;
        this.transactionStatus = transactionStatus;
        this.bankCode = bankCode;
    }

    public Payment() {
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public BigDecimal getTransactionNo() {
        return transactionNo;
    }

    public void setTransactionNo(BigDecimal transactionNo) {
        this.transactionNo = transactionNo;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public LocalDateTime getPayDate() {
        return payDate;
    }

    public void setPayDate(LocalDateTime payDate) {
        this.payDate = payDate;
    }

    public int getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(int transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }


    

    
    
}
