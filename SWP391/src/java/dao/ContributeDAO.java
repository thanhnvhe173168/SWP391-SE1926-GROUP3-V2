/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Contribute;

/**
 *
 * @author Admin
 */
public class ContributeDAO extends ConnectDB {

    public void createContribute(Contribute c) {
        String sql = "Insert into Contribute(Author, Content) values (?, ?)";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, c.getAuthor());
            pre.setString(2, c.getContent());
            pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ResultSet getContribute(int currentPage, int pageSize, String authorName, String orderBy) {
        ResultSet rs = null;
        String prefixSql = "select c.ID, c.Content, c.CreatedAt, u.FullName as AuthorName from Contribute c "
                + "inner join Users u on c.Author = u.UserID ";
        String suffixSql = "order by c.CreatedAt " + (orderBy != null && !orderBy.trim().isEmpty() ? orderBy : "DESC")
                + " offset ? rows fetch next ? rows only";
        if (authorName != null && !authorName.trim().isEmpty()) {
            prefixSql += "where u.FullName like ? ";
        }
        String sql = prefixSql + suffixSql;
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            if (authorName != null && !authorName.trim().isEmpty()) {
                pre.setString(1, "%" + authorName + "%");
                pre.setString(2, orderBy);
                pre.setInt(3, (currentPage - 1) * pageSize);
                pre.setInt(4, pageSize);
            } else {
                pre.setInt(1, (currentPage - 1) * pageSize);
                pre.setInt(2, pageSize);
            }
            rs = pre.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
