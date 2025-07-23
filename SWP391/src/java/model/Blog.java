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

    private int BlogID, Author;
    private String Avatar, Title, Content, BlogStatus;
    private Date CreatedAt;

    public Blog() {
    }

    public Blog(int BlogID, int Author, String Avatar, String Title, String Content, String BlogStatus, Date CreatedAt) {
        this.BlogID = BlogID;
        this.Author = Author;
        this.Avatar = Avatar;
        this.Title = Title;
        this.Content = Content;
        this.BlogStatus = BlogStatus;
        this.CreatedAt = CreatedAt;
    }

    public Blog(int BlogID, String Avatar, String Title, String Content) {
        this.BlogID = BlogID;
        this.Avatar = Avatar;
        this.Title = Title;
        this.Content = Content;
    }

    public Blog(int Author, String Avatar, String Title, String Content, String BlogStatus) {
        this.Author = Author;
        this.Avatar = Avatar;
        this.Title = Title;
        this.Content = Content;
        this.BlogStatus = BlogStatus;
    }

    public int getBlogID() {
        return BlogID;
    }

    public void setBlogID(int BlogID) {
        this.BlogID = BlogID;
    }

    public int getAuthor() {
        return Author;
    }

    public void setAuthor(int Author) {
        this.Author = Author;
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

    public String getBlogStatus() {
        return BlogStatus;
    }

    public void setBlogStatus(String BlogStatus) {
        this.BlogStatus = BlogStatus;
    }

    public Date getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(Date CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

}
