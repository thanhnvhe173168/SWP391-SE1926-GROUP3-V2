/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author linhd
 */
public class WishList {
    private int wishlistId;
    private int userId;
    private int laptopId;
    private Date addedDate;

    public WishList() {
    }

    public WishList(int wishlistId, int userId, int laptopId, Date addedDate) {
        this.wishlistId = wishlistId;
        this.userId = userId;
        this.laptopId = laptopId;
        this.addedDate = addedDate;
    }

    public int getWishlistId() {
        return wishlistId;
    }

    public void setWishlistId(int wishlistId) {
        this.wishlistId = wishlistId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getLaptopId() {
        return laptopId;
    }

    public void setLaptopId(int laptopId) {
        this.laptopId = laptopId;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }
    
    
}
