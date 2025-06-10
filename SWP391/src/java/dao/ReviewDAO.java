/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Review;
import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Window 11
 */
public class ReviewDAO extends ConnectDB{
    public Review getReviewByID(int id){
        Review rv=new Review();
        String sql="select * from Review where ReviewID=?";
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                rv.setReviewID(id);
                rv.setReviewDate(rs.getDate("ReviewDate").toLocalDate());
                rv.setComment(rs.getNString("comment"));
                rv.setRating(rs.getBigDecimal("rating"));
                
        }
    }
        catch(SQLException e){
            e.printStackTrace();
        }
        return rv;
}
}
