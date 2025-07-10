/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author Admin
 */
public class PromotionLaptop {

    private int id, promotionId, laptopId;
    private BigDecimal discountPrice;

    public PromotionLaptop() {
    }

    public PromotionLaptop(int laptopId, BigDecimal discountPrice) {
        this.laptopId = laptopId;
        this.discountPrice = discountPrice;
    }

    public PromotionLaptop(int id, int promotionId, int laptopId, BigDecimal discountPrice) {
        this.id = id;
        this.promotionId = promotionId;
        this.laptopId = laptopId;
        this.discountPrice = discountPrice;
    }

    public PromotionLaptop(int promotionId, int laptopId, BigDecimal discountPrice) {
        this.promotionId = promotionId;
        this.laptopId = laptopId;
        this.discountPrice = discountPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public int getLaptopId() {
        return laptopId;
    }

    public void setLaptopId(int laptopId) {
        this.laptopId = laptopId;
    }

    public BigDecimal getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }

}
