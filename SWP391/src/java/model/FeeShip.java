/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author Window 11
 */
public class FeeShip {
    private int FeeShipID;
    private BigDecimal fee;
    private String des;

    public FeeShip() {
    }

    public FeeShip(int FeeShipID, BigDecimal fee, String des) {
        this.FeeShipID = FeeShipID;
        this.fee = fee;
        this.des = des;
    }

    public int getFeeShipID() {
        return FeeShipID;
    }

    public void setFeeShipID(int FeeShipID) {
        this.FeeShipID = FeeShipID;
    }

    public BigDecimal getFee() {
        return fee;
    }

    public void setFee(BigDecimal fee) {
        this.fee = fee;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
    
    
}
