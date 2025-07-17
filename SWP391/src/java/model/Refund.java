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
public class Refund {
    private int refundId;
    private int paymentId;
    private BigDecimal amount;  
    private String refundType;   
    private String refundTransactionNo;
    private LocalDateTime createDate;
    private int statusId;       
    private String createBy;

    public Refund(int refundId, int paymentId, BigDecimal amount, String refundType, String refundTransactionNo, LocalDateTime createDate, int statusId, String createBy) {
        this.refundId = refundId;
        this.paymentId = paymentId;
        this.amount = amount;
        this.refundType = refundType;
        this.refundTransactionNo = refundTransactionNo;
        this.createDate = createDate;
        this.statusId = statusId;
        this.createBy = createBy;
    }

    public Refund() {
    }

    public int getRefundId() {
        return refundId;
    }

    public void setRefundId(int refundId) {
        this.refundId = refundId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getRefundType() {
        return refundType;
    }

    public void setRefundType(String refundType) {
        this.refundType = refundType;
    }

    public String getRefundTransactionNo() {
        return refundTransactionNo;
    }

    public void setRefundTransactionNo(String refundTransactionNo) {
        this.refundTransactionNo = refundTransactionNo;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    
}
