/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Window 11
 */
import java.math.BigDecimal;

public class CartDetail {
    private Cart cart;
    private Laptop laptop;
    private int quantity;
    private BigDecimal unitPrice;
    private boolean IsSelect;

    public CartDetail() {
    }

    public CartDetail(Cart cart, Laptop laptop, int quantity, BigDecimal unitPrice, boolean IsSelect) {
        this.cart = cart;
        this.laptop = laptop;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.IsSelect = IsSelect;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public Laptop getLaptop() {
        return laptop;
    }

    public void setLaptop(Laptop laptop) {
        this.laptop = laptop;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public boolean isIsSelect() {
        return IsSelect;
    }

    public void setIsSelect(boolean IsSelect) {
        this.IsSelect = IsSelect;
    }
    
    
} 




