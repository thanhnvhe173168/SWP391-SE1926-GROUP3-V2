/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Blog;

/**
 *
 * @author Admin
 */
public class BlogDAO extends ConnectDB {

    public ResultSet getListBlog(int currentPage, int pageSize, String title, String blogStatus) {
        ResultSet rs = null;
        String prefixSql = "Select b.BlogID, b.Avatar, b.Title, b.Content, b.CreatedAt, b.BlogStatus, u.FullName as AuthorName from Blog b "
                + "inner join Users u on b.Author = u.UserID ";
        String suffixSql = "order by b.BlogID offset ? rows fetch next ? rows only";
        if (title != null && !title.trim().isEmpty() && blogStatus == null) {
            prefixSql += "where b.Title like ? ";
        } else if (title == null && blogStatus != null && !blogStatus.trim().isEmpty()) {
            prefixSql += "where b.BlogStatus = ? ";
        } else if (title != null && !title.trim().isEmpty() && blogStatus != null && !blogStatus.trim().isEmpty()) {
            prefixSql += "where b.Title like ? and b.BlogStatus = ? ";
        }
        String sql = prefixSql + suffixSql;
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            if (title != null && !title.trim().isEmpty() && blogStatus == null) {
                pre.setString(1, "%" + title + "%");
                pre.setInt(2, (currentPage - 1) * pageSize);
                pre.setInt(3, pageSize);
            } else if (title == null && blogStatus != null && !blogStatus.trim().isEmpty()) {
                pre.setString(1, blogStatus);
                pre.setInt(2, (currentPage - 1) * pageSize);
                pre.setInt(3, pageSize);
            } else if (title != null && !title.trim().isEmpty() && blogStatus != null && !blogStatus.trim().isEmpty()) {
                pre.setString(1, "%" + title + "%");
                pre.setString(2, blogStatus);
                pre.setInt(3, (currentPage - 1) * pageSize);
                pre.setInt(4, pageSize);
            } else if(title == null && blogStatus == null) {
                pre.setInt(1, (currentPage - 1) * pageSize);
                pre.setInt(2, pageSize);
            }
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public boolean checkExistBlogTitle(String title, int blogId) {
        boolean check = false;
        ResultSet rs = null;
        String sql = blogId != 0
                ? "Select * from Blog where Title = ? and BlogID != ?"
                : "Select * from Blog where Title = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, title);
            if (blogId != 0) {
                pre.setInt(2, blogId);
            }
            rs = pre.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return check;
    }

    public int createBlog(Blog blog) {
        int n = 0;
        String sql = "Insert into Blog(Avatar, Title, Content, Author, BlogStatus) values (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, blog.getAvatar());
            pre.setString(2, blog.getTitle());
            pre.setString(3, blog.getContent());
            pre.setInt(4, blog.getAuthor());
            pre.setString(5, blog.getBlogStatus());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public Blog getBlogById(int blogId) {
        ResultSet rs = null;
        String sql = "Select * from Blog where BlogID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, blogId);
            rs = pre.executeQuery();
            if (rs.next()) {
                return new Blog(
                        rs.getInt("BlogID"),
                        rs.getString("Avatar"),
                        rs.getString("Title"),
                        rs.getString("Content")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateBlog(Blog blog) {
        int n = 0;
        String sql = "Update Blog set Avatar = ?, Title = ?, Content = ?, BlogStatus = ? where BlogID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, blog.getAvatar());
            pre.setString(2, blog.getTitle());
            pre.setString(3, blog.getContent());
            pre.setString(4, blog.getBlogStatus());
            pre.setInt(5, blog.getBlogID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int deleteBlog(int blogId) {
        int n = 0;
        String sql = "Delete from Blog where BlogID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, blogId);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    
    public ResultSet blogDetail (int blogId) {
         ResultSet rs = null;
        String sql = "Select b.BlogID, b.Avatar, b.Title, b.Content, b.CreatedAt, b.BlogStatus, u.FullName as AuthorName from Blog b "
                + "inner join Users u on b.Author = u.UserID where b.BlogID = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, blogId);
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
