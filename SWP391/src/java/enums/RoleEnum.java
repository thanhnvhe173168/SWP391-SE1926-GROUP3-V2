/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

/**
 *
 * @author Admin
 */
public enum RoleEnum {

    ADMIN(1),
    STAFF(2),
    CUSTOMER(3);

    private final int role;

    RoleEnum(int role) {
        this.role = role;
    }

    public int getRole() {
        return role;
    }
}
