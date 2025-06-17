/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Blog {

    private int BlogID;
    private String Avatar, Title, Content;
    private Date CreatedAt;

    public Blog() {
    }

    public Blog(int BlogID, String Avatar, String Title, String Content) {
        this.BlogID = BlogID;
        this.Avatar = Avatar;
        this.Title = Title;
        this.Content = Content;
    }

    public Blog(String Avatar, String Title, String Content) {
        this.Avatar = Avatar;
        this.Title = Title;
        this.Content = Content;
    }

    public int getBlogID() {
        return BlogID;
    }

    public void setBlogID(int BlogID) {
        this.BlogID = BlogID;
    }

    public String getAvatar() {
        return Avatar;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String Title) {
        this.Title = Title;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String Content) {
        this.Content = Content;
    }

    public Date getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(Date CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

}
