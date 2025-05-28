/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

/**
 *
 * @author Admin
 */
public enum LaptopStatusEnum {

    IN_STOCK(1),
    IN_ACTIVE(2);

    private final int laptopStatus;

    LaptopStatusEnum(int laptopStatus) {
        this.laptopStatus = laptopStatus;
    }

    public int getLaptopStatus() {
        return laptopStatus;
    }
}
