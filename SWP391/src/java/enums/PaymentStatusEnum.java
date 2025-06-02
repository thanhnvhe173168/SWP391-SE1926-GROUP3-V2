/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

/**
 *
 * @author Admin
 */
public enum PaymentStatusEnum {

    UNPAID(1),
    PAID(2);

    private final int paymentStatus;

    PaymentStatusEnum(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public int getPaymentStatus() {
        return paymentStatus;
    }
}
