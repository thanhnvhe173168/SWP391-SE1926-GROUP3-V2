/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author linhd
 */
import java.sql.Timestamp;

public class Feedback {
     private int feedbackID;
    private int laptopID;
    private int orderID;
    private int userID;
    private String title;
    private String content;
    private int rating; 
    private int sellerRating; 
    private int shippingRating;
    private String imageURL; 
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int statusID; 
    private String replyContent; 

    public Feedback() {
    }

    public Feedback(int feedbackID, int laptopID, int orderID, int userID, String title, String content, int rating, int sellerRating, int shippingRating, String imageURL, Timestamp createdAt, Timestamp updatedAt, int statusID, String replyContent) {
        this.feedbackID = feedbackID;
        this.laptopID = laptopID;
        this.orderID = orderID;
        this.userID = userID;
        this.title = title;
        this.content = content;
        this.rating = rating;
        this.sellerRating = sellerRating;
        this.shippingRating = shippingRating;
        this.imageURL = imageURL;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.statusID = statusID;
        this.replyContent = replyContent;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getLaptopID() {
        return laptopID;
    }

    public void setLaptopID(int laptopID) {
        this.laptopID = laptopID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public int getSellerRating() {
        return sellerRating;
    }

    public void setSellerRating(int sellerRating) {
        this.sellerRating = sellerRating;
    }

    public int getShippingRating() {
        return shippingRating;
    }

    public void setShippingRating(int shippingRating) {
        this.shippingRating = shippingRating;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }
    
    

}
