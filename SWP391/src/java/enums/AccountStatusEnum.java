/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package enums;

/**
 *
 * @author Admin
 */
public enum AccountStatusEnum {

    ACTIVE(1),
    IN_ACTIVE(2);

    private final int accountStatus;

    AccountStatusEnum(int accountStatus) {
        this.accountStatus = accountStatus;
    }

    public int getAccountStatus() {
        return accountStatus;
    }
}
