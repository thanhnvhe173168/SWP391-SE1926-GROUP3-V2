/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

/**
 *
 * @author Admin
 */
public enum OrderStatusEnum {

    PENDING(5),
    DELIVERING(6),
    DELIVERED(7),
    CANCELED(8);

    private final int orderStatus;

    OrderStatusEnum(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getOrderStatus() {
        return orderStatus;
    }
}
