/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Payment;
import config.ConnectDB;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Window 11
 */
public class PaymentDAO extends ConnectDB {

    public Payment getPayment(int orderid) {
        Payment payment = new Payment();
        String sql = "select * from payment\n"
                + "where order_id=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, orderid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                payment.setPaymentId(rs.getInt("paymentid"));
                payment.setOrderId(rs.getInt("order_id"));
                BigDecimal txnNo = rs.getBigDecimal("TransactionNo");
                payment.setTransactionNo(txnNo);
                payment.setAmount(rs.getBigDecimal("Amount"));
                Timestamp payDate = rs.getTimestamp("PayDate");
                if (payDate != null) {
                    payment.setPayDate(payDate.toLocalDateTime());
                }
                payment.setTransactionStatus(rs.getInt("transaction_status"));
                payment.setBankCode(rs.getNString("bankcode"));
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payment;
    }
    
    public void addpayment(Payment payment){
         String sql = "INSERT INTO payment " +
                 "(order_id, TransactionNo, Amount, PayDate, transaction_status, bankcode) " +
                 "VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement ps = connect.prepareStatement(sql)) {
        ps.setInt(1, payment.getOrderId());
        // DECIMAL(15,0) mapped as BigDecimal
        if (payment.getTransactionNo() != null) {
            ps.setBigDecimal(2, payment.getTransactionNo());
        } else {
            ps.setNull(2, java.sql.Types.NUMERIC);
        }
        ps.setBigDecimal(3, payment.getAmount());
        if (payment.getPayDate() != null) {
            ps.setTimestamp(4, Timestamp.valueOf(payment.getPayDate()));
        } else {
            ps.setNull(4, java.sql.Types.TIMESTAMP);
        }
        ps.setInt(5, payment.getTransactionStatus());
        ps.setNString(6, payment.getBankCode());
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
    
}
